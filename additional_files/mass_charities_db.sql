-- ********************************************
-- Create the mass_nonprofits database
-- *******************************************
CREATE SCHEMA IF NOT EXISTS `mass_nonprofits`;
USE `mass_nonprofits`;

--
-- Table structure for table `regions`
--
CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`regions` (
	`regionNo` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL, -- add unique constraint?
    CONSTRAINT `region_pk` PRIMARY KEY (`regionNo`)
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`organizations`(
	`orgNo` INT NOT NULL AUTO_INCREMENT,
    `region` INT NOT NULL,
    `address_street` INT NOT NULL,
    `address_town` INT NOT NULL,
    `address_zip` INT NOT NULL,
    `email` VARCHAR(45), -- some organizations may not have emails
    `phone` CHAR(10), -- some organizations may not have phones
    `website` VARCHAR(145), -- some organizations may not have websites
    `description` VARCHAR(255) NOT NULL,
    `notes` VARCHAR(255),
    CONSTRAINT `org_pk` PRIMARY KEY (`orgNo`),
    CONSTRAINT `org_reg_fk` FOREIGN KEY (`region`) REFERENCES `regions`
		(`regionNo`) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`administrators`(
	`userID` INT NOT NULL AUTO_INCREMENT, -- is this necessary with username?
    `name` VARCHAR(75) NOT NULL,
    `username` VARCHAR(45) NOT NULL,
    CONSTRAINT `admin_pk` PRIMARY KEY (`userID`)
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`organization_admins` (
	`administrator` INT NOT NULL,
    `organization` INT NOT NULL,
    CONSTRAINT `org_admin_pk` PRIMARY KEY (`administrator`, `organization`),
    CONSTRAINT `admin_overseeing_fk` FOREIGN KEY (`administrator`) REFERENCES
		`administrators` (`userID`) ON UPDATE CASCADE ON DELETE CASCADE, -- But don't delete if this is the only admin?
	CONSTRAINT `org_admin_fk` FOREIGN KEY (`organization`) REFERENCES
		`organizations` (`orgNo`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`languages` (
	`languageNo` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL, -- should be unique? make primary key?
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
    `serviceType` VARCHAR(45) NOT NULL,
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

-- NOTE: change to 1 table for parent, separate tables for children
-- age: min age, max age, description (numbers can be null?)
-- gender: male/female/nonbinary, cisgender/transgender
-- immigrant status: immigrant t/f (?), refugee, asylee, undocumented, pos. country of origin
-- sexual orientation: gay, lesbian, bisexual, asexual
CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`populations` (
	`populationNo` INT NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(255) NOT NULL,
    `subclass` VARCHAR(45), -- Can create list of options (age, gender, immigrant status, sexual orientation, NULL)?
    CONSTRAINT `population_pk` PRIMARY KEY (`populationNo`)
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`populations_age` (
	`populationNo` INT NOT NULL,
    `min_age` INT,
    `max_age` INT,
    CONSTRAINT `pop_age_pk` PRIMARY KEY (`populationNo`),
	CONSTRAINT `pop_age_fk` FOREIGN KEY (`populationNo`) REFERENCES
		`populations` (`populationNo`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`populations_gender` (
	`populationNo` INT NOT NULL,
    `gender` VARCHAR(25), -- male, female, nonbinary
    `transgender` TINYINT, -- 1 if true (transgender), 0 if false (cisgender), can be null
    CONSTRAINT `pop_gender_pk` PRIMARY KEY (`populationNo`),
	CONSTRAINT `pop_gender_fk` FOREIGN KEY (`populationNo`) REFERENCES
		`populations` (`populationNo`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`populations_immigrant` (
	`populationNo` INT NOT NULL,
    `immigrant` TINYINT, -- 1 if true, 0 if false, can be null
    `refugee` TINYINT, -- 1 if true, 0 if false, can be null
    `asylee` TINYINT, -- 1 if true, 0 if false, can be null
    `undocumented` TINYINT, -- 1 if true, 0 if false, can be null
    CONSTRAINT `pop_immigrant_pk` PRIMARY KEY (`populationNo`),
	CONSTRAINT `pop_immigrant_fk` FOREIGN KEY (`populationNo`) REFERENCES
		`populations` (`populationNo`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`populations_sexual_orientation` (
	`populationNo` INT NOT NULL,
    `gay` TINYINT, -- 1 if true, 0 if false, can be null
    `lesbian` TINYINT, -- 1 if true, 0 if false, can be null
    `bisexual` TINYINT, -- 1 if true, 0 if false, can be null
    `asexual` TINYINT, -- 1 if true, 0 if false, can be null
    CONSTRAINT `pop_sexual_orientation_pk` PRIMARY KEY (`populationNo`),
	CONSTRAINT `pop_sexual_orientation_fk` FOREIGN KEY (`populationNo`) REFERENCES
		`populations` (`populationNo`) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS `mass_nonprofits`.`populations_served` (
	`population` INT NOT NULL,
    `organization` INT NOT NULL,
    CONSTRAINT `populations_served_pk` PRIMARY KEY (`population`, `organization`),
    CONSTRAINT `populations_served_fk` FOREIGN KEY (`population`)
		REFERENCES `populations` (`populationNo`)
        ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `org_pop_fk` FOREIGN KEY (`organization`) REFERENCES
		`organizations` (`orgNo`) ON UPDATE CASCADE ON DELETE CASCADE -- BUT should it update if key is number, not orgname?
);