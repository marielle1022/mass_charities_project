/*
* Organization procedures
*/
USE mass_nonprofits;

/*
* Procedure to create an organization
*/
DROP PROCEDURE IF EXISTS create_org;

DELIMITER $$

CREATE PROCEDURE create_org(IN org_name VARCHAR(125), IN region_name VARCHAR(45),
							IN org_email VARCHAR(80), IN org_website VARCHAR(145),
                            IN org_description VARCHAR(255), IN org_notes VARCHAR(255),
                            IN org_population VARCHAR(255)) -- note: must make sure values are null (if applicable)
                            
BEGIN

DECLARE region_num INT;

DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This organization already exists.' AS error;
    END;
    
DECLARE EXIT HANDLER FOR 1048 -- ALSO exits if a column is null; application doesn't allow other null entries (should only be triggered by region not existing when used in application)
	BEGIN
    SELECT 'The region does not exist.' AS error; 
    END;
    
SELECT regionNo INTO region_num FROM regions
	WHERE regionName = region_name; -- get the index for the region
    
INSERT INTO organizations(orgName, regionNo, email, website, description, notes, population)
	VALUES (org_name, region_num, org_email, org_website, org_description, org_notes, org_population);
    
END $$

DELIMITER ;

/*
* Procedure to delete an organization
*/
DROP PROCEDURE IF EXISTS delete_org;

DELIMITER $$

CREATE PROCEDURE delete_org(IN org_name VARCHAR(125))
                            
BEGIN

DECLARE org_num INT;

SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;

IF isNull(org_num) THEN
	SELECT "This organization does not exist in the database." AS error;
ELSE
	DELETE FROM organizations WHERE orgNo = org_num;
END IF;
    
END $$

DELIMITER ;

/*
* Procedure to find single organization based on name
*/
DROP PROCEDURE IF EXISTS find_org_name;

DELIMITER $$

CREATE PROCEDURE find_org_name(IN org_name VARCHAR(125))
                            
BEGIN

DECLARE org_check INT;

SELECT bool_check INTO org_check FROM
	(SELECT org_exists(org_name) AS bool_check) AS b;

IF org_check = 0 THEN
	SELECT 'This organization does not exist.' AS error;
ELSE
	SELECT orgName AS Organization, regionName AS Region,
		description AS Description,
		REPLACE(GROUP_CONCAT(DISTINCT serviceType), ',', ', ') AS 'Services Offered',
		REPLACE(GROUP_CONCAT(DISTINCT languageName), ',', ', ') AS 'Languages Spoken',
		population AS 'Target Population', website AS Website, email AS Email,
		notes AS 'Additional Notes'
	FROM
		organizations
		JOIN
		regions
		ON organizations.regionNo = regions.regionNo
		LEFT OUTER JOIN
		languages_spoken
		ON organizations.orgNo = languages_spoken.orgNo
		LEFT OUTER JOIN
		languages
		ON languages_spoken.languageNo = languages.languageNo
		LEFT OUTER JOIN
		services_offered
		ON organizations.orgNo = services_offered.orgNo
		LEFT OUTER JOIN
		services
		ON services_offered.serviceNo = services.serviceNo
		WHERE orgName = org_name
		GROUP BY orgName;
END IF;
    
END $$

DELIMITER ;


/*
Procedure to list all organizations
*/
DROP PROCEDURE IF EXISTS list_orgs;

DELIMITER $$

CREATE PROCEDURE list_orgs()

BEGIN

SELECT orgName FROM organizations ORDER BY orgName ASC;

END $$

DELIMITER ;

/*
* Procedure to list all regions
* NOTE: may not need
*/
DROP PROCEDURE IF EXISTS list_regions;

DELIMITER $$

CREATE PROCEDURE list_regions()

BEGIN

SELECT regionName FROM regions ORDER BY regionName ASC;

END $$

DELIMITER ;

/*
* Procedure to modify an organization
*/
DROP PROCEDURE IF EXISTS change_org;
DELIMITER $$
CREATE PROCEDURE change_org(IN in_org_name VARCHAR(125), IN in_email VARCHAR(80), IN in_website VARCHAR(145),
                            IN in_description VARCHAR(255), IN in_notes VARCHAR(255), 
                            IN in_population VARCHAR(255))

BEGIN

DECLARE org_check INT;
DECLARE org_num INT;

SELECT bool_check INTO org_check FROM
	(SELECT org_exists(in_org_name) AS bool_check) AS b;

IF org_check = 0 THEN
	SELECT 'This organization does not exist' AS error;
ELSE
	SELECT orgNo INTO org_num FROM organizations
		WHERE orgName = in_org_name;
        
	IF NOT isNull(in_email) THEN
		UPDATE organizations
			SET email = in_email
		WHERE orgNo = org_num;
	END IF;

	IF NOT isNull(in_website) THEN
		UPDATE organizations
			SET website = in_website
		WHERE orgNo = org_num;
	END IF;

	IF NOT isNull(in_description) THEN
		UPDATE organizations
			SET description = in_description
		WHERE orgNo = org_num;
	END IF;

	IF NOT isNull(in_notes) THEN
		UPDATE organizations
			SET notes = in_notes
		WHERE orgNo = org_num;
	END IF;

	IF NOT isNull(in_population) THEN
		UPDATE organizations
			SET population = in_population
		WHERE orgNo = org_num;
	END IF;
    
END IF;
	
END $$

DELIMITER ;