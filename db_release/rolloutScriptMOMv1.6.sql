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
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_created_By_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_discussion_type_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_discussion_type`
--

LOCK TABLES `domo_discussion_type` WRITE;
/*!40000 ALTER TABLE `domo_discussion_type` DISABLE KEYS */;
INSERT INTO `domo_discussion_type` VALUES (1,'discussion',NULL,NULL),(2,'query',NULL,NULL),(3,'demo',NULL,NULL),(4,'other',NULL,NULL);
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
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_meetingId_idx` (`meetingId`),
  KEY `domo_mom_fk_responsible_idx` (`responsible`),
  KEY `domo_mom_fk_status_idx` (`status`),
  KEY `domo_mom_fk_created_By_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_meeting_action_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_meetinId` FOREIGN KEY (`meetingId`) REFERENCES `domo_meeting_master` (`meetingId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_responsible` FOREIGN KEY (`responsible`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_status` FOREIGN KEY (`status`) REFERENCES `domo_meeting_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_action`
--

LOCK TABLES `domo_meeting_action` WRITE;
/*!40000 ALTER TABLE `domo_meeting_action` DISABLE KEYS */;
INSERT INTO `domo_meeting_action` VALUES (1,1,'Josh to review PR #6893, 6895,6896, 6923',1,'2017-02-08','2017-02-10',NULL,NULL,NULL,NULL),(2,1,'Josh to check with Brandon  for DOMO-92119, to comment on it (whether to display buzz icon or not)',2,'2017-02-08','2017-02-09',NULL,NULL,NULL,NULL),(3,1,'Josh to ask Brandon to provide more details for DOMO-93084, as it is not reproducible at Cybage\' end',3,'2017-02-08','2017-02-14',NULL,NULL,NULL,NULL),(4,1,'Vikas asked if we could have one default component to display in case of any broken image like in case of datasets , buzz message avatar pic, Josh to discuss same with Brandon',2,'2017-02-08','2017-02-09',NULL,NULL,NULL,NULL),(12,8,'Vikas asked if we could have one default component to display in case of any broken image like in case of datasets , buzz message avatar pic, Josh to discuss same with Brandon',4,'2017-03-01','2017-03-01','2017-03-14',2,NULL,NULL),(13,8,'Vikas asked if we could have one default component to display in case of any broken image like in case of datasets , buzz message avatar pic, Josh to discuss same with Brandon',4,'2017-03-01','2017-03-02','2017-03-14',2,NULL,NULL);
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
  `generatedExcel` tinyint(4) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_master`
--

LOCK TABLES `domo_meeting_master` WRITE;
/*!40000 ALTER TABLE `domo_meeting_master` DISABLE KEYS */;
INSERT INTO `domo_meeting_master` VALUES (1,1,3,'meeting_domo_101','Weekly Sprint Status meeting',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','General Engineering updates,JIRA User Stories Status','1,2,3',1,0,NULL,NULL),(2,1,3,'meeting_domo_102','Weekly Sprint Status meeting',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','JIRA User Stories Status','4,5,6',1,0,NULL,NULL),(3,1,3,'meeting_domo_103','Weekly Sprint Status meeting',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','General Engineering updates','7,8,9',1,0,NULL,NULL),(4,1,3,'meeting_domo_104','Weekly Sprint Status meeting',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','General Engineering updates,JIRA User Stories Status','10,3,5',1,0,NULL,NULL),(5,1,3,'meeting_domo_105','Weekly Sprint Status meeting',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','General Engineering updates','7,4,1',1,0,NULL,NULL),(6,1,3,'meeting_domo_106','Weekly Sprint Status meeting',3,3,'CT1-2-6284','2017-02-06','12:00:00','01:00:00','JIRA User Stories Status','6,3,7',0,0,NULL,NULL),(7,2,3,'meeting_domo_107','Weekly Sprint Status meeting',6,6,'CT1-4567','2017-02-12','01:00:00','12:00:30','General Engineering updates,JIRA User Stories Status','8,9,5',0,0,NULL,NULL),(8,2,3,'meeting_domo_108','Weekly Sprint Status meeting',6,6,'CT1-4567','2017-02-12','01:00:00','12:00:30','JIRA User Stories Status','1,6,4',0,0,NULL,NULL),(9,2,4,'meeting_domo_109','Weekly Sprint Status meeting',3,3,'CT1-4567','2017-02-06','11:30:00','12:00:00','General Engineering updates','8,5,1',0,0,NULL,NULL);
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
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_meetinId_idx` (`meetingId`),
  KEY `domo_mom_fk_discussedBy_idx` (`discussionBy`),
  KEY `domo_mom_fk_discussionType_idx` (`discussionType`),
  KEY `domo_mom_fk_decisionBy_idx` (`decisionBy`),
  KEY `domo_mom_fk_meeting_points_createdBy_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_decisionBy` FOREIGN KEY (`decisionBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_discussedBy` FOREIGN KEY (`discussionBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_discussionType` FOREIGN KEY (`discussionType`) REFERENCES `domo_discussion_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_meetingId` FOREIGN KEY (`meetingId`) REFERENCES `domo_meeting_master` (`meetingId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_meeting_points_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_points`
--

LOCK TABLES `domo_meeting_points` WRITE;
/*!40000 ALTER TABLE `domo_meeting_points` DISABLE KEYS */;
INSERT INTO `domo_meeting_points` VALUES (1,1,2,4,' Vikas updated the status on DOMO-94394,DOMO-93705,DOMO-93726,DOMO-94278',1,'decision1',NULL,NULL),(2,1,3,4,'Josh discussed the tasks he is working on',2,'decision2',NULL,NULL),(3,1,1,1,'Cybage team discussed their future leave plans',1,'decision3',NULL,NULL),(4,1,3,1,'Sandhya asked queries on observation found during testing, Josh clarified those',1,'decision4',NULL,NULL),(5,1,1,2,'discussion4',1,'decision4',NULL,NULL),(6,1,2,3,'discussion5',3,'decision5',NULL,NULL),(7,4,2,3,'discussion4',2,'decision4',NULL,NULL),(8,4,3,3,'discussion12',3,'decision12',NULL,NULL),(9,4,4,3,'discussion11',4,'decision11',NULL,NULL),(10,2,4,4,'discussion1',3,'decision1',NULL,NULL),(11,2,5,2,'discussion2',4,'decision2',NULL,NULL),(12,9,2,3,'discussion2',3,'decision2',NULL,NULL),(13,2,2,2,'discussion2',3,'decision2',NULL,NULL),(14,2,2,4,'discussion3',4,'decision3',NULL,NULL),(15,9,11,4,'discussion1',11,'decision1',NULL,NULL),(16,9,10,4,'discussion2',9,'decision2',NULL,NULL),(17,9,11,4,'discussion3',11,'decision3',NULL,NULL);
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
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_meeting_status_createdBy_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_meeting_status_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_status`
--

LOCK TABLES `domo_meeting_status` WRITE;
/*!40000 ALTER TABLE `domo_meeting_status` DISABLE KEYS */;
INSERT INTO `domo_meeting_status` VALUES (1,'Open',NULL,NULL),(2,'Closed',NULL,NULL),(3,'In Progress',NULL,NULL),(4,'On Hold',NULL,NULL);
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
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_meeting_type_createdBy_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_meeting_type_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_type`
--

LOCK TABLES `domo_meeting_type` WRITE;
/*!40000 ALTER TABLE `domo_meeting_type` DISABLE KEYS */;
INSERT INTO `domo_meeting_type` VALUES (1,'Stand Up ',NULL,NULL),(2,'Client Call',NULL,NULL),(3,'Sprint Meet',NULL,NULL),(4,'Other',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_tasklogs`
--

LOCK TABLES `domo_tasklogs` WRITE;
/*!40000 ALTER TABLE `domo_tasklogs` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_token`
--

LOCK TABLES `domo_token` WRITE;
/*!40000 ALTER TABLE `domo_token` DISABLE KEYS */;
INSERT INTO `domo_token` VALUES (1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODc3NTM0MzIsImlhdCI6MTQ4Nzc1MjgzMn0.2VLrqaWREgW3NE7ju2IXRxWJZoSv9Jh1Mi02iYsoMgY','2017-02-22 08:50:32',NULL,NULL),(2,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODc3NTUyMjcsImlhdCI6MTQ4Nzc1NDYyN30.VlP-VjiJG5u4AQ2JMd6CPL1vLq0jNkMyq5oVjIgUQ5U','2017-02-22 09:20:27',NULL,NULL),(3,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODc4Mjc4NTMsImlhdCI6MTQ4NzgyNzI1M30.Nqx2lS3LuSBKfS7N7xKYZo82Rrx_dS9x-swK2WE5OSQ','2017-02-23 05:30:53',NULL,NULL),(4,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyNzQzNDEsImlhdCI6MTQ4ODI3Mzc0MX0.7JT1RXEmQjF_fS4EW4YixWBxB1abkZfBPaSOo17PJT4','2017-02-28 09:32:21',NULL,NULL),(5,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyNzQ0ODUsImlhdCI6MTQ4ODI3Mzg4NX0.ea14-3mWAFO73TXveSAP1IQuf-mzuhgtlFeQnxm2_4E','2017-02-28 09:34:45',NULL,NULL),(6,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyNzQ2NzQsImlhdCI6MTQ4ODI3NDA3NH0.O8EsqNFpZVkwxcZGPaHmljFMfzgCb1enZsr4JBkGo_M','2017-02-28 09:37:54',NULL,NULL),(7,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyNzQ4NzMsImlhdCI6MTQ4ODI3NDI3M30.GpGCSXjDERnVOMPnFCW_BO2YGdvHW6gSj2msQHR1qIE','2017-02-28 09:41:13',NULL,NULL),(8,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjc2MDEsImV4cCI6MTQ4ODI3NTAyOSwiaWF0IjoxNDg4Mjc0NDI5fQ.eB7-KwoJUq86nAonXOHCwBbWzSkbA2Jfh76sF0DfkOU','2017-02-28 09:43:49',NULL,NULL),(9,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyNjEwLCJleHAiOjE0ODgyNzUxMDIsImlhdCI6MTQ4ODI3NDUwMn0.4APfXMK-CG_nM5RymzEUJ47utaORBmLV3o2qKhI1Lyk','2017-02-28 09:45:02',NULL,NULL),(10,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODEzMTUsImlhdCI6MTQ4ODI4MDcxNX0.k_k4GM2rIFrVnfrZjbxFgdTycP8_VqoRcxdQZsURzI8','2017-02-28 11:28:35',NULL,NULL),(11,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODI2OTAsImlhdCI6MTQ4ODI4MjA5MH0.7SjCw_4qLXRvQa8tADCbxq5tUJ5j02fuZb8BSt4cxYk','2017-02-28 11:51:30',NULL,NULL),(12,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODg3NjcsImlhdCI6MTQ4ODI4ODE2N30.Ddlg_TJcvD5P-eo1ZOfSfkOGIKEsFX7Yf7OYyi4buV0','2017-02-28 13:32:47',NULL,NULL),(13,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODkxMjIsImlhdCI6MTQ4ODI4ODUyMn0.N1Gdwg6RT-lJzuqjpbLO93tn8fdJd7KVPicsIRTuj1s','2017-02-28 13:38:42',NULL,NULL),(14,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODk1NTYsImlhdCI6MTQ4ODI4ODk1Nn0.NXz1BtwkjeevmosY-N0FgMXR8vrkGvJkZMdk1xDRKZE','2017-02-28 13:45:56',NULL,NULL),(15,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNDgxMTUsImlhdCI6MTQ4ODM0NzUxNX0.em8IfpWRNkn6_UOwWRS6YOw0a0ZegrdlQhwCo0dECxw','2017-03-01 06:01:55',NULL,NULL),(16,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNTgwNDIsImlhdCI6MTQ4ODM1NzQ0Mn0.G-qzh1MumkuBTnEucf4rNQLfxQA_bLquYg7-Tm9I4E8','2017-03-01 08:47:22',NULL,NULL),(17,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNTgxMjYsImlhdCI6MTQ4ODM1NzUyNn0.FtmEThkdn7y_2f9ZxmwN7dcZPj4PTIefki425fdqLO8','2017-03-01 08:48:46',NULL,NULL),(18,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNTgyMDMsImlhdCI6MTQ4ODM1NzYwM30.Puj2jqL6Mcdjf1Zo77rQ9rCOkmibmRmTv_VrAUloubc','2017-03-01 08:50:03',NULL,NULL),(19,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNTkwNjcsImlhdCI6MTQ4ODM1ODQ2N30.B7CP29H-wY56XagcE_srpkohchO4ZW8U7lJdMKHyfM8','2017-03-01 09:04:27',NULL,NULL),(20,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNzAwMzcsImlhdCI6MTQ4ODM2OTQzN30.qvTuZhCWmpyDqVM_g33FCNLzGnEI0Ldzxmn3LUEMxi4','2017-03-01 12:07:17',NULL,NULL),(21,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNzAyNjYsImlhdCI6MTQ4ODM2OTY2Nn0.vxp_S_QPvgUzlmNHuoo913b91M1kbfFC7af4InOiBEU','2017-03-01 12:11:06',NULL,NULL),(22,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg0NjY1OTQsImlhdCI6MTQ4ODQ2NTk5NH0.phtc0P7sBujtWocDSqHlk8y2Yds0xE6pHiWjmXMymYE','2017-03-02 14:56:34',NULL,NULL),(23,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg4NzUzMzUsImlhdCI6MTQ4ODg3NDczNX0.OkCNVP1vhas8YvimBDC4gpbYsnvr16gg79CraJqNj80','2017-03-07 08:28:56',NULL,NULL),(24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzA3NTAsImlhdCI6MTQ4ODk3MDE1MH0.NGV02JdiNCWQ7grbbTq59m_ZP9v9RrRpHYE5jJdiFWQ','2017-03-08 10:59:10',NULL,NULL),(25,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzA4MTAsImlhdCI6MTQ4ODk3MDIxMH0.IVpi9dqmAJWICUXYDMDOkEU_3_KKveDvR7sS5_0eGUo','2017-03-08 11:00:10',NULL,NULL),(26,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzA4MzMsImlhdCI6MTQ4ODk3MDIzM30.hBNZC0HPI3N9mdteWb5IBGDV6gJO4ZXUxGsttdhT3S0','2017-03-08 11:00:33',NULL,NULL),(27,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzA5NTMsImlhdCI6MTQ4ODk3MDM1M30.MY3n7ZTWE1b03I62b5jvDNjJc7lUnUDRhrgotmg18a4','2017-03-08 11:02:33',NULL,NULL),(28,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzExNjgsImlhdCI6MTQ4ODk3MDU2OH0.xLpHk2yQddm2YraIQI3Mj6v9i2O_9nXJHYWwwsYUQeM','2017-03-08 11:06:08',NULL,NULL),(29,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzEzNTYsImlhdCI6MTQ4ODk3MDc1Nn0.j2azL06kdKf-QP-OzDkk-LgzS8gFmD5_zPQThOZKDKc','2017-03-08 11:09:16',NULL,NULL),(30,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzE1NzgsImlhdCI6MTQ4ODk3MDk3OH0.ichGY_yPHeDJfvlIEuMxEdr-dTj3CZ5IDU5xdJa5NaI','2017-03-08 11:12:58',NULL,NULL),(31,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzE2NzcsImlhdCI6MTQ4ODk3MTA3N30.0Yzf45pj_pvyEuzNHPXVVVBbVRy4QgfXObwIXgx1y2k','2017-03-08 11:14:37',NULL,NULL),(32,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzE5MjcsImlhdCI6MTQ4ODk3MTMyN30.4eJxK6aya2B_y-kxjcrpjEMeFCF12BB71nwlwC23f78','2017-03-08 11:18:47',NULL,NULL),(33,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzI4MjMsImlhdCI6MTQ4ODk3MjIyM30.94hReviK7KissXs_MIzBGfEg0hzuLplZYvDt-RyIxA0','2017-03-08 11:33:43',NULL,NULL),(34,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzI4OTMsImlhdCI6MTQ4ODk3MjI5M30.a0wTUAZH_vyCNrbx6boyFhHOl-0Z9ZB2gPtUKeV967A','2017-03-08 11:34:53',NULL,NULL),(35,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzI5NjgsImlhdCI6MTQ4ODk3MjM2OH0.XSvbxZGIf4YqVV-y4QB3Gm3DoAV_PkJWk5JvtCmmd7Y','2017-03-08 11:36:08',NULL,NULL),(36,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzMwNTEsImlhdCI6MTQ4ODk3MjQ1MX0.B23JL8f-nkGcWr5eyGPOLMn59q0BS-U3dj4Lrl6bzO0','2017-03-08 11:37:31',NULL,NULL),(37,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzMxNjcsImlhdCI6MTQ4ODk3MjU2N30.jlx5vAqczgGYIGf4LXh5OzjLSrcwOvEui_f7fo9-jqc','2017-03-08 11:39:27',NULL,NULL),(38,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzMxOTUsImlhdCI6MTQ4ODk3MjU5NX0.g0izxnc5BbKgbEI0NBoOqdjqQl7jRCkh91HMWHvxAjA','2017-03-08 11:39:55',NULL,NULL),(39,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5Nzk3ODAsImlhdCI6MTQ4ODk3OTE4MH0.VhhJZLRPBsvZa7TWbxdkmyCeFDN0KaFOddUkdwcBcZA','2017-03-08 13:29:40',NULL,NULL),(40,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5Nzk4NzEsImlhdCI6MTQ4ODk3OTI3MX0.cScYMv8ZAaktgzLNmSC59m74CK0pablgamqeR1v6HZI','2017-03-08 13:31:11',NULL,NULL),(41,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODAwNTEsImlhdCI6MTQ4ODk3OTQ1MX0.9VQjDhTJzq1GmN-xoodPJilg3DczXsEXVr9jLaj4u6w','2017-03-08 13:34:11',NULL,NULL),(42,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODAxNjcsImlhdCI6MTQ4ODk3OTU2N30.9aGtKEfMIhe2mJ3H3H7WAqBdHYmzOqcaBlB1-WEW4zo','2017-03-08 13:36:07',NULL,NULL),(43,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODAyMzYsImlhdCI6MTQ4ODk3OTYzNn0.s4nrtWN_xd1hQ8aQdnBnxRbRHUv_yo6ZeMU0y5ePYwk','2017-03-08 13:37:16',NULL,NULL),(44,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODEyOTYsImlhdCI6MTQ4ODk4MDY5Nn0.6Ldjm1x4L2q7LW-iGCfxjVJwSePaSRwflHV7JK8Xkjs','2017-03-08 13:54:56',NULL,NULL),(45,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODE4NjMsImlhdCI6MTQ4ODk4MTI2M30.s5Xs5rcYTM2WUM0H_M5ixjW_SFx-N6bK4522yjJfGOc','2017-03-08 14:04:23',NULL,NULL),(46,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzU0MDQsImlhdCI6MTQ4OTAzNDgwNH0.xjxemSzwVEOk56jvZTp05HAHvLBRn63jq7qVu7ZSEoc','2017-03-09 04:56:44',NULL,NULL),(47,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzU2NDUsImlhdCI6MTQ4OTAzNTA0NX0.zYcEHFN2CsGhwKf5Ll_F8Z2tjfv3ZbLDRda4gdF62_I','2017-03-09 05:00:45',NULL,NULL),(48,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzU3MTgsImlhdCI6MTQ4OTAzNTExOH0.gBoyMOSXkp2jl8cW4TyCyUSrt3doK_ruogI6331isk8','2017-03-09 05:01:58',NULL,NULL),(49,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzU5MzUsImlhdCI6MTQ4OTAzNTMzNX0.BDfx3HSWTsV0hrr9a6GoAFW6ect0b_vhl0nPb0boNWE','2017-03-09 05:05:35',NULL,NULL),(50,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzYxMDcsImlhdCI6MTQ4OTAzNTUwN30.jNni8jMHpWqYOrSBP6nBWCnK4hE7_aotHC9_XLUc1L0','2017-03-09 05:08:27',NULL,NULL),(51,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzYyNDgsImlhdCI6MTQ4OTAzNTY0OH0.Z3gx10cLJ77KrsVsvUv-i66L1PuwIiLq91ZizFm6m4A','2017-03-09 05:10:48',NULL,NULL),(52,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzY0NTksImlhdCI6MTQ4OTAzNTg1OX0.XuGFkXHNF6n8aqSMIbDapoMM-GaeYAa1PCTfaXSTSCk','2017-03-09 05:14:19',NULL,NULL),(53,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzY2MzYsImlhdCI6MTQ4OTAzNjAzNn0.NCKLzV3IlaLnl_lGBI9sFHWNotURB2pxlRbdGRNOC8k','2017-03-09 05:17:16',NULL,NULL),(54,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzY3MTUsImlhdCI6MTQ4OTAzNjExNX0.Vv7rxRTBpkOl8OliM9QnoTefOhwXEmkv2ZoQsEu04GE','2017-03-09 05:18:35',NULL,NULL),(55,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzY4NjEsImlhdCI6MTQ4OTAzNjI2MX0.8yyO43SzGaSK389mTQyYgsDfVCtqtIUj0cYJTBX_Kps','2017-03-09 05:21:01',NULL,NULL),(56,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzcwMTQsImlhdCI6MTQ4OTAzNjQxNH0.tIfWcWM9Wb9z2hlC7SWuLjQna9XwdB3zRkzKmSad3HM','2017-03-09 05:23:34',NULL,NULL),(57,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzc1OTksImlhdCI6MTQ4OTAzNjk5OX0.vZGwtReaklNS8hWjJtdj1-aYqURZ_LG6ebnKSuD2wA8','2017-03-09 05:33:19',NULL,NULL),(58,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzg0MjUsImlhdCI6MTQ4OTAzNzgyNX0.nSs_PBH1hNtesX3ZqAiLKTgOUk8MKOa_wEqQ00fEMs4','2017-03-09 05:47:05',NULL,NULL),(59,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMjE5MjUsImlhdCI6MTQ4OTEyMTMyNX0.LD9pLab0iXjblvERcLrcimHjnsRnIFX4g91nbCCcDwg','2017-03-10 04:58:46',NULL,NULL),(60,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMjIxNzIsImlhdCI6MTQ4OTEyMTU3Mn0.42wwlv0zbwoLpsqeE_jJQbV37j4LEHAkzU0CvjTR5Rc','2017-03-10 05:02:53',NULL,NULL),(61,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMjU5NzMsImlhdCI6MTQ4OTEyNTM3M30.wP17RrHltyv7FKuyXu9-va7sU2jJXKKZMejKP3wI8LE','2017-03-10 06:06:13',NULL,NULL),(62,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMzk5OTAsImlhdCI6MTQ4OTEzOTM5MH0.2pGUGDxqj6RGOukvffEXU9eaMlHUCvCd8yjHJbaj8fQ','2017-03-10 09:59:50',NULL,NULL),(63,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMzk5OTAsImlhdCI6MTQ4OTEzOTM5MH0.2pGUGDxqj6RGOukvffEXU9eaMlHUCvCd8yjHJbaj8fQ','2017-03-10 09:59:50',NULL,NULL),(64,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxNDAwNjgsImlhdCI6MTQ4OTEzOTQ2OH0.JF1ZL4hgOEwVvVvjO-cd_8mIghOvIwipZyqdLOTGgCQ','2017-03-10 10:01:08',NULL,NULL),(65,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxNDE5ODIsImlhdCI6MTQ4OTE0MTM4Mn0.zLRCEMBKY3Ehtc5GPZrxrMFmKTY_p1F2_SQc1gHFpwg','2017-03-10 10:33:02',NULL,NULL),(66,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxNDIxOTQsImlhdCI6MTQ4OTE0MTU5NH0.dCZYMl2BQUepi9wOplXldOPAbwhnqnFnex9cjtcUcPM','2017-03-10 10:36:34',NULL,NULL),(67,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0Njg0MjMsImlhdCI6MTQ4OTQ2NzgyM30.IAl8B7DrEaPpPv2TxouU1_7AUAh-hFbtIlu3bHaAm-c','2017-03-14 05:13:43',NULL,NULL),(68,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0ODc0MTQsImlhdCI6MTQ4OTQ4NjgxNH0.WpxIFGp3PUiNIcKU4nEebdCI-TL31Nr-h2SPDxBsbmU','2017-03-14 10:30:14',NULL,NULL),(69,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0OTA3MTEsImlhdCI6MTQ4OTQ5MDExMX0.aCFNsAQpL48D_inscAn7CAmg8dYdptllp3CCQQyy4c4','2017-03-14 11:25:11',NULL,NULL),(70,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0OTExODksImlhdCI6MTQ4OTQ5MDU4OX0.hsznKHCRmaszTY8shViGnE4oHXig8K2ZjJEgv6Xs36Y','2017-03-14 11:33:09',NULL,NULL),(71,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0OTEyOTEsImlhdCI6MTQ4OTQ5MDY5MX0.bVTMgJlsEfKY9XD5XuR6wyMd0UZYTgwhG5KqbNsfP0M','2017-03-14 11:34:51',NULL,NULL),(72,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQwOTEsImlhdCI6MTQ4OTU1MzQ5MX0.vq_lz9OpD6hwUG41G6QWlKgV-YAz7-lq07YqzNvM-1U','2017-03-15 05:01:31',NULL,NULL),(73,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQwOTEsImlhdCI6MTQ4OTU1MzQ5MX0.vq_lz9OpD6hwUG41G6QWlKgV-YAz7-lq07YqzNvM-1U','2017-03-15 05:01:31',NULL,NULL),(74,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQyNDYsImlhdCI6MTQ4OTU1MzY0Nn0.zUyFAICmDxo4uQvokOi29kMjrYbTm25KOJ9mUip3P0g','2017-03-15 05:04:06',NULL,NULL),(75,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQ4OTYsImlhdCI6MTQ4OTU1NDI5Nn0.qQRvkFtZTVjH6fmH10yBDv41YZIlEuag8h4rRlLzcaY','2017-03-15 05:14:56',NULL,NULL),(76,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQ5OTEsImlhdCI6MTQ4OTU1NDM5MX0.yk98p5FimBrRWaDmC91gIPn-T1U7m5U4OhQpo23hTy0','2017-03-15 05:16:31',NULL,NULL),(77,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTUyMDMsImlhdCI6MTQ4OTU1NDYwM30.K5MDnt-VeT2ypDUZzlkxoFozFevlE6RspNkKnB9nN9c','2017-03-15 05:20:03',NULL,NULL),(78,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTUyOTQsImlhdCI6MTQ4OTU1NDY5NH0.L3SZe-ZzEcvwnWUZpF7eHx6qyXa8N7ack5gEs3sEbZY','2017-03-15 05:21:34',NULL,NULL),(79,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTU2MjIsImlhdCI6MTQ4OTU1NTAyMn0.PMv2HVbvvZVAniYoQ0bovwyAq8_9rtl6R0ZcOK1hzLE','2017-03-15 05:27:02',NULL,NULL),(80,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTU5ODAsImlhdCI6MTQ4OTU1NTM4MH0.0iEn1eQHla7FLlHeqf44qft4x8b4IJjohnrGHs23k4Q','2017-03-15 05:33:00',NULL,NULL),(81,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTYxMzcsImlhdCI6MTQ4OTU1NTUzN30.ChWfVPciQQhLreB0EvIXHPeVGzkHrGv1L95OYT9uGBc','2017-03-15 05:35:37',NULL,NULL),(82,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTYzMTksImlhdCI6MTQ4OTU1NTcxOX0.KZ20QIhKLyIxB35wttIhG1cK8U3eFIwLcFE2nkZ21qs','2017-03-15 05:38:39',NULL,NULL),(83,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTY2NjEsImlhdCI6MTQ4OTU1NjA2MX0.fR2top5G96vSUpKU7bq7Kcj9CMdSgcyHBzvlPwa1wbE','2017-03-15 05:44:21',NULL,NULL),(84,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTY3NjIsImlhdCI6MTQ4OTU1NjE2Mn0.1hp-xU94APADedJkRyB4s7EmDgXjSSLXUslOZEXvsw4','2017-03-15 05:46:02',NULL,NULL),(85,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTcxNTUsImlhdCI6MTQ4OTU1NjU1NX0.eghosT5efxRPbAm4O0B9X7rf_DcyYDIxx11sS9kxilU','2017-03-15 05:52:35',NULL,NULL),(86,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTcyNDYsImlhdCI6MTQ4OTU1NjY0Nn0.nhzAF1snAUDJQlL2eX2j_aF_SXnY40dQg80mnzcSCH0','2017-03-15 05:54:06',NULL,NULL),(87,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTgzMTYsImlhdCI6MTQ4OTU1NzcxNn0.8PZXYKZSI_b7Y8Qr78PliYy3TQ-x8sS1mxPmxCsSoyI','2017-03-15 06:11:56',NULL,NULL),(88,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTk4NzcsImlhdCI6MTQ4OTU1OTI3N30.N4l1ROSfyrN3AVCU8pXj7Fzp1AidIJlAawmZMT6wJOo','2017-03-15 06:37:57',NULL,NULL),(89,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjA2NzYsImlhdCI6MTQ4OTU2MDA3Nn0.osGB38ce_-k_2wPxjKnY9s646DAnppPG0brpsXXYP4M','2017-03-15 06:51:16',NULL,NULL),(90,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjU5MzksImlhdCI6MTQ4OTU2NTMzOX0.JIWDF6qSxWauFUDsGkMMVjYhS_VxnZlfL-yLl5ZwwMg','2017-03-15 08:18:59',NULL,NULL),(91,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjYwMzgsImlhdCI6MTQ4OTU2NTQzOH0.hGNktgPj678P9bKs6hwCapxSeBqB9zvP_ztjBZtE4A4','2017-03-15 08:20:38',NULL,NULL),(92,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjY0MzcsImlhdCI6MTQ4OTU2NTgzN30.-9HN4s1K16E-kx43OphY9b6BSwW9vmINWdTiPDK7pKI','2017-03-15 08:27:17',NULL,NULL),(93,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjY2NjcsImlhdCI6MTQ4OTU2NjA2N30.IQyk_Cqnao8udDLs4iXm_1g_kBHLj6PR46JGSiWonUM','2017-03-15 08:31:07',NULL,NULL),(94,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjY4NjQsImlhdCI6MTQ4OTU2NjI2NH0.7FvA6NvGHJiH6Cl1Kncp2rSxtiyBfc39ztGgo5cW98o','2017-03-15 08:34:24',NULL,NULL),(95,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjY5NTgsImlhdCI6MTQ4OTU2NjM1OH0.Yb7ccdOfNU1d2oWbd1UMlkq3wtIK6Qn02l_cK9bUyRo','2017-03-15 08:35:58',NULL,NULL),(96,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjcwNjIsImlhdCI6MTQ4OTU2NjQ2Mn0.rLH7cyJnTaKGH_9MkwBK-nUpqQJzUcxEAp3BE_7k6oc','2017-03-15 08:37:42',NULL,NULL),(97,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjcxMDMsImlhdCI6MTQ4OTU2NjUwM30.QTfWkqSUSCFD8KvAT3ekwsOuytll4NkC7DTmTXfS5qM','2017-03-15 08:38:23',NULL,NULL),(98,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjcxNjIsImlhdCI6MTQ4OTU2NjU2Mn0.ichuAL72Ye22Dl7Yl4NcJWon-lasRU_qdOBqKkYKBXg','2017-03-15 08:39:22',NULL,NULL),(99,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjcyMDEsImlhdCI6MTQ4OTU2NjYwMX0.c4lhFr-FuxM62_SfnOfT-E5SoE87u7S_U1OEO7EFs_E','2017-03-15 08:40:01',NULL,NULL),(100,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjczMzksImlhdCI6MTQ4OTU2NjczOX0.Jxh8q7Y04jJC_pHDxs7JTRq0qT2lTIMpPawhJJQRUek','2017-03-15 08:42:19',NULL,NULL),(101,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1Njc5OTMsImlhdCI6MTQ4OTU2NzM5M30.1HI2OAzM75BgrV40qWyHP78PB97lh9gAmeFh4RQZhrs','2017-03-15 08:53:13',NULL,NULL),(102,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgwNzksImlhdCI6MTQ4OTU2NzQ3OX0._aA8qtM5Z3iSm1aMYfeWJ99c1VvkmW798RUUBwTy2Jc','2017-03-15 08:54:39',NULL,NULL),(103,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgxMjksImlhdCI6MTQ4OTU2NzUyOX0.WPm0ChnvznHwgVB5cLAmyHH335hgixmPe6fxmOglMdM','2017-03-15 08:55:29',NULL,NULL),(104,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgxODEsImlhdCI6MTQ4OTU2NzU4MX0.9izoCQmJu-sJZBrQMRsDVZTWlLvFvo72t8Wqr3Me0oA','2017-03-15 08:56:21',NULL,NULL),(105,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgyOTQsImlhdCI6MTQ4OTU2NzY5NH0._k4KaDZK2nd59SpUCPsCACGHPJ5gzZcHBakqqYGs4dU','2017-03-15 08:58:14',NULL,NULL),(106,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgzNTUsImlhdCI6MTQ4OTU2Nzc1NX0.diIBgTsOnLng0MiWhOGsCPtodhzG31DRUiNT7pBJs3k','2017-03-15 08:59:15',NULL,NULL),(107,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjkxODYsImlhdCI6MTQ4OTU2ODU4Nn0.gVQo7J4bMSl-6HVsw4I46qF2uGSgYpjNNq7Gbs74G6M','2017-03-15 09:13:06',NULL,NULL),(108,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1Njk0MDAsImlhdCI6MTQ4OTU2ODgwMH0.4xl6niKOQU6Ay16qOBEZ0OaAe5C5oXDekeNdU_WTuMQ','2017-03-15 09:16:40',NULL,NULL),(109,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1Njk2MzIsImlhdCI6MTQ4OTU2OTAzMn0.x7suFGF4mzI0IqF36zdO6w-l3Ryj1CT0GkxEe4I80FY','2017-03-15 09:20:32',NULL,NULL),(110,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1Njk3OTUsImlhdCI6MTQ4OTU2OTE5NX0.uVBD8Z8XjAT5qkk1chmdqD6c33Aq0ut1MSFQ43dX_G8','2017-03-15 09:23:15',NULL,NULL),(111,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzAwNjksImlhdCI6MTQ4OTU2OTQ2OX0.RFbwoRmv_Srz1Xa4rhO8x0E9AzBZm6qJNrCqWlaTDpw','2017-03-15 09:27:49',NULL,NULL),(112,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzAyOTgsImlhdCI6MTQ4OTU2OTY5OH0.rJedauFXl5VpnvZyJ6TgnsZHSWvYGKOIAj5iOyszjtw','2017-03-15 09:31:38',NULL,NULL),(113,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzA5NDEsImlhdCI6MTQ4OTU3MDM0MX0.P93DPL89TBSC5Dq6AbErXoKE3Jd6wMv361alxsUJv5I','2017-03-15 09:42:21',NULL,NULL),(114,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzE3MTEsImlhdCI6MTQ4OTU3MTExMX0.fWs3ANHc7Wg3dpu5xnMZ3f24asWwIRRQJ2uCDQksB-U','2017-03-15 09:55:11',NULL,NULL),(115,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIxMjgsImlhdCI6MTQ4OTU3MTUyOH0.AHMC72xMrVSpGjlfgj8Qf_8wB6R-8TM-HGKRyIgetfA','2017-03-15 10:02:08',NULL,NULL),(116,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIxNzYsImlhdCI6MTQ4OTU3MTU3Nn0.Tov7NoQuXDx597MB7jwETN7O8vZBG8NBrCHlrd2Eh5M','2017-03-15 10:02:56',NULL,NULL),(117,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIyMTgsImlhdCI6MTQ4OTU3MTYxOH0.XJYBqApYTH6WVnjjzLmjuRz8ew7MrN0ELbTXdufG69g','2017-03-15 10:03:38',NULL,NULL),(118,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIyOTUsImlhdCI6MTQ4OTU3MTY5NX0.W5b_JcDTbkl7_PimGYKvu97-m9N5cK761yknBcfRnHs','2017-03-15 10:04:55',NULL,NULL),(119,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIzOTQsImlhdCI6MTQ4OTU3MTc5NH0.L2jC6PJDudkZ18txZ7SspxqzgTPuqoK_Y-ILpvp9_as','2017-03-15 10:06:34',NULL,NULL),(120,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzI0OTYsImlhdCI6MTQ4OTU3MTg5Nn0.r65JpNPnGP0p5zIwCeblpAWqcECcpyt6euw1-0_8nVk','2017-03-15 10:08:16',NULL,NULL),(121,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzI1NTIsImlhdCI6MTQ4OTU3MTk1Mn0.pPt04pAIErvra34nt1W1d9V2chkE9QBVUk3SLGsMBrE','2017-03-15 10:09:12',NULL,NULL),(122,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzI3ODYsImlhdCI6MTQ4OTU3MjE4Nn0.yQ28x2Vo8AFV6igKO5rh0V-o0_kOj82tlYCPH4ua63U','2017-03-15 10:13:06',NULL,NULL),(123,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzI4NTUsImlhdCI6MTQ4OTU3MjI1NX0.cLYWSYP1oyd28SXNkjXvGi4jAYY0PuGpNgUrbTRkHRc','2017-03-15 10:14:15',NULL,NULL),(124,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzMwMDMsImlhdCI6MTQ4OTU3MjQwM30.jNJfBVajTq40kcwbcdHi0D9ZUB15zeiz7owzE4UWePc','2017-03-15 10:16:43',NULL,NULL),(125,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzMyMDQsImlhdCI6MTQ4OTU3MjYwNH0.lEA8xkROIGrOSDks1s7-2Myl5KkJNRHQIN6gmGcki_Y','2017-03-15 10:20:04',NULL,NULL),(126,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzM3NTIsImlhdCI6MTQ4OTU3MzE1Mn0.bcjHuxU-_PQIMzOM8Uh7w6SW_cFsZmvoxx5F5_g8GEA','2017-03-15 10:29:12',NULL,NULL),(127,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzM4MzIsImlhdCI6MTQ4OTU3MzIzMn0.ZDapQcLlvyO3l64ITkb7yZnlkXkKyJ337YJ4j22y_2Y','2017-03-15 10:30:32',NULL,NULL),(128,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzM4OTcsImlhdCI6MTQ4OTU3MzI5N30.LM4ctnKtX4z6DlSM_UYSYG-KLYA07OhGZxIs5f7x2Pw','2017-03-15 10:31:37',NULL,NULL),(129,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzY5MDcsImlhdCI6MTQ4OTU3NjMwN30.m-RpUKz4EfLthJNo_lqh17oAX4xm7ahRxpyoCGf_EhI','2017-03-15 11:21:47',NULL,NULL),(130,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDEzODcsImlhdCI6MTQ4OTY0MDc4N30.8MFT31gKFEEGor3I8G4shozD08zIeQLioIpb-Qrf4GM','2017-03-16 05:16:27',NULL,NULL),(131,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDc4NzgsImlhdCI6MTQ4OTY0NzI3OH0.0OVR5-GqGdjgw9mpA2WQFE3Uqc0NARPuCT6JNuY6Bm8','2017-03-16 07:04:38',NULL,NULL),(132,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDgwNTMsImlhdCI6MTQ4OTY0NzQ1M30.-7Czm5g2d7aMPqKLJbkVCE6wvqmZFpEQ3zEB39PsvqU','2017-03-16 07:07:33',NULL,NULL),(133,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDgxMTQsImlhdCI6MTQ4OTY0NzUxNH0.Y0CSLQgDrOXVpIwwvM-6BJPfWr_o2EfW7q2rkg_qx0A','2017-03-16 07:08:34',NULL,NULL),(134,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDgxNTEsImlhdCI6MTQ4OTY0NzU1MX0.H6M_AX68f3SefXm7O4n6RrhvKyPFcFRuXHpH24YhUjs','2017-03-16 07:09:11',NULL,NULL),(135,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDgyMzksImlhdCI6MTQ4OTY0NzYzOX0.aG7yOS4KDqFcwQqWMp-dsP3IhwHv51mzBWOjuNOPtbI','2017-03-16 07:10:39',NULL,NULL),(136,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDg0NjIsImlhdCI6MTQ4OTY0Nzg2Mn0.WycOOWT965M99FWRSa7yX_SFVPidJmj1bXPgj2NffxE','2017-03-16 07:14:22',NULL,NULL),(137,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDg1NjMsImlhdCI6MTQ4OTY0Nzk2M30.TjMa6j5UL86bk3o2fKWukV_6mdnyqOdBQEGTV-L3v7k','2017-03-16 07:16:03',NULL,NULL),(138,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDg3MzUsImlhdCI6MTQ4OTY0ODEzNX0.2hDuAvqJgxJxLwgFG2tXNiA725mYDGvZQCb-6VH27m4','2017-03-16 07:18:55',NULL,NULL),(139,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NTM0NjQsImlhdCI6MTQ4OTY1Mjg2NH0.madjWKuiTuwb4BJ5PmgR0Zz8P9V7ugZDjszBCxqs1tc','2017-03-16 08:37:44',NULL,NULL),(140,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NTUzMzYsImlhdCI6MTQ4OTY1NDczNn0.0UbUCZzTZ_t1Vkzpon4Vsi1KnfHbFpj67xv7hER2Bro','2017-03-16 09:08:56',NULL,NULL),(141,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NTUzNjcsImlhdCI6MTQ4OTY1NDc2N30.YYoMEYEE8LVzp8GCvBlWZNBmfO2HAfWxhG-gL3iSGa0','2017-03-16 09:09:27',NULL,NULL);
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
  `userId` int(11) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `loginTime` timestamp NULL DEFAULT NULL,
  `token` varchar(200) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_userlogs_createdBy_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_userlogs_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_userlogs`
--

LOCK TABLES `domo_userlogs` WRITE;
/*!40000 ALTER TABLE `domo_userlogs` DISABLE KEYS */;
INSERT INTO `domo_userlogs` VALUES (5,4,1,'2017-02-28','2017-02-28 09:31:13','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyNzQ4NzMsImlhdCI6MTQ4ODI3NDI3M30.GpGCSXjDERnVOMPnFCW_BO2YGdvHW6gSj2msQHR1qIE',NULL,NULL),(6,3,1,'2017-02-28','2017-02-28 09:33:49','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjc2MDEsImV4cCI6MTQ4ODI3NTAyOSwiaWF0IjoxNDg4Mjc0NDI5fQ.eB7-KwoJUq86nAonXOHCwBbWzSkbA2Jfh76sF0DfkOU',NULL,NULL),(7,2,1,'2017-02-28','2017-02-28 09:35:02','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyNjEwLCJleHAiOjE0ODgyNzUxMDIsImlhdCI6MTQ4ODI3NDUwMn0.4APfXMK-CG_nM5RymzEUJ47utaORBmLV3o2qKhI1Lyk',NULL,NULL),(8,4,1,'2017-02-28','2017-02-28 11:18:35','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODEzMTUsImlhdCI6MTQ4ODI4MDcxNX0.k_k4GM2rIFrVnfrZjbxFgdTycP8_VqoRcxdQZsURzI8',NULL,NULL),(9,4,1,'2017-02-28','2017-02-28 11:41:30','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODI2OTAsImlhdCI6MTQ4ODI4MjA5MH0.7SjCw_4qLXRvQa8tADCbxq5tUJ5j02fuZb8BSt4cxYk',NULL,NULL),(10,4,1,'2017-02-28','2017-02-28 13:22:47','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODg3NjcsImlhdCI6MTQ4ODI4ODE2N30.Ddlg_TJcvD5P-eo1ZOfSfkOGIKEsFX7Yf7OYyi4buV0',NULL,NULL),(11,4,1,'2017-02-28','2017-02-28 13:28:42','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODkxMjIsImlhdCI6MTQ4ODI4ODUyMn0.N1Gdwg6RT-lJzuqjpbLO93tn8fdJd7KVPicsIRTuj1s',NULL,NULL),(12,4,1,'2017-02-28','2017-02-28 13:35:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgyODk1NTYsImlhdCI6MTQ4ODI4ODk1Nn0.NXz1BtwkjeevmosY-N0FgMXR8vrkGvJkZMdk1xDRKZE',NULL,NULL),(13,4,1,'2017-03-01','2017-03-01 05:51:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNDgxMTUsImlhdCI6MTQ4ODM0NzUxNX0.em8IfpWRNkn6_UOwWRS6YOw0a0ZegrdlQhwCo0dECxw',NULL,NULL),(14,4,1,'2017-03-01','2017-03-01 08:37:22','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNTgwNDIsImlhdCI6MTQ4ODM1NzQ0Mn0.G-qzh1MumkuBTnEucf4rNQLfxQA_bLquYg7-Tm9I4E8',NULL,NULL),(15,4,1,'2017-03-01','2017-03-01 08:38:46','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNTgxMjYsImlhdCI6MTQ4ODM1NzUyNn0.FtmEThkdn7y_2f9ZxmwN7dcZPj4PTIefki425fdqLO8',NULL,NULL),(16,4,1,'2017-03-01','2017-03-01 08:40:03','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNTgyMDMsImlhdCI6MTQ4ODM1NzYwM30.Puj2jqL6Mcdjf1Zo77rQ9rCOkmibmRmTv_VrAUloubc',NULL,NULL),(17,4,1,'2017-03-01','2017-03-01 08:54:27','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNTkwNjcsImlhdCI6MTQ4ODM1ODQ2N30.B7CP29H-wY56XagcE_srpkohchO4ZW8U7lJdMKHyfM8',NULL,NULL),(18,4,1,'2017-03-01','2017-03-01 11:57:18','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNzAwMzcsImlhdCI6MTQ4ODM2OTQzN30.qvTuZhCWmpyDqVM_g33FCNLzGnEI0Ldzxmn3LUEMxi4',NULL,NULL),(19,4,1,'2017-03-01','2017-03-01 12:01:06','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODgzNzAyNjYsImlhdCI6MTQ4ODM2OTY2Nn0.vxp_S_QPvgUzlmNHuoo913b91M1kbfFC7af4InOiBEU',NULL,NULL),(20,4,1,'2017-03-02','2017-03-02 14:46:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg0NjY1OTQsImlhdCI6MTQ4ODQ2NTk5NH0.phtc0P7sBujtWocDSqHlk8y2Yds0xE6pHiWjmXMymYE',NULL,NULL),(21,4,1,'2017-03-07','2017-03-07 08:18:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg4NzUzMzUsImlhdCI6MTQ4ODg3NDczNX0.OkCNVP1vhas8YvimBDC4gpbYsnvr16gg79CraJqNj80',NULL,NULL),(22,4,1,'2017-03-08','2017-03-08 10:49:10','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzA3NTAsImlhdCI6MTQ4ODk3MDE1MH0.NGV02JdiNCWQ7grbbTq59m_ZP9v9RrRpHYE5jJdiFWQ',NULL,NULL),(23,4,1,'2017-03-08','2017-03-08 10:50:10','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzA4MTAsImlhdCI6MTQ4ODk3MDIxMH0.IVpi9dqmAJWICUXYDMDOkEU_3_KKveDvR7sS5_0eGUo',NULL,NULL),(24,4,1,'2017-03-08','2017-03-08 10:50:33','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzA4MzMsImlhdCI6MTQ4ODk3MDIzM30.hBNZC0HPI3N9mdteWb5IBGDV6gJO4ZXUxGsttdhT3S0',NULL,NULL),(25,4,1,'2017-03-08','2017-03-08 10:52:33','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzA5NTMsImlhdCI6MTQ4ODk3MDM1M30.MY3n7ZTWE1b03I62b5jvDNjJc7lUnUDRhrgotmg18a4',NULL,NULL),(26,4,1,'2017-03-08','2017-03-08 10:56:08','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzExNjgsImlhdCI6MTQ4ODk3MDU2OH0.xLpHk2yQddm2YraIQI3Mj6v9i2O_9nXJHYWwwsYUQeM',NULL,NULL),(27,4,1,'2017-03-08','2017-03-08 10:59:16','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzEzNTYsImlhdCI6MTQ4ODk3MDc1Nn0.j2azL06kdKf-QP-OzDkk-LgzS8gFmD5_zPQThOZKDKc',NULL,NULL),(28,4,1,'2017-03-08','2017-03-08 11:02:58','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzE1NzgsImlhdCI6MTQ4ODk3MDk3OH0.ichGY_yPHeDJfvlIEuMxEdr-dTj3CZ5IDU5xdJa5NaI',NULL,NULL),(29,4,1,'2017-03-08','2017-03-08 11:04:37','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzE2NzcsImlhdCI6MTQ4ODk3MTA3N30.0Yzf45pj_pvyEuzNHPXVVVBbVRy4QgfXObwIXgx1y2k',NULL,NULL),(30,4,1,'2017-03-08','2017-03-08 11:08:47','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzE5MjcsImlhdCI6MTQ4ODk3MTMyN30.4eJxK6aya2B_y-kxjcrpjEMeFCF12BB71nwlwC23f78',NULL,NULL),(31,4,1,'2017-03-08','2017-03-08 11:23:43','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzI4MjMsImlhdCI6MTQ4ODk3MjIyM30.94hReviK7KissXs_MIzBGfEg0hzuLplZYvDt-RyIxA0',NULL,NULL),(32,4,1,'2017-03-08','2017-03-08 11:24:53','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzI4OTMsImlhdCI6MTQ4ODk3MjI5M30.a0wTUAZH_vyCNrbx6boyFhHOl-0Z9ZB2gPtUKeV967A',NULL,NULL),(33,4,1,'2017-03-08','2017-03-08 11:26:08','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzI5NjgsImlhdCI6MTQ4ODk3MjM2OH0.XSvbxZGIf4YqVV-y4QB3Gm3DoAV_PkJWk5JvtCmmd7Y',NULL,NULL),(34,4,1,'2017-03-08','2017-03-08 11:27:31','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzMwNTEsImlhdCI6MTQ4ODk3MjQ1MX0.B23JL8f-nkGcWr5eyGPOLMn59q0BS-U3dj4Lrl6bzO0',NULL,NULL),(35,4,1,'2017-03-08','2017-03-08 11:29:27','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzMxNjcsImlhdCI6MTQ4ODk3MjU2N30.jlx5vAqczgGYIGf4LXh5OzjLSrcwOvEui_f7fo9-jqc',NULL,NULL),(36,4,1,'2017-03-08','2017-03-08 11:29:55','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5NzMxOTUsImlhdCI6MTQ4ODk3MjU5NX0.g0izxnc5BbKgbEI0NBoOqdjqQl7jRCkh91HMWHvxAjA',NULL,NULL),(37,4,1,'2017-03-08','2017-03-08 13:19:40','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5Nzk3ODAsImlhdCI6MTQ4ODk3OTE4MH0.VhhJZLRPBsvZa7TWbxdkmyCeFDN0KaFOddUkdwcBcZA',NULL,NULL),(38,4,1,'2017-03-08','2017-03-08 13:21:11','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5Nzk4NzEsImlhdCI6MTQ4ODk3OTI3MX0.cScYMv8ZAaktgzLNmSC59m74CK0pablgamqeR1v6HZI',NULL,NULL),(39,4,1,'2017-03-08','2017-03-08 13:24:11','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODAwNTEsImlhdCI6MTQ4ODk3OTQ1MX0.9VQjDhTJzq1GmN-xoodPJilg3DczXsEXVr9jLaj4u6w',NULL,NULL),(40,4,1,'2017-03-08','2017-03-08 13:26:07','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODAxNjcsImlhdCI6MTQ4ODk3OTU2N30.9aGtKEfMIhe2mJ3H3H7WAqBdHYmzOqcaBlB1-WEW4zo',NULL,NULL),(41,4,1,'2017-03-08','2017-03-08 13:27:16','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODAyMzYsImlhdCI6MTQ4ODk3OTYzNn0.s4nrtWN_xd1hQ8aQdnBnxRbRHUv_yo6ZeMU0y5ePYwk',NULL,NULL),(42,4,1,'2017-03-08','2017-03-08 13:44:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODEyOTYsImlhdCI6MTQ4ODk4MDY5Nn0.6Ldjm1x4L2q7LW-iGCfxjVJwSePaSRwflHV7JK8Xkjs',NULL,NULL),(43,4,1,'2017-03-08','2017-03-08 13:54:23','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODg5ODE4NjMsImlhdCI6MTQ4ODk4MTI2M30.s5Xs5rcYTM2WUM0H_M5ixjW_SFx-N6bK4522yjJfGOc',NULL,NULL),(44,4,1,'2017-03-09','2017-03-09 04:46:44','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzU0MDQsImlhdCI6MTQ4OTAzNDgwNH0.xjxemSzwVEOk56jvZTp05HAHvLBRn63jq7qVu7ZSEoc',NULL,NULL),(45,4,1,'2017-03-09','2017-03-09 04:50:45','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzU2NDUsImlhdCI6MTQ4OTAzNTA0NX0.zYcEHFN2CsGhwKf5Ll_F8Z2tjfv3ZbLDRda4gdF62_I',NULL,NULL),(46,4,1,'2017-03-09','2017-03-09 04:51:58','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzU3MTgsImlhdCI6MTQ4OTAzNTExOH0.gBoyMOSXkp2jl8cW4TyCyUSrt3doK_ruogI6331isk8',NULL,NULL),(47,4,1,'2017-03-09','2017-03-09 04:55:35','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzU5MzUsImlhdCI6MTQ4OTAzNTMzNX0.BDfx3HSWTsV0hrr9a6GoAFW6ect0b_vhl0nPb0boNWE',NULL,NULL),(48,4,1,'2017-03-09','2017-03-09 04:58:27','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzYxMDcsImlhdCI6MTQ4OTAzNTUwN30.jNni8jMHpWqYOrSBP6nBWCnK4hE7_aotHC9_XLUc1L0',NULL,NULL),(49,4,1,'2017-03-09','2017-03-09 05:00:48','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzYyNDgsImlhdCI6MTQ4OTAzNTY0OH0.Z3gx10cLJ77KrsVsvUv-i66L1PuwIiLq91ZizFm6m4A',NULL,NULL),(50,4,1,'2017-03-09','2017-03-09 05:04:19','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzY0NTksImlhdCI6MTQ4OTAzNTg1OX0.XuGFkXHNF6n8aqSMIbDapoMM-GaeYAa1PCTfaXSTSCk',NULL,NULL),(51,4,1,'2017-03-09','2017-03-09 05:07:16','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzY2MzYsImlhdCI6MTQ4OTAzNjAzNn0.NCKLzV3IlaLnl_lGBI9sFHWNotURB2pxlRbdGRNOC8k',NULL,NULL),(52,4,1,'2017-03-09','2017-03-09 05:08:35','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzY3MTUsImlhdCI6MTQ4OTAzNjExNX0.Vv7rxRTBpkOl8OliM9QnoTefOhwXEmkv2ZoQsEu04GE',NULL,NULL),(53,4,1,'2017-03-09','2017-03-09 05:11:01','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzY4NjEsImlhdCI6MTQ4OTAzNjI2MX0.8yyO43SzGaSK389mTQyYgsDfVCtqtIUj0cYJTBX_Kps',NULL,NULL),(54,4,1,'2017-03-09','2017-03-09 05:13:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzcwMTQsImlhdCI6MTQ4OTAzNjQxNH0.tIfWcWM9Wb9z2hlC7SWuLjQna9XwdB3zRkzKmSad3HM',NULL,NULL),(55,4,1,'2017-03-09','2017-03-09 05:23:19','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzc1OTksImlhdCI6MTQ4OTAzNjk5OX0.vZGwtReaklNS8hWjJtdj1-aYqURZ_LG6ebnKSuD2wA8',NULL,NULL),(56,4,1,'2017-03-09','2017-03-09 05:37:06','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkwMzg0MjUsImlhdCI6MTQ4OTAzNzgyNX0.nSs_PBH1hNtesX3ZqAiLKTgOUk8MKOa_wEqQ00fEMs4',NULL,NULL),(57,4,1,'2017-03-10','2017-03-10 04:48:46','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMjE5MjUsImlhdCI6MTQ4OTEyMTMyNX0.LD9pLab0iXjblvERcLrcimHjnsRnIFX4g91nbCCcDwg',NULL,NULL),(58,4,1,'2017-03-10','2017-03-10 04:52:53','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMjIxNzIsImlhdCI6MTQ4OTEyMTU3Mn0.42wwlv0zbwoLpsqeE_jJQbV37j4LEHAkzU0CvjTR5Rc',NULL,NULL),(59,4,1,'2017-03-10','2017-03-10 05:56:13','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMjU5NzMsImlhdCI6MTQ4OTEyNTM3M30.wP17RrHltyv7FKuyXu9-va7sU2jJXKKZMejKP3wI8LE',NULL,NULL),(60,4,1,'2017-03-10','2017-03-10 09:49:50','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMzk5OTAsImlhdCI6MTQ4OTEzOTM5MH0.2pGUGDxqj6RGOukvffEXU9eaMlHUCvCd8yjHJbaj8fQ',NULL,NULL),(61,4,1,'2017-03-10','2017-03-10 09:49:51','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxMzk5OTAsImlhdCI6MTQ4OTEzOTM5MH0.2pGUGDxqj6RGOukvffEXU9eaMlHUCvCd8yjHJbaj8fQ',NULL,NULL),(62,4,1,'2017-03-10','2017-03-10 09:51:08','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxNDAwNjgsImlhdCI6MTQ4OTEzOTQ2OH0.JF1ZL4hgOEwVvVvjO-cd_8mIghOvIwipZyqdLOTGgCQ',NULL,NULL),(63,4,1,'2017-03-10','2017-03-10 10:23:02','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxNDE5ODIsImlhdCI6MTQ4OTE0MTM4Mn0.zLRCEMBKY3Ehtc5GPZrxrMFmKTY_p1F2_SQc1gHFpwg',NULL,NULL),(64,4,1,'2017-03-10','2017-03-10 10:26:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODkxNDIxOTQsImlhdCI6MTQ4OTE0MTU5NH0.dCZYMl2BQUepi9wOplXldOPAbwhnqnFnex9cjtcUcPM',NULL,NULL),(65,4,1,'2017-03-14','2017-03-14 05:03:44','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0Njg0MjMsImlhdCI6MTQ4OTQ2NzgyM30.IAl8B7DrEaPpPv2TxouU1_7AUAh-hFbtIlu3bHaAm-c',NULL,NULL),(66,4,1,'2017-03-14','2017-03-14 10:20:14','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0ODc0MTQsImlhdCI6MTQ4OTQ4NjgxNH0.WpxIFGp3PUiNIcKU4nEebdCI-TL31Nr-h2SPDxBsbmU',NULL,NULL),(67,4,1,'2017-03-14','2017-03-14 11:15:11','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0OTA3MTEsImlhdCI6MTQ4OTQ5MDExMX0.aCFNsAQpL48D_inscAn7CAmg8dYdptllp3CCQQyy4c4',NULL,NULL),(68,4,1,'2017-03-14','2017-03-14 11:23:09','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0OTExODksImlhdCI6MTQ4OTQ5MDU4OX0.hsznKHCRmaszTY8shViGnE4oHXig8K2ZjJEgv6Xs36Y',NULL,NULL),(69,4,1,'2017-03-14','2017-03-14 11:24:51','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk0OTEyOTEsImlhdCI6MTQ4OTQ5MDY5MX0.bVTMgJlsEfKY9XD5XuR6wyMd0UZYTgwhG5KqbNsfP0M',NULL,NULL),(70,4,1,'2017-03-15','2017-03-15 04:51:31','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQwOTEsImlhdCI6MTQ4OTU1MzQ5MX0.vq_lz9OpD6hwUG41G6QWlKgV-YAz7-lq07YqzNvM-1U',NULL,NULL),(71,4,1,'2017-03-15','2017-03-15 04:51:32','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQwOTEsImlhdCI6MTQ4OTU1MzQ5MX0.vq_lz9OpD6hwUG41G6QWlKgV-YAz7-lq07YqzNvM-1U',NULL,NULL),(72,4,1,'2017-03-15','2017-03-15 04:54:06','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQyNDYsImlhdCI6MTQ4OTU1MzY0Nn0.zUyFAICmDxo4uQvokOi29kMjrYbTm25KOJ9mUip3P0g',NULL,NULL),(73,4,1,'2017-03-15','2017-03-15 05:04:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQ4OTYsImlhdCI6MTQ4OTU1NDI5Nn0.qQRvkFtZTVjH6fmH10yBDv41YZIlEuag8h4rRlLzcaY',NULL,NULL),(74,4,1,'2017-03-15','2017-03-15 05:06:31','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTQ5OTEsImlhdCI6MTQ4OTU1NDM5MX0.yk98p5FimBrRWaDmC91gIPn-T1U7m5U4OhQpo23hTy0',NULL,NULL),(75,4,1,'2017-03-15','2017-03-15 05:10:03','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTUyMDMsImlhdCI6MTQ4OTU1NDYwM30.K5MDnt-VeT2ypDUZzlkxoFozFevlE6RspNkKnB9nN9c',NULL,NULL),(76,4,1,'2017-03-15','2017-03-15 05:11:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTUyOTQsImlhdCI6MTQ4OTU1NDY5NH0.L3SZe-ZzEcvwnWUZpF7eHx6qyXa8N7ack5gEs3sEbZY',NULL,NULL),(77,4,1,'2017-03-15','2017-03-15 05:17:02','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTU2MjIsImlhdCI6MTQ4OTU1NTAyMn0.PMv2HVbvvZVAniYoQ0bovwyAq8_9rtl6R0ZcOK1hzLE',NULL,NULL),(78,4,1,'2017-03-15','2017-03-15 05:23:00','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTU5ODAsImlhdCI6MTQ4OTU1NTM4MH0.0iEn1eQHla7FLlHeqf44qft4x8b4IJjohnrGHs23k4Q',NULL,NULL),(79,4,1,'2017-03-15','2017-03-15 05:25:37','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTYxMzcsImlhdCI6MTQ4OTU1NTUzN30.ChWfVPciQQhLreB0EvIXHPeVGzkHrGv1L95OYT9uGBc',NULL,NULL),(80,4,1,'2017-03-15','2017-03-15 05:28:39','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTYzMTksImlhdCI6MTQ4OTU1NTcxOX0.KZ20QIhKLyIxB35wttIhG1cK8U3eFIwLcFE2nkZ21qs',NULL,NULL),(81,4,1,'2017-03-15','2017-03-15 05:34:21','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTY2NjEsImlhdCI6MTQ4OTU1NjA2MX0.fR2top5G96vSUpKU7bq7Kcj9CMdSgcyHBzvlPwa1wbE',NULL,NULL),(82,4,1,'2017-03-15','2017-03-15 05:36:02','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTY3NjIsImlhdCI6MTQ4OTU1NjE2Mn0.1hp-xU94APADedJkRyB4s7EmDgXjSSLXUslOZEXvsw4',NULL,NULL),(83,4,1,'2017-03-15','2017-03-15 05:42:35','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTcxNTUsImlhdCI6MTQ4OTU1NjU1NX0.eghosT5efxRPbAm4O0B9X7rf_DcyYDIxx11sS9kxilU',NULL,NULL),(84,4,1,'2017-03-15','2017-03-15 05:44:06','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTcyNDYsImlhdCI6MTQ4OTU1NjY0Nn0.nhzAF1snAUDJQlL2eX2j_aF_SXnY40dQg80mnzcSCH0',NULL,NULL),(85,4,1,'2017-03-15','2017-03-15 06:01:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTgzMTYsImlhdCI6MTQ4OTU1NzcxNn0.8PZXYKZSI_b7Y8Qr78PliYy3TQ-x8sS1mxPmxCsSoyI',NULL,NULL),(86,4,1,'2017-03-15','2017-03-15 06:27:57','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NTk4NzcsImlhdCI6MTQ4OTU1OTI3N30.N4l1ROSfyrN3AVCU8pXj7Fzp1AidIJlAawmZMT6wJOo',NULL,NULL),(87,4,1,'2017-03-15','2017-03-15 06:41:17','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjA2NzYsImlhdCI6MTQ4OTU2MDA3Nn0.osGB38ce_-k_2wPxjKnY9s646DAnppPG0brpsXXYP4M',NULL,NULL),(88,4,1,'2017-03-15','2017-03-15 08:08:59','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjU5MzksImlhdCI6MTQ4OTU2NTMzOX0.JIWDF6qSxWauFUDsGkMMVjYhS_VxnZlfL-yLl5ZwwMg',NULL,NULL),(89,4,1,'2017-03-15','2017-03-15 08:10:38','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjYwMzgsImlhdCI6MTQ4OTU2NTQzOH0.hGNktgPj678P9bKs6hwCapxSeBqB9zvP_ztjBZtE4A4',NULL,NULL),(90,4,1,'2017-03-15','2017-03-15 08:17:17','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjY0MzcsImlhdCI6MTQ4OTU2NTgzN30.-9HN4s1K16E-kx43OphY9b6BSwW9vmINWdTiPDK7pKI',NULL,NULL),(91,4,1,'2017-03-15','2017-03-15 08:21:07','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjY2NjcsImlhdCI6MTQ4OTU2NjA2N30.IQyk_Cqnao8udDLs4iXm_1g_kBHLj6PR46JGSiWonUM',NULL,NULL),(92,4,1,'2017-03-15','2017-03-15 08:24:24','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjY4NjQsImlhdCI6MTQ4OTU2NjI2NH0.7FvA6NvGHJiH6Cl1Kncp2rSxtiyBfc39ztGgo5cW98o',NULL,NULL),(93,4,1,'2017-03-15','2017-03-15 08:25:58','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjY5NTgsImlhdCI6MTQ4OTU2NjM1OH0.Yb7ccdOfNU1d2oWbd1UMlkq3wtIK6Qn02l_cK9bUyRo',NULL,NULL),(94,4,1,'2017-03-15','2017-03-15 08:27:42','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjcwNjIsImlhdCI6MTQ4OTU2NjQ2Mn0.rLH7cyJnTaKGH_9MkwBK-nUpqQJzUcxEAp3BE_7k6oc',NULL,NULL),(95,4,1,'2017-03-15','2017-03-15 08:28:23','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjcxMDMsImlhdCI6MTQ4OTU2NjUwM30.QTfWkqSUSCFD8KvAT3ekwsOuytll4NkC7DTmTXfS5qM',NULL,NULL),(96,4,1,'2017-03-15','2017-03-15 08:29:22','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjcxNjIsImlhdCI6MTQ4OTU2NjU2Mn0.ichuAL72Ye22Dl7Yl4NcJWon-lasRU_qdOBqKkYKBXg',NULL,NULL),(97,4,1,'2017-03-15','2017-03-15 08:30:01','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjcyMDEsImlhdCI6MTQ4OTU2NjYwMX0.c4lhFr-FuxM62_SfnOfT-E5SoE87u7S_U1OEO7EFs_E',NULL,NULL),(98,4,1,'2017-03-15','2017-03-15 08:32:19','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjczMzksImlhdCI6MTQ4OTU2NjczOX0.Jxh8q7Y04jJC_pHDxs7JTRq0qT2lTIMpPawhJJQRUek',NULL,NULL),(99,4,1,'2017-03-15','2017-03-15 08:43:13','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1Njc5OTMsImlhdCI6MTQ4OTU2NzM5M30.1HI2OAzM75BgrV40qWyHP78PB97lh9gAmeFh4RQZhrs',NULL,NULL),(100,4,1,'2017-03-15','2017-03-15 08:44:39','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgwNzksImlhdCI6MTQ4OTU2NzQ3OX0._aA8qtM5Z3iSm1aMYfeWJ99c1VvkmW798RUUBwTy2Jc',NULL,NULL),(101,4,1,'2017-03-15','2017-03-15 08:45:29','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgxMjksImlhdCI6MTQ4OTU2NzUyOX0.WPm0ChnvznHwgVB5cLAmyHH335hgixmPe6fxmOglMdM',NULL,NULL),(102,4,1,'2017-03-15','2017-03-15 08:46:21','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgxODEsImlhdCI6MTQ4OTU2NzU4MX0.9izoCQmJu-sJZBrQMRsDVZTWlLvFvo72t8Wqr3Me0oA',NULL,NULL),(103,4,1,'2017-03-15','2017-03-15 08:48:14','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgyOTQsImlhdCI6MTQ4OTU2NzY5NH0._k4KaDZK2nd59SpUCPsCACGHPJ5gzZcHBakqqYGs4dU',NULL,NULL),(104,4,1,'2017-03-15','2017-03-15 08:49:15','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjgzNTUsImlhdCI6MTQ4OTU2Nzc1NX0.diIBgTsOnLng0MiWhOGsCPtodhzG31DRUiNT7pBJs3k',NULL,NULL),(105,4,1,'2017-03-15','2017-03-15 09:03:07','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NjkxODYsImlhdCI6MTQ4OTU2ODU4Nn0.gVQo7J4bMSl-6HVsw4I46qF2uGSgYpjNNq7Gbs74G6M',NULL,NULL),(106,4,1,'2017-03-15','2017-03-15 09:06:40','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1Njk0MDAsImlhdCI6MTQ4OTU2ODgwMH0.4xl6niKOQU6Ay16qOBEZ0OaAe5C5oXDekeNdU_WTuMQ',NULL,NULL),(107,4,1,'2017-03-15','2017-03-15 09:10:32','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1Njk2MzIsImlhdCI6MTQ4OTU2OTAzMn0.x7suFGF4mzI0IqF36zdO6w-l3Ryj1CT0GkxEe4I80FY',NULL,NULL),(108,4,1,'2017-03-15','2017-03-15 09:13:15','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1Njk3OTUsImlhdCI6MTQ4OTU2OTE5NX0.uVBD8Z8XjAT5qkk1chmdqD6c33Aq0ut1MSFQ43dX_G8',NULL,NULL),(109,4,1,'2017-03-15','2017-03-15 09:17:49','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzAwNjksImlhdCI6MTQ4OTU2OTQ2OX0.RFbwoRmv_Srz1Xa4rhO8x0E9AzBZm6qJNrCqWlaTDpw',NULL,NULL),(110,4,1,'2017-03-15','2017-03-15 09:21:38','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzAyOTgsImlhdCI6MTQ4OTU2OTY5OH0.rJedauFXl5VpnvZyJ6TgnsZHSWvYGKOIAj5iOyszjtw',NULL,NULL),(111,4,1,'2017-03-15','2017-03-15 09:32:21','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzA5NDEsImlhdCI6MTQ4OTU3MDM0MX0.P93DPL89TBSC5Dq6AbErXoKE3Jd6wMv361alxsUJv5I',NULL,NULL),(112,4,1,'2017-03-15','2017-03-15 09:45:11','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzE3MTEsImlhdCI6MTQ4OTU3MTExMX0.fWs3ANHc7Wg3dpu5xnMZ3f24asWwIRRQJ2uCDQksB-U',NULL,NULL),(113,4,1,'2017-03-15','2017-03-15 09:52:08','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIxMjgsImlhdCI6MTQ4OTU3MTUyOH0.AHMC72xMrVSpGjlfgj8Qf_8wB6R-8TM-HGKRyIgetfA',NULL,NULL),(114,4,1,'2017-03-15','2017-03-15 09:52:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIxNzYsImlhdCI6MTQ4OTU3MTU3Nn0.Tov7NoQuXDx597MB7jwETN7O8vZBG8NBrCHlrd2Eh5M',NULL,NULL),(115,4,1,'2017-03-15','2017-03-15 09:53:38','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIyMTgsImlhdCI6MTQ4OTU3MTYxOH0.XJYBqApYTH6WVnjjzLmjuRz8ew7MrN0ELbTXdufG69g',NULL,NULL),(116,4,1,'2017-03-15','2017-03-15 09:54:55','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIyOTUsImlhdCI6MTQ4OTU3MTY5NX0.W5b_JcDTbkl7_PimGYKvu97-m9N5cK761yknBcfRnHs',NULL,NULL),(117,4,1,'2017-03-15','2017-03-15 09:56:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzIzOTQsImlhdCI6MTQ4OTU3MTc5NH0.L2jC6PJDudkZ18txZ7SspxqzgTPuqoK_Y-ILpvp9_as',NULL,NULL),(118,4,1,'2017-03-15','2017-03-15 09:58:16','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzI0OTYsImlhdCI6MTQ4OTU3MTg5Nn0.r65JpNPnGP0p5zIwCeblpAWqcECcpyt6euw1-0_8nVk',NULL,NULL),(119,4,1,'2017-03-15','2017-03-15 09:59:12','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzI1NTIsImlhdCI6MTQ4OTU3MTk1Mn0.pPt04pAIErvra34nt1W1d9V2chkE9QBVUk3SLGsMBrE',NULL,NULL),(120,4,1,'2017-03-15','2017-03-15 10:03:06','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzI3ODYsImlhdCI6MTQ4OTU3MjE4Nn0.yQ28x2Vo8AFV6igKO5rh0V-o0_kOj82tlYCPH4ua63U',NULL,NULL),(121,4,1,'2017-03-15','2017-03-15 10:04:15','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzI4NTUsImlhdCI6MTQ4OTU3MjI1NX0.cLYWSYP1oyd28SXNkjXvGi4jAYY0PuGpNgUrbTRkHRc',NULL,NULL),(122,4,1,'2017-03-15','2017-03-15 10:06:43','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzMwMDMsImlhdCI6MTQ4OTU3MjQwM30.jNJfBVajTq40kcwbcdHi0D9ZUB15zeiz7owzE4UWePc',NULL,NULL),(123,4,1,'2017-03-15','2017-03-15 10:10:04','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzMyMDQsImlhdCI6MTQ4OTU3MjYwNH0.lEA8xkROIGrOSDks1s7-2Myl5KkJNRHQIN6gmGcki_Y',NULL,NULL),(124,4,1,'2017-03-15','2017-03-15 10:19:12','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzM3NTIsImlhdCI6MTQ4OTU3MzE1Mn0.bcjHuxU-_PQIMzOM8Uh7w6SW_cFsZmvoxx5F5_g8GEA',NULL,NULL),(125,4,1,'2017-03-15','2017-03-15 10:20:32','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzM4MzIsImlhdCI6MTQ4OTU3MzIzMn0.ZDapQcLlvyO3l64ITkb7yZnlkXkKyJ337YJ4j22y_2Y',NULL,NULL),(126,4,1,'2017-03-15','2017-03-15 10:21:37','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzM4OTcsImlhdCI6MTQ4OTU3MzI5N30.LM4ctnKtX4z6DlSM_UYSYG-KLYA07OhGZxIs5f7x2Pw',NULL,NULL),(127,4,1,'2017-03-15','2017-03-15 11:11:47','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk1NzY5MDcsImlhdCI6MTQ4OTU3NjMwN30.m-RpUKz4EfLthJNo_lqh17oAX4xm7ahRxpyoCGf_EhI',NULL,NULL),(128,4,1,'2017-03-16','2017-03-16 05:06:27','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDEzODcsImlhdCI6MTQ4OTY0MDc4N30.8MFT31gKFEEGor3I8G4shozD08zIeQLioIpb-Qrf4GM',NULL,NULL),(129,4,1,'2017-03-16','2017-03-16 06:54:38','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDc4NzgsImlhdCI6MTQ4OTY0NzI3OH0.0OVR5-GqGdjgw9mpA2WQFE3Uqc0NARPuCT6JNuY6Bm8',NULL,NULL),(130,4,1,'2017-03-16','2017-03-16 06:57:33','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDgwNTMsImlhdCI6MTQ4OTY0NzQ1M30.-7Czm5g2d7aMPqKLJbkVCE6wvqmZFpEQ3zEB39PsvqU',NULL,NULL),(131,4,1,'2017-03-16','2017-03-16 06:58:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDgxMTQsImlhdCI6MTQ4OTY0NzUxNH0.Y0CSLQgDrOXVpIwwvM-6BJPfWr_o2EfW7q2rkg_qx0A',NULL,NULL),(132,4,1,'2017-03-16','2017-03-16 06:59:11','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDgxNTEsImlhdCI6MTQ4OTY0NzU1MX0.H6M_AX68f3SefXm7O4n6RrhvKyPFcFRuXHpH24YhUjs',NULL,NULL),(133,4,1,'2017-03-16','2017-03-16 07:00:39','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDgyMzksImlhdCI6MTQ4OTY0NzYzOX0.aG7yOS4KDqFcwQqWMp-dsP3IhwHv51mzBWOjuNOPtbI',NULL,NULL),(134,4,1,'2017-03-16','2017-03-16 07:04:22','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDg0NjIsImlhdCI6MTQ4OTY0Nzg2Mn0.WycOOWT965M99FWRSa7yX_SFVPidJmj1bXPgj2NffxE',NULL,NULL),(135,4,1,'2017-03-16','2017-03-16 07:06:03','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDg1NjMsImlhdCI6MTQ4OTY0Nzk2M30.TjMa6j5UL86bk3o2fKWukV_6mdnyqOdBQEGTV-L3v7k',NULL,NULL),(136,4,1,'2017-03-16','2017-03-16 07:08:55','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NDg3MzUsImlhdCI6MTQ4OTY0ODEzNX0.2hDuAvqJgxJxLwgFG2tXNiA725mYDGvZQCb-6VH27m4',NULL,NULL),(137,4,1,'2017-03-16','2017-03-16 08:27:44','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NTM0NjQsImlhdCI6MTQ4OTY1Mjg2NH0.madjWKuiTuwb4BJ5PmgR0Zz8P9V7ugZDjszBCxqs1tc',NULL,NULL),(138,4,1,'2017-03-16','2017-03-16 08:58:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NTUzMzYsImlhdCI6MTQ4OTY1NDczNn0.0UbUCZzTZ_t1Vkzpon4Vsi1KnfHbFpj67xv7hER2Bro',NULL,NULL),(139,4,1,'2017-03-16','2017-03-16 08:59:27','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMzg5LCJleHAiOjE0ODk2NTUzNjcsImlhdCI6MTQ4OTY1NDc2N30.YYoMEYEE8LVzp8GCvBlWZNBmfO2HAfWxhG-gL3iSGa0',NULL,NULL);
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
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_userroles_createdBy_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_userroles_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_userroles`
--

LOCK TABLES `domo_userroles` WRITE;
/*!40000 ALTER TABLE `domo_userroles` DISABLE KEYS */;
INSERT INTO `domo_userroles` VALUES (1,'cybage',NULL,NULL),(2,'domo',NULL,NULL),(3,'admin',NULL,NULL);
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
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_users_createdBy_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_users_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COMMENT='User information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_users`
--

LOCK TABLES `domo_users` WRITE;
/*!40000 ALTER TABLE `domo_users` DISABLE KEYS */;
INSERT INTO `domo_users` VALUES (1,17296,'sandeepnab','sandeepnab@cybage.com','Sandeep','Nabar','sandeep@12345',3,1,NULL,NULL),(2,12610,'vikasja','vikasja@cybage.com','Vikas','Jadhav','vikas@12345',1,1,NULL,NULL),(3,7601,'sajus','sajus@cybage.com','Saju','Sasidharan','saju@12345',1,1,NULL,NULL),(4,12389,'pravink','pravink@cybage.com','Pravin','Katta','pravin@12345',1,1,NULL,NULL),(5,14513,'ravikumard','ravikumard@cybage.com','Ravikumar','Dadhaniya','ravikumard@12345',1,1,NULL,NULL),(6,14170,'durgesha','durgesha@cybage.com','Durgesh','Ahire','durgesha@12345',1,1,NULL,NULL),(7,17005,'pranavki','pranavki@cybage.com','Pranav','Kishore','pranavki@12345',1,1,NULL,NULL),(8,15377,'sagarga','sagarga@cybage.com','Sagar','Gaikwad','sagarga@12345',1,1,NULL,NULL),(9,15106,'anjaliw','anjaliw@cybage.com','Anjali','Walke','anjaliw@12345',1,1,NULL,NULL),(10,8032,'rupeshr','rupeshr@cybage.com','Rupesh','Ramteke','rupeshr@12345',1,1,NULL,NULL),(11,12368,'prasanths','prasanths@cybage.com','Prasanth','Soman','prasanth@12345',1,0,NULL,NULL);
/*!40000 ALTER TABLE `domo_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'domo_mom_db'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `tokenTableCLeanup` */;
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
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `tokenTableCLeanup` ON SCHEDULE EVERY '30:0' MINUTE_SECOND STARTS '2017-02-10 15:11:49' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Clears out token table every 30 minutes.' DO DELETE FROM domo_mom_db.domo_token WHERE UNIX_TIMESTAMP(CURRENT_TIMESTAMP()) >  UNIX_TIMESTAMP(expiryTime); */ ;;
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

-- Dump completed on 2017-03-16 16:43:20
