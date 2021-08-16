/*
* Functions procedures
*/
USE mass_nonprofits;

/*
* Function to check if an organization exists
*/
DROP FUNCTION IF EXISTS org_exists;

DELIMITER $$

CREATE FUNCTION org_exists(org_name VARCHAR(125))
RETURNS INT DETERMINISTIC CONTAINS SQL
BEGIN

DECLARE org_check INT;

SELECT (SELECT EXISTS
		(SELECT * FROM organizations WHERE orgName = org_name))
        INTO org_check;

RETURN org_check;
END $$

DELIMITER ;

/*
* Function to check if an address exists and is associated with a given organization
*/
DROP FUNCTION IF EXISTS org_address_exists;

DELIMITER $$

CREATE FUNCTION org_address_exists(address_ID INT, org_name VARCHAR(125))
RETURNS INT DETERMINISTIC CONTAINS SQL
BEGIN

DECLARE org_num INT;
DECLARE address_check INT;

SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;

SELECT (SELECT EXISTS
		(SELECT * FROM organization_addresses WHERE addressNo = address_ID AND orgNo = org_num))
        INTO address_check;

RETURN address_check;
END $$

DELIMITER ;

/*
* Function to check if an address exists and is associated with a given organization
*/
DROP FUNCTION IF EXISTS addressNo_exists;

DELIMITER $$

CREATE FUNCTION addressNo_exists(address_ID INT)
RETURNS INT DETERMINISTIC CONTAINS SQL
BEGIN

DECLARE address_check INT;

SELECT (SELECT EXISTS
		(SELECT * FROM organization_addresses WHERE addressNo = address_ID))
        INTO address_check;

RETURN address_check;
END $$

DELIMITER ;

/*
* Function to check if a language exists
*/
DROP FUNCTION IF EXISTS lang_exists;

DELIMITER $$

CREATE FUNCTION lang_exists(lang_name VARCHAR(45))
RETURNS INT DETERMINISTIC CONTAINS SQL
BEGIN

DECLARE lang_check INT;

SELECT (SELECT EXISTS
		(SELECT * FROM languages WHERE languageName = lang_name))
        INTO lang_check;

RETURN lang_check;
END $$

DELIMITER ;

/*
* Function to check if a service exists
*/
DROP FUNCTION IF EXISTS service_exists;

DELIMITER $$

CREATE FUNCTION service_exists(service_type VARCHAR(45))
RETURNS INT DETERMINISTIC CONTAINS SQL
BEGIN

DECLARE serv_check INT;

SELECT (SELECT EXISTS
		(SELECT * FROM services WHERE serviceType = service_type))
        INTO serv_check;

RETURN serv_check;
END $$

DELIMITER ;