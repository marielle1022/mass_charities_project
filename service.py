"""
service.py file contains functions used to create and update services.
"""

import textwrap

import organization
import lang_serv
import validity_check

# Constant: number of characters to wrap output
wrap_char = 70

'''
Name: create_service
Parameters: database connection object
Returns: True if successful; False otherwise
Does: creates a new service in the database
'''


def create_service(cnx):
    while True:
        valid_service = False
        while not valid_service:
            service = input("Please enter the service to be offered.\n")
            if (not validity_check.check_length_valid(service, validity_check.max_service_type)) or (not service):
                if not service:
                    print("You did not enter a service description.")
                else:
                    print("This service description is too long (limit is " + str(validity_check.max_service_type)
                          + " characters).")
                try_again = input("Would you like to try again? (y/n)\n").lower()
                if try_again == 'n':
                    return False
            else:
                valid_service = True
        service_arr = [service]
        service_cursor = cnx.cursor()
        service_cursor.callproc("create_service", service_arr)
        error_check = service_cursor.fetchone()
        service_cursor.close()
        if error_check:
            print(error_check['error'] + "\n")
            recent_service_added = True
        else:
            print("Service was added successfully.")
            recent_service_added = True
            cnx.commit()
        add_another = input("Would you like to add another service? (y/n)\n")
        if add_another != 'y':
            return recent_service_added


'''
Name: update_services
Parameters: database connection object; string (organization name)
Returns: N/A
Does: Updates (adds new, modifies existing, or deletes existing) services associated with the given organization
'''


# Note: only called by user_interactions.update_operation, which already verifies that organization name is valid
def update_services(cnx, org_name):
    user_exit = False
    while not user_exit:
        org_services = lang_serv.get_org_lang_serv(cnx, org_name, "view_org_services")
        if org_services:
            print("Services offered by this organization are:")
            lang_serv.display_org_lang_serv(org_services, 'serviceType')
            options = ['1', '2', '3']
            user_choice = input("How would you like to update organization services? Your options are:\n"
                                "[1] do nothing\n[2] add new\n[3] delete existing\n"
                                "Please input the number corresponding to your selection.\n")
            while user_choice not in options:
                print("This is not a valid option. Please try again.")
                user_choice = input("Your options are:\n[1] do nothing\n[2] add new\n"
                                    "[3] delete existing\nPlease input the number corresponding to your selection.\n")
        else:
            options = ['1', '2']
            user_choice = input("There are no existing services for this organization.\nWhat you like to do? Your "
                                "options are:\n[1] do nothing\n[2] add new\nPlease input the number corresponding to "
                                "your selection.\n")
            while user_choice not in options:
                print("This is not a valid option. Please try again.")
                user_choice = input("Your options are:\n[1] do nothing\n[2] add new\nPlease input the number "
                                    "corresponding to your selection.\n")
        if user_choice == '1':
            return
        elif user_choice == '2':
            add_org_services(cnx, org_name)
        else:
            delete_org_service(cnx, org_name)
        update_another = input("Would you like to update more services for this organization? (y/n)\n").lower()
        if update_another != 'y':
            user_exit = True


'''
Name: add_org_services
Parameters: database connection object, string representing service type
Returns: False if trying to add to an organization that does not exist
Does: adds existing services to an organization
'''


def add_org_services(cnx, org_name):
    if organization.check_organization(cnx, org_name) == 0:
        print("This organization does not exist in the database.")
        return False
    display_existing_services(cnx)
    service_list_str = input("Please list all desired services, separated a comma (format: service1, service2).\n")
    service_arr = service_list_str.split(',')
    for service in service_arr:
        service = service.strip()
        add_service_cursor = cnx.cursor()
        add_service_cursor.callproc("add_org_service", [service, org_name])
        error_check = add_service_cursor.fetchone()
        add_service_cursor.close()
        if error_check:
            print(service + ": " + error_check['error'])
        else:
            print(service + " was added successfully.")
            cnx.commit()


'''
Name: delete_org_service
Parameters: database connection object; string (organization name)
Returns: N/A
Does: deletes the desired record connecting a service to the organization
'''


# Note: this is only called by update_services
# This path already checks that organization name is valid AND that at least one service exists for this organization
def delete_org_service(cnx, org_name):
    services = lang_serv.get_org_lang_serv(cnx, org_name, "view_org_services")
    print("The services associated with this organization are:")
    lang_serv.display_org_lang_serv(services, 'serviceType')
    serv = input("What service would you like to delete?\n")
    check_serv = 0
    for s in services:
        if s["serviceType"].lower() == serv.lower():
            check_serv += 1
    if check_serv == 0:
        print("The service you selected does not exist for this organization.")
        return False
    else:
        print("You have selected the following service: " + serv)
        delete_check = input("Are you sure you want to delete this service from this organization? (y/n)\n").lower()
        if delete_check == 'y':
            delete_cursor = cnx.cursor()
            delete_cursor.callproc("delete_org_service", [org_name, serv])
            rows = delete_cursor.fetchall()
            delete_cursor.close()
            if rows:
                for row in rows:
                    print(row['error'])
            else:
                print("The service was deleted successfully from this organization.")
                cnx.commit()
        else:
            return False


'''
Name: display_existing_services
Parameters: database connection object
Returns: N/A
Does: displays services that already exist in the database
'''


def display_existing_services(cnx):
    get_service_cursor = cnx.cursor()
    get_service_cursor.callproc("list_services", [])
    rows = get_service_cursor.fetchall()
    get_service_cursor.close()
    all_services_arr = []
    for row in rows:
        all_services_arr.append(row["serviceType"])
    all_services_str = ' | '.join(all_services_arr)
    print("Available services are:\n" + textwrap.fill(all_services_str, wrap_char) + "\n")


'''
Name: prompt_valid_service
Parameters: database connection object
Returns: string with service type if valid, None otherwise
Does: prompts user for valid service type (ie. one that exists in the database)
    until user enters valid information or quits
'''


def prompt_valid_service(cnx):
    view_all = input("Would you like to see a list of the services in the database? (y/n)\n").lower()
    if view_all == 'y':
        display_existing_services(cnx)
    service = input("Please enter the service type you wish to select.\n")
    serv_check = check_service_exists(cnx, service)
    while serv_check == 0:
        print("This service type does not exist in the database.\n")
        try_again = input("Would you like to try entering another service type? (y/n)\n").lower()
        if try_again == 'y':
            service = input("Please enter the service type you wish to select.\n")
            serv_check = check_service_exists(cnx, service)
        else:
            return None
    return service


'''
Name: check_service_exists
Parameters: database connection object, string representing service type
Returns: 1 if service type exists in database; 0 otherwise
Does: checks if service type exists in database
'''


def check_service_exists(cnx, service):
    if validity_check.check_length_valid(service, validity_check.max_service_type):
        serv_cursor = cnx.cursor()
        serv_stmt = "SELECT service_exists(%s) AS serv_check"
        serv_cursor.execute(serv_stmt, service)
        check = serv_cursor.fetchone()["serv_check"]
        serv_cursor.close()
        return check
    else:
        return 0
