-- ********************************************
-- Create the mass_nonprofits database
-- *******************************************
CREATE SCHEMA IF NOT EXISTS `mass_nonprofits`;
USE `mass_nonprofits`;

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`regions` (
	`regionNo` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL UNIQUE,
    CONSTRAINT `region_pk` PRIMARY KEY (`regionNo`)
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`organizations` (
	`orgNo` INT NOT NULL AUTO_INCREMENT,
    `orgName` VARCHAR(125) NOT NULL UNIQUE,
    `region` INT NOT NULL,
    `email` VARCHAR(80), -- some organizations may not have emails
    `website` VARCHAR(145), -- some organizations may not have websites
    `description` VARCHAR(255) NOT NULL,
    `notes` VARCHAR(255),
    `population` VARCHAR(255),
    CONSTRAINT `org_pk` PRIMARY KEY (`orgNo`),
    CONSTRAINT `org_reg_fk` FOREIGN KEY (`region`) REFERENCES `regions`
		(`regionNo`) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`organization_addresses` (
	`addressNo` INT NOT NULL AUTO_INCREMENT, -- create b/c different organizations can have the same address, and street address not enough for uniqueness
	`orgNo` INT NOT NULL,
    `address_name` VARCHAR(75), -- some locations may have names (?)
	`address_street` VARCHAR(45) NOT NULL, -- Note: multiple organizations may have the same street address
    `address_town` VARCHAR(25) NOT NULL,
    `address_zip` CHAR(5) NOT NULL, -- if use INT, zip codes beginning with 0 will not include the 0
	`phone` CHAR(12), -- some organizations may not have phones; xxx-xxx-xxxx
	CONSTRAINT `org_address_pk` PRIMARY KEY (`addressNo`),
    CONSTRAINT `org_address_fk` FOREIGN KEY (`orgNo`) REFERENCES `organizations`
		(`orgNo`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`languages` (
	`languageNo` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL UNIQUE,
    CONSTRAINT `lang_pk` PRIMARY KEY (`languageNo`)
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`languages_spoken` (
	`language` INT NOT NULL,
    `organization` INT NOT NULL,
    CONSTRAINT `lang_spoken_pk` PRIMARY KEY (`language`, `organization`),
    CONSTRAINT `lang_spoken_fk` FOREIGN KEY (`language`) REFERENCES `languages`
		(`languageNo`) ON UPDATE CASCADE ON DELETE RESTRICT, -- languages should not be deleted
	CONSTRAINT `org_lang_fk` FOREIGN KEY (`organization`) REFERENCES
		`organizations` (`orgNo`) ON UPDATE CASCADE ON DELETE CASCADE -- BUT should it update if key is number, not orgname?
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`services` (
	`serviceNo` INT NOT NULL AUTO_INCREMENT,
    `serviceType` VARCHAR(45) NOT NULL UNIQUE,
    CONSTRAINT `service_pk` PRIMARY KEY (`serviceNo`)
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`services_offered` (
	`service` INT NOT NULL,
    `organization` INT NOT NULL,
    CONSTRAINT `serv_offered_pk` PRIMARY KEY (`service`, `organization`),
    CONSTRAINT `serv_offered_fk` FOREIGN KEY (`service`) REFERENCES `services`
		(`serviceNo`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `org_serv_fk` FOREIGN KEY (`organization`) REFERENCES
		`organizations` (`orgNo`) ON UPDATE CASCADE ON DELETE CASCADE -- BUT should it update if key is number, not orgname?
);