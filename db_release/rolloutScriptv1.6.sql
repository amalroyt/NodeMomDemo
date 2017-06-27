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
-- Database structure for database `domo_mom_db`
--
CREATE DATABASE  IF NOT EXISTS `domo_mom_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `domo_mom_db`;

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
  `active` tinyint(4) DEFAULT '0',
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_meetingId_idx` (`meetingId`),
  KEY `domo_mom_fk_responsible_idx` (`responsible`),
  KEY `domo_mom_fk_status_idx` (`status`),
  CONSTRAINT `domo_mom_fk_meetinId` FOREIGN KEY (`meetingId`) REFERENCES `domo_meeting_master` (`meetingId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_responsible` FOREIGN KEY (`responsible`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_status` FOREIGN KEY (`status`) REFERENCES `domo_meeting_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_action`
--

LOCK TABLES `domo_meeting_action` WRITE;
/*!40000 ALTER TABLE `domo_meeting_action` DISABLE KEYS */;
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
  `meetingFacilitator` int(11) DEFAULT NULL,
  `meetingRecorder` int(11) DEFAULT NULL,
  `meetingVenue` varchar(40) DEFAULT NULL,
  `meetingDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `meetingAgenda` varchar(500) DEFAULT NULL,
  `meetingAttendees` varchar(100) DEFAULT NULL,
  `generatedExcel` tinyint(4) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  `startForm` varchar(2) DEFAULT NULL,
  `endForm` varchar(2) DEFAULT NULL,
  `duration` varchar(10) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`meetingId`),
  KEY `domo_mom_fk_status_idx` (`meetingStatus`),
  KEY `domo_mom_fk_type_idx` (`meetingType`),
  KEY `domo_mom_fk_facilitator_idx` (`meetingFacilitator`),
  KEY `domo_mom_fk_recorder_idx` (`meetingRecorder`),
  KEY `domo_mom_fk_created_By_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_meeting_master_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_meeting_fk_facilitator` FOREIGN KEY (`meetingFacilitator`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_meeting_fk_recorder` FOREIGN KEY (`meetingRecorder`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_meeting_fk_status` FOREIGN KEY (`meetingStatus`) REFERENCES `domo_meeting_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_meeting_fk_type` FOREIGN KEY (`meetingType`) REFERENCES `domo_meeting_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_master`
--

LOCK TABLES `domo_meeting_master` WRITE;
/*!40000 ALTER TABLE `domo_meeting_master` DISABLE KEYS */;
INSERT INTO `domo_meeting_master` VALUES (1,1,1,'Demo101',1,1,'CT1-2-6240A','2017-06-26','03:00:00','05:00:00','Trail run 1','1,2,3,4,5,6,7,8,9,10',0,0,1,'2017-06-26','PM','PM','02','undefined'),(2,1,1,'Demo102',1,1,'CT1-2-6240A','2017-06-26','04:00:00','05:00:00','Trial run 2','1,2,3,4,5,6,7,8,9,10',1,0,1,'2017-06-26','PM','PM','01','undefined'),(3,1,1,'Demo103',2,5,'CT1-2-6240A','2017-06-26','05:30:00','06:30:00','Trial run 3','1,2,3,4,5,6,7,8,9,10',1,0,1,'2017-06-26','PM','PM','01','undefined'),(4,2,2,'Demo104',1,4,'CT1-2-6240A','2017-06-26','04:30:00','05:30:00','sdsdsdsd','1,2,3,4,5,6,7,8,9,10',1,0,1,'2017-06-26','PM','PM','01','undefined'),(5,1,1,'Demo104',1,1,'CT1-2-6240A','2017-06-27','05:15:00','06:15:00','Trial 5678','1,2,3,4,5,6,8,9,10',0,0,7,'2017-06-27','PM','PM','01','undefined');
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
  `active` tinyint(4) DEFAULT '0',
  `decisionBy` int(11) DEFAULT NULL,
  `decision` varchar(200) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
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
INSERT INTO `domo_meeting_points` VALUES (1,2,4,1,'Trial run 1',0,1,'Trial',1,'2017-06-26'),(2,1,7,3,'Trial run 2',0,2,'Trial',1,'2017-06-26'),(3,3,10,1,'Trial 3GGGG',0,9,'Trial',1,'2017-06-26'),(4,5,2,4,'Trial',0,3,'Trial',7,'2017-06-27');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_status`
--

LOCK TABLES `domo_meeting_status` WRITE;
/*!40000 ALTER TABLE `domo_meeting_status` DISABLE KEYS */;
INSERT INTO `domo_meeting_status` VALUES (1,'Open'),(2,'Closed'),(3,'In Progress'),(4,'On Hold');
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
-- Table structure for table `domo_tasklogs`
--

DROP TABLE IF EXISTS `domo_tasklogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domo_tasklogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task` varchar(10) DEFAULT NULL,
  `onTable` varchar(20) DEFAULT NULL,
  `meetingId` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_tasklogs_updatedBy_idx` (`updatedBy`),
  KEY `domo_mom_fk_tasklogs_meetingId_idx` (`meetingId`),
  CONSTRAINT `domo_mom_fk_tasklogs_meetingId` FOREIGN KEY (`meetingId`) REFERENCES `domo_meeting_master` (`meetingId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_tasklogs_updatedBy` FOREIGN KEY (`updatedBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_tasklogs`
--

LOCK TABLES `domo_tasklogs` WRITE;
/*!40000 ALTER TABLE `domo_tasklogs` DISABLE KEYS */;
INSERT INTO `domo_tasklogs` VALUES (1,'Update','domo_meeting_points',2,1,'2017-06-26'),(2,'Insert','domo_meeting_points',3,1,'2017-06-26'),(3,'Update','domo_meeting_points',1,1,'2017-06-26'),(4,'Update','domo_meeting_master',3,1,'2017-06-26'),(5,'Update','domo_meeting_master',3,1,'2017-06-26'),(6,'Update','domo_meeting_master',3,1,'2017-06-26'),(7,'Update','domo_meeting_master',3,1,'2017-06-26'),(8,'Update','domo_meeting_master',3,1,'2017-06-26'),(9,'Update','domo_meeting_master',3,1,'2017-06-26'),(10,'Update','domo_meeting_master',3,1,'2017-06-26'),(11,'Update','domo_meeting_master',1,1,'2017-06-26'),(12,'Update','domo_meeting_master',1,1,'2017-06-26'),(13,'Update','domo_meeting_master',1,1,'2017-06-26'),(14,'Update','domo_meeting_master',3,1,'2017-06-26'),(15,'Update','domo_meeting_master',2,1,'2017-06-26'),(16,'Update','domo_meeting_master',3,1,'2017-06-26'),(17,'Update','domo_meeting_master',2,1,'2017-06-26'),(18,'Update','domo_meeting_master',1,1,'2017-06-26'),(19,'Update','domo_meeting_points',3,1,'2017-06-26'),(20,'Update','domo_meeting_points',1,1,'2017-06-26'),(21,'Update','domo_meeting_points',3,1,'2017-06-26'),(22,'Update','domo_meeting_points',3,1,'2017-06-26'),(23,'Update','domo_meeting_points',3,1,'2017-06-26'),(24,'Update','domo_meeting_points',3,1,'2017-06-26'),(25,'Update','domo_meeting_master',4,1,'2017-06-26'),(26,'Update','domo_meeting_master',5,7,'2017-06-27'),(27,'Insert','domo_meeting_points',5,7,'2017-06-27'),(28,'Update','domo_meeting_points',5,7,'2017-06-27');
/*!40000 ALTER TABLE `domo_tasklogs` ENABLE KEYS */;
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
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_token_createdBy_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_token_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_token`
--

LOCK TABLES `domo_token` WRITE;
/*!40000 ALTER TABLE `domo_token` DISABLE KEYS */;
INSERT INTO `domo_token` VALUES (232,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE1Mzc3LCJleHAiOjE0OTg1NDEyNDUsImlhdCI6MTQ5ODU0MDY0NX0.Z6tMCQDFIIm6xsnPAegVFED0-NJEjTvVlmAouG41ykY','2017-06-27 05:27:25',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_userlogs`
--

LOCK TABLES `domo_userlogs` WRITE;
/*!40000 ALTER TABLE `domo_userlogs` DISABLE KEYS */;
INSERT INTO `domo_userlogs` VALUES (1,'7',1,'2017-06-27','2017-06-27 05:17:25','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE1Mzc3LCJleHAiOjE0OTg1NDEyNDUsImlhdCI6MTQ5ODU0MDY0NX0.Z6tMCQDFIIm6xsnPAegVFED0-NJEjTvVlmAouG41ykY');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COMMENT='User information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_users`
--

LOCK TABLES `domo_users` WRITE;
/*!40000 ALTER TABLE `domo_users` DISABLE KEYS */;
INSERT INTO `domo_users` VALUES (1,17296,'sandeepnab','sandeepnab@cybage.com','Sandeep','Nabar','sandeepnab@12345',3,1),(2,12610,'vikasja','vikasja@cybage.com','Vikas','Jadhav','vikasja@12345',1,1),(3,7601,'sajus','sajus@cybage.com','Saju','Sasidharan','sajus@12345',1,1),(4,12389,'pravink','pravink@cybage.com','Pravin','Katta','pravink@12345',1,1),(5,14513,'ravikumard','ravikumard@cybage.com','Ravikumar','Dadhaniya','ravikumard@12345',1,1),(6,17005,'pranavki','pranavki@cybage.com','Pranav','Kishore','pranavki@12345',1,1),(7,15377,'sagarga','sagarga@cybage.com','Sagar','Gaikwad','sagarga@12345',1,1),(8,15106,'anjaliw','anjaliw@cybage.com','Anjali','Walke','anjaliw@12345',1,1),(9,8032,'rupeshr','rupeshr@cybage.com','Rupesh','Ramteke','rupeshr@12345',1,1),(10,8818,'pramodwa','pramodwa@cybage.com','Pramod','Wagale','pramodwa@12345',1,1);
/*!40000 ALTER TABLE `domo_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-27 10:52:34
