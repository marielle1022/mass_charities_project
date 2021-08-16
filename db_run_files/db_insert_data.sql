USE mass_nonprofits;

-- Add all regions
INSERT IGNORE INTO regions(regionName)
	VALUES ('Central Massachusetts'), ('Metro Boston'), ('Northeast-Suburban'),
		('Southeast'), ('Western Massachusetts');
        
-- Add all (basic) languages
-- INSERT INTO languages(languageName)
-- 	VALUES ('American Sign Language'), ('Amharic'), ('Albanian'), ('Arabic'),
-- 		('Armenian'), ('Bambara'), ('Bhutanese'), ('Bosnian'),
--         ('Burmese'), ('Cambodian'), ('Cantonese'), ('Cape Verdean Creole'),
--         ('Chichewa'), ('Chinn'), ('Croatian'), ('Czech'), ('Danish'),
--         ('Davaweno'), ('Dutch'), ('English'), ('Farsi'), ('Fijian'), ('French'),
--         ('French Creole'), ('Gaelige'), ('German'), ('Greek'), ('Gujarati'),
--         ('Haitian Creole'), ('Hebrew'), ('Hindi'), ('Hmong'), ('Igbo'),
--         ('Interpreter Service'), ('Irish'), ('Italian'), ('Japanese'),
--         ('Karen'), ('Karenni'), ('Khmer'), ('Kikongo'), ('Kikuyu'),
--         ('Kinyarwanda'), ('Kirundi'), ('Korean'), ('Kurdish'), ('Laotian'),
--         ('Liberian'), ('Lingala'), ('Lithuanian'), ('Luganda'), ('Mandarin'),
--         ('Micmac'), ('Nepali'), ('Nigerian Dialect'), ('Persian'),
--         ('Pidgin Signed English'), ('Polish'), ('Portuguese'), ('Punjabi'),
--         ('Romanian'), ('Russian'), ('Sango'), ('Sanskrit'), ('Serbian'),
--         ('Serbo-Croatian'), ('Slovak'), ('Signed English'), ('Somali'),
--         ('Spanish'), ('Swahili'), ('Tagalog'), ('Taiwanese'), ('Thai'),
--         ('Tigrinya'), ('Toisanese'), ('Tshiluba'), ('TTY'), ('Turkish'),
--         ('Twi'), ('Ukrainian'), ('Urdu'), ('Vietnamese'), ('Visayan'),
--         ('Zarma');
INSERT IGNORE INTO languages(languageName)
	VALUES ('American Sign Language'), ('Arabic'), ('Cantonese'), ('Cape Verdean Creole'),
        ('English'), ('French'), ('French Creole'), ('Greek'), 
        ('Haitian Creole'), ('Hebrew'), ('Hindi'), ('Interpreter Service'), ('Italian'), ('Japanese'),
        ('Khmer'), ('Korean'), ('Laotian'), ('Mandarin'),
		('Polish'), ('Portuguese'), ('Russian'), ('Spanish'), ('Vietnamese'), ('Igbo');
       
-- Add all (basic) services
INSERT INTO services(serviceType)
	VALUES ('Community Outreach'), ('Crises Services'), ('Domestic Violence'),
		('Education'), ('Elder Services'), ('ESL'), ('Homeless Services'),
        ('HIV/AIDS Services'), ('Healthcare'), ('Legal Services'),
        ('LGBTQ Services'), ('Mental Health: Family Education/Support'),
        ('Mental Health: Peer Support'), ('Mental Health: Counseling'),
        ('Mental Health: Psychiatric Services'),
        ('Mental Health: Psychiatric Evaluation'),
        ('Mental Health: Emergency Services'),
        ('Refugee and Immigrant Services'), ('Substance Abuse'),
        ('Sexual Assault'), ('Deaf and Hard of Hearing Services'),
        ('Wellness Services'), ('Referrals'), ('Dental Services');
SELECT * from languages;
-- Add some organizations
-- INSERT INTO organizations()
-- INSERT INTO organizations(region, email, website, description, notes)
-- don't have to specify columns IF adding values for each column,
-- BUT need in correct order
-- delete ex: DELETE FROM organizations WHERE orgNo = 1;

-- NOTE: MUST drop db to run these commands, in order to get fks correct

-- Page 61; Central Massachusetts
-- Organization: Family Health Center (FHC) of Worcester, Inc.
INSERT INTO organizations(orgName, regionNo, website, description, notes, population)
	VALUES ('Family Health Center (FHC) of Worcester, Inc.', 1,
			'http://www.fhcw.org', 'Family Health Center of Worcester provides access '
            'to affordable, high quality, integrated, comprehensive, and '
            'respectful primary health care and social services, regardless of '
            'patients’ ability to pay.', 'Certain services offered in certain '
            'locations.', 'All residents of Worcester and surrounding towns');
-- Addresses
INSERT INTO organization_addresses(orgNo, descriptor, street,
			city, zipcode, phone)
	VALUES (1, 'Main', '26 Queens Street', 'Worcester', '01610', '508-860-7700'); -- verified w/ website
INSERT INTO organization_addresses(orgNo, descriptor, street,
			city, zipcode, phone)
	VALUES (1, 'Southbridge Family Medicine', '29 Orchard Street',
			'Southbridge', '01550', '774-318-1445'); -- verified w/ website
INSERT INTO organization_addresses(orgNo, descriptor, street,
			city, zipcode, phone)
	VALUES (1, 'Southbridge Family Dental Care and Health Benefits Advising',
			'32 Orchard Street', 'Southbridge', '01550', '774-318-1484'); -- verified w/ website
INSERT INTO organization_addresses(orgNo, descriptor, street,
			city, zipcode, phone)
	VALUES (1, 'Homeless Outreach and Advocacy Program (HOAP)',
			'162 Chandler Street', 'Worcester', '01609', '508-860-1080'); -- verified w/ website
-- Languages spoken
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (2, 1); -- Arabic
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (5, 1); -- English
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (6, 1); -- French
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (9, 1); -- Haitian Creole
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (20, 1); -- Portuguese
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (22, 1); -- Spanish
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (23, 1); -- Vietnamese
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (12, 1); -- Interpreter Service
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (24, 1); -- Igbo
-- Services offered
INSERT INTO services_offered(serviceNo, orgNo) VALUES (1, 1); -- Community Outreach
INSERT INTO services_offered(serviceNo, orgNo) VALUES (4, 1); -- Education
INSERT INTO services_offered(serviceNo, orgNo) VALUES (7, 1); -- Homeless Services
INSERT INTO services_offered(serviceNo, orgNo) VALUES (8, 1); -- HIV/AIDS Services
INSERT INTO services_offered(serviceNo, orgNo) VALUES (9, 1); -- Healthcare
INSERT INTO services_offered(serviceNo, orgNo) VALUES (14, 1); -- Mental Heatlh Counseling
INSERT INTO services_offered(serviceNo, orgNo) VALUES (18, 1); -- Refugee and Immigrant Services
INSERT INTO services_offered(serviceNo, orgNo) VALUES (22, 1); -- Wellness Services
INSERT INTO services_offered(serviceNo, orgNo) VALUES (23, 1); -- Referrals
INSERT INTO services_offered(serviceNo, orgNo) VALUES (24, 1); -- Dental Services

-- Page 178; Northeast-Suburban
-- Organization: The Butler Center
INSERT INTO organizations(orgName, regionNo, website, description, notes, population)
	VALUES ('The Butler Center', 3, 'https://jri.org/services/acute-care-and-juvenile-justice/juvenile-justice/butler',
			'At the Butler Center, boys with significant emotional and mental health '
            'needs, who have been committed to the Massachusetts Department of '
            'Youth Services, are able to develop and practice strategies that '
            'will enable them to modulate their behavior.', 'Closed referrals '
            'via DYS; capacity of 12', 'Males 13-21; Committed to the Department of Youth Services');
-- Address
INSERT INTO organization_addresses(orgNo, descriptor, street,
			city, zipcode, phone) VALUES (2, 'Contact Address',
            '288 Lyman Street', 'Westborough', '01581', '508-475-2601'); -- Checked against website
-- Languages Spoken
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (5, 2); -- English
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (22, 2); -- Spanish
-- Services Offered
INSERT INTO services_offered(serviceNo, orgNo) VALUES (4, 2); -- Education
INSERT INTO services_offered(serviceNo, orgNo) VALUES (13, 2); -- Mental Health: Peer Support


SELECT * FROM regions;
SELECT * from organizations;
SELECT * FROM languages;
SELECT * FROM services;
SELECT * from organizations;