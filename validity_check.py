"""
validity_checks.py file contains functions that are used to verify that the input to be sent to MySQL procedures
match type and length constraints of the schema.
"""

import re

# If constraints for schema ever change, will only need to change the constants
# here (rather than passing max length as a parameter and having a single
# function to check validity, and potentially needing these constants in multiple
# files).

# Constants: maximum number of characters for different fields in the database
max_org_name = 125
max_email = 80
max_website = 145
max_description = 255
max_notes = 255
max_population = 255
max_region_name = 45
max_address_name = 75
max_address_street = 45
max_address_town = 25
max_language_name = 45
max_service_type = 45
# Constants: regex patterns for zip code, phone number, languages
zip_pattern = re.compile("[0-9]{5}")
phone_pattern = re.compile("[0-9]{3}-[0-9]{3}-[0-9]{4}")
# Allows lowercase, uppercase, spaces, and hyphens
lang_pattern = re.compile("[a-zA-Z\\s\\-]*")

'''
Name: check_length_valid
Parameters: 2 strings (input to be checked, maximum length value)
Returns: True if input matches database constraints, False otherwise
Does: Checks if the user input adheres to database type constraints
'''


def check_length_valid(user_input, max_len):
    if len(user_input) <= max_len:
        return True
    else:
        return False

'''
Name: check_zip_pattern
Parameters: 1 strings (input to be checked)
Returns: True if input matches database constraints, False otherwise
Does: Checks if the user input for zip code adheres to database type constraints
'''


def check_zip_pattern(zip_code):
    if re.fullmatch(zip_pattern, zip_code):
        return True
    else:
        return False

'''
Name: check_phone_pattern
Parameters: 1 strings (input to be checked)
Returns: True if input matches database constraints, False otherwise
Does: Checks if the user input for phone adheres to database type constraints
'''


def check_phone_pattern(phone):
    if re.fullmatch(phone_pattern, phone):
        return True
    else:
        return False

'''
Name: check_language_name
Parameters: 1 strings (input to be checked)
Returns: True if input matches database constraints, False otherwise
Does: Checks if the user input for language name adheres to database type constraints
'''


def check_language_name(language):
    if re.fullmatch(lang_pattern, language) and len(language) <= max_language_name:
        return True
    else:
        return False


