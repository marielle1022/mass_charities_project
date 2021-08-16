"""
address.py file contains functions that are used to create and update addresses.
"""

import validity_check

'''
Name: update_addresses
Parameters: database connection object; string (organization name)
Returns: N/A
Does: Updates (adds new, modifies existing, or deletes existing) addresses associated with the given organization
'''


# Note: only called by user_interactions.update_operation, which already verifies that organization name is valid
def update_addresses(cnx, org_name):
    user_exit = False
    while not user_exit:
        org_has_address = check_if_addresses(cnx, org_name)
        if org_has_address:
            view_addresses(cnx, org_name)
            options = ['1', '2', '3', '4']
            user_choice = input("How would you like to update organization addresses? Your options are:\n"
                                "[1] do nothing\n[2] add new\n[3] update existing\n[4] delete existing\n"
                                "Please input the number corresponding to your selection.\n")
            while user_choice not in options:
                print("This is not a valid option. Please try again.")
                user_choice = input("Your options are:\n[1] do nothing\n[2] add new\n[3] update existing\n"
                                    "[4] delete existing\nPlease enter the number corresponding to your selection.\n")
        else:
            options = ['1', '2']
            user_choice = input("There are no existing addresses for this organization.\nWhat you like to do? Your "
                                "options are:\n[1] do nothing\n[2] add new\nPlease input the number corresponding to "
                                "your selection.\n")
            while user_choice not in options:
                print("This is not a valid option. Please try again.")
                user_choice = input("Your options are:\n[1] do nothing\n[2] add new\nPlease input the number "
                                    "corresponding to your selection.\n")
        if user_choice == '1':
            return
        elif user_choice == '2':
            input_addresses(cnx, org_name)
        elif user_choice == '3':
            modify_existing(cnx, org_name)
        else:
            delete_existing_address(cnx, org_name)
        update_another = input("Would you like to update more addresses for this organization? (y/n)\n").lower()
        if update_another != 'y':
            user_exit = True


'''
Name: input_addresses
Parameters: database connection object; string (organization name)
Returns: nothing
Does: Creates addresses as desired by the user.
'''


# Note: input_addresses only called by address.update_addresses and create_obj.create_full_process
# Both paths already check for valid organization name
def input_addresses(cnx, org_name):
    address_desired = 'y'
    while address_desired == 'y':
        address = new_address_checks(org_name)
        address_cursor = cnx.cursor()
        address_cursor.callproc("add_address", address)
        rows = address_cursor.fetchall()
        address_cursor.close()
        if rows:
            for row in rows:
                print(row['error'])
        else:
            print("This address was created successfully.")
            cnx.commit()
        address_desired = input("Would you like to enter another address? (y/n)\n").lower()


'''
Name: view_addresses
Parameters: database connection object; string (organization name)
Returns: N/A
Does: Displays addresses associated with the given organization
'''


def view_addresses(cnx, org_name):
    org = [org_name]
    view_cursor = cnx.cursor()
    view_cursor.callproc("view_org_addresses", org)
    rows = view_cursor.fetchall()
    view_cursor.close()
    print("Addresses associated with this organization are:")
    # NOTE: want to update output to nicer format (do later, maybe create helper function)
    if not rows:
        print('No addresses are associated with this organization.')
    for row in rows:
        print(row)


'''
Name: delete_existing_address
Parameters: database connection object; string (organization name)
Returns: N/A
Does: deletes the desired address
'''


# Note: this is only called by update_addresses
# This path already checks that organization name is valid
def delete_existing_address(cnx, org_name):
    addr_id = select_existing(cnx, org_name)
    if not addr_id:
        return False
    show_addr_cursor = cnx.cursor()
    show_addr_cursor.callproc("view_single_address", [addr_id])
    result = show_addr_cursor.fetchone()
    show_addr_cursor.close()
    print("You have selected the following address:")
    print(result)
    delete_check = input("Are you sure you want to delete this address? (y/n)\n").lower()
    if delete_check == 'y':
        delete_cursor = cnx.cursor()
        delete_cursor.callproc("delete_address", [addr_id])
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
Name: modify_existing
Parameters: database connection object; string (organization name)
Returns: N/A
Does: Modifies the desired address
'''


# Note: this is only called by update_addresses
# This path already checks that organization name is valid
def modify_existing(cnx, org_name):
    addr_id = select_existing(cnx, org_name)
    if not addr_id:
        return False
    show_addr_cursor = cnx.cursor()
    show_addr_cursor.callproc("view_single_address", [addr_id])
    result = show_addr_cursor.fetchone()
    show_addr_cursor.close()
    print("You have selected the following address:")
    print(result)
    mod_values = modify_address_checks(addr_id)
    modify_cursor = cnx.cursor()
    modify_cursor.callproc("change_address", mod_values)
    rows = modify_cursor.fetchall()
    modify_cursor.close()
    if rows:
        for row in rows:
            print(row["error"])
    else:
        cnx.commit()
        print("The address is now listed as follows:")
        show_new_cursor = cnx.cursor()
        show_new_cursor.callproc("view_single_address", [addr_id])
        new_result = show_new_cursor.fetchone()
        show_new_cursor.close()
        print(new_result)


'''
Name: select_existing
Parameters: database connection object; string (organization name)
Returns: N/A
Does: Finds a valid address that user would like to modify
'''


# Note: this is only called by modify_existing and update_existing
# These paths already checks that organization name is valid
def select_existing(cnx, org_name):
    address_choice = input("Please enter the AddressID of the desired address. If "
                           "you need to view the addresses again, enter 'v'.\nIf you do not want "
                           "to make any changes to the addresses, enter 'q'.\n")
    valid_address_choice = False
    while valid_address_choice is False:
        if address_choice.isnumeric():
            if check_address_exists(cnx, org_name, int(address_choice)) == 0:
                address_choice = input("This is not one of the addresses listed. Please try again.\n")
            else:
                return address_choice
        else:
            if address_choice.isalpha() and ((address_choice.lower() == 'v') or (address_choice.lower() == 'q')):
                if address_choice.lower() == 'v':
                    view_addresses(cnx, org_name)
                    address_choice = input("Please enter the desired AddressID from the options listed, or "
                                           "'q' if you do not want to make changes.\n")
                else:
                    return False
            else:
                address_choice = input("This is not a valid input. Please enter the desired AddressID "
                                       "or 'v' if you need to view the addresses again.\n")


'''
Name: check_if_addresses
Parameters: database connection object; string representing organization name
Returns: True if organization has associated addresses, False otherwise
Does: Checks if any addresses exist in the database for a given organization.
'''


# Note: this is only called by update_addresses
# This path already checks that organization name is valid
def check_if_addresses(cnx, org_name):
    address_cursor = cnx.cursor()
    address_cursor.callproc("view_org_addresses", [org_name])
    rows = address_cursor.fetchall()
    address_cursor.close()
    if rows:
        return True
    else:
        return False


'''
Name: new_address_checks
Parameters: string representing organization name
Returns: array with 6 strings
Does: Checks user input for validity for different parts of addresses. Creates an array
    with the organization name, address name(if desired), street address, town, zip code,
    and phone number associated with the address.
'''


# Note: this is only called by create_obj.create_full_process and input_addresses
# Both paths already check that organization name is valid
def new_address_checks(org_name):
    street = input("Please enter the street address (including suite/office number if applicable).\n")
    check_str = validity_check.check_length_valid(street, validity_check.max_address_street)
    while not street or not check_str:
        if not street:
            street = input("This field is required. Please try again.\n")
        else:
            street = input("This street name is too long (limit is " + str(validity_check.max_address_street) +
                           " characters). Please check for errors and try again.\n")
        check_str = validity_check.check_length_valid(street, validity_check.max_address_street)
    town = input("Please enter the town.\n")
    check_town = validity_check.check_length_valid(town, validity_check.max_address_town)
    while not town or not check_town:
        if not town:
            town = input("This field is required. Please try again.\n")
        else:
            town = input("This town name is too long (limit is " + str(validity_check.max_address_town) +
                         " characters). Please check for errors and try again.\n")
        check_town = validity_check.check_length_valid(town, validity_check.max_address_town)
    zip_code = input("Please enter the zip code.\n")
    check_zip = validity_check.check_zip_pattern(zip_code)
    while not check_zip:
        zip_code = input("This zip code is not valid. Please try again (format: xxxxx).\n")
        check_zip = validity_check.check_zip_pattern(zip_code)
    name_desired = input("Would you like to enter a name for this address? (y/n)\n").lower()
    if name_desired == 'y':
        address_name = input("Please enter the name for the address.\n")
        check_addr_name = validity_check.check_length_valid(address_name, validity_check.max_address_name)
        while (not check_addr_name or not address_name) and (name_desired == 'y'):
            if not address_name:
                print("You did not enter an address name.")
            else:
                print("This name is too long (limit is " + str(validity_check.max_address_name) + " characters).")
            name_desired = input("Would you like to try again? (y/n)\n").lower()
            if name_desired == 'y':
                address_name = input("Please enter the name for the address.\n")
                check_addr_name = validity_check.check_length_valid(address_name, validity_check.max_address_name)
            else:
                address_name = None
    else:
        address_name = None
    phone_desired = input("Would you like to enter a phone number for this address? (y/n)\n").lower()
    if phone_desired == 'y':
        address_phone = input("Please enter the phone number for the address (format: xxx-xxx-xxxx).\n")
        check_phone = validity_check.check_phone_pattern(address_phone)
        while not check_phone and (phone_desired == 'y'):
            print("This phone number is not valid (format: xxx-xxx-xxxx).")
            phone_desired = input("Would you like to try again? (y/n)\n")
            if phone_desired == 'y':
                address_phone = input("Please enter the phone number (format: xxx-xxx-xxxx).\n")
                check_phone = validity_check.check_phone_pattern(address_phone)
            else:
                address_phone = None
    else:
        address_phone = None
    address_arr = [org_name, address_name, street, town, zip_code, address_phone]
    return address_arr


'''
Name: modify_address_checks
Parameters: string representing organization name
Returns: array with one integer and 5 strings
Does: Checks user input for validity for different parts of addresses for the address sections they wish to update.
    Creates an array with the address id, address name(if desired), street address, town, zip code,
    and phone number associated with the address.
'''


# Note: this is only called by modify_existing
# This path already checks that organization name is valid
# NOTE: if there's time later, try to clean this up
def modify_address_checks(addr_id):
    name_check = input("Would you like to update the address name? (y/n)\n").lower()
    if name_check == 'y':
        new_name = input("Please enter the new name for the address.\n")
        check_addr_name = validity_check.check_length_valid(new_name, validity_check.max_address_name)
        while (not check_addr_name or not new_name) and (name_check == 'y'):
            if not new_name:
                print("You did not enter an address name.")
            else:
                print("This name is too long (limit is " + str(validity_check.max_address_name) + " characters).")
            name_check = input("Would you like to try again? (y/n)\n").lower()
            if name_check == 'y':
                new_name = input("Please enter the name for the address.\n")
                check_addr_name = validity_check.check_length_valid(new_name, validity_check.max_address_name)
            else:
                new_name = None
    else:
        new_name = None
    street_check = input("Would you like to update the street? (y/n)\n").lower()
    if street_check == 'y':
        new_street = input("Please input the new street address, including the office/suite if applicable.\n")
        check_str = validity_check.check_length_valid(new_street, validity_check.max_address_street)
        while (not new_street or not check_str) and street_check == 'y':
            if not new_street:
                print("You did not enter a street.")
            else:
                print("This street name is too long (limit is " + str(validity_check.max_address_street) +
                      " characters).")
            street_check = input("Would you like to try again? (y/n)\n").lower()
            if street_check == 'y':
                new_street = input("Please input the new street address, including the office/suite if applicable.\n")
                check_str = validity_check.check_length_valid(new_street, validity_check.max_address_street)
            else:
                new_street = None
    else:
        new_street = None
    town_check = input("Would you like to update the town? (y/n)\n").lower()
    if town_check == 'y':
        new_town = input("Please input the new town.\n")
        check_town = validity_check.check_length_valid(new_town, validity_check.max_address_town)
        while (not new_town or not check_town) and town_check == 'y':
            if not new_town:
                print("You did not input a town.")
            else:
                print("This town name is too long (limit is " + str(validity_check.max_address_town) + " characters).")
            town_check = input("Would you like to try again? (y/n)\n").lower()
            if town_check == 'y':
                new_town = input("Please input the new town.\n")
                check_town = validity_check.check_length_valid(new_town, validity_check.max_address_town)
            else:
                new_town = None
    else:
        new_town = None
    zip_check = input("Would you like to update the zip code? (y/n)\n").lower()
    if zip_check == 'y':
        new_zip = input("Please input the new zip code (format: xxxxx).\n")
        check_zip = validity_check.check_zip_pattern(new_zip)
        while not check_zip and zip_check == 'y':
            zip_check = input("This zip code is not valid.\nWould you like to try again? (y/n)\n").lower()
            if zip_check == 'y':
                new_zip = input("Please input the new zip code (format: xxxxx).\n")
                check_zip = validity_check.check_zip_pattern(new_zip)
            else:
                new_zip = None
    else:
        new_zip = None
    phone_check = input("Would you like to update the phone number? (y/n)\n").lower()
    if phone_check == 'y':
        new_phone = input("Please enter the new phone number (format: xxx-xxx-xxxx).\n")
        check_phone = validity_check.check_phone_pattern(new_phone)
        while not check_phone and phone_check == 'y':
            phone_check = input("This phone number is not valid.\nWould you like to try again? (y/n)\n").lower()
            if phone_check == 'y':
                new_phone = input("Please enter the new phone number (format: xxx-xxx-xxxx).\n")
                check_phone = validity_check.check_phone_pattern(new_phone)
            else:
                new_phone = None
    else:
        new_phone = None
    address_arr = [addr_id, new_name, new_street, new_town, new_zip, new_phone]
    return address_arr


'''
Name: check_address_exists
Parameters: database connection object, string representing organization name, int representing address ID
Returns: 1 if address already exists in database for that organization; 0 otherwise
Does: checks if address already exists in database
'''


def check_address_exists(cnx, org_name, addr_id):
    if validity_check.check_length_valid(org_name, validity_check.max_org_name) and isinstance(addr_id, int):
        addr_params = (addr_id, org_name)
        addr_cursor = cnx.cursor()
        addr_stmt = "SELECT org_address_exists(%s, %s) AS addr_check"
        addr_cursor.execute(addr_stmt, addr_params)
        check = addr_cursor.fetchone()["addr_check"]
        addr_cursor.close()
        return check
    else:
        return 0
