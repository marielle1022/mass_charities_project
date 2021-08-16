"""
organization.py file contains general functions used to check database information.
"""

import textwrap

import language
import service
import validity_check

'''
Name: check_organization
Parameters: database connection object, string representing organization name
Returns: 1 if organization already exists in database; 0 otherwise
Does: checks if organization already exists in database
'''


def check_organization(cnx, org_name):
    if validity_check.check_length_valid(org_name, validity_check.max_org_name):
        org_cursor = cnx.cursor()
        org_stmt = "SELECT org_exists(%s) AS org_check"
        org_cursor.execute(org_stmt, org_name)
        check = org_cursor.fetchone()["org_check"]
        org_cursor.close()
        return check
    else:
        return 0


'''
Name: prompt_valid_org
Parameters: database connection object
Returns: string with organization name if valid, None otherwise
Does: prompts user for valid organization (ie. one that exists in the database)
    until user enters valid information or quits
'''


def prompt_valid_org(cnx):
    view_all = input("Would you like to see a list of the organizations in the database? (y/n)\n").lower()
    if view_all == 'y':
        display_orgs(cnx)
    org_name = input("Please enter the name of the organization you wish to select.\n")
    while True:
        check_len = validity_check.check_length_valid(org_name, validity_check.max_org_name)
        if not check_len:
            print("This name is too long (maximum is " + str(validity_check.max_org_name) + " characters).")
        else:
            org_check = check_organization(cnx, org_name)
            if org_check == 0:
                print("This organization does not exist in the database.\n")
            else:
                return org_name
        retry = input('Would you like to try again? (y/n)\n').lower()
        if retry == 'y':
            org_name = input("Please enter the name of the organization you wish to select.\n")
        else:
            return None


'''
Name: display_orgs
Parameters: database connection object
Returns: N/A
Does: displays organizations in the database
'''


def display_orgs(cnx):
    view_cursor = cnx.cursor()
    view_cursor.callproc("list_orgs")
    rows = view_cursor.fetchall()
    view_cursor.close()
    print("Organizations in the database:")
    for row in rows:
        print(row['orgName'])


'''
Name: find_single_org_by_name
Parameters: database connection object
Returns: N/A
Does: undertakes the search of a database item as prompted by the user
'''


# This is called by display_single_org and update_population.
# Both paths already check that the organization name is valid
def find_single_org_by_name(cnx, org_name):
    find_org_cursor = cnx.cursor()
    find_org_cursor.callproc("find_org_name", [org_name])
    # Organization name is unique, so there is at most one result
    row = find_org_cursor.fetchone()
    find_org_cursor.close()
    return row


'''
Name: display_single_org
Parameters: database connection object
Returns: N/A
Does: undertakes the search of a database item as prompted by the user
'''


# This is called by user_interaction.search and organization.update_basic_info
# Both already check that organization name is valid
def display_single_org(cnx, org_name):
    row = find_single_org_by_name(cnx, org_name)
    for key in row:
        if (key == 'Website') or (not row[key]):
            print(key + ':', row[key])
        else:
            print(key + ':', textwrap.fill(row[key], 70))
    print('')
    return row


'''
Name: orgs_by_lang_serv
Parameters: database connection object, string representing whether organizations will be searched by languages or 
            by services offered
Returns: N/A
Does: undertakes the search of a (set of) database item(s) as prompted by the user and displays the results
'''


def orgs_by_lang_serv(cnx, choose):
    if choose == 'language':
        criteria = language.prompt_valid_lang(cnx)
        proc = 'orgs_by_lang'
        message = 'There is no organization that currently offers that language.'
    else:
        criteria = service.prompt_valid_service(cnx)
        proc = 'orgs_by_service'
        message = 'There is no organization that currently offers that service.'
    if not criteria:
        return False
    search_cursor = cnx.cursor()
    search_cursor.callproc(proc, [criteria])
    rows = search_cursor.fetchall()
    search_cursor.close()
    if not rows:
        print(message)
    else:
        print("Organizations that offer " + criteria + " are:")
        for row in rows:
            print(row['Organization'])


'''
Name: delete organization
Parameters: database connection object, string representing org_name
Returns: N/A
Does: deletes the record of an organization from the database
'''


def delete_org(cnx, org_name):
    verify = input("Are you sure you want to delete " + org_name + "? (y/n)\n").lower()
    if verify == 'y':
        delete_cursor = cnx.cursor()
        delete_cursor.callproc("delete_org", [org_name])
        error_check = delete_cursor.fetchone()
        delete_cursor.close()
        if error_check:
            print(error_check["error"])
            return
        else:
            print("You have successfully deleted " + org_name + ".")
            cnx.commit()


'''
Name: update_basic_info
Parameters: database connection object, org_name
Returns: N/A
Does: updates the basic information of an organization (email, website, description, notes)
'''


# Only called by user_interactions.update_operation
# This already validates that organization name is valid
def update_basic_info(cnx, org_name):
    print('Current information for this organization:')
    current_info = display_single_org(cnx, org_name)
    selection_choice = select_basic_info()
    if not selection_choice:
        return
    # Note: the info_to update array corresponds to:
    # organization name(0), email(1), website(2), description(3), notes(4), population(5)
    # Population is updated separately
    # As of right now, organization name cannot be updated
    info_to_update = [org_name, None, None, None, None, None]
    for s in selection_choice:
        if s == '1':
            new_description = update_description(current_info['Description'])
            info_to_update[3] = new_description
        elif s == '2':
            new_website = update_website(current_info['Website'])
            info_to_update[2] = new_website
        elif s == '3':
            new_email = update_email(current_info['Email'])
            info_to_update[1] = new_email
        else:
            new_notes = update_notes(current_info['Additional Notes'])
            info_to_update[4] = new_notes
    org_update = update_info_in_database(cnx, info_to_update)
    if org_update:
        print('Updated information for this organization:')
        display_single_org(cnx, org_name)


'''
Name: update_population
Parameters: database connection object, org_name
Returns: N/A
Does: updates the target population of an organization
'''


# Only called by user_interactions.update_operation
# This already validates that organization name is valid
def update_population(cnx, org_name):
    print("Current population information for this organization:")
    current_info = find_single_org_by_name(cnx, org_name)
    for c in current_info:
        if c == 'Organization' or c == 'Target Population':
            if not current_info[c]:
                print(c + ':', current_info[c])
            else:
                print(c + ':', textwrap.fill(current_info[c], 70))
    user_check = input('Note: updating the target population will overwrite the existing value.\nAre you sure you want '
                       'to continue? (y/n)\n').lower()
    if user_check != 'y':
        return
    # Note: the info_to update array corresponds to:
    # organization name(0), email(1), website(2), description(3), notes(4), population(5)
    # Values other than population (and organization name) are updated separately
    # As of right now, organization name cannot be updated
    info_to_update = [org_name, None, None, None, None, None]
    new_population = verify_population()
    if new_population:
        info_to_update[5] = new_population
        org_update = update_info_in_database(cnx, info_to_update)
        if org_update:
            print("Updated population information for this organization:")
            current_info = find_single_org_by_name(cnx, org_name)
            for c in current_info:
                if c == 'Organization' or c == 'Target Population':
                    if not current_info[c]:
                        print(c + ':', current_info[c])
                    else:
                        print(c + ':', textwrap.fill(current_info[c], 70))
    else:
        return


'''
Name: select_basic_info
Parameters: database connection object, org_name
Returns: N/A
Does: selects what basic information of an organization (email, website, description, and/or notes) will be updated
'''


# Only called by update_basic_info
def select_basic_info():
    warning = 'Please note, any updates will overwrite the existing information (for example, updating the ' \
              'description will overwrite the current description, but the other fields will remain unchanged).'
    print(textwrap.fill(warning, 70))
    check_continue = input("Would you like to continue? (y/n)\n")
    if check_continue != 'y':
        return
    str_options = 'Options are:\n[1] description\n[2] website\n[3] email\n[4] additional notes\n'
    options = ['1', '2', '3', '4']
    all_options_valid = False
    while not all_options_valid:
        choose_what = input('What would you like to update? ' + str_options +
                            'Please enter the number for your selection(s), separated by a comma if you wish to '
                            'select more than one option (example: 1, 2).\n')
        choice_list = choose_what.replace(" ", "")
        choice_arr = choice_list.split(',')
        valid_choice_arr = []
        for c in choice_arr:
            if c not in options:
                print(c + ': This is not a valid option.')
            elif c in valid_choice_arr:
                print(c + ': You already selected this option.')
            else:
                valid_choice_arr.append(c)
        if valid_choice_arr:
            continue_check = input("You have selected the following options:\n" + str(valid_choice_arr) +
                                   "\nWould you like to [1] continue with those options, [2] try again, or [3] exit?\n"
                                   "Please enter either 1, 2, or 3.\n")
            if continue_check == "1":
                return valid_choice_arr
            elif continue_check == "2":
                continue
            else:
                return


'''
Name: update_info_in_database
Parameters: database connection object, array of 6 strings (or None values) corresponding to organization name(0), 
            email(1), website(2), description(3), notes(4), population(5)
Returns: True if update is successful, False otherwise
Does: updates the organization in the database with the information listed
'''


def update_info_in_database(cnx, new_info_arr):
    update_cursor = cnx.cursor()
    update_cursor.callproc("change_org", new_info_arr)
    error_check = update_cursor.fetchone()
    update_cursor.close()
    if error_check:
        print(error_check["error"])
        return False
    else:
        cnx.commit()
        print("Organization was updated successfully.")
        return True


'''
Name: update_email
Parameters: string (current email)
Returns: string (email) if valid, None if not
Does: verifies that user input for new email is valid
'''


def update_email(current_email):
    print("Current Email:", current_email)
    new_email = input("Please enter the new organization email.\n")
    check_email = validity_check.check_length_valid(new_email, validity_check.max_email)
    try_again = 'y'
    while not check_email and try_again == 'y':
        try_again = input("This email is too long (limit is " + str(validity_check.max_email) +
                          " characters).\nWould you like to try again? (y/n)\n").lower()
        if try_again == 'y':
            new_email = input("Please enter the new organization email.\n")
            check_email = validity_check.check_length_valid(new_email, validity_check.max_email)
        else:
            new_email = None
    return new_email


'''
Name: update_website
Parameters: string (current website)
Returns: string (website) if valid, None if not
Does: verifies that user input for new website is valid
'''


def update_website(current_website):
    print('Current Website:', current_website)
    new_website = input("Please enter the new organization website.\n")
    check_website = validity_check.check_length_valid(new_website, validity_check.max_website)
    try_again = 'y'
    while not check_website and try_again == 'y':
        try_again = input("This website is too long (limit is " + str(validity_check.max_website) +
                          " characters).\nWould you like to try again? (y/n)\n").lower()
        if try_again == 'y':
            new_website = input("Please enter the new organization website.\n")
            check_website = validity_check.check_length_valid(new_website, validity_check.max_website)
        else:
            new_website = None
    return new_website


'''
Name: update_description
Parameters: string (current description)
Returns: string (description) if valid, None if not
Does: verifies that user input for new description is valid
'''


def update_description(current_description):
    print('Current Description:', textwrap.fill(current_description, 70))
    new_description = input("Please enter the new organization description.\n")
    check_description = validity_check.check_length_valid(new_description, validity_check.max_description)
    try_again = 'y'
    while not check_description and try_again == 'y':
        try_again = input("This description is too long (limit is " + str(validity_check.max_description) +
                          " characters).\nWould you like to try again? (y/n)\n").lower()
        if try_again == 'y':
            new_description = input("Please enter the new organization description.\n")
            check_description = validity_check.check_length_valid(new_description, validity_check.max_description)
        else:
            new_description = None
    return new_description


'''
Name: update_notes
Parameters: string (current notes)
Returns: string (notes) if valid, None if not
Does: verifies that user input for new notes is valid
'''


def update_notes(current_notes):
    print('Current Additional Notes:', textwrap.fill(current_notes, 70))
    new_notes = input("Please enter the new notes for the notes.\n")
    check_notes = validity_check.check_length_valid(new_notes, validity_check.max_notes)
    try_again = 'y'
    while not check_notes and try_again == 'y':
        try_again = input("These notes are too long (limit is " + str(validity_check.max_notes) +
                          " characters).\nWould you like to try again? (y/n)\n").lower()
        if try_again == 'y':
            new_notes = input("Please enter the new notes for the organization.\n")
            check_notes = validity_check.check_length_valid(new_notes, validity_check.max_notes)
        else:
            new_notes = None
    return new_notes


'''
Name: verify_population
Parameters: None
Returns: string (population) if valid, None if not
Does: verifies that user input for new target population is valid
'''


def verify_population():
    new_population = input("Please enter the new target population for the organization.\n")
    check_population = validity_check.check_length_valid(new_population, validity_check.max_population)
    try_again = 'y'
    while not check_population and try_again == 'y':
        try_again = input("This target population is too long (limit is " + str(validity_check.max_population) +
                          " characters).\nWould you like to try again? (y/n)\n").lower()
        if try_again == 'y':
            new_population = input("Please enter the new target population for the organization.\n")
            check_population = validity_check.check_length_valid(new_population, validity_check.max_population)
        else:
            new_population = None
    return new_population
