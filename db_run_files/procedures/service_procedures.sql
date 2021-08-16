/*
* Service procedures
*/

USE mass_nonprofits;

/*
* Procedure to list all services
*/
DROP PROCEDURE IF EXISTS list_services;

DELIMITER $$

CREATE PROCEDURE list_services()
BEGIN
SELECT serviceType FROM services ORDER BY serviceType asc;
END $$

DELIMITER ;

/*
* Procedure to add a service to the services table
*/
DROP PROCEDURE IF EXISTS create_service;

DELIMITER $$

CREATE PROCEDURE create_service(IN service_name VARCHAR(45))
BEGIN

DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This service already exists.' AS error;
    END;
    
INSERT INTO services(serviceType) VALUES (service_name);

END $$

DELIMITER ;

/*
* Procedure to add a service to an organization
* Note: assuming that 1048 won't apply to organization because will first do a check
* for existence of organization on application's end
*/
DROP PROCEDURE IF EXISTS add_org_service;

DELIMITER $$

CREATE PROCEDURE add_org_service(IN service_name VARCHAR(45), IN org_name VARCHAR(125))
BEGIN

DECLARE service_num INT;
DECLARE org_num INT;

DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'This service does not exist in the database.' AS error;
    END;
    
DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This service is already listed for this organization.' AS error;
    END;
    
SELECT serviceNo INTO service_num FROM services
	WHERE serviceType = service_name;
    
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
INSERT INTO services_offered(serviceNo, orgNo) VALUES (service_num, org_num);

END $$

DELIMITER ;

/*
* Procedure to find organizations that use a particular service
*/
DROP PROCEDURE IF EXISTS orgs_by_service;

DELIMITER $$

CREATE PROCEDURE orgs_by_service(IN in_service_type VARCHAR(45))
                            
BEGIN

SELECT orgName AS Organization FROM
	(SELECT orgNo FROM services
		JOIN
        services_offered
        ON services.serviceNo = services_offered.serviceNo
        WHERE services.serviceType = in_service_type) AS st
	JOIN
	organizations
	ON st.orgNo = organizations.orgNo;

    
END $$

DELIMITER ;

/*
* Procedure to view services associated with an organization
*/
DROP PROCEDURE IF EXISTS view_org_services;
DELIMITER $$
CREATE PROCEDURE view_org_services(IN org_name VARCHAR(125))

BEGIN
DECLARE org_num INT;
    
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
IF isNull(org_num) THEN
	SELECT 'This organization does not exist.' AS error;
ELSE
	SELECT serviceType FROM services_offered
		JOIN
		services
        ON services_offered.serviceNo = services.serviceNo
		WHERE orgNo = org_num;
END IF;
END $$

DELIMITER ;

/*
* Procedure to delete a service associated with an organization
*/
DROP PROCEDURE IF EXISTS delete_org_service;
DELIMITER $$
CREATE PROCEDURE delete_org_service(IN org_name VARCHAR(125), IN serv_type VARCHAR(45))

BEGIN

DECLARE serv_num INT;
DECLARE org_num INT;

SELECT serviceNo INTO serv_num FROM services
	WHERE serviceType = serv_type;

SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
DELETE FROM services_offered WHERE serviceNo = serv_num AND orgNo = org_num;
    
END $$

DELIMITER ;

/*
* Procedure to delete a service from the services table
*/
DROP PROCEDURE IF EXISTS delete_service_record;
DELIMITER $$
CREATE PROCEDURE delete_service_record(IN serv_type VARCHAR(45))

BEGIN

DECLARE serv_num INT;

DECLARE EXIT HANDLER FOR 1451
    BEGIN
 	SELECT 'This service cannot be deleted because it is currently offered by one or more organizations.'
		AS error;
    END;

SELECT serviceNo INTO serv_num FROM services
	WHERE serviceType = serv_type;

IF isNull(serv_num) THEN
	SELECT "This service type does not exist in the database." AS error;
ELSE
	DELETE FROM services WHERE serviceNo = serv_num;
END IF;

    
END $$

DELIMITER ;