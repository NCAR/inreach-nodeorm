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

-- CREATE DATABASE /*!32312 IF NOT EXISTS*/ `inreach` /*!40100 DEFAULT CHARACTER SET utf8 */;
-- USE `inreach`;

DROP TABLE IF EXISTS `inreach_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inreach_event` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `imei` varchar(15) NOT NULL DEFAULT '',
  `message_code` int(11) DEFAULT NULL,
  `free_text` varchar(255) DEFAULT NULL,
  `message_time` timestamp NOT NULL DEFAULT '1970-01-01 00:00:01',
  `pingback_received` timestamp NULL DEFAULT NULL,
  `pingback_responded` timestamp NULL DEFAULT NULL,
  `addresses` text,
  `latitude` decimal(7,5) NOT NULL DEFAULT '-90.00000',
  `longitude` decimal(8,5) NOT NULL DEFAULT '-180.00000',
  `altitude` decimal(11,5) DEFAULT NULL,
  `gps_fix` int(11) DEFAULT NULL,
  `course` float DEFAULT NULL,
  `speed` float DEFAULT NULL,
  `autonomous` int(11) DEFAULT NULL,
  `low_battery` int(11) DEFAULT NULL,
  `interval_change` int(11) DEFAULT NULL,
  `reset_detected` int(11) DEFAULT NULL,
  `row_create_time` timestamp NOT NULL DEFAULT '1970-01-01 00:00:01',
  `row_revise_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `imei` (`imei`),
  KEY `message_time` (`message_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `inreach_message_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inreach_message_code` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `row_create_time` timestamp NOT NULL DEFAULT '1970-01-01 00:00:01',
  `row_revise_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `inreach_message_code` WRITE;
/*!40000 ALTER TABLE `inreach_message_code` DISABLE KEYS */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
INSERT INTO `inreach_message_code` VALUES (0,'Position Report','Drops a breadcrumb while tracking.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (1,'Reserved','Reserved for later use.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (2,'Locate Response','Position for a locate request.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (3,'Free Text Message','Message containing a free-text block.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (4,'Declare SOS','Declares an emergency state.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (5,'Reserved','Reserved for later use.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (6,'Confirm SOS','Confirms an unconfirmed SOS.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (7,'Cancel SOS','Stops a SOS event.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (8,'Reference Point','Shares a non-GPS location.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (9,'Check In','Response to a scheduled or unscheduled check-in.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (10,'Start Track','Begins a tracking process on the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (11,'Track Interval','Indicates changes in tracking interval.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (12,'Stop Track','Ends a tracking process on the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (13,'Unknown Index','Used when the device receives a message from the server addressed to a synced contact identifier that is not on the device.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (14,'Puck Message 1','Sends the first of three inReach message button events.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (15,'Puck Message 2','Sends the second of three inReach message button events.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (16,'Puck Message 3','Sends the third of three inReach message button events.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (17,'Map Share','Sends a message to the shared map.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (20,'Mail Check','Sent to determine if any messages are queued for the device.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (21,'Am I Alive','Sent when the device needs to determine if it is active. This message is automatically replied to by the DeLorme server to indicate the current status of the device.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (24,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (25,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (26,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (27,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (28,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (29,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (30,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (31,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (32,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (33,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (34,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (35,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (36,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (37,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (38,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (39,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (40,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (41,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (42,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (43,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (44,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (45,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (46,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (47,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (48,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (49,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (50,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (51,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (52,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (53,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (54,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (55,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (56,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (57,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (58,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (59,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (60,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (61,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (62,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (63,'Pre-defined Message','The index for a text message that is synchronized with the server.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (64,'Encrypted Binary','An encrypted binary Earthmate message.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (65,'Pingback Message','A pingback response message (initiated through IPCInbound).',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (66,'Generic Binary','An uninterpreted binary message.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (67,'EncryptedPinpoint','A fully-encrypted inReach message.',NOW(),NULL);
INSERT INTO `inreach_message_code` VALUES (3099,'Canned Message','A Quicktext message, potentially edited by the user.',NOW(),NULL);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40000 ALTER TABLE `inreach_message_code` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
