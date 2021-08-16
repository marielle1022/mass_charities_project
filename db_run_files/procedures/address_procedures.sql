/*
* Address procedures
*/

USE mass_nonprofits;

/*
* Procedure to add an address to an organization
*/
DROP PROCEDURE IF EXISTS add_address;
DELIMITER $$
CREATE PROCEDURE add_address(IN org_name VARCHAR(125), IN add_name VARCHAR(75),
							IN add_street VARCHAR(45), IN add_town VARCHAR(25),
                            IN add_zip CHAR(5), IN add_phone CHAR(12))
BEGIN
DECLARE org_num INT;
DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'No organzation found with that name.' AS error;
    END;
DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This address already exists for this organization.' AS error;
    END;
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
INSERT INTO organization_addresses(orgNo, descriptor, street,
			city, zipcode, phone)
            VALUE (org_num, add_name, add_street, add_town, add_zip, add_phone);
END $$

DELIMITER ;

/*
* Procedure to view all addresses associated with an organization
*/
DROP PROCEDURE IF EXISTS view_org_addresses;
DELIMITER $$
CREATE PROCEDURE view_org_addresses(IN org_name VARCHAR(125))

BEGIN
DECLARE org_num INT;
    
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
IF isNull(org_num) THEN
	SELECT 'This organization does not exist.' AS error;
ELSE
	SELECT addressNo AS AddressID, descriptor AS 'Address Name', street AS Street,
			city AS Town, zipcode AS Zip, phone AS Phone
			FROM organization_addresses
			WHERE orgNo = org_num;
END IF;
END $$

DELIMITER ;

/*
* Procedure to view single address
*/
DROP PROCEDURE IF EXISTS view_single_address;
DELIMITER $$
CREATE PROCEDURE view_single_address(IN addr_num INT)

BEGIN
DECLARE address_check INT;

SELECT bool_check INTO address_check FROM
	(SELECT addressNo_exists(addr_num) AS bool_check) AS b;

IF address_check = 0 THEN
	SELECT 'This address ID does not exist.' AS error;
ELSE
	SELECT addressNo AS AddressID, descriptor AS Name, street AS Street,
			city AS Town, zipcode AS Zip, phone AS Phone
			FROM organization_addresses
			WHERE addressNo = addr_num;
END IF;
END $$

DELIMITER ;

/*
* Procedure to modify an address
*/
DROP PROCEDURE IF EXISTS change_address;
DELIMITER $$
CREATE PROCEDURE change_address(IN addr_num INT, IN add_name VARCHAR(75),
							IN add_street VARCHAR(45), IN add_town VARCHAR(25),
                            IN add_zip CHAR(5), IN add_phone CHAR(12))

BEGIN

DECLARE address_check INT;

SELECT bool_check INTO address_check FROM
	(SELECT addressNo_exists(addr_num) AS bool_check) AS b;

IF address_check = 0 THEN
	SELECT 'This address ID does not exist.' AS error;
ELSE
	IF NOT isNull(add_name) THEN
		UPDATE organization_addresses
			SET descriptor = add_name
		WHERE addressNo = addr_num;
	END IF;

	IF NOT isNull(add_street) THEN
		UPDATE organization_addresses
			SET street = add_street
		WHERE addressNo = addr_num;
	END IF;

	IF NOT isNull(add_town) THEN
		UPDATE organization_addresses
			SET city = add_town
		WHERE addressNo = addr_num;
	END IF;

	IF NOT isNull(add_zip) THEN
		UPDATE organization_addresses
			SET zipcode = add_zip
		WHERE addressNo = addr_num;
	END IF;

	IF NOT isNull(add_phone) THEN
		UPDATE organization_addresses
			SET phone = add_phone
		WHERE addressNo = addr_num;
	END IF;
END IF;
	
END $$

DELIMITER ;

/*
* Procedure to delete an address
*/
DROP PROCEDURE IF EXISTS delete_address;
DELIMITER $$
CREATE PROCEDURE delete_address(IN addr_id INT)

BEGIN

DECLARE address_check INT;

SELECT bool_check INTO address_check FROM
	(SELECT addressNo_exists(addr_id) AS bool_check) AS b;

IF address_check = 0 THEN
	SELECT 'This address ID does not exist.' AS error;
ELSE
	DELETE FROM organization_addresses
		WHERE addressNo = addr_id;
END IF;
    
END $$

DELIMITER ;

