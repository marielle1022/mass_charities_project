"""
language.py file contains functions used to create and update languages.
"""

import re

import organization
import validity_check
import lang_serv
import textwrap

# Constant: regex pattern for language names (allows uppercase, lowercase, spaces, and hyphens)
lang_pattern = re.compile("[a-zA-Z\\s\\-]*")
# Constant: number of characters to wrap output
wrap_char = 70

'''
Name: update_languages
Parameters: database connection object; string (organization name)
Returns: N/A
Does: Updates (adds new, modifies existing, or deletes existing) languages associated with the given organization
'''


# Note: only called by user_interactions.update_operation, which already verifies that organization name is valid
def update_languages(cnx, org_name):
    user_exit = False
    while not user_exit:
        org_languages = lang_serv.get_org_lang_serv(cnx, org_name, "view_org_languages")
        if org_languages:
            print("Languages offered by this organization are:")
            lang_serv.display_org_lang_serv(org_languages, 'languageName')
            options = ['1', '2', '3']
            user_choice = input("How would you like to update organization languages? Your options are:\n"
                                "[1] do nothing\n[2] add new\n[3] delete existing\n"
                                "Please input the number corresponding to your selection.\n")
            while user_choice not in options:
                print("This is not a valid option. Please try again.")
                user_choice = input("Your options are:\n[1] do nothing\n[2] add new\n"
                                    "[3] delete existing\nPlease input the number corresponding to your selection.\n")
        else:
            options = ['1', '2']
            user_choice = input("There are no existing languages for this organization.\nWhat you like to do? Your "
                                "options are:\n[1] do nothing\n[2] add new\nPlease input the number corresponding to "
                                "your selection.\n")
            while user_choice not in options:
                print("This is not a valid option. Please try again.")
                user_choice = input("Your options are:\n[1] do nothing\n[2] add new\nPlease input the number "
                                    "corresponding to your selection.\n")
        if user_choice == '1':
            return
        elif user_choice == '2':
            add_org_languages(cnx, org_name)
        else:
            delete_org_lang(cnx, org_name)
        update_another = input("Would you like to update more languages for this organization? (y/n)\n").lower()
        if update_another != 'y':
            user_exit = True


'''
Name: create_language
Parameters: database connection object
Returns: True if successful; False otherwise
Does: creates a new language in the database
'''


def create_language(cnx):
    while True:
        valid_language = False
        while not valid_language:
            language = input("Please enter a language name.\n")
            # Note: not using validity check function to add language name so that more informative error messages can
            # be displayed.
            check_len = validity_check.check_length_valid(language, validity_check.max_language_name)
            check_pattern = re.fullmatch(lang_pattern, language)
            if not check_len or not check_pattern or not language:
                if not check_len:
                    print("This language name is too long (limit is " + str(validity_check.max_language_name) +
                          " characters).")
                elif not language:
                    print("You did not enter a language name.")
                else:
                    print("This language name is not valid. Only include letters, spaces, and/or hyphens.")
                try_again = input("Would you like to try again? (y/n)\n").lower()
                if try_again != 'y':
                    return False
            else:
                valid_language = True
        lang_arr = [language]
        lang_cursor = cnx.cursor()
        lang_cursor.callproc("create_language", lang_arr)
        error_check = lang_cursor.fetchone()
        lang_cursor.close()
        if error_check:
            print(error_check['error'] + "\n")
            recent_language_valid = False
        else:
            print("Language was created successfully.")
            recent_language_valid = True
            cnx.commit()
        add_another = input("Would you like to enter another language? (y/n)\n").lower()
        if add_another != 'y':
            return recent_language_valid


'''
Name: add_org_languages
Parameters: database connection object, string representing organization name
Returns: False if trying to add to an organization that does not exist
Does: adds existing languages to an organization
'''


# Note: this is only called by create_obj.create_full_process and update_languages
# Both paths already check that organization is valid
def add_org_languages(cnx, org_name):
    if organization.check_organization(cnx, org_name) == 0:
        print("This organization does not exist in the database.")
        return False
    display_existing_languages(cnx)
    lang_list_str = input("Please list all desired languages, separated a comma\n(format: lang1, lang2).\n")
    lang_arr = lang_list_str.split(',')
    for lang in lang_arr:
        lang = lang.strip()
        if validity_check.check_language_name(lang):
            add_lang_cursor = cnx.cursor()
            add_lang_cursor.callproc("add_org_language", [lang, org_name])
            error_check = add_lang_cursor.fetchone()
            add_lang_cursor.close()
            if error_check:
                print(lang + ": " + error_check['error'])
            else:
                print(lang + " was added successfully.")
                cnx.commit()
        else:
            print(lang + ": This is not a valid language name.")


'''
Name: delete_org_lang
Parameters: database connection object; string (organization name)
Returns: N/A
Does: deletes the desired record connecting a language to the organization
'''


# Note: this is only called by update_languages
# This path already checks that organization name is valid AND that at least one language exists for this organization
def delete_org_lang(cnx, org_name):
    langs = lang_serv.get_org_lang_serv(cnx, org_name, "view_org_languages")
    print("The languages associated with this organization are:")
    lang_serv.display_org_lang_serv(langs, 'languageName')
    lang = input("What language would you like to delete?\n").lower()
    check_lang = 0
    for l in langs:
        if l["languageName"].lower() == lang:
            check_lang += 1
    if check_lang == 0:
        print("The language you selected does not exist for this organization.")
        return False
    else:
        print("You have selected the following language: " + lang)
        delete_check = input("Are you sure you want to delete this language? (y/n)\n").lower()
        if delete_check == 'y':
            delete_cursor = cnx.cursor()
            delete_cursor.callproc("delete_org_language", [org_name, lang])
            rows = delete_cursor.fetchall()
            delete_cursor.close()
            if rows:
                for row in rows:
                    print(row['error'])
            else:
                cnx.commit()
        else:
            return False


'''
Name: get_existing_languages
Parameters: database connection object
Returns: N/A
Does: gets a list of languages that already exist in the database
'''


def get_existing_languages(cnx):
    get_lang_cursor = cnx.cursor()
    get_lang_cursor.callproc("list_languages", [])
    rows = get_lang_cursor.fetchall()
    get_lang_cursor.close()
    all_lang_arr = []
    for row in rows:
        all_lang_arr.append(row["languageName"])
    return all_lang_arr


'''
Name: display_existing_languages
Parameters: database connection object
Returns: N/A
Does: displays a list of languages that already exist in the database
'''


def display_existing_languages(cnx):
    all_lang_arr = get_existing_languages(cnx)
    all_lang_str = ' | '.join(all_lang_arr)
    print("Available languages are:\n" + textwrap.fill(all_lang_str, wrap_char) + "\n")


'''
Name: prompt_valid_lang
Parameters: database connection object
Returns: string with language name if valid, None otherwise
Does: prompts user for valid language (ie. one that exists in the database)
    until user enters valid information or quits
'''


def prompt_valid_lang(cnx):
    view_all = input("Would you like to see a list of the languages in the database? (y/n)\n").lower()
    if view_all == 'y':
        display_existing_languages(cnx)
    lang = input("Please enter the language you wish to select.\n")
    lang_check = check_lang_exists(cnx, lang)
    while lang_check == 0:
        print("This language does not exist in the database.\n")
        try_again = input("Would you like to try entering another language? (y/n)\n").lower()
        if try_again == 'y':
            lang = input("Please enter the language you wish to select.\n")
            lang_check = check_lang_exists(cnx, lang)
        else:
            return None
    return lang


'''
Name: check_lang_exists
Parameters: database connection object, string representing language
Returns: 1 if language exists in database; 0 otherwise
Does: checks if language exists in database
'''


def check_lang_exists(cnx, lang_name):
    if validity_check.check_language_name(lang_name):
        lang_cursor = cnx.cursor()
        lang_stmt = "SELECT lang_exists(%s) AS lang_check"
        lang_cursor.execute(lang_stmt, lang_name)
        check = lang_cursor.fetchone()["lang_check"]
        lang_cursor.close()
        return check
    else:
        return 0
