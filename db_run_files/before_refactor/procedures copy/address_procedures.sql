/*
* Address procedures
*/

USE mass_nonprofits;

/*
* Procedure to add an address to an organization
* NB: for some reason, exit handler for 1406 not working -- do error check on python end for now
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
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
INSERT INTO organization_addresses(orgNo, address_name, address_street,
			address_town, address_zip, phone)
            VALUE (org_num, add_name, add_street, add_town, add_zip, add_phone);
END $$

DELIMITER ;

/*
* Procedure to view addresses associated with an organization
*/
DROP PROCEDURE IF EXISTS view_org_addresses;
DELIMITER $$
CREATE PROCEDURE view_org_addresses(IN org_name VARCHAR(125))

BEGIN
DECLARE org_num INT;
DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'No organzation found with that name.' AS error;
    END;
    
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
SELECT addressNo AS AddressID, address_name AS Name, address_street AS Street,
		address_town AS Town, address_zip AS Zip, phone AS Phone
        FROM organization_addresses
        WHERE orgNo = org_num;
END $$

DELIMITER ;

/*
* Procedure to view single address
*/
DROP PROCEDURE IF EXISTS view_single_address;
DELIMITER $$
CREATE PROCEDURE view_single_address(IN addr_num INT)

BEGIN
DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'No address found with that ID.' AS error;
    END;
    
SELECT addressNo AS AddressID, address_name AS Name, address_street AS Street,
		address_town AS Town, address_zip AS Zip, phone AS Phone
        FROM organization_addresses
        WHERE addressNo = addr_num;
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

DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'No address found with that ID.' AS error;
    END;
    
IF NOT isNull(add_name) THEN
	UPDATE organization_addresses
		SET address_name = add_name
	WHERE addressNo = addr_num;
END IF;

IF NOT isNull(add_street) THEN
	UPDATE organization_addresses
		SET address_street = add_street
	WHERE addressNo = addr_num;
END IF;

IF NOT isNull(add_town) THEN
	UPDATE organization_addresses
		SET address_town = add_town
	WHERE addressNo = addr_num;
END IF;

IF NOT isNull(add_zip) THEN
	UPDATE organization_addresses
		SET address_zip = add_zip
	WHERE addressNo = addr_num;
END IF;

IF NOT isNull(add_phone) THEN
	UPDATE organization_addresses
		SET phone = add_phone
	WHERE addressNo = addr_num;
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
DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'No address found with that ID.' AS error;
    END;
    
DELETE FROM organization_addresses
	WHERE addressNo = addr_id;
    
END $$

DELIMITER ;

