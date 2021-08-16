#!/usr/bin/env python
# -*- coding: utf-8 -*-


# %% Simple selector (MySQL database)
# import pymysql for a simple interface to a MySQL DB


import pymysql
import sys
import stdiomask
import termios

import user_interactions


login_success = False

# Set up connection to database by creating connection object
while not login_success:
    try:
        print("Please log in now.")
        username = input("Enter username: ")
        try:
            pwd = stdiomask.getpass(prompt='Enter password: ')
        # Note: stdiomask.getpass generates a termios error when not used in terminal
        except termios.error as e:
            # When I catch the error in PyCharm, it shows the prompt from getpass(), so the input prompt is blank
            # I was unable to see how this worked in other IDEs
            pwd = input()
        cnx = pymysql.connect(host='localhost', user=username, password=pwd,
                              db='mass_nonprofits', charset='utf8mb4',
                              cursorclass=pymysql.cursors.DictCursor)
        login_success = True
    # If connection isn't established because of bad login information,
    # triggers exception.
    except pymysql.err.OperationalError as e:
        print("The database cannot be accessed with those login credentials.")
        # If there is a bad login attempt, give the user the ability to try again.
        # Also give the user the ability to exit the program if they don't want to keep
        # trying passwords.
        try_again = input("Would you like to try logging in again? (y/n)\n").lower()
        if try_again == 'n':
            sys.exit("You have ended the program.")
    # If there's any other runtime error during login/connection process, have option to terminate the program.
    # Used for catching issues with the cryptography dependency
    # Triggered only if cryptography is not installed and password is incorrect
    except RuntimeError as e:
        print("The database cannot be accessed with those login credentials.")
        try_again = input("Would you like to try logging in again? (y/n)\n").lower()
        if try_again == 'n':
            sys.exit("You have ended the program.")

try:
    program_running = True
    print("Hello. You are using the Massachusetts Resource Directory Management Tool.")
    actions = ['1', '2', '3', '4', '5']
    while program_running:
        user_action = input("What would you like to do? Options are:\n[1] Create\n[2] Search\n[3] Update\n"
                            "[4] Delete\n[5] Exit\nPlease enter the number corresponding to the desired action.\n")
        while user_action not in actions:
            user_action = input("This is not a valid action. Please try again.\nOptions are:\n1] Create\n[2] Search\n"
                                "[3] Update\n[4] Delete\n[5] Exit\nPlease enter the number corresponding to the "
                                "desired action.\n")
        if user_action == '1':
            user_interactions.create_operation(cnx)
        elif user_action == '2':
            user_interactions.search_operation(cnx)
        elif user_action == '3':
            user_interactions.update_operation(cnx)
        elif user_action == '4':
            user_interactions.delete_operation(cnx)
        else:
            program_running = False

except pymysql.Error as e:
    # Exception prints error number (%d) and error message (%s)
    print('Error: %d: %s' % (e.args[0], e.args[1]))

finally:
    print("You have exited the program. Have a nice day!")
    cnx.commit()
    cnx.close()
