"""
user_interactions.py file contains functions that are used by the user interface.
"""

import create_obj
import service
import language
import address
import organization
import lang_serv

'''
Name: create_operation
Parameters: database connection object
Returns: N/A
Does: undertakes creation of a database item prompted by the user
'''


def create_operation(cnx):
    create_actions = ['1', '2', '3']
    create_what = input("What would you like to create? Options are:\n[1] organization\n[2] language\n[3] service\n"
                        "Please enter the number corresponding to the desired action.\n")
    while create_what not in create_actions:
        create_what = input("This is not a valid option. Please try again.\nOptions are:\n[1] organization\n"
                            "[2] language\n[3] service\nPlease enter the number corresponding to the desired action.\n")
    if create_what == '1':
        create_obj.Create(cnx)
    elif create_what == '2':
        language.create_language(cnx)
    else:
        service.create_service(cnx)


'''
Name: search_operation
Parameters: database connection object
Returns: N/A
Does: undertakes the search of a database item as prompted by the user
'''


def search_operation(cnx):
    while True:
        search_options = "Options are:\n[1] find organization by name\n[2] find organizations by language\n[3] find " \
                         "organizations by services offered"
        search_type = validate_search_delete_options(search_options, 'search')
        if not search_type:
            return False
        if search_type == '1':
            org_name = organization.prompt_valid_org(cnx)
            if org_name:
                organization.display_single_org(cnx, org_name)
        elif search_type == '2':
            organization.orgs_by_lang_serv(cnx, 'language')
        else:
            organization.orgs_by_lang_serv(cnx, 'service')
        search_again = input("Would you like to do another search? (y/n)\n").lower()
        if search_again != 'y':
            return False


'''
Name: update_operation
Parameters: database connection object
Returns: N/A
Does: undertakes update of a database item prompted by the user
'''


def update_operation(cnx):
    update_what = input("What would you like to update? Options are:\n[1] addresses for an organization\n"
                        "[2] languages offered by an organization\n[3] services offered by an organization\n"
                        "[4] target population of an organization\n[5] basic information of an organization\n"
                        "Please enter the number associated with your selection.\n")
    update_actions = ['1', '2', '3', '4', '5']
    while update_what not in update_actions:
        update_what = input("This is not a valid option. Please try again.\nOptions are:\n[1] addresses for an "
                            "organization\n[2] languages offered by an organization\n[3] services offered by an "
                            "organization\n[4] target population of an organization\n[5] basic information of an "
                            "organization\nPlease enter only the number associated with your selection.\n")
    org_check = 0
    while org_check == 0:
        view_org = input("Would you like to view a list of existing organizations? (y/n)\n").lower()
        if view_org == 'y':
            organization.display_orgs(cnx)
        org_name = input("What organization would you like to update?\n")
        org_check = organization.check_organization(cnx, org_name)
        if org_check == 0:
            escape_check = input("This organization does not exist in the database. Would you like to try again? "
                                 "(y/n)\n").lower()
            if escape_check == 'n':
                return False
    if update_what == '1':
        address.update_addresses(cnx, org_name)
    elif update_what == '2':
        language.update_languages(cnx, org_name)
    elif update_what == '3':
        service.update_services(cnx, org_name)
    elif update_what == '4':
        organization.update_population(cnx, org_name)
    else:
        organization.update_basic_info(cnx, org_name)


'''
Name: delete_operation
Parameters: database connection object
Returns: N/A
Does: undertakes the delete of a database item as prompted by the user
'''


def delete_operation(cnx):
    delete_options = "Options are:\n[1] organization\n[2] language record\n[3] service type record\n\nNote: you can " \
                     "only delete a language or service record if it is not in use by any organizations.\nIf you want "\
                     "to delete either one from an organization, enter 'q' to go back and then select 'Update' from " \
                     "the main menu. "
    delete_type = validate_search_delete_options(delete_options, 'delete')
    if not delete_type:
        return False
    if delete_type == '1':
        org_name = organization.prompt_valid_org(cnx)
        if org_name:
            organization.delete_org(cnx, org_name)
    elif delete_type == '2':
        lang = language.prompt_valid_lang(cnx)
        if lang:
            lang_serv.delete_lang_serv(cnx, lang, 'language')
    else:
        serv = service.prompt_valid_service(cnx)
        if serv:
            lang_serv.delete_lang_serv(cnx, serv, 'service')


'''
Name: choose_search_type
Parameters: string (list of valid search options for input)
Returns: int (number corresponding to a valid search option, or None if user decides not to select a valid option)
Does: verifies that user inputs proper option for searching the database
'''


def validate_search_delete_options(options, action):
    if action == 'search':
        prompt = 'How would you like to search?\n'
    else:
        prompt = 'What would you like to delete?\n'
    search_what = input(prompt + options + "\nPlease enter the number corresponding with your desired option.\n")
    valid_option = False
    while not valid_option:
        if action == 'delete' and search_what.lower() == 'q':
            return
        if not search_what.isnumeric() or not (1 <= int(search_what) <= 3):
            if not search_what.isnumeric():
                print("Please enter only the number listed by one of the options.")
            else:
                print("This is not one of the numbers listed by the options.")
            view_again = input("Would you like to view the options again? (y/n)\n")
            if view_again == 'y':
                print(options)
            try_again = input("Would you like to try entering another option? (y/n)\n").lower()
            if try_again == 'n':
                return
            else:
                search_what = input("Please enter the number corresponding to an option.\n")
        else:
            return search_what
