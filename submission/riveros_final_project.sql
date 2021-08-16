CREATE DATABASE  IF NOT EXISTS `mass_nonprofits` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mass_nonprofits`;
-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: localhost    Database: mass_nonprofits
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `languageNo` int NOT NULL AUTO_INCREMENT,
  `languageName` varchar(45) NOT NULL,
  PRIMARY KEY (`languageNo`),
  UNIQUE KEY `languageName` (`languageName`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (25,'Albanian'),(1,'American Sign Language'),(30,'Amharic'),(2,'Arabic'),(26,'Bosnian'),(3,'Cantonese'),(4,'Cape Verdean Creole'),(5,'English'),(6,'French'),(7,'French Creole'),(8,'Greek'),(9,'Haitian Creole'),(10,'Hebrew'),(11,'Hindi'),(24,'Igbo'),(12,'Interpreter Service'),(13,'Italian'),(14,'Japanese'),(15,'Khmer'),(16,'Korean'),(17,'Laotian'),(18,'Mandarin'),(31,'Micmac'),(28,'Nepali'),(19,'Polish'),(20,'Portuguese'),(21,'Russian'),(29,'Somali'),(22,'Spanish'),(27,'Ukrainian'),(23,'Vietnamese');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages_spoken`
--

DROP TABLE IF EXISTS `languages_spoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages_spoken` (
  `languageNo` int NOT NULL,
  `orgNo` int NOT NULL,
  PRIMARY KEY (`languageNo`,`orgNo`),
  KEY `org_lang_fk` (`orgNo`),
  CONSTRAINT `lang_spoken_fk` FOREIGN KEY (`languageNo`) REFERENCES `languages` (`languageNo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `org_lang_fk` FOREIGN KEY (`orgNo`) REFERENCES `organizations` (`orgNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages_spoken`
--

LOCK TABLES `languages_spoken` WRITE;
/*!40000 ALTER TABLE `languages_spoken` DISABLE KEYS */;
INSERT INTO `languages_spoken` VALUES (2,1),(5,1),(6,1),(9,1),(12,1),(20,1),(22,1),(23,1),(24,1),(5,2),(22,2),(5,3),(6,3),(9,3),(5,4),(20,4),(5,5),(22,5),(5,6),(6,6),(14,6),(5,7),(6,7),(19,7),(22,7),(5,8),(13,8),(22,8),(25,8),(2,9),(5,9),(12,9),(21,9),(22,9),(23,9),(25,9),(26,9),(27,9),(28,9),(29,9),(3,10),(5,10),(6,10),(9,10),(20,10),(22,10),(25,10),(5,11),(6,11),(12,11),(20,11),(22,11),(23,11),(30,11),(5,12),(19,12),(21,12),(22,12),(27,12),(4,13),(5,13),(20,13),(22,13),(5,14),(6,14),(22,14),(23,14),(5,15),(31,15);
/*!40000 ALTER TABLE `languages_spoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization_addresses`
--

DROP TABLE IF EXISTS `organization_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_addresses` (
  `addressNo` int NOT NULL AUTO_INCREMENT,
  `orgNo` int NOT NULL,
  `descriptor` varchar(75) DEFAULT NULL,
  `street` varchar(45) NOT NULL,
  `city` varchar(25) NOT NULL,
  `zipcode` char(5) NOT NULL,
  `phone` char(12) DEFAULT NULL,
  PRIMARY KEY (`addressNo`),
  UNIQUE KEY `org_address_uq` (`orgNo`,`street`,`city`,`zipcode`),
  CONSTRAINT `org_address_fk` FOREIGN KEY (`orgNo`) REFERENCES `organizations` (`orgNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization_addresses`
--

LOCK TABLES `organization_addresses` WRITE;
/*!40000 ALTER TABLE `organization_addresses` DISABLE KEYS */;
INSERT INTO `organization_addresses` VALUES (1,1,'Main','26 Queens Street','Worcester','01610','508-860-7700'),(2,1,'Southbridge Family Medicine','29 Orchard Street','Southbridge','01550','774-318-1445'),(3,1,'Southbridge Family Dental Care and Health Benefits Advising','32 Orchard Street','Southbridge','01550','774-318-1484'),(4,1,'Homeless Outreach and Advocacy Program (HOAP)','162 Chandler Street','Worcester','01609','508-860-1080'),(5,2,'Contact Address','288 Lyman Street','Westborough','01581','508-475-2601'),(6,3,NULL,'330 Fuller Street','Dorchester','02124','617-287-0096'),(7,4,NULL,'697 Cambridge Street Suite 106','Allston','02134','617-202-5775'),(8,5,NULL,'P.O. Box 15265','Boston','02115','888-595-4678'),(9,6,NULL,'380 Massachusetts Avenue','Acton','01720','978-266-1991'),(10,7,'James House (Main/Mailing)','42 Gothic Street','Northampton','01060','413-587-0084'),(11,7,'CNA at Montague Catholic Social Ministries','41-43 3rd Street','Turners Falls','01376','413-676-9101'),(12,7,'Greenfield Family Learning Center','90 Federal Street','Greenfield','01301','413-772-0055'),(13,7,'Bangs Community Center','70 Boltwood Walk','Amherst','01002','413-259-3288'),(14,8,NULL,'36 Wall Street','Worcester','01604','508-755-4362'),(15,9,NULL,'1049 Main St','Springfield','01301','413-739-1100'),(16,10,NULL,'105 Chauncy St, Suite 901','Boston','02111','617-350-5480'),(17,11,NULL,'250 Washington Street, 5th Floor','Boston','02108','617-624-5590'),(18,12,NULL,'130 Maple Street','Springfield','01103','413-739-0882'),(19,13,NULL,'874 Purchase Street','New Bedford','02740','508-992-6553'),(20,14,NULL,'34 Haverhill Street','Lawrence','01841','978-686-0090'),(21,15,NULL,'105 South Huntington Avenue','Jamaica Plain','02130','617-232-0343');
/*!40000 ALTER TABLE `organization_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations` (
  `orgNo` int NOT NULL AUTO_INCREMENT,
  `orgName` varchar(125) NOT NULL,
  `regionNo` int NOT NULL,
  `email` varchar(80) DEFAULT NULL,
  `website` varchar(145) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `population` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`orgNo`),
  UNIQUE KEY `orgName` (`orgName`),
  KEY `org_reg_fk` (`regionNo`),
  CONSTRAINT `org_reg_fk` FOREIGN KEY (`regionNo`) REFERENCES `regions` (`regionNo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations`
--

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
INSERT INTO `organizations` VALUES (1,'Family Health Center (FHC) of Worcester, Inc.',1,NULL,'http://www.fhcw.org','Family Health Center of Worcester provides access to affordable, high quality, integrated, comprehensive, and respectful primary health care and social services, regardless of patients’ ability to pay.','Certain services offered in certain locations.','All residents of Worcester and surrounding towns'),(2,'The Butler Center',3,NULL,'https://jri.org/services/acute-care-and-juvenile-justice/juvenile-justice/butler','At the Butler Center, boys with significant emotional and mental health needs, who have been committed to the Massachusetts Department of Youth Services, are able to develop and practice strategies that will enable them to modulate their behavior.','Closed referrals via DYS; capacity of 12','Males 13-21; Committed to the Department of Youth Services'),(3,'Association of Haitian Women in Boston',2,'office@afab-kafanm.org','www.afab-kafanm.org','Community-based grassroots organization dedicated to empowering low-income Haitian women and their children. Programs include housing, domestic violence, adult education, and youth development services.',NULL,'Haitian women and their children'),(4,'Brazilian Women’s Group',2,'mulherbrasileira@verdeamaelo.org',NULL,'A group of women who are interested in the issues of being an immigrant woman from Brazil in the United States. Main activities include ESL classes, workshops on issues such as domestic violence, immigration, bilingual education, health and safety, etc.','BWG mostly works through referrals.','Brazilian families in Greater Boston'),(5,'Hospitality Homes',2,NULL,'www.hosp.org','Hospitality Homes provides temporary housing in volunteer host homes and other donated accommodations for families and friends of patients seeking care at Boston-area medical centers.','Guests travel internationally to seek treatment at Boston’s area hospitals. Hospitality Homes places guests from all over the world.','Families and friends of patients.'),(6,'The Victor School',4,NULL,'https://www.jri.org/victor/','The Victor School is a private, co-ed, therapeutic day school for students in grades 8-12. The school is fully approved by the Department of Education. All teachers are licensed in content (subject) area and/or special education.','Alternative school, students are bussed in from surrounding school districts. The school also has high MCAS scores and college entrance percentage.','Ages 12-21'),(7,'Center for New Americans',5,'info@cnam.org','www.cnam.org','A community based education and resource center for immigrants and refugees in Western Massachusetts.','All services are free.','Adult immigrants, refugees, or migrants'),(8,'Friendly House, Inc.',1,NULL,'https://www.friendlyhousema.org','Provides an after school program, art and recreation programs, summer camping programs, senior services, basic needs services, a continuum of shelter services, community organizing efforts, and a host of information and referral service.',NULL,'Serving the residents and families of Worcester'),(9,'Caring Health Center',5,NULL,'http://www.caringhealth.org/index.html','Provides primary care healthcare and services in Adult, Pediatric, OB/GYN, Mental Health and Optometry, Nutrition, HIV Management, Family Planning and WIC.','Serves the greater Springfield area.','African American, Puerto Rican, Russian, Vietnamese, Albanian, Ukrainian, Bosnian, Arabic, and others'),(10,'Massachusetts Immigrant and Refugee Advocacy Coalition (MIRA)',2,NULL,'www.miracoalition.org','MIRA is a coalition of member organizations which advocates for the rights and opportunities of immigrants and refugees. The coalition advances this mission through education, training, leadership development, organizing, policy analysis, and advocacy.',NULL,'Organizations and individuals who work with newcomers and those interested in preserving the civil and human rights of newcomers.'),(11,'Office of Health Equity',2,NULL,'https://www.mass.gov/orgs/office-of-health-equity','Provides advocacy and action for improving access to and the appropriateness of health services and health information for all refugee and immigrant communities in Massachusetts.',NULL,NULL),(12,'Center for Psychological and Family Services',5,NULL,NULL,'Provides an array of psychiatric and psychological services, including couples, family, group, and individual therapy.','Serves the Springfield area','People with psychological/psychiatric problems from a variety of backgrounds'),(13,'Greater New Bedford Community Health Center',4,NULL,'www.gnbchc.org','Provides primary care and ancillary services. Maximizes access to health care by providing both linguistically and culturally sensitive care through well-trained bilingual and minority staff.',NULL,'Everyone with or without health insurance. All services are provided regardless of ability to pay.'),(14,'Greater Lawrence Family Health Center',3,NULL,'www.glfhc.org ','A non-profit community operated medical practice and Community Health Center that provides primary care medicine, social services, nutrition, outreach, health education, HIV counseling and testing, and Family planning.',NULL,'Indochinese, Cuban, Central American, Puerto Rican and Dominican'),(15,'North American Indian Center of Boston, Inc.',2,NULL,'www.naicob.org','An Indian controlled non-profit corporation licensed in Massachusetts. Provides Indian health services and employment and training services. Also provides a Native American Head Start Program, cultural activities, and social events.',NULL,'North American Indians with the ability to provide proof of tribal affiliation for program services. Cultural activities and social events are open to all.');
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regions` (
  `regionNo` int NOT NULL AUTO_INCREMENT,
  `regionName` varchar(45) NOT NULL,
  PRIMARY KEY (`regionNo`),
  UNIQUE KEY `regionName` (`regionName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` VALUES (1,'Central Massachusetts'),(2,'Metro Boston'),(3,'Northeast-Suburban'),(4,'Southeast'),(5,'Western Massachusetts');
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `serviceNo` int NOT NULL AUTO_INCREMENT,
  `serviceType` varchar(45) NOT NULL,
  PRIMARY KEY (`serviceNo`),
  UNIQUE KEY `serviceType` (`serviceType`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (31,'After School Program'),(30,'Citizenship Classes'),(1,'Community Outreach'),(2,'Crises Services'),(21,'Deaf and Hard of Hearing Services'),(24,'Dental Services'),(3,'Domestic Violence'),(4,'Education'),(5,'Elder Services'),(44,'Employment Services'),(6,'ESL'),(34,'Family Planning'),(33,'Food Pantry'),(43,'Health/Community Service Advocacy/Referral'),(9,'Healthcare'),(8,'HIV/AIDS Services'),(7,'Homeless Services'),(25,'Housing'),(32,'Information and Referral'),(37,'Leadership Development'),(10,'Legal Services'),(11,'LGBTQ Services'),(39,'Liaisons in All Areas of Health'),(36,'Mental Health'),(14,'Mental Health: Counseling'),(40,'Mental Health: Counseling (Couples)'),(28,'Mental Health: Counseling (Family)'),(29,'Mental Health: Counseling (Group)'),(17,'Mental Health: Emergency Services'),(12,'Mental Health: Family Education/Support'),(13,'Mental Health: Peer Support'),(16,'Mental Health: Psychiatric Evaluation'),(15,'Mental Health: Psychiatric Services'),(41,'Nutrition'),(38,'Policy Analysis'),(23,'Referrals'),(18,'Refugee and Immigrant Services'),(20,'Sexual Assault'),(42,'Social Services'),(19,'Substance Abuse'),(27,'Temporary Housing'),(22,'Wellness Services'),(35,'WIC'),(26,'Youth Development Services');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_offered`
--

DROP TABLE IF EXISTS `services_offered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services_offered` (
  `serviceNo` int NOT NULL,
  `orgNo` int NOT NULL,
  PRIMARY KEY (`serviceNo`,`orgNo`),
  KEY `org_serv_fk` (`orgNo`),
  CONSTRAINT `org_serv_fk` FOREIGN KEY (`orgNo`) REFERENCES `organizations` (`orgNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `serv_offered_fk` FOREIGN KEY (`serviceNo`) REFERENCES `services` (`serviceNo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_offered`
--

LOCK TABLES `services_offered` WRITE;
/*!40000 ALTER TABLE `services_offered` DISABLE KEYS */;
INSERT INTO `services_offered` VALUES (1,1),(4,1),(7,1),(8,1),(9,1),(14,1),(18,1),(22,1),(23,1),(24,1),(4,2),(13,2),(1,3),(3,3),(4,3),(6,3),(13,3),(14,3),(25,3),(26,3),(1,4),(4,4),(6,4),(10,4),(18,4),(27,5),(4,6),(28,6),(29,6),(1,7),(6,7),(18,7),(30,7),(1,8),(5,8),(7,8),(18,8),(31,8),(32,8),(33,8),(1,9),(8,9),(9,9),(18,9),(24,9),(34,9),(35,9),(36,9),(18,10),(37,10),(38,10),(1,11),(4,11),(10,11),(18,11),(39,11),(15,12),(28,12),(29,12),(40,12),(8,13),(9,13),(22,13),(35,13),(41,13),(42,13),(1,14),(4,14),(8,14),(9,14),(14,14),(34,14),(36,14),(43,15),(44,15);
/*!40000 ALTER TABLE `services_offered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mass_nonprofits'
--

--
-- Dumping routines for database 'mass_nonprofits'
--
/*!50003 DROP FUNCTION IF EXISTS `addressNo_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `addressNo_exists`(address_ID INT) RETURNS int
    DETERMINISTIC
BEGIN

DECLARE address_check INT;

SELECT (SELECT EXISTS
		(SELECT * FROM organization_addresses WHERE addressNo = address_ID))
        INTO address_check;

RETURN address_check;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `lang_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `lang_exists`(lang_name VARCHAR(45)) RETURNS int
    DETERMINISTIC
BEGIN

DECLARE lang_check INT;

SELECT (SELECT EXISTS
		(SELECT * FROM languages WHERE languageName = lang_name))
        INTO lang_check;

RETURN lang_check;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `org_address_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `org_address_exists`(address_ID INT, org_name VARCHAR(125)) RETURNS int
    DETERMINISTIC
BEGIN

DECLARE org_num INT;
DECLARE address_check INT;

SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;

SELECT (SELECT EXISTS
		(SELECT * FROM organization_addresses WHERE addressNo = address_ID AND orgNo = org_num))
        INTO address_check;

RETURN address_check;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `org_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `org_exists`(org_name VARCHAR(125)) RETURNS int
    DETERMINISTIC
BEGIN

DECLARE org_check INT;

SELECT (SELECT EXISTS
		(SELECT * FROM organizations WHERE orgName = org_name))
        INTO org_check;

RETURN org_check;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `service_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `service_exists`(service_type VARCHAR(45)) RETURNS int
    DETERMINISTIC
BEGIN

DECLARE serv_check INT;

SELECT (SELECT EXISTS
		(SELECT * FROM services WHERE serviceType = service_type))
        INTO serv_check;

RETURN serv_check;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_address`(IN org_name VARCHAR(125), IN add_name VARCHAR(75),
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_org_language` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_org_language`(IN language_name VARCHAR(45), IN org_name VARCHAR(125))
BEGIN

DECLARE lang_num INT;
DECLARE org_num INT;

DECLARE EXIT HANDLER FOR 1048
    BEGIN
 	SELECT 'This input does not exist in the database.' AS error;
    END;
    
DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This language is already listed for this organization.' AS error;
    END;
    
SELECT languageNo INTO lang_num FROM languages
	WHERE languageName = language_name;
    
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
INSERT INTO languages_spoken(languageNo, orgNo) VALUES (lang_num, org_num);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_org_service` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_org_service`(IN service_name VARCHAR(45), IN org_name VARCHAR(125))
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_address`(IN addr_num INT, IN add_name VARCHAR(75),
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
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_org` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_org`(IN in_org_name VARCHAR(125), IN in_email VARCHAR(80), IN in_website VARCHAR(145),
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
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_language` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_language`(IN language_name VARCHAR(45))
BEGIN

DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This language already exists.' AS error;
    END;
    
INSERT INTO languages(languageName) VALUES (language_name);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_org` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_org`(IN org_name VARCHAR(125), IN region_name VARCHAR(45),
							IN org_email VARCHAR(80), IN org_website VARCHAR(145),
                            IN org_description VARCHAR(255), IN org_notes VARCHAR(255),
                            IN org_population VARCHAR(255))
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
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_service` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_service`(IN service_name VARCHAR(45))
BEGIN

DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT 'This service already exists.' AS error;
    END;
    
INSERT INTO services(serviceType) VALUES (service_name);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_address`(IN addr_id INT)
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
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_language_record` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_language_record`(IN lang_name VARCHAR(45))
BEGIN

DECLARE lang_num INT;

DECLARE EXIT HANDLER FOR 1451
    BEGIN
 	SELECT 'This language cannot be deleted because it is currently offered by one or more organizations.'
		AS error;
    END;

SELECT languageNo INTO lang_num FROM languages
	WHERE languageName = lang_name;

IF isNull(lang_num) THEN
	SELECT "This language does not exist in the database." AS error;
ELSE
	DELETE FROM languages WHERE languageNo = lang_num;
END IF;

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_org` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_org`(IN org_name VARCHAR(125))
BEGIN

DECLARE org_num INT;

SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;

IF isNull(org_num) THEN
	SELECT "This organization does not exist in the database." AS error;
ELSE
	DELETE FROM organizations WHERE orgNo = org_num;
END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_org_language` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_org_language`(IN org_name VARCHAR(125), IN lang_name VARCHAR(45))
BEGIN

DECLARE lang_num INT;
DECLARE org_num INT;

SELECT languageNo INTO lang_num FROM languages
	WHERE languageName = lang_name;

SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
DELETE FROM languages_spoken WHERE languageNo = lang_num AND orgNo = org_num;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_org_service` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_org_service`(IN org_name VARCHAR(125), IN serv_type VARCHAR(45))
BEGIN

DECLARE serv_num INT;
DECLARE org_num INT;

SELECT serviceNo INTO serv_num FROM services
	WHERE serviceType = serv_type;

SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
DELETE FROM services_offered WHERE serviceNo = serv_num AND orgNo = org_num;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_service_record` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_service_record`(IN serv_type VARCHAR(45))
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

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `find_org_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `find_org_name`(IN org_name VARCHAR(125))
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
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `list_languages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_languages`()
BEGIN
SELECT languageName FROM languages ORDER BY languageName asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `list_orgs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_orgs`()
BEGIN

SELECT orgName FROM organizations ORDER BY orgName ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `list_regions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_regions`()
BEGIN

SELECT regionName FROM regions ORDER BY regionName ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `list_services` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_services`()
BEGIN
SELECT serviceType FROM services ORDER BY serviceType asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `orgs_by_lang` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `orgs_by_lang`(IN in_lang_name VARCHAR(45))
BEGIN

SELECT orgName AS Organization FROM
	(SELECT orgNo FROM languages
		JOIN
        languages_spoken
        ON languages.languageNo = languages_spoken.languageNo
        WHERE languages.languageName = in_lang_name) AS ls
	JOIN
	organizations
	ON ls.orgNo = organizations.orgNo;

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `orgs_by_service` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `orgs_by_service`(IN in_service_type VARCHAR(45))
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

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_org_addresses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_org_addresses`(IN org_name VARCHAR(125))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_org_languages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_org_languages`(IN org_name VARCHAR(125))
BEGIN
DECLARE org_num INT;
    
SELECT orgNo INTO org_num FROM organizations
	WHERE orgName = org_name;
    
IF isNull(org_num) THEN
	SELECT 'This organization does not exist.' AS error;
ELSE
	SELECT languageName FROM languages_spoken
		JOIN
		languages
        ON languages_spoken.languageNo = languages.languageNo
		WHERE orgNo = org_num;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_org_services` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_org_services`(IN org_name VARCHAR(125))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_single_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_single_address`(IN addr_num INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-10 21:48:10
