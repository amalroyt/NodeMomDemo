-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: domo_mom_db
-- ------------------------------------------------------
-- Server version	5.5.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
--
-- Database structure for`domo_mom_db`
--
DROP DATABASE IF EXISTS `domo_mom_db`;
CREATE DATABASE `domo_mom_db`;
USE domo_mom_db;
--
-- Table structure for table `domo_discussion_type`
--

DROP TABLE IF EXISTS `domo_discussion_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_discussion_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discussionType` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_discussion_type`
--

LOCK TABLES `domo_discussion_type` WRITE;
/*!40000 ALTER TABLE `domo_discussion_type` DISABLE KEYS */;
INSERT INTO `domo_discussion_type` VALUES (1,'discussion'),(2,'query'),(3,'demo'),(4,'other');
/*!40000 ALTER TABLE `domo_discussion_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domo_meeting_action`
--

DROP TABLE IF EXISTS `domo_meeting_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_meeting_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meetingId` int(11) DEFAULT NULL,
  `actionDesc` varchar(200) DEFAULT NULL,
  `responsible` int(11) DEFAULT NULL,
  `openSince` date DEFAULT NULL,
  `expectedCompletion` date DEFAULT NULL,
  `actualCompletion` date DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_meetingId_idx` (`meetingId`),
  KEY `domo_mom_fk_responsible_idx` (`responsible`),
  KEY `domo_mom_fk_status_idx` (`status`),
  CONSTRAINT `domo_mom_fk_meetinId` FOREIGN KEY (`meetingId`) REFERENCES `domo_meeting_master` (`meetingId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_responsible` FOREIGN KEY (`responsible`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_status` FOREIGN KEY (`status`) REFERENCES `domo_meeting_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_action`
--

LOCK TABLES `domo_meeting_action` WRITE;
/*!40000 ALTER TABLE `domo_meeting_action` DISABLE KEYS */;
INSERT INTO `domo_meeting_action` VALUES (1,1,'Josh to review PR #6893, 6895,6896, 6923',1,'2017-02-08','2017-02-10',NULL,NULL),(2,1,'Josh to check with Brandon  for DOMO-92119, to comment on it (whether to display buzz icon or not)',2,'2017-02-08','2017-02-09',NULL,NULL),(3,1,'Josh to ask Brandon to provide more details for DOMO-93084, as it is not reproducible at Cybage\' end',3,'2017-02-08','2017-02-14',NULL,NULL),(4,1,'Vikas asked if we could have one default component to display in case of any broken image like in case of datasets , buzz message avatar pic, Josh to discuss same with Brandon',2,'2017-02-08','2017-02-09',NULL,NULL);
/*!40000 ALTER TABLE `domo_meeting_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domo_meeting_master`
--
DROP TABLE IF EXISTS `domo_meeting_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_meeting_master` (
  `meetingId` int(11) NOT NULL AUTO_INCREMENT,
  `meetingStatus` int(11) DEFAULT NULL,
  `meetingType` int(11) DEFAULT NULL,
  `meetingTitle` varchar(50) DEFAULT NULL,
  `meetingPurpose` varchar(50) DEFAULT NULL,
  `meetingFacilitator` int(11) DEFAULT NULL,
  `meetingRecorder` int(11) DEFAULT NULL,
  `meetingVenue` varchar(40) DEFAULT NULL,
  `meetingDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `meetingAgenda` varchar(100) DEFAULT NULL,
  `meetingAttendees` varchar(100) DEFAULT NULL,
  `generatedExcel` varchar(20) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`meetingId`),
  KEY `domo_mom_fk_status_idx` (`meetingStatus`),
  KEY `domo_mom_fk_type_idx` (`meetingType`),
  KEY `domo_mom_fk_facilitator_idx` (`meetingFacilitator`),
  KEY `domo_mom_fk_recorder_idx` (`meetingRecorder`),
  CONSTRAINT `domo_mom_meeting_fk_facilitator` FOREIGN KEY (`meetingFacilitator`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_meeting_fk_recorder` FOREIGN KEY (`meetingRecorder`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_meeting_fk_status` FOREIGN KEY (`meetingStatus`) REFERENCES `domo_meeting_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_meeting_fk_type` FOREIGN KEY (`meetingType`) REFERENCES `domo_meeting_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_master`
--

LOCK TABLES `domo_meeting_master` WRITE;
/*!40000 ALTER TABLE `domo_meeting_master` DISABLE KEYS */;
INSERT INTO `domo_meeting_master` VALUES (1,1,3,'meeting_domo_101','ab',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','abcdefghijkl','Saju Sasidharan,Pranav Kishore,Sagar Gaikwad','NULL',NULL),(2,1,3,'meeting_domo_102','bc',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','abcdefghijkl','Saju Sasidharan,Pranav Kishore,Sagar Gaikwad','NULL',NULL),(3,1,3,'meeting_domo_103','cd',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','abcdefghijkl','Saju Sasidharan,Pranav Kishore,Sagar Gaikwad','NULL',NULL),(4,1,3,'meeting_domo_104','de',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','abcdefghijkl','Saju Sasidharan,Pranav Kishore,Sagar Gaikwad','NULL',NULL),(5,1,3,'meeting_domo_105','ef',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','abcdefghijkl','Saju Sasidharan,Pranav Kishore,Sagar Gaikwad','NULL',NULL),(6,1,3,'meeting_domo_106','gh',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','abcdefghijkl','Saju Sasidharan,Pranav Kishore,Sagar Gaikwad','NULL',NULL),(7,2,3,'meeting_domo_107','hi',6,6,'CT1-4567','2017-02-12','01:00:00','12:00:30','abc','Durgesh Ahire,Pranav Kishore','NULL',NULL),(8,2,3,'meeting_domo_108','jk',6,6,'CT1-4567','2017-02-12','01:00:00','12:00:30','abc','Durgesh Ahire,Pranav Kishore','NULL',NULL),(9,2,4,'meeting_domo_109','kl',3,3,'CT1-4567','2017-02-06','11:30:00','12:00:00','None','Pravin Katta,Saju Sasidharan,Vikas Jadhav','NULL',NULL);
/*!40000 ALTER TABLE `domo_meeting_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domo_meeting_points`
--

DROP TABLE IF EXISTS `domo_meeting_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_meeting_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meetingId` int(11) NOT NULL,
  `discussionBy` int(11) DEFAULT NULL,
  `discussionType` int(11) DEFAULT NULL,
  `discussion` varchar(200) DEFAULT NULL,
  `decisionBy` int(11) DEFAULT NULL,
  `decision` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_meetinId_idx` (`meetingId`),
  KEY `domo_mom_fk_discussedBy_idx` (`discussionBy`),
  KEY `domo_mom_fk_discussionType_idx` (`discussionType`),
  KEY `domo_mom_fk_decisionBy_idx` (`decisionBy`),
  CONSTRAINT `domo_mom_fk_decisionBy` FOREIGN KEY (`decisionBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_discussedBy` FOREIGN KEY (`discussionBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_discussionType` FOREIGN KEY (`discussionType`) REFERENCES `domo_discussion_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_meetingId` FOREIGN KEY (`meetingId`) REFERENCES `domo_meeting_master` (`meetingId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_points`
--

LOCK TABLES `domo_meeting_points` WRITE;
/*!40000 ALTER TABLE `domo_meeting_points` DISABLE KEYS */;
INSERT INTO `domo_meeting_points` VALUES (1,1,1,1,' Vikas updated the status on DOMO-94394,DOMO-93705,DOMO-93726,DOMO-94278',2,NULL),(2,1,2,1,'Josh discussed the tasks he is working on',2,NULL),(3,1,3,1,'Cybage team discussed their future leave plans',1,NULL),(4,1,3,1,'Sandhya asked queries on observation found during testing, Josh clarified those',1,NULL);
/*!40000 ALTER TABLE `domo_meeting_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domo_meeting_status`
--

DROP TABLE IF EXISTS `domo_meeting_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_meeting_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_status`
--

LOCK TABLES `domo_meeting_status` WRITE;
/*!40000 ALTER TABLE `domo_meeting_status` DISABLE KEYS */;
INSERT INTO `domo_meeting_status` VALUES (1,'open'),(2,'closed');
/*!40000 ALTER TABLE `domo_meeting_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domo_meeting_type`
--

DROP TABLE IF EXISTS `domo_meeting_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_meeting_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meetingType` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_type`
--

LOCK TABLES `domo_meeting_type` WRITE;
/*!40000 ALTER TABLE `domo_meeting_type` DISABLE KEYS */;
INSERT INTO `domo_meeting_type` VALUES (1,'Stand Up '),(2,'Client Call'),(3,'Sprint Meet'),(4,'Other');
/*!40000 ALTER TABLE `domo_meeting_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domo_token`
--

DROP TABLE IF EXISTS `domo_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(200) DEFAULT NULL,
  `expiryTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_token`
--

LOCK TABLES `domo_token` WRITE;
/*!40000 ALTER TABLE `domo_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `domo_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domo_userlogs`
--

DROP TABLE IF EXISTS `domo_userlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_userlogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empId` varchar(20) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `loginTime` timestamp NULL DEFAULT NULL,
  `token` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_userlogs`
--

LOCK TABLES `domo_userlogs` WRITE;
/*!40000 ALTER TABLE `domo_userlogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `domo_userlogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domo_userroles`
--

DROP TABLE IF EXISTS `domo_userroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_userroles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_userroles`
--

LOCK TABLES `domo_userroles` WRITE;
/*!40000 ALTER TABLE `domo_userroles` DISABLE KEYS */;
INSERT INTO `domo_userroles` VALUES (1,'cybage'),(2,'domo'),(3,'admin');
/*!40000 ALTER TABLE `domo_userroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domo_users`
--

DROP TABLE IF EXISTS `domo_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empId` int(11) NOT NULL,
  `userName` varchar(30) NOT NULL,
  `emailId` varchar(30) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) DEFAULT NULL,
  `password` varchar(30) NOT NULL,
  `role` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='User information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_users`
--

LOCK TABLES `domo_users` WRITE;
/*!40000 ALTER TABLE `domo_users` DISABLE KEYS */;
INSERT INTO `domo_users` VALUES (1,17296,'sandeepnab','sandeepnab@cybage.com','Sandeep','Nabar','sandeep@12345',3,1),(2,12610,'vikasja','vikasja@cybage.com','Vikas','Jadhav','vikas@12345',1,1),(3,7601,'sajus','sajus@cybage.com','Saju','Sasidharan','saju@12345',1,1),(4,12389,'pravink','pravink@cybage.com','Pravin','Katta','pravin@12345',1,1),(5,14513,'ravikumard','ravikumard@cybage.com','Ravikumar','Dadhaniya','ravikumard@12345',1,1),(6,14170,'durgesha','durgesha@cybage.com','Durgesh','Ahire','durgesha@12345',1,1),(7,17005,'pranavki','pranavki@cybage.com','Pranav','Kishore','pranavki@12345',1,1),(8,15377,'sagarga','sagarga@cybage.com','Sagar','Gaikwad','sagarga@12345',1,1),(9,15106,'anjaliw','anjaliw@cybage.com','Anjali','Walke','anjaliw@12345',1,1),(10,8032,'rupeshr','rupeshr@cybage.com','Rupesh','Ramteke','rupeshr@12345',1,1),(11,12368,'prasanths','prasanths@cybage.com','Prasanth','Soman','prasanth@12345',1,0);
/*!40000 ALTER TABLE `domo_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'domo_mom_db'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
DROP EVENT IF EXISTS `tokenTableCLeanup`;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = cp850 */ ;;
/*!50003 SET character_set_results = cp850 */ ;;
/*!50003 SET collation_connection  = cp850_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
CREATE EVENT `tokenTableCLeanup` ON SCHEDULE EVERY '30:0' MINUTE_SECOND STARTS '2017-02-10 15:11:49' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Clears out token table every 30 minutes.' DO DELETE FROM domo_mom_db.domo_token WHERE UNIX_TIMESTAMP(CURRENT_TIMESTAMP()) >  UNIX_TIMESTAMP(expiryTime);
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-10 15:15:38
