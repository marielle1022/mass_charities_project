/*
* Language procedures
*/

USE mass_nonprofits;

/*
* Procedure to list all languages
*/
DROP PROCEDURE IF EXISTS list_languages;

DELIMITER $$

CREATE PROCEDURE list_languages()
BEGIN
SELECT name FROM languages ORDER BY name asc;
END $$

DELIMITER ;

/*
* Procedure to add a language to the languages table
*/
DROP PROCEDURE IF EXISTS create_language;

DELIMITER $$

CREATE PROCEDURE create_language(IN language_name VARCHAR(45))
BEGIN

DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This language already exists.' AS error;
    END;
    
INSERT INTO languages(name) VALUES (language_name);

END $$

DELIMITER ;

/*
* Procedure to add a language to an organization
* Note: assuming that 1048 won't apply to organization because will first do a check
* for existence of organization on application's end
*/
DROP PROCEDURE IF EXISTS add_org_language;

DELIMITER $$

CREATE PROCEDURE add_org_language(IN language_name VARCHAR(45), IN org_name VARCHAR(125))
BEGIN

DECLARE lang_num INT;
DECLARE org_num INT;

DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'This language does not exist in the database.' AS error;
    END;
    
DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This language is already listed for this organization.' AS error;
    END;
    
SELECT languageNo INTO lang_num FROM languages
	WHERE name = language_name;
    
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
INSERT INTO languages_spoken(language, organization) VALUES (lang_num, org_num);

END $$

DELIMITER ;

/*
* Procedure to find organizations that use a particular language
*/
DROP PROCEDURE IF EXISTS orgs_by_lang;

DELIMITER $$

CREATE PROCEDURE orgs_by_lang(IN in_lang_name VARCHAR(125))
                            
BEGIN

SELECT orgName AS Organization FROM
	(SELECT organization FROM languages
		JOIN
        languages_spoken
        ON languages.languageNo = languages_spoken.language
        WHERE languages.name = in_lang_name) AS ls
	JOIN
	organizations
	ON ls.organization = organizations.orgNo;

    
END $$

DELIMITER ;