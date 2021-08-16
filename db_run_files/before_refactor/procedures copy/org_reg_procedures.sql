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
							IN org_email VARCHAR(45), IN org_website VARCHAR(145),
                            IN org_description VARCHAR(255), IN org_notes VARCHAR(255),
                            IN org_population VARCHAR(255)) -- note: must make sure values are null (if applicable)
                            
BEGIN

DECLARE region_num INT;

DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This organization already exists.' AS error;
    END;
    
DECLARE EXIT HANDLER FOR 1048 -- exit if a column is null; application doesn't allow other null entries
	BEGIN
    SELECT 'The region does not exist.' AS error;
    END;
    
SELECT regionNo INTO region_num FROM regions
	WHERE name = region_name; -- get the index for the region
    
INSERT INTO organizations(orgName, region, email, website, description, notes, population)
	VALUES (org_name, region_num, org_email, org_website, org_description, org_notes, org_population);
    
END $$

DELIMITER ;

/*
* Procedure to find single organization based on name
*/
DROP PROCEDURE IF EXISTS find_org_name;

DELIMITER $$

CREATE PROCEDURE find_org_name(IN org_name VARCHAR(125))
                            
BEGIN
    
SELECT orgName AS Organization, regions.name AS Region,
	description AS Description,
	REPLACE(GROUP_CONCAT(DISTINCT serviceType), ',', ', ') AS 'Services Offered',
	REPLACE(GROUP_CONCAT(DISTINCT languages.name), ',', ', ') AS 'Languages Spoken',
    population AS 'Target Population', website AS Website, email AS Email,
	notes AS 'Additional Notes'
FROM
    organizations
    JOIN
    regions
    ON organizations.region = regions.regionNo
    LEFT OUTER JOIN
    languages_spoken
    ON organizations.orgNo = languages_spoken.organization
    LEFT OUTER JOIN
    languages
    ON languages_spoken.language = languages.languageNo
    LEFT OUTER JOIN
    services_offered
    ON organizations.orgNo = services_offered.organization
    LEFT OUTER JOIN
    services
    ON services_offered.service = services.serviceNo
    WHERE orgName = org_name
    GROUP BY orgName;
    
END $$

DELIMITER ;


/*
Procedure to list all organizations
*/
DROP PROCEDURE IF EXISTS list_orgs;

DELIMITER $$

CREATE PROCEDURE list_orgs()

BEGIN

SELECT orgName FROM organizations ORDER BY orgName asc;

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

SELECT name FROM regions ORDER BY name asc;

END $$

DELIMITER ;