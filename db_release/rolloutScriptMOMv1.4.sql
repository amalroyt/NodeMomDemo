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
  `createdBy` int(11) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  `active` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `domo_mom_fk_meetingId_idx` (`meetingId`),
  KEY `domo_mom_fk_responsible_idx` (`responsible`),
  KEY `domo_mom_fk_status_idx` (`status`),
  KEY `domo_mom_fk_created_By_idx` (`createdBy`),
  CONSTRAINT `domo_mom_fk_meeting_action_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_meetinId` FOREIGN KEY (`meetingId`) REFERENCES `domo_meeting_master` (`meetingId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_responsible` FOREIGN KEY (`responsible`) REFERENCES `domo_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `domo_mom_fk_status` FOREIGN KEY (`status`) REFERENCES `domo_meeting_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_action`
--

LOCK TABLES `domo_meeting_action` WRITE;
/*!40000 ALTER TABLE `domo_meeting_action` DISABLE KEYS */;
INSERT INTO `domo_meeting_action` VALUES (29,176,'Change the Size of Glyphicons',1,'2017-04-06','2017-04-10','2017-04-14',2,4,'2017-04-06',0),(30,176,'Chenge the layout of the Create new Meeting Form',2,'2017-04-06','2017-04-07','2017-04-14',2,4,'2017-04-06',0),(31,177,'Matt updated that go ahead create a fork request in medium editor, When medium editor fixes these issues then we will switch to stable branch.',2,'2017-03-01','2017-04-14',NULL,1,4,'2017-04-06',0),(32,177,'Timezone Project issues',2,'2017-04-19','2017-04-23','2017-04-06',2,4,'2017-04-06',0),(33,178,'Pendo improvements',4,'2017-01-23','2017-01-30','2017-04-06',2,4,'2017-04-06',0),(34,178,'NoteBook card tooltip issue',5,'2017-01-04','2017-01-26',NULL,3,4,'2017-04-06',0),(35,179,'Apply/cancel bulleted list inside empty table changes table position in editor',4,'2017-03-02','2017-04-14','2017-04-06',2,4,'2017-04-06',0),(36,185,'abc',1,'2017-01-10','2017-01-12','2017-04-14',2,4,'2017-04-14',0),(37,185,'abc',2,'2017-01-16','2017-01-18','2017-04-14',2,4,'2017-04-14',0),(38,185,'abc',3,'2017-01-17','2017-01-19','2017-04-14',2,4,'2017-04-14',0),(39,185,'abc',5,'2017-01-24','2017-01-26','2017-04-14',2,4,'2017-04-14',0),(40,185,'abc',4,'2017-01-23','2017-01-25','2017-04-14',2,4,'2017-04-14',0),(41,184,'def',5,'2017-02-02','2017-02-03','2017-04-14',2,4,'2017-04-14',0),(42,184,'def',4,'2017-02-06','2017-02-07','2017-04-14',2,4,'2017-04-14',0),(43,184,'def',3,'2017-02-09','2017-02-20','2017-04-14',2,4,'2017-04-14',0),(44,184,'def',2,'2017-02-21','2017-02-27','2017-04-14',2,4,'2017-04-14',0),(45,184,'def',1,'2017-02-27','2017-02-28','2017-04-14',2,4,'2017-04-14',0),(46,183,'ghi',1,'2017-02-07','2017-02-09','2017-04-14',2,4,'2017-04-14',0),(47,183,'ghi',2,'2017-02-13','2017-02-15','2017-04-14',2,4,'2017-04-14',0),(48,183,'ghi',3,'2017-02-15','2017-02-16','2017-04-14',2,4,'2017-04-14',0),(49,183,'ghi',4,'2017-02-22','2017-02-24','2017-04-14',2,4,'2017-04-14',0),(50,183,'ghi',5,'2017-02-27','2017-03-02','2017-04-14',2,4,'2017-04-14',0),(51,182,'jkl',1,'2017-03-01','2017-03-03','2017-04-14',2,4,'2017-04-14',0),(52,182,'jkl',2,'2017-03-06','2017-03-08','2017-04-14',2,4,'2017-04-14',0),(53,182,'jkl',3,'2017-03-09','2017-03-13','2017-04-14',2,4,'2017-04-14',0),(54,182,'jkl',4,'2017-03-21','2017-03-23','2017-04-14',2,4,'2017-04-14',0),(55,182,'jkl',5,'2017-03-27','2017-03-29','2017-04-14',2,4,'2017-04-14',0),(56,181,'klm',1,'2017-03-03','2017-03-06','2017-04-14',2,4,'2017-04-14',0),(57,181,'klm',2,'2017-03-08','2017-03-10','2017-04-14',2,4,'2017-04-14',0),(58,181,'klm',3,'2017-03-13','2017-03-15','2017-04-14',2,4,'2017-04-14',0),(59,181,'klm',4,'2017-03-20','2017-03-22','2017-04-14',2,4,'2017-04-14',0),(60,181,'klm',5,'2017-03-27','2017-03-29','2017-04-14',2,4,'2017-04-14',0),(61,180,'nop',1,'2017-03-02','2017-03-03','2017-04-14',2,4,'2017-04-14',0),(62,180,'nop',2,'2017-03-06','2017-03-08','2017-04-14',2,4,'2017-04-14',0),(63,180,'nop',3,'2017-03-09','2017-03-10','2017-04-14',2,4,'2017-04-14',0),(64,180,'nop',4,'2017-03-13','2017-03-15','2017-04-14',2,4,'2017-04-14',0),(65,180,'nop',5,'2017-03-20','2017-03-22','2017-04-14',2,4,'2017-04-14',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_master`
--

LOCK TABLES `domo_meeting_master` WRITE;
/*!40000 ALTER TABLE `domo_meeting_master` DISABLE KEYS */;
INSERT INTO `domo_meeting_master` VALUES (176,1,4,'DOMO_MoM_1','undefined',1,6,'CT1-2-6284','2017-04-06','04:00:00','05:00:00','1) Demo\n2) Suggestions','1,2,3,4,5',0,1,4,'2017-04-06','PM','PM','01','undefined'),(177,1,1,'DOMO_MoM_2','undefined',1,9,'CT-2-8267','2017-03-28','10:30:00','12:30:00','Release items\nAny open items?\nPendo guides\nAnalyzer Pendo\nAlerts\n','1,2,3,4,5',0,1,4,'2017-04-06','AM','PM','02',NULL),(178,1,1,'DOMO_MoM_3','undefined',1,7,'CT-2-8268','2017-02-02','11:30:00','12:00:00','DOMO-112523  Advanced Notebook card:IE10- Can not upload an image through \"Upload an Image\" link\nDOMO-112342  Notebook Card: IE10-Color picker pop-up is not displayed.\nDOMO-112335  Incorrect image icon is not displaying\n','1,2,3,4,5',1,1,4,'2017-04-06','AM','PM','30','undefined'),(179,1,1,'DOMO_MoM_4','undefined',3,10,'CT-2-8269','2017-03-24','04:00:00','05:00:00','DOMO-111757  Heading reset to default body font size when I apply UL/OL\nDOMO-105636  Text color loss when we apply UL/OL\nDOMO-99901     Apply/cancel bulleted list inside empty table changes table position in editor\n','1,2,3,4,5',1,1,4,'2017-04-06','PM','PM','01',NULL),(180,1,4,'DOMO_MoM_5','undefined',4,3,'zzz','2017-03-28','04:00:00','06:00:00','zzz','1,2,3,4,5',1,0,4,'2017-04-10','PM','PM','02',NULL),(181,1,4,'DOMO_MoM_6','undefined',4,3,'zz','2017-04-11','03:00:00','06:00:00','zzz','1,2,3,4,5',1,0,4,'2017-04-11','PM','PM','03',NULL),(182,1,2,'DOMO_MoM_7','undefined',4,3,'abc','2015-03-12','02:00:00','04:00:00','abc','1,2,3,4,5',1,0,4,'2015-03-11','PM','PM','02','abc'),(183,1,1,'DOMO_MoM_8','undefined',1,6,'CT1-2-6284','2017-02-15','11:30:00','12:00:00','DOMO-111757  Heading reset to default body font size when I apply UL/OL\n DOMO-105636  Text color loss when we apply UL/OL\n DOMO-99901     Apply/cancel bulleted list inside empty table changes table position in editor\n ','1,2,3,4,5',NULL,0,4,'2017-04-14','AM','PM','30',NULL),(184,1,2,'DOMO_MoM_9','undefined',1,8,'CT1-2-6284','2017-02-23','07:30:00','08:30:00','DOMO-111757  Heading reset to default body font size when I apply UL/OL\n DOMO-105636  Text color loss when we apply UL/OL\n DOMO-99901     Apply/cancel bulleted list inside empty table changes table position in editor\n ','1,2,3,4,5',NULL,0,4,'2017-04-14','PM','PM','01',NULL),(185,1,2,'DOMO_MoM_10','undefined',1,8,'CT1-2-6284','2017-03-21','08:30:00','09:30:00','DOMO-111757  Heading reset to default body font size when I apply UL/OL\n DOMO-105636  Text color loss when we apply UL/OL\n DOMO-99901     Apply/cancel bulleted list inside empty table changes table position in editor\n ','1,2,3,4,5',NULL,0,4,'2017-04-14','PM','PM','01',NULL),(186,1,3,'DOMO_MoM_11','undefined',3,5,'CT1-2-6284','2017-04-06','04:00:00','04:30:00','abc','1,2,3,4,5',NULL,0,4,'2017-04-17','PM','PM','30',NULL),(187,1,1,'DOMO_MoM_12','undefined',1,5,'CT1-2-6284','2017-04-06','04:30:00','06:30:00','abc','1,2,4,5',NULL,0,4,'2017-04-17','PM','PM','02',NULL),(188,1,3,'DOMO_MoM_13','undefined',1,5,'CT1-2-6284','2017-04-06','07:30:00','09:30:00','aaa','1,2,3,4,5,6,7,8,9,10',NULL,0,4,'2017-04-17','PM','PM','02',NULL),(189,1,1,'DOMO_MoM_14','undefined',1,1,'CT1-2-6284','2017-04-06','04:00:00','05:00:00','abc','1,2,3,4,5,6,7,8,9,10',NULL,0,4,'2017-04-17','PM','PM','01',NULL),(190,1,1,'DOMO_MoM_15','undefined',2,5,'CT1-2-6284','2017-03-28','11:30:00','12:00:00','xyz','1,2,3,4,5,6',NULL,0,4,'2017-04-17','AM','PM','30',NULL),(191,1,2,'DOMO_MoM_16','undefined',3,8,'CT1-2-6284','2017-03-28','03:00:00','04:00:00','fgs','1,2,3,4,5,6,7,8',NULL,0,4,'2017-04-17','PM','PM','01','undefined'),(192,1,2,'DOMO_MoM_17','undefined',2,8,'CT1-2-6284','2017-03-21','07:30:00','08:30:00','ffjbjfk','1,2,3,5,6,7',NULL,0,4,'2017-04-17','PM','PM','01',NULL),(193,1,3,'DOMO_MoM_18','undefined',1,6,'CT1-2-6284','2017-03-21','05:00:00','06:00:00','fxhggfnjcgh','1,2,3,4,5,6,7,8,9,10',NULL,0,4,'2017-04-17','PM','PM','01',NULL),(194,1,2,'DOMO_MoM_19','undefined',4,4,'CT1-2-6284','2017-02-23','07:30:00','09:30:00','sjtgd','7,8,9',1,0,4,'2017-04-17','PM','PM','02','undefined'),(195,1,2,'DOMO_MoM_20','undefined',1,8,'CT1-2-6284','2017-04-27','07:30:00','08:30:00','abc','1,2,3,4,5,7,8,9,10',1,0,NULL,'2017-04-27','PM','PM','01',NULL),(196,1,2,'DOMO_MoM_21','undefined',1,8,'CT1-2-6284','2017-05-09','07:30:00','08:30:00','abcdef','1,3,4,5,6,7,8,9,10',NULL,0,1,'2017-05-09','PM','PM','01',NULL),(197,1,2,'DOMO_MoM_22','undefined',1,8,'CT1-2-6284','2017-05-11','08:00:00','09:00:00','asdad','1,2,3,6,7,8,9,10',NULL,0,1,'2017-05-09','PM','PM','01',NULL);
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
  `active` tinyint(4) DEFAULT '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domo_meeting_points`
--

LOCK TABLES `domo_meeting_points` WRITE;
/*!40000 ALTER TABLE `domo_meeting_points` DISABLE KEYS */;
INSERT INTO `domo_meeting_points` VALUES (3,176,1,1,'Discussion on Meeting List Page',1,'Change the Size of Glyphicons',4,'2017-04-06',0),(4,176,2,1,'Discussion on Create New Meeting Page',2,'Keep the important fields in the left Panel of the form',4,'2017-04-06',0),(5,177,3,1,'Changes are behind feature switch and we will be having drag and drop for this.',1,'Approved the changes',4,'2017-04-06',0),(6,177,2,1,'Customer wants Standard feed on domo activity, Certified cards/pages and Admin feature for beast mode.',3,' Standard feed on activity should be provided',4,'2017-04-06',0),(7,177,4,3,'Demo on work done so far',1,'Mentioned few improvements',4,'2017-04-06',0),(8,178,5,2,'DOMO13789 card issue',1,'updated that we will go ahead and create the card for DOMO13789.',4,'2017-04-06',0),(9,178,3,1,'discussed on DP17.',1,'updated that we will go ahead and create the card for DP17.',4,'2017-04-06',0),(10,179,6,1,'Issues with Medium Editor Library marked as Prep',3,'Can not upload an image through \"Upload an Image\" link',4,'2017-04-06',0),(11,179,3,3,'Issues of Data Linage',1,'appreciate work done on Data Linage. ',4,'2017-04-06',0);
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
