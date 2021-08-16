/*
* Population procedures
*/

USE mass_nonprofits;

/*
* Procedure to list all populations
*/
DROP PROCEDURE IF EXISTS list_populations;

DELIMITER $$

CREATE PROCEDURE list_populations()
BEGIN
SELECT description FROM populations ORDER BY description asc;
END $$

DELIMITER ;

/*
* Procedure to add a population to the populations table
*/
DROP PROCEDURE IF EXISTS create_population;

DELIMITER $$

CREATE PROCEDURE create_population(IN population_description VARCHAR(255))
BEGIN

DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This population already exists.' AS error;
    END;
    
INSERT INTO populations(description) VALUES (population_description);

END $$

DELIMITER ;

/*
* Procedure to create age regulations
*/

DROP PROCEDURE IF EXISTS add_pop_ages;

DELIMITER $$

CREATE PROCEDURE add_pop_ages(IN population_description VARCHAR(255), IN minimum_age INT, IN maximum_age INT)
BEGIN

DECLARE population_num INT;

DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'This population does not exist in the database.' AS error;
    END;
    
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This population already has an age range.' AS error;
    END;

SELECT populationNo INTO population_num FROM populations
	WHERE description = population_description;
    
INSERT INTO populations_age(populationNo, min_age, max_age)
	VALUES (population_num, minimum_age, maximum_age);

END $$

DELIMITER ;

/*
* Procedure to create gender regulations
*/

DROP PROCEDURE IF EXISTS add_pop_genders;

DELIMITER $$

CREATE PROCEDURE add_pop_genders(IN population_description VARCHAR(255), IN in_male TINYINT, IN in_female TINYINT,
							IN in_nonbinary TINYINT, IN in_transgender TINYINT)
BEGIN

DECLARE population_num INT;

DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'This population does not exist in the database.' AS error;
    END;

DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This population already has defined gender criterion.' AS error;
    END;
    
SELECT populationNo INTO population_num FROM populations
	WHERE description = population_description;
    
INSERT INTO populations_gender(populationNo, male, female, nonbinary, transgender)
	VALUES (population_num, in_male, in_female, in_nonbinary, in_transgender);

END $$

DELIMITER ;

/*
* Procedure to create immigrant regulations
*/

DROP PROCEDURE IF EXISTS add_pop_immigrants;

DELIMITER $$

CREATE PROCEDURE add_pop_immigrants(IN population_description VARCHAR(255), IN in_immigrant TINYINT,
								IN in_refugee TINYINT, IN in_asylee TINYINT, IN in_undocumented TINYINT)
BEGIN

DECLARE population_num INT;

DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'This population does not exist in the database.' AS error;
    END;

SELECT populationNo INTO population_num FROM populations
	WHERE description = population_description;
    
INSERT INTO populations_immigrant(populationNo, immigrant, refugee, asylee, undocumented)
	VALUES (population_num, in_immigrant, in_refugee, in_asylee, in_undocumented);

END $$

DELIMITER ;

/*
* Procedure to create sexual orientation regulations
*/

DROP PROCEDURE IF EXISTS add_pop_orientations;

DELIMITER $$

CREATE PROCEDURE add_pop_orientations(IN population_description VARCHAR(255), IN in_gay TINYINT,
								IN in_lesbian TINYINT, IN in_bisexual TINYINT, IN in_asexual TINYINT)
BEGIN

DECLARE population_num INT;

DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'This population does not exist in the database.' AS error;
    END;

SELECT populationNo INTO population_num FROM populations
	WHERE description = population_description;
    
INSERT INTO populations_sexual_orientation(populationNo, gay, lesbian, bisexual, asexual)
	VALUES (population_num, in_gay, in_lesbian, in_bisexual, in_asexual);

END $$

DELIMITER ;