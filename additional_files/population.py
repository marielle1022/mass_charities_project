"""
population.py file contains functions used to create and update populations.
"""

import organization
import re
import textwrap

# Constant: maximum number of characters for description of population
max_description = 255
# Constant: number of characters to wrap output
wrap_char = 70
# Constant: list of column names different tables
glob_gender_arr = ['male', 'female', 'nonbinary', 'transgender']  # Table: populations_gender
glob_immigrant_arr = ['immigrant', 'refugee', 'asylee', 'undocumented']  # Table: populations_immigrant
glob_orientation_arr = ['gay', 'lesbian', 'bisexual', 'asexual']  # Table: populations_sexual_orientation

# NOTE: should add cnx commit after successfully creating population (for example)?

'''
Name: create_population
Parameters: database connection object
Returns: True if successful; False otherwise
Does: creates a new population in the database
'''


def create_population(cnx):
    valid_population = False
    while not valid_population:
        pop_description = input("Please enter the population that will be served.\n")
        if (len(pop_description) > max_description) or (not pop_description):
            if not pop_description:
                print("You did not enter a population description.")
            else:
                print("This population description is too long.")
            try_again = input("Would you like to try again? (y/n)\n").lower()
            if try_again == 'n':
                return False
        else:
            valid_population = True
    pop_arr = [pop_description]
    pop_cursor = cnx.cursor()
    pop_cursor.callproc("create_population", pop_arr)
    error_check = pop_cursor.fetchone()
    pop_cursor.close()
    if error_check:
        print(error_check['error'] + "\n")
        return False
    # else:
    #     add_population_criterion(cnx, pop_description)
    return True

# NOTE: ignore population subsets for now, work on READ/UPDATE/DELETE

# '''
# Name: add_population_criterion
# Parameters: database connection object, string representing population description
# Returns: True if successful; False otherwise
# Does: adds any population criterion (age, gender, sexual orientation, immigrant status) desired by the user
# '''
# def add_population_criterion(cnx, pop_description):
#     ask_age = input("Does this population have an age range? (y/n)").lower()
#     if ask_age == 'y':
#         add_age(cnx, pop_description)
#     ask_gender = input("Does this population involve a specific gender identity? (y/n)").lower()
#     if ask_gender == 'y':
#
#
#
# '''
# Name: add_age
# Parameters: database connection object, string representing population description
# Returns: True if successful; False otherwise
# Does: adds age values to a population
# '''
#
#
# def add_age(cnx, pop_description):
#     age_arr = age_checks
#     age_arr.insert(0, pop_description)
#     age_cursor = cnx.cursor()
#     age_cursor.callproc("add_pop_ages", age_arr)
#     error_check = age_cursor.fetchone()
#     age_cursor.close()
#     if error_check:
#         print(error_check['error'])
#         return False
#     else:
#         return True
#
#
# '''
# Name: age_checks
# Parameters: none
# Returns: array of minimum and maximum ages
# Does: Checks that desired minimum and maximum ages match necessary criteria
# '''
#
#
# def age_checks():
#     both_ages = False
#     while not both_ages:
#         check_min = input("Is there a minimum age? (y/n)\n").lower()
#         if check_min == 'y':
#             min_age = create_min_age()
#         else:
#             min_age = None
#         check_max = input("Is there a maximum age? (y/n)\n").lower()
#         if check_max == 'y':
#             if not min_age:
#                 max_age = create_max_age()
#             else:
#                 max_age = create_max_age(min_age)
#         else:
#             max_age = None
#         if (not min_age) and (not max_age):
#             print("You must input at least one age. Please try again.")
#         else:
#             both_ages = True
#     return [min_age, max_age]
#
#
# '''
# Name: create_min_age
# Parameters: none
# Returns: int (desired minimum age)
# Does: Checks that the input age is within the desired range before returning it.
# '''
#
#
# def create_min_age():
#     min_age = input("What is the minimum age?\n")
#     min_range = False
#     while (not min_age.isdigit()) or (not min_range):
#         # Note: isdigit() returns true iff number is int and >=0
#         if not min_age.isdigit():
#             min_age = input("You must enter a non-negative whole number. Please enter a valid minimum age.\n")
#         else:
#             if int(min_age) > 130:
#                 min_age = input("Age must be smaller than 130. Please enter a valid minimum age.\n")
#             else:
#                 min_range = True
#     return int(min_age)
#
#
# '''
# Name: create_max_age
# Parameters: int (the minimum age; this is an option parameter with a default of -1 to allow a comparison conditional
#             to exist without the default impacting it, as the isdigit() condition already determines that the number
#             must be greater than 0)
# Returns: int (desired maximum age)
# Does: Checks that the input age is within the desired range before returning it.
# '''
#
#
# def create_max_age(min_age=-1):
#     max_age = input("What is the maximum age?\n")
#     max_range = False
#     while (not max_age.isdigit()) or (not max_range):
#         # Note: isdigit() returns true iff number is int and >=0
#         if not max_age.isdigit():
#             max_age = input("You must enter a non-negative whole number. Please enter a valid maximum age.\n")
#         else:
#             if int(max_age) > 130:
#                 max_age = input("Age must be smaller than 130. Please enter a valid maximum age.\n")
#             elif int(max_age) <= min_age:
#                 max_age = input("Maximum age must be larger than minimum age. Please enter a valid maximum age.\n")
#             else:
#                 max_range = True
#     return int(max_age)
#
# '''
# Name: add_gender
# Parameters: database connection object, string representing population description
# Returns: True if successful; False otherwise
# Does: adds gender identities to a population
# '''
#
#
# def add_gender(cnx, pop_description):
#     gender_attr = [pop_description]
#     user_genders = input_genders()
#     if not user_genders:
#         return False
#     # Create an array to store the values that will be input into the stored procedure (gen_attr)
#     # Loop through the global variable stored for gender
#     # If the gender in the global variable is listed in by the user, store 1 in the gen_attr array; otherwise, store 0
#     # gen_attr will end with the length of the glob_gender_arr + 1
#     for gender in glob_gender_arr:
#         if gender in user_genders:
#             gender_attr.append(gender)
#     gender_cursor = cnx.cursor()
#     gender_cursor.callproc("add_pop_genders", gender_attr)
#     error_check = gender_cursor.fetchone()
#     gender_cursor.close()
#     if error_check:
#         print(error_check['error'])
#         return False
#     else:
#         return True
#
#
# '''
# Name: input_genders
# Parameters: none
# Returns: array of genders, or None if the user decides against creating this list
# Does: gets a list of genders from the user
# '''
# def input_genders():
#     all_gender_str = ', '.join(glob_gender_arr)
#     print('Available options for gender identity are:\n' + textwrap.fill(all_gender_str, wrap_char) + "\n")
#     count_valid_entries = 0
#     while count_valid_entries < 1:
#         gender_list_str = input('Please list all desired gender identities, separated a comma\n'
#                                 'and space (format: gender1, gender2).\n').lower()
#         gender_list_arr = gender_list_str.split(', ')
#         # Check to see if genders entered are valid
#         count_valid_entries = 0
#         for gender in gender_list_arr:
#             if gender not in glob_gender_arr:
#                 print('Note: "' + gender + '" is not currently an option in this program.')
#             else:
#                 count_valid_entries += 1
#         if count_valid_entries < 1:
#             try_gender = input('You did not input any genders listed in the database. Would you like to try again? '
#                                '(y/n)\n').lower()
#             if try_gender == 'n':
#                 return False
