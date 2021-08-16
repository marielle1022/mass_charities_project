import address
import language
import service
import validity_check


class Create:
    """
        Create class.
        Attributes:
        Attributes taken in by init: name (name of organization; string),
            region (region where organization is located; string), email (contact
            email for organization; string, can be null), website (website for
            organization; string, can be null), description (basic description of
            organization; string, can be null), notes (any additional notes about
            the organization; string, can be null)
        Methods: __init__,
    """

    '''
    Name: __init__
    Parameters: self, database connection object
    Returns: N/A
    Does: initializes database connection attribute based on 'connection' argument; initializes other object
        attributes to None; calls the create_full_process() function
    '''
    def __init__(self, connection):
        self.cnx = connection
        self.name = None
        self.region = None
        self.description = None
        self.email = None
        self.website = None
        self.notes = None
        self.population = None
        self.create_success = False
        self.create_full_process()

    '''
    Name: create_full_process
    Parameters: self
    Returns: N/A
    Does: attempts to create an organization using the create_organization method; if there is an error,
        allows user to re-try creation if desired; adds addresses, languages, services, and population types to
        to the organization by calling their respective methods
    '''
    def create_full_process(self):
        self.create_success = self.create_organization()
        while not self.create_success:
            try_again = input("Would you like to try creating the organization again? (y/n)\n").lower()
            if try_again == 'n':
                return
            else:
                self.create_success = self.create_organization()
        add_address = input("Would you like to input an address for the organization? (y/n)\n").lower()
        if add_address == 'y':
            address.input_addresses(self.cnx, self.name)
        add_lang = input("Would you like to add languages spoken at the organization? (y/n)\n").lower()
        if add_lang == 'y':
            language.add_org_languages(self.cnx, self.name)
        add_services = input("Would you like to add services offered by the organization? (y/n)\n").lower()
        if add_services == 'y':
            service.add_org_services(self.cnx, self.name)
        print("Organization creation is complete.")

    '''
    Name: create_organization
    Parameters: self
    Returns: True if organization was created successfully in the database; False otherwise
    Does: (attempts to) create an organization in the database
    '''
    def create_organization(self):
        self.name = self.input_org_name()
        self.region = self.input_region()
        self.description = self.input_description()
        self.email = self.input_email()
        self.website = self.input_website()
        self.notes = self.input_notes()
        self.population = self.input_population()
        arg_list = [self.name, self.region, self.email, self.website,
                    self.description, self.notes, self.population]
        org_cursor = self.cnx.cursor()
        org_cursor.callproc("create_org", arg_list)
        rows = org_cursor.fetchall()
        org_cursor.close()
        if not rows:
            print("Organization created successfully.")
            self.cnx.commit()
            return True
        else:
            for row in rows:
                print(row["error"])
            return False

    '''
    Name: input_region
    Parameters: self
    Returns: string (the region where the organization is located)
    Does: 
    '''
    def input_region(self):
        list_region_cursor = self.cnx.cursor()
        list_region_cursor.callproc("list_regions")
        rows = list_region_cursor.fetchall()
        list_region_cursor.close()
        list_regs = []
        list_regs_display = []
        for row in rows:
            list_regs.append(row['regionName'].lower())
            list_regs_display.append(row['regionName'])
        region = input("Please enter the main region where the organization is located.\n"
                       "The options are: {}\n".format(list_regs_display)).lower()
        while region not in list_regs:
            print("This region is not one of the listed options.")
            region = input("Please enter the main region where the organization is located.\n"
                           "The options are: {}\n".format(list_regs_display)).lower()
        return region

    '''
    Name: input_org_name
    Parameters: None
    Returns: string (the name of the organization being created)
    Does: 
    '''
    @staticmethod
    def input_org_name():
        org_name = input('Please enter a name for the organization.\n')
        check_len = validity_check.check_length_valid(org_name, validity_check.max_org_name)
        while not org_name or not check_len:
            if not org_name:
                org_name = input('This field is required. Please enter a name for the organization.\n')
            else:
                org_name = input('This name is too long (maximum is ' + str(validity_check.max_org_name) +
                                 ' characters). Please enter a name for the organization.\n')
                check_len = validity_check.check_length_valid(org_name, validity_check.max_org_name)
        return org_name

    '''
    Name: input_description
    Parameters: None
    Returns: string (the description of the organization)
    Does: Stores the description to be associated with the organization.
        Verifies that user input matches database restrictions.
    '''
    @staticmethod
    def input_description():
        description = input('Please enter a short description of the organization.\n')
        check_len = validity_check.check_length_valid(description, validity_check.max_description)
        while not description or not check_len:
            if not description:
                description = input('This field is required. Please try again.\n')
            else:
                description = input('This description is too long (maximum is ' +
                                    str(validity_check.max_description) + ' characters). Please try again.\n')
                check_len = validity_check.check_length_valid(description, validity_check.max_description)
        return description

    '''
    Name: input_email
    Parameters: None
    Returns: string (the email of the organization) or None (if the user does not want to input an email)
    Does: Stores an email if the user wants one associated with the organization.
        Verifies that user input matches database restrictions.
    '''
    @staticmethod
    def input_email():
        email_desired = input('Would you like to input an email for the organization? (y/n)\n').lower()
        while email_desired == 'y':
            email = input('Please enter the email.\n')
            check_len = validity_check.check_length_valid(email, validity_check.max_email)
            if not email or not check_len:
                if not email:
                    print("You did not enter an email.")
                else:
                    print("This email is too long (limit is " + str(validity_check.max_email) + " characters).")
                email_desired = input("Would you like to try again? (y/n)\n").lower()
            else:
                return email
        return None

    '''
    Name: input_website
    Parameters: None
    Returns: string (the website of the organization) or None (if the user does not want to input an website)
    Does: Stores a website if the user wants one associated with the organization.
        Verifies that user input matches database restrictions.
    '''
    @staticmethod
    def input_website():
        site_desired = input('Would you like to input a website for the organization? (y/n)\n').lower()
        while site_desired == 'y':
            website = input('Please enter the website.\n')
            check_len = validity_check.check_length_valid(website, validity_check.max_website)
            if not website or not check_len:
                if not website:
                    print("You did not enter a website.")
                else:
                    print("This website is too long (limit is " + str(validity_check.max_website) + " characters).")
                site_desired = input('Would you like to try again? (y/n)\n').lower()
            else:
                return website
        return None

    '''
    Name: input_notes
    Parameters: None
    Returns: string (additional notes about the organization) or None (if the user does not want to input
            any additional notes)
    Does: Stores any additional notes the user wants to add to the organization.
        Verifies that user input matches database restrictions.
    '''
    @staticmethod
    def input_notes():
        notes_desired = input('Would you like to input any additional notes about the organization? (y/n)\n').lower()
        while notes_desired == 'y':
            notes = input('Please enter the notes.\n')
            check_len = validity_check.check_length_valid(notes, validity_check.max_notes)
            if not notes or not check_len:
                if not notes:
                    print("You did not enter any notes.")
                else:
                    print("These notes are too long (limit is " + str(validity_check.max_notes) + " characters).")
                notes_desired = input('Would you like to try again? (y/n)\n').lower()
            else:
                return notes
        return None

    '''
    Name: input_population
    Parameters: None
    Returns: string (target population of the organization) or None (if the user does not want to input
            a target population)
    Does: Stores the target population that the user wants to add to the organization.
        Verifies that user input matches database restrictions.
    '''
    @staticmethod
    def input_population():
        population_desired = input('Would you like to input a target population for the organization? (y/n)\n').lower()
        while population_desired == 'y':
            population = input('Please enter a description of the target population.\n')
            check_len = validity_check.check_length_valid(population, validity_check.max_population)
            if not population or not check_len:
                if not population:
                    print("You did not enter a target population.")
                else:
                    print("This description of the target population is too long (limit is " +
                          str(validity_check.max_population) + " characters).")
                population_desired = input('Would you like to try again? (y/n)\n').lower()
            else:
                return population
        return None
