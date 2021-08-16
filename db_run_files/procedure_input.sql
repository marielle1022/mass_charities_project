-- create_org(org_name, region_name, org_email, org_website, org_description, org_notes, org_population)
-- add_address(org_name, add_name, add_street, add_town, add_zip, add_phone)

-- Page 79
-- CALL create_org('Association of Haitian Women in Boston', 'Metro Boston', 'office@afab-kafanm.org',
-- 'www.afab-kafanm.org', 'Community-based grassroots organization dedicated to empowering low-income '
-- 'Haitian women and their children. Programs include housing, domestic violence, adult education, and '
-- 'youth development services.', NULL, 'Haitian women and their children');
-- CALL add_address('Association of Haitian Women in Boston', NULL, '330 Fuller Street', 'Dorchester', '02124', '617-287-0096');
-- CALL add_org_service('Community Outreach', 'Association of Haitian Women in Boston');
-- CALL add_org_service('Domestic Violence', 'Association of Haitian Women in Boston');
-- CALL add_org_service('Education', 'Association of Haitian Women in Boston');
-- CALL add_org_service('ESL', 'Association of Haitian Women in Boston');
-- CALL add_org_service('Mental Health: Peer Support', 'Association of Haitian Women in Boston');
-- CALL add_org_service('Mental Health: Counseling', 'Association of Haitian Women in Boston');
-- CALL create_service('Housing');
-- CALL create_service('Youth Development Services');
-- CALL add_org_service('Housing', 'Association of Haitian Women in Boston');
-- CALL add_org_service('Youth Development Services', 'Association of Haitian Women in Boston');
-- CALL add_org_language('English','Association of Haitian Women in Boston');
-- CALL add_org_language('French','Association of Haitian Women in Boston');
-- CALL add_org_language('Haitian Creole','Association of Haitian Women in Boston');

-- -- create_org(org_name, region_name, org_email, org_website, org_description, org_notes, org_population)
-- -- add_address(org_name, add_name, add_street, add_town, add_zip, add_phone)

-- CALL create_org('Brazilian Women’s Group', 'Metro Boston', 'mulherbrasileira@verdeamaelo.org', NULL, 'A group of women '
-- 'who are interested in the issues of being an immigrant woman from Brazil in the United States. Main activities include '
-- 'ESL classes, workshops on issues such as domestic violence, immigration, bilingual education, health and safety, etc.',
-- 'BWG mostly works through referrals.', 'Brazilian families in Greater Boston');
-- CALL add_address('Brazilian Women’s Group', NULL, '697 Cambridge Street Suite 106', 'Allston', '02134', '617-202-5775');
-- CALL add_org_service('Community Outreach', 'Brazilian Women’s Group');
-- CALL add_org_service('Education', 'Brazilian Women’s Group');
-- CALL add_org_service('ESL', 'Brazilian Women’s Group');
-- CALL add_org_service('Legal Services', 'Brazilian Women’s Group');
-- CALL add_org_service('Refugee and Immigrant Services', 'Brazilian Women’s Group');
-- CALL add_org_language('English','Brazilian Women’s Group');
-- CALL add_org_language('Portuguese','Brazilian Women’s Group');

-- -- create_org(org_name, region_name, org_email, org_website, org_description, org_notes, org_population)
-- -- add_address(org_name, add_name, add_street, add_town, add_zip, add_phone)

-- CALL create_org('Hospitality Homes', 'Metro Boston', NULL, 'www.hosp.org', 'Hospitality Homes provides temporary '
-- 'housing in volunteer host homes and other donated accommodations for families and friends of patients seeking '
-- 'care at Boston-area medical centers.', 'Guests travel internationally to seek treatment at Boston’s area hospitals. '
-- 'Hospitality Homes places guests from all over the world.', 'Families and friends of patients.');
-- CALL add_address('Hospitality Homes', NULL, 'P.O. Box 15265', 'Boston', '02115', '888-595-4678');
-- CALL create_service('Temporary Housing');
-- CALL add_org_service('Temporary Housing','Hospitality Homes');
-- call add_org_language('English', 'Hospitality Homes');
-- CAll add_org_language('Spanish','Hospitality Homes');

-- call create_org('The Victor School','Southeast', NULL, 'https://www.jri.org/victor/', 'The Victor School is a '
-- 'private, co-ed, therapeutic day school for students in grades 8-12. The school is fully approved by the Department '
-- 'of Education. All teachers are licensed in content (subject) area and/or special education.', 
-- 'Alternative school, students are bussed in from surrounding school districts. '
-- 'The school also has high MCAS scores and college entrance percentage.', 'Ages 12-21');
-- call add_address('The Victor School', NULL, '380 Massachusetts Avenue', 'Acton', '01720', '978-266-1991');
-- CALL create_service('Mental Health: Counseling (Family)');
-- CALL create_service('Mental Health: Counseling (Group)');
-- call add_org_service('Mental Health: Counseling (Family)','The Victor School');
-- call add_org_service('Mental Health: Counseling (Group)','The Victor School');
-- call add_org_service('Education','The Victor School');
-- call add_org_language('English','The Victor School');
-- call add_org_language('French','The Victor School');
-- call add_org_language('Japanese','The Victor School');

-- -- create_org(org_name, region_name, org_email, org_website, org_description, org_notes, org_population)
-- -- add_address(org_name, add_name, add_street, add_town, add_zip, add_phone)
-- call create_org('Center for New Americans', 'Western Massachusetts', 'info@cnam.org', 'www.cnam.org', 'A community based '
-- 'education and resource center for immigrants and refugees in Western Massachusetts.', 'All services are free.',
-- 'Adult immigrants, refugees, or migrants');
-- call add_address('Center for New Americans','James House (Main/Mailing)','42 Gothic Street','Northampton','01060','413-587-0084');
-- call add_address('Center for New Americans','CNA at Montague Catholic Social Ministries','41-43 3rd Street','Turners Falls','01376','413-676-9101');
-- call add_address('Center for New Americans','Greenfield Family Learning Center','90 Federal Street','Greenfield','01301','413-772-0055');
-- call add_address('Center for New Americans','Bangs Community Center','70 Boltwood Walk','Amherst','01002','413-259-3288');
-- call create_service('Citizenship Classes');
-- call add_org_service('Community Outreach','Center for New Americans');
-- call add_org_service('ESL','Center for New Americans');
-- call add_org_service('Refugee and Immigrant Services','Center for New Americans');
-- call add_org_service('Citizenship Classes','Center for New Americans');
-- call add_org_language('English','Center for New Americans');
-- call add_org_language('french','Center for New Americans');
-- call add_org_language('polish','Center for New Americans');
-- call add_org_language('spanish','Center for New Americans');

-- create_org(org_name, region_name, org_email, org_website, org_description, org_notes, org_population)
-- add_address(org_name, add_name, add_street, add_town, add_zip, add_phone)
call create_org('Center for Psychological and Family Services','Western Massachusetts',NULL,NULL,'Provides an array of '
'psychiatric and psychological services, including couples, family, group, and individual therapy.','Serves the Springfield area',
'People with psychological/psychiatric problems from a variety of backgrounds');
call add_address('Center for Psychological and Family Services',NULL,'130 Maple Street','Springfield','01103','413-739-0882');
call create_service('Mental Health: Counseling (Couples)');
call add_org_service('Mental Health: Counseling (Family)','Center for Psychological and Family Services');
call add_org_service('Mental Health: Counseling (Group)','Center for Psychological and Family Services');
call add_org_service('Mental Health: Counseling (Couples)','Center for Psychological and Family Services');
call add_org_service('Mental Health: Psychiatric Services','Center for Psychological and Family Services');
call add_org_language('English','Center for Psychological and Family Services');
call add_org_language('Polish','Center for Psychological and Family Services');
call add_org_language('Russian','Center for Psychological and Family Services');
call add_org_language('Spanish','Center for Psychological and Family Services');
call add_org_language('Ukrainian','Center for Psychological and Family Services');

-- create_org(org_name, region_name, org_email, org_website, org_description, org_notes, org_population)
-- add_address(org_name, add_name, add_street, add_town, add_zip, add_phone)
call create_org('Greater New Bedford Community Health Center','Southeast',NULL,'www.gnbchc.org',
'Provides primary care and ancillary services. Maximizes access to health care by providing both '
'linguistically and culturally sensitive care through well-trained bilingual and minority staff.',NULL,
'Everyone with or without health insurance. All services are provided regardless of ability to pay.');
call add_address('Greater New Bedford Community Health Center',NULL,'874 Purchase Street','New Bedford',
'02740','508-992-6553');
call create_service('Nutrition');
call create_service('Social Services');
call add_org_service('HIV/AIDS Services','Greater New Bedford Community Health Center');
call add_org_service('Healthcare','Greater New Bedford Community Health Center');
call add_org_service('Wellness Services','Greater New Bedford Community Health Center');
call add_org_service('WIC','Greater New Bedford Community Health Center');
call add_org_service('Social Services','Greater New Bedford Community Health Center');
call add_org_service('Nutrition','Greater New Bedford Community Health Center');
call add_org_language('Cape Verdean Creole','Greater New Bedford Community Health Center');
call add_org_language('English','Greater New Bedford Community Health Center');
call add_org_language('Portuguese','Greater New Bedford Community Health Center');
call add_org_language('Spanish','Greater New Bedford Community Health Center');


-- create_org(org_name, region_name, org_email, org_website, org_description, org_notes, org_population)
-- add_address(org_name, add_name, add_street, add_town, add_zip, add_phone)
select * from services;
call create_org('Greater Lawrence Family Health Center','Northeast-Suburban', null, 'www.glfhc.org ','A non-profit '
'community operated medical practice and Community Health Center that provides primary care medicine, social services, '
'nutrition, outreach, health education, HIV counseling and testing, and Family planning.',null,'Indochinese, Cuban, '
'Central American, Puerto Rican and Dominican');
call add_address('Greater Lawrence Family Health Center',null,'34 Haverhill Street','Lawrence','01841','978-686-0090');
call add_org_service('Community Outreach','Greater Lawrence Family Health Center');
call add_org_service('Education','Greater Lawrence Family Health Center');
call add_org_service('HIV/AIDS Services','Greater Lawrence Family Health Center');
call add_org_service('Healthcare','Greater Lawrence Family Health Center');
call add_org_service('Mental Health','Greater Lawrence Family Health Center');
call add_org_service('Mental Health: Counseling','Greater Lawrence Family Health Center');
call add_org_service('Family Planning','Greater Lawrence Family Health Center');
call add_org_language('English','Greater Lawrence Family Health Center');
call add_org_language('French','Greater Lawrence Family Health Center');
call add_org_language('Spanish','Greater Lawrence Family Health Center');
call add_org_language('Vietnamese','Greater Lawrence Family Health Center');

select * from organizations;
select * from services;

-- create_org(org_name, region_name, org_email, org_website, org_description, org_notes, org_population)
-- add_address(org_name, add_name, add_street, add_town, add_zip, add_phone)
call create_org('North American Indian Center of Boston, Inc.', 'Metro Boston', Null,'www.naicob.org','An Indian '
'controlled non-profit corporation licensed in Massachusetts. Provides Indian health services and employment and '
'training services. Also provides a Native American Head Start Program, cultural activities, and social events.',
Null,'North American Indians with the ability to provide proof of tribal affiliation for program services. '
'Cultural activities and social events are open to all.');
call add_address('North American Indian Center of Boston, Inc.',NULL,'105 South Huntington Avenue','Jamaica Plain',
'02130','617-232-0343');
call create_service('Health/Community Service Advocacy/Referral');
call create_service('Employment Services');
call create_language('Micmac');
call add_org_service('Health/Community Service Advocacy/Referral','North American Indian Center of Boston, Inc.');
call add_org_service('Employment Services','North American Indian Center of Boston, Inc.');
call add_org_language('English','North American Indian Center of Boston, Inc.');
call add_org_language('Micmac','North American Indian Center of Boston, Inc.');
call find_org_name('North American Indian Center of Boston, Inc.');