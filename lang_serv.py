'''
lang_serv.py holds functions that can be abstracted out and used for both language.py and service.py.
'''

# Note: Additional functions likely can be abstracted out -- will do so in the future (with more time)

'''
Name: get_org_lang_serv
Parameters: database connection object; string representing organization name, string representing procedure to be run
Returns: collection of languages or services associated with an organization
Does: finds any languages or services associated with a given organization
'''


# Note: this is only called by update_languages and delete_org_lang
# This path already checks that organization name is valid
# Note: with more time to refactor, abstract out (pass proc as parameter)
def get_org_lang_serv(cnx, org_name, procedure):
    o_cursor = cnx.cursor()
    o_cursor.callproc(procedure, [org_name])
    rows = o_cursor.fetchall()
    o_cursor.close()
    return rows


'''
Name: display_org_lang_serv
Parameters: collection of languages or services associated with a single organization
Returns: N/A
Does: Prints the languages or services
'''


def display_org_lang_serv(collection, key):
    for c in collection:
        print(c[key])


'''
Name: delete language or service
Parameters: database connection object, string representing the language or service, string representing whether it is
a language or service to be deleted
Returns: N/A
Does: deletes the record of a language or service from the database.
    Note: this cannot occur if the language or service is associated with an organization.
'''


def delete_lang_serv(cnx, item, option):
    verify = input("Are you sure you want to delete " + item + "? (y/n)\n").lower()
    if verify == 'y':
        if option == 'language':
            procedure = 'delete_language_record'
        else:
            procedure = 'delete_service_record'
        delete_cursor = cnx.cursor()
        delete_cursor.callproc(procedure, [item])
        error_check = delete_cursor.fetchone()
        delete_cursor.close()
        if error_check:
            print(error_check["error"])
            return
        else:
            cnx.commit()
            print("You have successfully deleted " + item + ".")
