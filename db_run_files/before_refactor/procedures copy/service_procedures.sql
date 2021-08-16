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
* Procedure to add a servie to the services table
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
    
INSERT INTO services_offered(service, organization) VALUES (service_num, org_num);

END $$

DELIMITER ;
