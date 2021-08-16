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
SELECT languageName FROM languages ORDER BY languageName asc;
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
    
INSERT INTO languages(languageName) VALUES (language_name);

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
 	SELECT 'This input does not exist in the database.' AS error;
    END;
    
DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This language is already listed for this organization.' AS error;
    END;
    
SELECT languageNo INTO lang_num FROM languages
	WHERE languageName = language_name;
    
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (lang_num, org_num);

END $$

DELIMITER ;

/*
* Procedure to find organizations that use a particular language
*/
DROP PROCEDURE IF EXISTS orgs_by_lang;

DELIMITER $$

CREATE PROCEDURE orgs_by_lang(IN in_lang_name VARCHAR(45))
                            
BEGIN

SELECT orgName AS Organization FROM
	(SELECT orgNo FROM languages
		JOIN
        languages_spoken
        ON languages.languageNo = languages_spoken.languageNo
        WHERE languages.languageName = in_lang_name) AS ls
	JOIN
	organizations
	ON ls.orgNo = organizations.orgNo;

    
END $$

DELIMITER ;

/*
* Procedure to view languages associated with an organization
*/
DROP PROCEDURE IF EXISTS view_org_languages;
DELIMITER $$
CREATE PROCEDURE view_org_languages(IN org_name VARCHAR(125))

BEGIN
DECLARE org_num INT;
    
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
IF isNull(org_num) THEN
	SELECT 'This organization does not exist.' AS error;
ELSE
	SELECT languageName FROM languages_spoken
		JOIN
		languages
        ON languages_spoken.languageNo = languages.languageNo
		WHERE orgNo = org_num;
END IF;
END $$

DELIMITER ;

/*
* Procedure to delete a language associated with an organization
*/
DROP PROCEDURE IF EXISTS delete_org_language;
DELIMITER $$
CREATE PROCEDURE delete_org_language(IN org_name VARCHAR(125), IN lang_name VARCHAR(45))

BEGIN

DECLARE lang_num INT;
DECLARE org_num INT;

SELECT languageNo INTO lang_num FROM languages
	WHERE languageName = lang_name;

SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
DELETE FROM languages_spoken WHERE languageNo = lang_num AND orgNo = org_num;
    
END $$

DELIMITER ;

/*
* Procedure to delete a language from the languages table
*/
DROP PROCEDURE IF EXISTS delete_language_record;
DELIMITER $$
CREATE PROCEDURE delete_language_record(IN lang_name VARCHAR(45))

BEGIN

DECLARE lang_num INT;

DECLARE EXIT HANDLER FOR 1451
    BEGIN
 	SELECT 'This language cannot be deleted because it is currently offered by one or more organizations.'
		AS error;
    END;

SELECT languageNo INTO lang_num FROM languages
	WHERE languageName = lang_name;

IF isNull(lang_num) THEN
	SELECT "This language does not exist in the database." AS error;
ELSE
	DELETE FROM languages WHERE languageNo = lang_num;
END IF;

    
END $$

DELIMITER ;