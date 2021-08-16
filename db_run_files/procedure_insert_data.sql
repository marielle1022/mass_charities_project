-- Page 63, Central Massachusetts
CALL create_org('Friendly House, Inc.', 'Central Massachusetts', NULL, 'https://www.friendlyhousema.org',
				'Provides an after school program, art and recreation programs, summer camping programs, '
                'senior services, basic needs services, a continuum of shelter services, community '
                'organizing efforts, and a host of information and referral service.', NULL,
                'Serving the residents and families of Worcester');
CALL add_address('Friendly House, Inc.', NULL, '36 Wall Street', 'Worcester', '01604', '508-755-4362');
CALL create_service('After School Program');
CALL create_service('Information and Referral');
CALL create_service('Food Pantry');
CALL add_org_service('Community Outreach', 'Friendly House, Inc.');
CALL add_org_service('Elder Services', 'Friendly House, Inc.');
CALL add_org_service('Homeless Services', 'Friendly House, Inc.');
CALL add_org_service('Refugee and Immigrant Services', 'Friendly House, Inc.');
CALL add_org_service('After School Program', 'Friendly House, Inc.');
CALL add_org_service('Information and Referral', 'Friendly House, Inc.');
CALL add_org_service('Food Pantry', 'Friendly House, Inc.');
CALL create_language('Albanian');
CALL add_org_language('English', 'Friendly House, Inc.');
CALL add_org_language('Italian', 'Friendly House, Inc.');
CALL add_org_language('Spanish', 'Friendly House, Inc.');
CALL add_org_language('Albanian', 'Friendly House, Inc.');

-- Page 262, Western Massachusetts
CALL create_org('Caring Health Center', 'Western Massachusetts', NULL, 'http://www.caringhealth.org/index.html',
				'Provides primary care healthcare and services in Adult, Pediatric, OB/GYN, Mental Health and '
                'Optometry, Nutrition, HIV Management, Family Planning and WIC.', 'Serves the greater '
                'Springfield area.', 'African American, Puerto Rican, Russian, Vietnamese, Albanian, '
                'Ukrainian, Bosnian, Arabic, and others');
CALL add_address('Caring Health Center', NULL, '1049 Main St', 'Springfield', '01301', '413-739-1100');
CALL create_service('Family Planning');
CALL create_service('WIC');
CALL create_service('Mental Health');
CALL add_org_service('Community Outreach', 'Caring Health Center');
CALL add_org_service('HIV/AIDS Services', 'Caring Health Center');
CALL add_org_service('Healthcare', 'Caring Health Center');
CALL add_org_service('Mental Health', 'Caring Health Center');
CALL add_org_service('Refugee and Immigrant Services', 'Caring Health Center');
CALL add_org_service('Family Planning', 'Caring Health Center');
CALL add_org_service('WIC', 'Caring Health Center');
CALL add_org_service('Dental Services', 'Caring Health Center');
CALL create_language('Bosnian');
CALL create_language('Ukranian');
CALL create_language('Nepali');
CALL create_language('Somali');
CALL add_org_language('Arabic', 'Caring Health Center');
CALL add_org_language('English', 'Caring Health Center');
CALL add_org_language('Russian', 'Caring Health Center');
CALL add_org_language('Spanish', 'Caring Health Center');
CALL add_org_language('Vietnamese', 'Caring Health Center');
CALL add_org_language('Interpreter Service', 'Caring Health Center');
CALL add_org_language('Albanian', 'Caring Health Center');
CALL add_org_language('Bosnian', 'Caring Health Center');
CALL add_org_language('Ukranian', 'Caring Health Center');
CALL add_org_language('Nepali', 'Caring Health Center');
CALL add_org_language('Somali', 'Caring Health Center');

-- Page 132, Metro Boston
CALL create_org('Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)', 'Metro Boston', NULL,
				'www.miracoalition.org', 'MIRA is a coalition of member organizations which advocates for '
                'the rights and opportunities of immigrants and refugees. The coalition advances this mission '
                'through education, training, leadership development, organizing, policy analysis, and '
                'advocacy.', NULL, 'Organizations and individuals who work with newcomers and those interested '
                'in preserving the civil and human rights of newcomers.');
CALL add_address('Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)', NULL, '105 Chauncy St, Suite '
				'901', 'Boston', '02111', '617-350-5480');
CALL create_service('Leadership Development');
CALL create_service('Policy Analysis');
CALL add_org_service('Refugee and Immigrant Services', 'Massachusetts Immigrant and Refugee Advocacy '
					'Coalition (MIRA)');
CALL add_org_service('Leadership Development', 'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)');
CALL add_org_service('Policy Analysis', 'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)');
CALL add_org_language('Albanian', 'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)');
CALL add_org_language('Cantonese', 'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)');
CALL add_org_language('English', 'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)');
CALL add_org_language('French', 'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)');
CALL add_org_language('Haitian Creole', 'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)');
CALL add_org_language('Portuguese', 'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)');
CALL add_org_language('Spanish', 'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)');

-- Page 140, Metro Boston
-- create_org(IN org_name VARCHAR(125), IN region_name VARCHAR(45),
							-- IN org_email VARCHAR(80), IN org_website VARCHAR(145),
                            -- IN org_description VARCHAR(255), IN org_notes VARCHAR(255),
                            -- IN org_population VARCHAR(255))
CALL create_org('Office of Health Equity', 'Metro Boston', NULL, 'https://www.mass.gov/orgs/office-of-health-equity',
				'Provides advocacy and action for improving access to and the appropriateness of health services and '
                'health information for all refugee and immigrant communities in Massachusetts.', NULL, NULL);
CALL add_address('Office of Health Equity', NULL, '250 Washington Street, 5th Floor', 'Boston', '02108',
				'617-624-5590');
CALL create_service('Liaisons in All Areas of Health');
CALL add_org_service('Liaisons in All Areas of Health', 'Office of Health Equity');
CALL add_org_service('Community Outreach', 'Office of Health Equity');
CALL add_org_service('Education', 'Office of Health Equity');
CALL add_org_service('Legal Services', 'Office of Health Equity');
CALL add_org_service('Refugee and Immigrant Services', 'Office of Health Equity');
CALL create_language('Amharic');
CALL add_org_language('Amharic', 'Office of Health Equity');
CALL add_org_language('English', 'Office of Health Equity');
CALL add_org_language('French', 'Office of Health Equity');
CALL add_org_language('Portuguese', 'Office of Health Equity');
CALL add_org_language('Spanish', 'Office of Health Equity');
CALL add_org_language('Vietnamese', 'Office of Health Equity');
CALL add_org_language('Interpreter Service', 'Office of Health Equity');