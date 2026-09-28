-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: dl_ldb_1
-- ------------------------------------------------------
-- Server version	5.7.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `dl_ldb_1`
--

/*!40000 DROP DATABASE IF EXISTS `dl_ldb_1`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dl_ldb_1` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `dl_ldb_1`;

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `activity` varchar(32) NOT NULL DEFAULT '',
  `start_time` char(14) NOT NULL DEFAULT '',
  `end_time` char(14) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '0',
  `para2` varchar(128) NOT NULL DEFAULT '0',
  `para3` varchar(255) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `activity` (`activity`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anti_cheater_log`
--

DROP TABLE IF EXISTS `anti_cheater_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anti_cheater_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lv` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `ip` char(15) NOT NULL DEFAULT '',
  `mac` char(32) NOT NULL DEFAULT '',
  `para1` varchar(32) DEFAULT '',
  `para2` varchar(32) DEFAULT '',
  `para3` varchar(128) DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `type` (`type`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anti_cheater_log`
--

LOCK TABLES `anti_cheater_log` WRITE;
/*!40000 ALTER TABLE `anti_cheater_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `anti_cheater_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antiaddiction_log`
--

DROP TABLE IF EXISTS `antiaddiction_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `antiaddiction_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `online_time` int(11) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antiaddiction_log`
--

LOCK TABLES `antiaddiction_log` WRITE;
/*!40000 ALTER TABLE `antiaddiction_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `antiaddiction_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apex_log`
--

DROP TABLE IF EXISTS `apex_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apex_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(3) NOT NULL DEFAULT '0',
  `kill_action` varchar(32) NOT NULL DEFAULT '',
  `task` tinyint(3) NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) DEFAULT NULL,
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `lv` tinyint(3) NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) DEFAULT NULL,
  `error_id` int(11) NOT NULL DEFAULT '0',
  `str_n` tinyint(3) NOT NULL DEFAULT '0',
  `ip` varchar(16) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `ip_gids` int(11) NOT NULL DEFAULT '0',
  `mac_gids` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `error_id` (`error_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apex_log`
--

LOCK TABLES `apex_log` WRITE;
/*!40000 ALTER TABLE `apex_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `apex_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apply_log`
--

DROP TABLE IF EXISTS `apply_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apply_log` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `upgrade_state` tinyint(3) NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) DEFAULT NULL,
  `lv` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `gold_coin` int(10) NOT NULL DEFAULT '0',
  `insider` int(10) unsigned NOT NULL DEFAULT '0',
  `item_type` tinyint(3) NOT NULL DEFAULT '0',
  `item_name` varchar(32) NOT NULL DEFAULT '',
  `item_price` int(11) NOT NULL DEFAULT '0',
  `item_life` int(11) NOT NULL DEFAULT '0',
  `item_source` tinyint(4) NOT NULL DEFAULT '0',
  `iid` varchar(32) NOT NULL DEFAULT '',
  `lv_equipment` smallint(5) unsigned DEFAULT NULL,
  `para1` int(10) DEFAULT NULL,
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(32) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `name` (`item_name`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apply_log`
--

LOCK TABLES `apply_log` WRITE;
/*!40000 ALTER TABLE `apply_log` DISABLE KEYS */;
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000001,'20180413155720',1,2,'apply',0,'stanwind','0000000000000001',1,499997200,1,1,'会员卡',2800,4,1,':5AD062DC00010198243F:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000002,'20180413155908',1,2,'apply',0,'test','0000000000000002',3,499434000,1,1,'360天年费会员卡',566000,4,1,':5AD06348000101982441:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000003,'20180413155926',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,3,1,':5AD0635B000101982446:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000004,'20180413155926',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,3,1,':5AD0635B00010198244B:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000005,'20180413155927',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,4,1,':5AD0635B00010198244A:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000006,'20180413155927',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,4,1,':5AD0635B000101982445:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000007,'20180413155927',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,4,1,':5AD0635B00010198244F:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000008,'20180413155928',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,5,1,':5AD0635B000101982450:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000009,'20180413155928',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,5,1,':5AD0635B000101982451:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000010,'20180413155928',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,5,1,':5AD0635B00010198244C:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000011,'20180413155928',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,5,1,':5AD0635B000101982447:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000012,'20180413155929',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,6,1,':5AD0635B000101982448:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000013,'20180413155929',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,6,1,':5AD0635B00010198244D:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000014,'20180413155929',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,6,1,':5AD0635B000101982452:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000015,'20180413155929',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,6,1,':5AD0635B000101982453:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000016,'20180413155930',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,7,1,':5AD0635B00010198244E:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000017,'20180413155930',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,7,1,':5AD0635B000101982449:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000018,'20180413155930',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,7,1,':5AD0635B000101982444:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000019,'20180413155930',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,7,1,':5AD0635B000101982443:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000020,'20180413155932',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,9,1,':5AD0635B000101982454:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000021,'20180413155950',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,27,1,':5AD0635B000101982455:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000022,'20180413155950',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,27,1,':5AD0635B00010198245A:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000023,'20180413155950',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,27,1,':5AD0635B000101982459:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000024,'20180413155950',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,27,1,':5AD0635B00010198245E:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000025,'20180413155951',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,28,1,':5AD0635B00010198245F:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000026,'20180413155951',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,28,1,':5AD0635B000101982460:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000027,'20180413155951',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,28,1,':5AD0635B00010198245B:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000028,'20180413155952',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,29,1,':5AD0635B000101982456:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000029,'20180413155952',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,29,1,':5AD0635B000101982457:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000030,'20180413155952',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,29,1,':5AD0635B00010198245C:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000031,'20180413155959',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,36,1,':5AD0635B000101982465:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000032,'20180413155959',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,36,1,':5AD0635B000101982464:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000033,'20180413160000',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,37,1,':5AD0635B000101982463:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000034,'20180413160000',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,37,1,':5AD0635B000101982466:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000035,'20180413160001',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,38,1,':5AD0635B000101982461:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000036,'20180413160001',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,38,1,':5AD0635B000101982462:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000037,'20180413160001',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,38,1,':5AD0635B000101982467:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000038,'20180413160001',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,38,1,':5AD0635B00010198245D:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000039,'20180413160002',1,2,'apply',0,'test','0000000000000002',3,498634000,1,1,'锦囊',20000,39,1,':5AD0635B000101982458:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000040,'20180413160007',1,2,'apply',0,'stanwind','0000000000000001',1,499997200,1,1,'北极熊',100000,0,1,':5AD06387000101982478:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000041,'20180413160025',1,2,'apply',0,'stanwind','0000000000000001',1,499657200,1,1,'锦囊',20000,2,1,':5AD06397000101982480:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000042,'20180413160026',1,2,'apply',0,'stanwind','0000000000000001',1,499657200,1,1,'锦囊',20000,3,1,':5AD0639700010198247A:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000043,'20180413160026',1,2,'apply',0,'stanwind','0000000000000001',1,499657200,1,1,'锦囊',20000,3,1,':5AD0639700010198247F:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000044,'20180413160028',1,2,'apply',0,'stanwind','0000000000000001',1,499657200,1,1,'锦囊',20000,5,1,':5AD0639700010198247E:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000045,'20180413160033',1,2,'apply',0,'stanwind','0000000000000001',1,499657200,1,1,'锦囊',20000,10,1,':5AD06397000101982483:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000046,'20180413160034',1,2,'apply',0,'stanwind','0000000000000001',1,499657200,1,1,'锦囊',20000,11,1,':5AD06397000101982484:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000047,'20180413160035',1,2,'apply',0,'stanwind','0000000000000001',1,499657200,1,1,'锦囊',20000,12,1,':5AD06397000101982485:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000048,'20180413160036',1,2,'apply',0,'stanwind','0000000000000001',1,499657200,1,1,'锦囊',20000,13,1,':5AD06397000101982481:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000049,'20180413160036',1,2,'apply',0,'stanwind','0000000000000001',1,499657200,1,1,'锦囊',20000,13,1,':5AD06397000101982482:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000050,'20180413160353',1,2,'apply',0,'stanwind','0000000000000001',1,499620200,1,1,'高级道具套餐卡',8000,5,1,':5AD0646400010198249C:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000051,'20180413160354',1,2,'apply',0,'stanwind','0000000000000001',1,499620200,1,1,'高级道具套餐卡',8000,5,1,':5AD0646500010198249E:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000052,'20180413160355',1,2,'apply',0,'stanwind','0000000000000001',1,499620200,1,1,'高级道具套餐卡',8000,6,1,':5AD064650001019824A0:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000053,'20180413160356',1,2,'apply',0,'stanwind','0000000000000001',1,499620200,1,1,'高级道具套餐卡',8000,6,1,':5AD064660001019824A2:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000054,'20180413160429',1,2,'apply',0,'stanwind','0000000000000001',1,499054200,1,1,'360天年费会员卡',566000,3,1,':5AD0648A0001019824A4:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000055,'20180413160546',1,2,'apply',0,'stanwind','0000000000000001',1,499054200,1,1,'喇叭',8000,258,1,':5AD063D8000101982494:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000056,'20180413160549',1,2,'apply',0,'stanwind','0000000000000001',1,499054200,1,1,'锦囊',20000,326,1,':5AD0639700010198247B:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000057,'20180413160550',1,2,'apply',0,'stanwind','0000000000000001',1,499054200,1,1,'锦囊',20000,327,1,':5AD0639700010198247C:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000058,'20180413160552',1,2,'apply',0,'stanwind','0000000000000001',1,499054200,1,1,'锦囊',20000,329,1,':5AD0639700010198247D:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000059,'20180413160618',1,2,'apply',0,'test','0000000000000002',16,498628672,1,1,'喇叭',8000,330,1,':5AD063B0000101982491:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000060,'20180413160725',1,2,'apply',0,'test','0000000000000002',16,498622272,1,1,'高级灵池',2400,9,1,':5AD065340001019824B1:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000061,'20180413160727',1,2,'apply',0,'test','0000000000000002',16,498622272,1,1,'高级灵池',2400,6,1,':5AD065390001019824B5:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000062,'20180413160728',1,2,'apply',0,'test','0000000000000002',16,498622272,1,1,'高级血池',800,9,1,':5AD065370001019824B3:',0,0,'','','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000063,'20180413160738',1,2,'apply',0,'test','0000000000000002',16,498619072,1,1,'高级血池',800,24,1,':5AD065320001019824AF:',0,0,':5AD0636200010198246F:','重明','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000064,'20180413160739',1,2,'apply',0,'test','0000000000000002',16,498619072,1,1,'高级血池',800,7,1,':5AD065440001019824B7:',0,0,':5AD0636200010198246F:','重明','');
INSERT INTO `apply_log` (`id`, `update_time`, `line`, `type`, `action`, `upgrade_state`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `item_type`, `item_name`, `item_price`, `item_life`, `item_source`, `iid`, `lv_equipment`, `para1`, `para2`, `para3`, `memo`) VALUES (0000000065,'20180413160740',1,2,'apply',0,'test','0000000000000002',16,498619072,1,1,'高级灵池',2400,6,1,':5AD065460001019824B9:',0,0,':5AD0636200010198246F:','重明','');
/*!40000 ALTER TABLE `apply_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto_talk_log`
--

DROP TABLE IF EXISTS `auto_talk_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auto_talk_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `line` tinyint(2) NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `ip` char(15) NOT NULL DEFAULT '',
  `level` int(11) NOT NULL DEFAULT '0',
  `max_lv` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `map` varchar(255) NOT NULL DEFAULT '',
  `call_times` int(11) NOT NULL DEFAULT '0',
  `publish` tinyint(2) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `account` (`account`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `mac` (`mac`) USING BTREE,
  KEY `update_time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_talk_log`
--

LOCK TABLES `auto_talk_log` WRITE;
/*!40000 ALTER TABLE `auto_talk_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_talk_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `behavior_log`
--

DROP TABLE IF EXISTS `behavior_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `behavior_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `time_used` smallint(5) unsigned NOT NULL DEFAULT '0',
  `time_used_fd` smallint(5) unsigned NOT NULL DEFAULT '0',
  `lv` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `tao` int(10) unsigned NOT NULL DEFAULT '0',
  `upgrade_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `addup_exp` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `addup_tao` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `addup_play` smallint(5) unsigned NOT NULL DEFAULT '0',
  `addup_round` smallint(5) unsigned NOT NULL DEFAULT '0',
  `addup_talk_times` smallint(5) unsigned NOT NULL DEFAULT '0',
  `addup_friend_times` smallint(5) unsigned NOT NULL DEFAULT '0',
  `addup_click_npc` smallint(5) unsigned NOT NULL DEFAULT '0',
  `addup_exchange` smallint(5) unsigned NOT NULL DEFAULT '0',
  `addup_click_mouse` smallint(5) unsigned NOT NULL DEFAULT '0',
  `addup_move_order` smallint(5) unsigned NOT NULL DEFAULT '0',
  `time_used_stall` smallint(5) unsigned NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `behavior_log`
--

LOCK TABLES `behavior_log` WRITE;
/*!40000 ALTER TABLE `behavior_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `behavior_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_log`
--

DROP TABLE IF EXISTS `block_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `mode` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `due` int(11) NOT NULL DEFAULT '0',
  `reason_type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `operator` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(255) NOT NULL DEFAULT '',
  `para3` int(11) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `operator` (`operator`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `action` (`action`) USING BTREE,
  KEY `time_gid` (`update_time`,`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_log`
--

LOCK TABLES `block_log` WRITE;
/*!40000 ALTER TABLE `block_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_log`
--

DROP TABLE IF EXISTS `campaign_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `line` varchar(15) NOT NULL DEFAULT '',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `lv` int(11) NOT NULL DEFAULT '0',
  `party_gid` varchar(32) NOT NULL DEFAULT '',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `insider` tinyint(1) NOT NULL DEFAULT '0',
  `para1` int(11) DEFAULT NULL,
  `para2` varchar(32) DEFAULT NULL,
  `para3` varchar(255) DEFAULT NULL,
  `bonus_type` tinyint(4) NOT NULL DEFAULT '0',
  `bonus_name` varchar(32) NOT NULL DEFAULT '',
  `bonus_prop` varchar(32) DEFAULT NULL,
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `action` (`action`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_log`
--

LOCK TABLES `campaign_log` WRITE;
/*!40000 ALTER TABLE `campaign_log` DISABLE KEYS */;
INSERT INTO `campaign_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (1,'20180413155735','1',1,'xinsqfl','test','0000000000000002',2,'',0,13,0,'116.208.216.141','',1,'功能卷轴·天神降临','1','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `campaign_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (2,'20180413155735','1',1,'xinsqfl','test','0000000000000002',2,'',0,13,0,'116.208.216.141','',1,'七色花','20','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `campaign_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (3,'20180413155735','1',1,'xinsqfl','test','0000000000000002',2,'',0,13,0,'116.208.216.141','',2,'250','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `campaign_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (4,'20180413160232','1',1,'wendylr_dj','test','0000000000000002',11,'',498629000,16,100,'116.208.216.141','',0,'0000000000000001','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `campaign_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (5,'20180413160232','1',1,'yinlrjfhjl','stanwind','0000000000000001',1,'',499652200,16,0,'182.100.43.245','',101,'1','0000000000000002','0000001c42f48da8;2;team_num:1;ip_num:1;mac_num:1;玩家增加前的活力值: 0 、增加后的活力值: 1、活动名称：引路人换积分');
INSERT INTO `campaign_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (6,'20180413160254','1',1,'bangd','test','0000000000000002',12,'',498629000,16,100,'116.208.216.141','',101,'bind',':5AD0642E000101982498:','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
/*!40000 ALTER TABLE `campaign_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_log`
--

DROP TABLE IF EXISTS `channel_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channel_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lv` tinyint(4) NOT NULL DEFAULT '0',
  `channel` int(11) NOT NULL DEFAULT '0',
  `target` varchar(32) NOT NULL DEFAULT '',
  `msg` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `sender` (`name`) USING BTREE,
  KEY `target` (`target`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_log`
--

LOCK TABLES `channel_log` WRITE;
/*!40000 ALTER TABLE `channel_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `channel_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_log`
--

DROP TABLE IF EXISTS `chat_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lv` tinyint(4) NOT NULL DEFAULT '0',
  `chat_type` varchar(32) NOT NULL DEFAULT '',
  `chat_channel` int(11) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_log`
--

LOCK TABLES `chat_log` WRITE;
/*!40000 ALTER TABLE `chat_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_action_log`
--

DROP TABLE IF EXISTS `client_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_action_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `account` varchar(32) DEFAULT NULL,
  `gid` varchar(32) DEFAULT NULL,
  `mac` varchar(64) DEFAULT NULL,
  `ip` varchar(32) DEFAULT NULL,
  `insider` tinyint(4) unsigned DEFAULT NULL,
  `lv` int(11) unsigned DEFAULT NULL,
  `tao` int(11) unsigned DEFAULT NULL,
  `gold_coin` int(11) unsigned DEFAULT NULL,
  `in_party` tinyint(4) unsigned DEFAULT NULL,
  `send_num` int(11) unsigned DEFAULT NULL,
  `send_gids` int(11) unsigned DEFAULT NULL,
  `receive_num` int(11) unsigned DEFAULT NULL,
  `receive_gids` int(11) unsigned DEFAULT NULL,
  `current_channel` int(11) unsigned DEFAULT NULL,
  `troop_channel` int(11) unsigned DEFAULT NULL,
  `party_channel` int(11) unsigned DEFAULT NULL,
  `team_channel` int(11) unsigned DEFAULT NULL,
  `world_channel` int(11) unsigned DEFAULT NULL,
  `whoop_channel` int(11) unsigned DEFAULT NULL,
  `para1` int(11) DEFAULT NULL,
  `para2` int(11) DEFAULT NULL,
  `para3` int(11) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `mac` (`mac`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_action_log`
--

LOCK TABLES `client_action_log` WRITE;
/*!40000 ALTER TABLE `client_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_performance_log`
--

DROP TABLE IF EXISTS `client_performance_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_performance_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `record_interval` int(11) DEFAULT NULL,
  `account` varchar(32) DEFAULT NULL,
  `gid` varchar(32) DEFAULT NULL,
  `mac` varchar(64) DEFAULT NULL,
  `ip` varchar(32) DEFAULT NULL,
  `insider` tinyint(4) unsigned DEFAULT NULL,
  `lv` int(11) unsigned DEFAULT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL,
  `cpu_cost` int(11) DEFAULT NULL,
  `mem_cost` varchar(128) DEFAULT NULL,
  `render_frame_rate` int(11) unsigned DEFAULT NULL,
  `cur_scene` tinyint(4) unsigned DEFAULT NULL,
  `cur_room_user` int(11) unsigned DEFAULT NULL,
  `cur_room_name` varchar(32) DEFAULT NULL,
  `cur_process_num` int(11) unsigned DEFAULT NULL,
  `minimize_window` tinyint(4) unsigned DEFAULT NULL,
  `button_type` varchar(32) DEFAULT NULL,
  `button_name` varchar(32) DEFAULT NULL,
  `timeslice` varchar(32) DEFAULT NULL,
  `button_times` int(11) unsigned DEFAULT NULL,
  `directx_version` varchar(19) DEFAULT NULL,
  `prever_download` varchar(19) DEFAULT NULL,
  `para1` int(11) DEFAULT NULL,
  `para2` varchar(32) DEFAULT NULL,
  `para3` varchar(32) DEFAULT NULL,
  `para4` varchar(64) DEFAULT NULL,
  `para5` varchar(128) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `mac` (`mac`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_performance_log`
--

LOCK TABLES `client_performance_log` WRITE;
/*!40000 ALTER TABLE `client_performance_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_performance_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coin_consume_log`
--

DROP TABLE IF EXISTS `coin_consume_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coin_consume_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `coin` int(11) NOT NULL DEFAULT '0',
  `update_time` char(14) NOT NULL DEFAULT '',
  `consume_info` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `account` (`account`) USING BTREE,
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coin_consume_log`
--

LOCK TABLES `coin_consume_log` WRITE;
/*!40000 ALTER TABLE `coin_consume_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `coin_consume_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coin_order_log`
--

DROP TABLE IF EXISTS `coin_order_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coin_order_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `order_id` varchar(15) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(12) NOT NULL DEFAULT '',
  `mac` char(16) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `insider` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `lv` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `store_coin` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `tax` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `server` (`server`) USING BTREE,
  KEY `order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coin_order_log`
--

LOCK TABLES `coin_order_log` WRITE;
/*!40000 ALTER TABLE `coin_order_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `coin_order_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collect_data_log`
--

DROP TABLE IF EXISTS `collect_data_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collect_data_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `cpu_id` varchar(64) NOT NULL DEFAULT '',
  `cpu_info` varchar(64) NOT NULL DEFAULT '',
  `disk_sequence` varchar(64) NOT NULL DEFAULT '',
  `mac_address` varchar(64) NOT NULL DEFAULT '',
  `video_card` varchar(64) NOT NULL DEFAULT '',
  `memory_size` int(11) NOT NULL DEFAULT '0',
  `video_memory` int(11) NOT NULL DEFAULT '0',
  `bios` varchar(64) NOT NULL DEFAULT '',
  `privilege` int(11) NOT NULL DEFAULT '0',
  `para1` varchar(64) NOT NULL DEFAULT '',
  `para2` varchar(64) NOT NULL DEFAULT '',
  `para3` varchar(64) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect_data_log`
--

LOCK TABLES `collect_data_log` WRITE;
/*!40000 ALTER TABLE `collect_data_log` DISABLE KEYS */;
INSERT INTO `collect_data_log` (`id`, `update_time`, `account`, `gid`, `cpu_id`, `cpu_info`, `disk_sequence`, `mac_address`, `video_card`, `memory_size`, `video_memory`, `bios`, `privilege`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180413155303','stanwind','0000000000000001','529267711,GenuineIntel','586,2,6,15620,2.71GHz','4KSEFR8VCSYM5DH3EZ7B','001c42f48da8,001c42f48da8','1,Parallels Display Adapter (WDDM)',4095,1048576,'',1,'2;6;2;;1;256;0;unknown version','1.60.0905','','');
/*!40000 ALTER TABLE `collect_data_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `combat_in_map_log`
--

DROP TABLE IF EXISTS `combat_in_map_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `combat_in_map_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `level` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `insider` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(32) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `tao` int(11) NOT NULL DEFAULT '0',
  `family` varchar(32) NOT NULL DEFAULT '',
  `create_time` char(14) NOT NULL DEFAULT '',
  `map` varchar(32) NOT NULL DEFAULT '',
  `combat_times` int(11) NOT NULL DEFAULT '0',
  `combat_pet` varchar(32) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `char_name` (`char_name`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `combat_in_map_log`
--

LOCK TABLES `combat_in_map_log` WRITE;
/*!40000 ALTER TABLE `combat_in_map_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `combat_in_map_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `combat_log`
--

DROP TABLE IF EXISTS `combat_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `combat_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `mac` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `insider` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `lv` int(11) NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `in_party` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `all_round` int(11) NOT NULL DEFAULT '0',
  `abnormal_round` int(11) NOT NULL DEFAULT '0',
  `abnormal_degree` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `main_attribute` varchar(32) NOT NULL DEFAULT '0',
  `ratio_attribute` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` int(11) NOT NULL DEFAULT '0',
  `para3` varchar(32) NOT NULL DEFAULT '0',
  `para4` varchar(128) NOT NULL DEFAULT '0',
  `para5` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `combat_log`
--

LOCK TABLES `combat_log` WRITE;
/*!40000 ALTER TABLE `combat_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `combat_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `common_hist`
--

DROP TABLE IF EXISTS `common_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `common_hist` (
  `id` int(11) NOT NULL DEFAULT '0',
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `severity` int(11) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(128) NOT NULL DEFAULT '',
  `para2` varchar(128) NOT NULL DEFAULT '',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  KEY `id` (`id`) USING BTREE,
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common_hist`
--

LOCK TABLES `common_hist` WRITE;
/*!40000 ALTER TABLE `common_hist` DISABLE KEYS */;
/*!40000 ALTER TABLE `common_hist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `common_log`
--

DROP TABLE IF EXISTS `common_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `common_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `severity` int(11) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(128) NOT NULL DEFAULT '',
  `para2` varchar(128) NOT NULL DEFAULT '',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common_log`
--

LOCK TABLES `common_log` WRITE;
/*!40000 ALTER TABLE `common_log` DISABLE KEYS */;
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180305175851','ccs_daili','time',4,'save_server_time','ccs_daili','20180305175851','11','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (2,'20180305175935','一线','time',4,'save_server_time','一线','20180305175935','11','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (3,'20180305182851','ccs_daili','time',4,'save_server_time','ccs_daili','20180305182851','1811','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (4,'20180305182935','一线','time',4,'save_server_time','一线','20180305182935','1811','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (5,'20180305185851','ccs_daili','time',4,'save_server_time','ccs_daili','20180305185851','3611','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (6,'20180305185935','一线','time',4,'save_server_time','一线','20180305185935','3611','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (7,'20180413143922','ccs_daili','time',4,'save_server_time','ccs_daili','20180413143922','5','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (8,'20180413150922','ccs_daili','time',4,'save_server_time','ccs_daili','20180413150922','1805','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (9,'20180413152613','一线','time',4,'save_server_time','一线','20180413152613','7','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (10,'20180413154750','ccs_daili','time',4,'save_server_time','ccs_daili','20180413154750','1','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (11,'20180413154807','一线','time',4,'save_server_time','一线','20180413154807','7','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (12,'20180413155720','一线','charge_item',1,'consumption','0000000000000001',':5AD062DC00010198243F:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (13,'20180413155908','一线','charge_item',1,'consumption','0000000000000002',':5AD06348000101982441:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (14,'20180413155926','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982446:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (15,'20180413155926','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198244B:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (16,'20180413155927','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198244A:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (17,'20180413155927','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982445:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (18,'20180413155927','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198244F:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (19,'20180413155928','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982450:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (20,'20180413155928','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982451:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (21,'20180413155928','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198244C:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (22,'20180413155928','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982447:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (23,'20180413155929','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982448:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (24,'20180413155929','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198244D:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (25,'20180413155929','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982452:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (26,'20180413155929','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982453:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (27,'20180413155930','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198244E:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (28,'20180413155930','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982449:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (29,'20180413155930','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982444:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (30,'20180413155930','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982443:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (31,'20180413155932','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982454:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (32,'20180413155950','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982455:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (33,'20180413155950','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198245A:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (34,'20180413155950','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982459:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (35,'20180413155950','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198245E:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (36,'20180413155951','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198245F:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (37,'20180413155951','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982460:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (38,'20180413155951','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198245B:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (39,'20180413155952','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982456:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (40,'20180413155952','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982457:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (41,'20180413155952','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198245C:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (42,'20180413155959','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982465:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (43,'20180413155959','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982464:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (44,'20180413160000','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982463:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (45,'20180413160000','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982466:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (46,'20180413160001','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982461:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (47,'20180413160001','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982462:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (48,'20180413160001','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982467:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (49,'20180413160001','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B00010198245D:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (50,'20180413160002','一线','charge_item',1,'consumption','0000000000000002',':5AD0635B000101982458:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (51,'20180413160025','一线','charge_item',1,'consumption','0000000000000001',':5AD06397000101982480:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (52,'20180413160026','一线','charge_item',1,'consumption','0000000000000001',':5AD0639700010198247A:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (53,'20180413160026','一线','charge_item',1,'consumption','0000000000000001',':5AD0639700010198247F:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (54,'20180413160028','一线','charge_item',1,'consumption','0000000000000001',':5AD0639700010198247E:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (55,'20180413160033','一线','charge_item',1,'consumption','0000000000000001',':5AD06397000101982483:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (56,'20180413160034','一线','charge_item',1,'consumption','0000000000000001',':5AD06397000101982484:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (57,'20180413160035','一线','charge_item',1,'consumption','0000000000000001',':5AD06397000101982485:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (58,'20180413160036','一线','charge_item',1,'consumption','0000000000000001',':5AD06397000101982481:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (59,'20180413160036','一线','charge_item',1,'consumption','0000000000000001',':5AD06397000101982482:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (60,'20180413160056','一线','charge_item',1,'apply','0000000000000002',':5AD063B0000101982491:','喇叭','大坝坝对自己使用了喇叭，剩余次数：5');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (61,'20180413160131','一线','charge_item',1,'apply','0000000000000001',':5AD063D8000101982494:','喇叭','西风对自己使用了喇叭，剩余次数：5');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (62,'20180413160200','一线','charge_item',1,'apply','0000000000000002',':5AD063B0000101982491:','喇叭','大坝坝对自己使用了喇叭，剩余次数：4');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (63,'20180413160205','一线','charge_item',1,'apply','0000000000000001',':5AD063D8000101982494:','喇叭','西风对自己使用了喇叭，剩余次数：4');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (64,'20180413160353','一线','charge_item',1,'consumption','0000000000000001',':5AD0646400010198249C:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (65,'20180413160354','一线','charge_item',1,'consumption','0000000000000001',':5AD0646500010198249E:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (66,'20180413160355','一线','charge_item',1,'consumption','0000000000000001',':5AD064650001019824A0:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (67,'20180413160356','一线','charge_item',1,'consumption','0000000000000001',':5AD064660001019824A2:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (68,'20180413160359','一线','charge_item',1,'apply','0000000000000001',':5AD063D8000101982494:','喇叭','西风对自己使用了喇叭，剩余次数：3');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (69,'20180413160408','一线','charge_item',1,'apply','0000000000000001',':5AD063D8000101982494:','喇叭','西风对自己使用了喇叭，剩余次数：2');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (70,'20180413160415','一线','charge_item',1,'apply','0000000000000002',':5AD063B0000101982491:','喇叭','大坝坝对自己使用了喇叭，剩余次数：3');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (71,'20180413160427','一线','charge_item',1,'apply','0000000000000001',':5AD063D8000101982494:','喇叭','西风对自己使用了喇叭，剩余次数：1');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (72,'20180413160429','一线','charge_item',1,'consumption','0000000000000001',':5AD0648A0001019824A4:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (73,'20180413160541','一线','charge_item',1,'apply','0000000000000002',':5AD063B0000101982491:','喇叭','大坝坝对自己使用了喇叭，剩余次数：2');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (74,'20180413160546','一线','charge_item',1,'consumption','0000000000000001',':5AD063D8000101982494:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (75,'20180413160549','一线','charge_item',1,'consumption','0000000000000001',':5AD0639700010198247B:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (76,'20180413160550','一线','charge_item',1,'consumption','0000000000000001',':5AD0639700010198247C:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (77,'20180413160551','一线','charge_item',1,'apply','0000000000000002',':5AD063B0000101982491:','喇叭','大坝坝对自己使用了喇叭，剩余次数：1');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (78,'20180413160552','一线','charge_item',1,'consumption','0000000000000001',':5AD0639700010198247D:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (79,'20180413160611','一线','charge_item',1,'apply','0000000000000001',':5AD064F10001019824AD:','喇叭','西风对自己使用了喇叭，剩余次数：5');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (80,'20180413160614','一线','charge_item',1,'apply','0000000000000001',':5AD064F10001019824AD:','喇叭','西风对自己使用了喇叭，剩余次数：4');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (81,'20180413160618','一线','charge_item',1,'consumption','0000000000000002',':5AD063B0000101982491:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (82,'20180413160725','一线','charge_item',1,'consumption','0000000000000002',':5AD065340001019824B1:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (83,'20180413160727','一线','charge_item',1,'consumption','0000000000000002',':5AD065390001019824B5:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (84,'20180413160728','一线','charge_item',1,'consumption','0000000000000002',':5AD065370001019824B3:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (85,'20180413160738','一线','charge_item',1,'consumption','0000000000000002',':5AD065320001019824AF:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (86,'20180413160739','一线','charge_item',1,'consumption','0000000000000002',':5AD065440001019824B7:','','');
INSERT INTO `common_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (87,'20180413160740','一线','charge_item',1,'consumption','0000000000000002',':5AD065460001019824B9:','','');
/*!40000 ALTER TABLE `common_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cost_coin_log`
--

DROP TABLE IF EXISTS `cost_coin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cost_coin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(64) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `cost_type` varchar(32) NOT NULL DEFAULT '',
  `cost` int(11) NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `item_name` varchar(32) NOT NULL DEFAULT '',
  `amount` int(11) NOT NULL DEFAULT '0',
  `uid` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(64) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cost_coin_log`
--

LOCK TABLES `cost_coin_log` WRITE;
/*!40000 ALTER TABLE `cost_coin_log` DISABLE KEYS */;
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180413155716','一线','onlinemall','buy_item','gold_coin',2800,'stanwind','0000000000000001','会员卡',1,'5AD062DC00010198243E','','','','0000000000000001 20180413155716 price: 2800, barcode: T00000001, total_cost: 2800, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (2,'20180413155904','一线','onlinemall','buy_item','gold_coin',566000,'test','0000000000000002','360天年费会员卡',1,'5AD06348000101982440','','','','0000000000000002 20180413155904 price: 566000, barcode: G00000049, total_cost: 566000, level = 3');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (3,'20180413155923','一线','onlinemall','buy_item','gold_coin',800000,'test','0000000000000002','锦囊',40,'5AD0635B000101982442','','','','0000000000000002 20180413155923 price: 20000, barcode: G00000023, total_cost: 800000, level = 3');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (4,'20180413160007','一线','onlinemall','buy_item','gold_coin',100000,'stanwind','0000000000000001','北极熊',1,'5AD06387000101982477','','','','0000000000000001 20180413160007 price: 100000, barcode: F00000055, total_cost: 100000, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (5,'20180413160023','一线','onlinemall','buy_item','gold_coin',240000,'stanwind','0000000000000001','锦囊',12,'5AD06397000101982479','','','','0000000000000001 20180413160023 price: 20000, barcode: G00000023, total_cost: 240000, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (6,'20180413160048','一线','onlinemall','buy_item','gold_coin',5000,'test','0000000000000002','喇叭',1,'5AD063B0000101982490','','','','0000000000000002 20180413160048 price: 5000, barcode: G00000029, total_cost: 5000, level = 5');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (7,'20180413160128','一线','onlinemall','buy_item','gold_coin',5000,'stanwind','0000000000000001','喇叭',1,'5AD063D8000101982493','','','','0000000000000001 20180413160128 price: 5000, barcode: G00000029, total_cost: 5000, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (8,'20180413160337','一线','onlinemall','buy_item','gold_coin',328,'test','0000000000000002','特级八卦阴阳令',1,'5AD06459000101982499','','','','0000000000000002 20180413160337 price: 328, barcode: G00000028, total_cost: 328, level = 13');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (9,'20180413160348','一线','onlinemall','buy_item','gold_coin',8000,'stanwind','0000000000000001','高级道具套餐卡',1,'5AD0646400010198249B','','','','0000000000000001 20180413160348 price: 8000, barcode: G00000001, total_cost: 8000, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (10,'20180413160349','一线','onlinemall','buy_item','gold_coin',8000,'stanwind','0000000000000001','高级道具套餐卡',1,'5AD0646500010198249D','','','','0000000000000001 20180413160349 price: 8000, barcode: G00000001, total_cost: 8000, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (11,'20180413160349','一线','onlinemall','buy_item','gold_coin',8000,'stanwind','0000000000000001','高级道具套餐卡',1,'5AD0646500010198249F','','','','0000000000000001 20180413160349 price: 8000, barcode: G00000001, total_cost: 8000, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (12,'20180413160350','一线','onlinemall','buy_item','gold_coin',8000,'stanwind','0000000000000001','高级道具套餐卡',1,'5AD064660001019824A1','','','','0000000000000001 20180413160350 price: 8000, barcode: G00000001, total_cost: 8000, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (13,'20180413160426','一线','onlinemall','buy_item','gold_coin',566000,'stanwind','0000000000000001','360天年费会员卡',1,'5AD0648A0001019824A3','','','','0000000000000001 20180413160426 price: 566000, barcode: G00000049, total_cost: 566000, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (14,'20180413160609','一线','onlinemall','buy_item','gold_coin',8000,'stanwind','0000000000000001','喇叭',1,'5AD064F10001019824AC','','','','0000000000000001 20180413160609 price: 8000, barcode: T00000013, total_cost: 8000, level = 1');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (15,'20180413160714','一线','onlinemall','buy_item','gold_coin',800,'test','0000000000000002','高级血池',1,'5AD065320001019824AE','','','','0000000000000002 20180413160714 price: 800, barcode: L00000017, total_cost: 800, level = 16');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (16,'20180413160716','一线','onlinemall','buy_item','gold_coin',2400,'test','0000000000000002','高级灵池',1,'5AD065340001019824B0','','','','0000000000000002 20180413160716 price: 2400, barcode: L00000018, total_cost: 2400, level = 16');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (17,'20180413160719','一线','onlinemall','buy_item','gold_coin',800,'test','0000000000000002','高级血池',1,'5AD065370001019824B2','','','','0000000000000002 20180413160719 price: 800, barcode: L00000017, total_cost: 800, level = 16');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (18,'20180413160721','一线','onlinemall','buy_item','gold_coin',2400,'test','0000000000000002','高级灵池',1,'5AD065390001019824B4','','','','0000000000000002 20180413160721 price: 2400, barcode: L00000018, total_cost: 2400, level = 16');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (19,'20180413160732','一线','onlinemall','buy_item','gold_coin',800,'test','0000000000000002','高级血池',1,'5AD065440001019824B6','','','','0000000000000002 20180413160732 price: 800, barcode: L00000017, total_cost: 800, level = 16');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (20,'20180413160734','一线','onlinemall','buy_item','gold_coin',2400,'test','0000000000000002','高级灵池',1,'5AD065460001019824B8','','','','0000000000000002 20180413160734 price: 2400, barcode: L00000018, total_cost: 2400, level = 16');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (21,'20180413160906','一线','onlinemall','buy_item','gold_coin',5000,'test','0000000000000002','喇叭',1,'5AD065A20001019824BB','','','','0000000000000002 20180413160906 price: 5000, barcode: G00000029, total_cost: 5000, level = 16');
INSERT INTO `cost_coin_log` (`id`, `update_time`, `server`, `type`, `action`, `cost_type`, `cost`, `account`, `gid`, `item_name`, `amount`, `uid`, `para1`, `para2`, `para3`, `memo`) VALUES (22,'20180413160907','一线','onlinemall','buy_item','gold_coin',5000,'test','0000000000000002','喇叭',1,'5AD065A30001019824BD','','','','0000000000000002 20180413160907 price: 5000, barcode: G00000029, total_cost: 5000, level = 16');
/*!40000 ALTER TABLE `cost_coin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csc_combat_log`
--

DROP TABLE IF EXISTS `csc_combat_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csc_combat_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `mac` char(16) NOT NULL DEFAULT '',
  `ip` char(15) NOT NULL DEFAULT '',
  `insider` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `lv` int(11) NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `g_coin` int(11) NOT NULL DEFAULT '0',
  `s_coin` int(11) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  `result` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` int(11) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `para4` varchar(128) NOT NULL DEFAULT '',
  `para5` varchar(128) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `server_account` (`server`,`account`) USING BTREE,
  KEY `server_gid` (`server`,`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csc_combat_log`
--

LOCK TABLES `csc_combat_log` WRITE;
/*!40000 ALTER TABLE `csc_combat_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `csc_combat_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csl_combat_log`
--

DROP TABLE IF EXISTS `csl_combat_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csl_combat_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `mac` varchar(15) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `lv` int(11) NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `league_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `season_id` tinyint(11) unsigned NOT NULL DEFAULT '0',
  `stage_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `round_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `matchday_id` tinyint(4) NOT NULL DEFAULT '0',
  `match_id` varchar(32) NOT NULL DEFAULT '',
  `level_section` varchar(15) NOT NULL DEFAULT '',
  `result` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  `score_left` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `combat_index` (`league_id`,`season_id`,`stage_id`,`round_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csl_combat_log`
--

LOCK TABLES `csl_combat_log` WRITE;
/*!40000 ALTER TABLE `csl_combat_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `csl_combat_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csl_match_log`
--

DROP TABLE IF EXISTS `csl_match_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csl_match_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `home_dist` varchar(32) NOT NULL DEFAULT '',
  `away_dist` varchar(32) NOT NULL DEFAULT '',
  `league_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `season_id` int(11) unsigned NOT NULL DEFAULT '0',
  `stage_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `round_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `matchday_id` tinyint(4) NOT NULL DEFAULT '0',
  `result` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `home_score` int(11) NOT NULL DEFAULT '0',
  `away_score` int(11) NOT NULL DEFAULT '0',
  `home_gid_num` int(11) NOT NULL DEFAULT '0',
  `away_gid_num` int(11) NOT NULL DEFAULT '0',
  `home_avg_lv` int(11) NOT NULL DEFAULT '0',
  `away_avg_lv` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `combat_index` (`league_id`,`season_id`,`stage_id`,`round_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csl_match_log`
--

LOCK TABLES `csl_match_log` WRITE;
/*!40000 ALTER TABLE `csl_match_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `csl_match_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csp_combat_log`
--

DROP TABLE IF EXISTS `csp_combat_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csp_combat_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `mac` varchar(15) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `lv` int(11) NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `league_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `season_id` tinyint(11) unsigned NOT NULL DEFAULT '0',
  `round_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `matchday_id` tinyint(4) NOT NULL DEFAULT '0',
  `match_id` varchar(32) NOT NULL DEFAULT '',
  `party_id` varchar(32) NOT NULL DEFAULT '',
  `result` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `party_contrib` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `combat_index` (`league_id`,`season_id`,`round_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csp_combat_log`
--

LOCK TABLES `csp_combat_log` WRITE;
/*!40000 ALTER TABLE `csp_combat_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `csp_combat_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csp_match_log`
--

DROP TABLE IF EXISTS `csp_match_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csp_match_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `home_dist` varchar(32) NOT NULL DEFAULT '',
  `away_dist` varchar(32) NOT NULL DEFAULT '',
  `league_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `season_id` int(11) unsigned NOT NULL DEFAULT '0',
  `round_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `matchday_id` tinyint(4) NOT NULL DEFAULT '0',
  `result` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `home_party_name` varchar(32) NOT NULL DEFAULT '0',
  `away_party_name` varchar(32) NOT NULL DEFAULT '0',
  `home_gid_num` int(11) NOT NULL DEFAULT '0',
  `away_gid_num` int(11) NOT NULL DEFAULT '0',
  `home_avg_lv` int(11) NOT NULL DEFAULT '0',
  `away_avg_lv` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `combat_index` (`league_id`,`season_id`,`round_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csp_match_log`
--

LOCK TABLES `csp_match_log` WRITE;
/*!40000 ALTER TABLE `csp_match_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `csp_match_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debug_log`
--

DROP TABLE IF EXISTS `debug_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debug_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(32) DEFAULT '',
  `para3` varchar(128) DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `type_action` (`type`,`action`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debug_log`
--

LOCK TABLES `debug_log` WRITE;
/*!40000 ALTER TABLE `debug_log` DISABLE KEYS */;
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180305175852','ccs_daili','CCS_PASSPOD_D','update_blank_orders','0','','','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (2,'20180305175937','一线','活动','帮战','debug','forward_schedule_status','enable_war_a','current_time: 2018-03-05-17:59:37 next_ti: 2018-03-12-00:00:00');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (3,'20180305175939','一线','task_stat','double_by_ip','get_time','一线','-1','({({1217520000,1217692800,}),({1218124800,1218297600,}),({1218729600,1218902400,}),({1219296600,1219296720,}),({1219296780,1219296900,}),({1219296960,1219297020,}),})');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (4,'20180305180021','一线','GAME_CFG_D','prepare_for_this_week','一线','2018-03-05-18:00:21','2018-03-12-00:00:00','({({1251288000,7200,604800,2147483647,([\"max_level\":129,\"min_level\":1,]),0,-1,}),({1229083200,7200,604800,2147483647,([]),0,-1,}),({1229148000,7200,604800,2147483647,([]),0,-1,}),({1229169600,7200,604800,2147483647,([\"max_level\":129,\"min_level\":1,]),0,-1,}),({1229234400,7200,604800,2147483647,([\"max_level\":99,\"min_level\":1,]),0,-1,}),})');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (5,'20180305180021','一线','treasureboxd','prepare','1520661600','1520668800','一线','2325;2326');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (6,'20180305180139','一线','lottery_ticket','fail','','','2018-03-05-18:01:39','V');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (7,'20180305180140','一线','lottery_ticket_ns','fail','','','2018-03-05-18:01:40','V');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (8,'20180305180248','一线','elixir_ns','fail','','','2018-03-05-18:02:48','V');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (9,'20180305180250','一线','gs_party_anni','gs_to_ccs','','2018-03-05-18:02:50','1','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (10,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','1','一线','([\"amount\":1,\"type\":8,\"level\":60,\"iid\"::5A9D15CE000101518D79:,\"prop\":([\"earth\":5,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":1,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (11,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','2','一线','([\"amount\":1,\"type\":8,\"level\":70,\"iid\"::5A9D15CE000101518D7C:,\"prop\":([\"accurate\":40,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":1,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (12,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','3','一线','([\"amount\":1,\"type\":8,\"level\":80,\"iid\"::5A9D15CE000101518D7F:,\"prop\":([\"resist_poison\":20,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":3,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (13,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','4','一线','([\"amount\":1,\"type\":8,\"level\":90,\"iid\"::5A9D15CE000101518D82:,\"prop\":([\"counter_attack_rate\":30,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":1,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (14,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','5','一线','([\"amount\":1,\"type\":8,\"level\":100,\"iid\"::5A9D15CE000101518D85:,\"prop\":([\"str\":25,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":1,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (15,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','7','一线','([\"amount\":1,\"type\":8,\"level\":120,\"iid\"::5A9D15CE000101518D8B:,\"prop\":([\"water\":5,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":1,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (16,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','6','一线','([\"amount\":1,\"type\":8,\"level\":110,\"iid\"::5A9D15CE000101518D88:,\"prop\":([\"str\":27,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":2,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (17,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','8','一线','([\"amount\":1,\"type\":8,\"level\":130,\"iid\"::5A9D15CE000101518D8E:,\"prop\":([\"def\":1000,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":10,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (18,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','9','一线','([\"amount\":1,\"type\":8,\"level\":140,\"iid\"::5A9D15CE000101518D91:,\"prop\":([\"all_skill\":10,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":1,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (19,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','10','一线','([\"amount\":1,\"type\":8,\"level\":150,\"iid\"::5A9D15CE000101518D94:,\"prop\":([\"water\":5,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":1,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (20,'20180305180254','一线','vendue','start_sys_vendue','黑水晶','11','一线','([\"amount\":1,\"type\":8,\"level\":160,\"iid\"::5A9D15CE000101518D97:,\"prop\":([\"counter_attack\":10,]),\"repair_ver\":36,\"imp_item\":0,\"upgrade_type\":2,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (21,'20180305183011','一线','SHOP','stat_half_an_hour','一线','20180305183011','','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (22,'20180305190011','一线','SHOP','stat_half_an_hour','一线','20180305190011','','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (23,'20180305190011','一线','SHOP','save_data','一线','20180305190011','','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (24,'20180413143923','ccs_daili','CCS_PASSPOD_D','update_blank_orders','0','','','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (25,'20180413152613','一线','pet','repair_pet_func10','',':5A9D150800010151784D:','青衣仙子','([\"life\":13202,\"own_ti\":1520243976,\"penetrate\":0,\"def_effect\":-4,\"type\":32768,\"phy_effect\":-46,\"exp_to_next_level\":877697,\"longevity\":13060,\"master\":V,\"ignore_def\":12,\"con\":127,\"str\":95,\"wiz\":90,\"pet_life_shape\":60,\"dex\":186,\"def\":4731,\"phy_absorb\":-15,\"repair_ver\":9,\"init\":([\"dex\":186,\"con\":127,\"str\":95,\"wiz\":90,]),\"phy_power\":969,\"basic_effect\":([\"speed\":18,\"life\":20,\"mana\":38,\"mag\":20,\"phy\":-46,]),\"mag_power\":2541,\"org_owner\":V,\"attack_eff\":-2,\"pet_mana_shape\":78,\"init_level\":75,\"dunwu_left_times\":7,\"shape\":250,\"top_data\":([\"speed\":463,\"def\":4731,\"phy_power\":969,\"mag_power\":2541,]),\"mag_effect\":20,\"resist_confusion\":30,\"mag_absorb\":-15,\"iid\"::5A9D150800010151784D:,\"rank\":1,\"resist_point\":45,\"speed\":463,\"mana\":6390,\"boss_monster\":1,\"name\":\"青衣仙子\",\"accurate\":0,\"dunwu_total_times\":7,\"pet_mag_shape\":60,\"attrib_point\":0,\"level\":75,\"life_effect\":20,\"pet_phy_shape\":-6,\"max_life\":13202,\"exp\":0,\"pet_speed_shape\":58,\"max_mana\":6390,\"imp_item\":0,\"mana_effect\":38,\"speed_effect\":18,\"loyalty\":100,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (26,'20180413152614','一线','pet','repair_pet_func10','',':5A9D1508000101517850:','白衣仙子','([\"life\":14805,\"own_ti\":1520243976,\"penetrate\":0,\"def_effect\":-7,\"type\":32768,\"phy_effect\":44,\"exp_to_next_level\":877697,\"longevity\":13449,\"master\":V,\"ignore_def\":12,\"con\":115,\"str\":133,\"wiz\":97,\"pet_life_shape\":77,\"dex\":171,\"def\":4827,\"phy_absorb\":-15,\"repair_ver\":9,\"init\":([\"dex\":171,\"con\":115,\"str\":133,\"wiz\":97,]),\"phy_power\":3443,\"basic_effect\":([\"speed\":16,\"life\":37,\"mana\":-1,\"mag\":-47,\"phy\":44,]),\"mag_power\":1244,\"org_owner\":V,\"attack_eff\":-6,\"pet_mana_shape\":39,\"init_level\":75,\"dunwu_left_times\":7,\"shape\":249,\"top_data\":([\"speed\":421,\"def\":4827,\"phy_power\":3443,\"mag_power\":1244,]),\"mag_effect\":-47,\"mag_absorb\":-15,\"iid\"::5A9D1508000101517850:,\"rank\":1,\"resist_point\":45,\"speed\":421,\"mana\":4665,\"boss_monster\":1,\"name\":\"白衣仙子\",\"accurate\":0,\"dunwu_total_times\":7,\"pet_mag_shape\":-7,\"attrib_point\":0,\"level\":75,\"life_effect\":37,\"resist_frozen\":30,\"pet_phy_shape\":84,\"max_life\":14805,\"exp\":0,\"pet_speed_shape\":56,\"max_mana\":4665,\"imp_item\":0,\"mana_effect\":-1,\"speed_effect\":16,\"loyalty\":100,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (27,'20180413152614','一线','pet','repair_pet_func10','',':5A9D150800010151789C:','红衣仙子','([\"life\":12890,\"own_ti\":1520243976,\"penetrate\":0,\"def_effect\":-8,\"type\":32768,\"phy_effect\":-45,\"exp_to_next_level\":877697,\"longevity\":10640,\"master\":V,\"ignore_def\":12,\"con\":111,\"resist_forgotten\":30,\"str\":139,\"wiz\":107,\"pet_life_shape\":60,\"dex\":123,\"def\":4651,\"phy_absorb\":-15,\"repair_ver\":9,\"init\":([\"dex\":123,\"con\":111,\"str\":139,\"wiz\":107,]),\"phy_power\":1413,\"basic_effect\":([\"speed\":15,\"life\":20,\"mana\":36,\"mag\":19,\"phy\":-45,]),\"mag_power\":2984,\"org_owner\":V,\"attack_eff\":-3,\"pet_mana_shape\":76,\"init_level\":75,\"dunwu_left_times\":7,\"shape\":245,\"top_data\":([\"speed\":310,\"def\":4651,\"phy_power\":1413,\"mag_power\":2984,]),\"mag_effect\":19,\"mag_absorb\":-15,\"iid\"::5A9D150800010151789C:,\"rank\":1,\"resist_point\":45,\"speed\":310,\"mana\":6568,\"boss_monster\":1,\"name\":\"红衣仙子\",\"accurate\":0,\"dunwu_total_times\":7,\"pet_mag_shape\":59,\"attrib_point\":0,\"level\":75,\"life_effect\":20,\"pet_phy_shape\":-5,\"max_life\":12890,\"exp\":0,\"pet_speed_shape\":55,\"max_mana\":6568,\"imp_item\":0,\"mana_effect\":36,\"speed_effect\":15,\"loyalty\":100,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (28,'20180413152614','一线','pet','repair_pet_func10','',':5A9D150800010151789F:','黄衣仙子','([\"life\":14619,\"own_ti\":1520243976,\"penetrate\":0,\"def_effect\":0,\"type\":32768,\"phy_effect\":-43,\"exp_to_next_level\":877697,\"longevity\":12588,\"master\":V,\"ignore_def\":12,\"con\":142,\"str\":145,\"resist_poison\":30,\"wiz\":111,\"pet_life_shape\":70,\"dex\":142,\"def\":4898,\"phy_absorb\":-15,\"repair_ver\":9,\"init\":([\"dex\":142,\"con\":142,\"str\":145,\"wiz\":111,]),\"phy_power\":1522,\"basic_effect\":([\"speed\":20,\"life\":30,\"mana\":34,\"mag\":18,\"phy\":-43,]),\"mag_power\":3068,\"org_owner\":V,\"attack_eff\":-7,\"pet_mana_shape\":74,\"init_level\":75,\"dunwu_left_times\":7,\"shape\":259,\"top_data\":([\"speed\":368,\"def\":4898,\"phy_power\":1522,\"mag_power\":3068,]),\"mag_effect\":18,\"mag_absorb\":-15,\"iid\"::5A9D150800010151789F:,\"rank\":1,\"resist_point\":45,\"speed\":368,\"mana\":6535,\"boss_monster\":1,\"name\":\"黄衣仙子\",\"accurate\":0,\"dunwu_total_times\":7,\"pet_mag_shape\":58,\"attrib_point\":0,\"level\":75,\"life_effect\":30,\"pet_phy_shape\":-3,\"max_life\":14619,\"exp\":0,\"pet_speed_shape\":60,\"max_mana\":6535,\"imp_item\":0,\"mana_effect\":34,\"speed_effect\":20,\"loyalty\":100,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (29,'20180413152614','一线','活动','帮战','debug','forward_schedule_status','enable_war_a','current_time: 2018-04-13-15:26:14 next_ti: 2018-04-13-15:26:14');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (30,'20180413152614','一线','活动','帮战','debug','forward_schedule_status','forward_schedule_status','cur_time: 2018-04-13-15:26:14 cur_status: wait_next_war\nnext_time: 2018-04-13-15:26:14 next_status: biding\n');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (31,'20180413152614','一线','活动','帮战','debug','forward_schedule_status','forward_schedule_status','cur_time: 2018-04-13-15:26:14 cur_status: biding\nnext_time: 2018-04-16-00:00:00 next_status: wait_next_war\n');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (32,'20180413152616','一线','task_stat','double_by_ip','get_time','一线','-1','({({1217520000,1217692800,}),({1218124800,1218297600,}),({1218729600,1218902400,}),({1219296600,1219296720,}),({1219296780,1219296900,}),({1219296960,1219297020,}),})');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (33,'20180413152640','一线','GAME_CFG_D','prepare_for_this_week','一线','2018-04-13-15:26:40','2018-04-16-00:00:00','({({1251288000,7200,604800,2147483647,([\"max_level\":129,\"min_level\":1,]),0,-1,}),({1229083200,7200,604800,2147483647,([]),0,-1,}),({1229148000,7200,604800,2147483647,([]),0,-1,}),({1229169600,7200,604800,2147483647,([\"max_level\":129,\"min_level\":1,]),0,-1,}),({1229234400,7200,604800,2147483647,([\"max_level\":99,\"min_level\":1,]),0,-1,}),})');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (34,'20180413152640','一线','treasureboxd','prepare','1523685600','1523692800','一线','2325;2326');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (35,'20180413152723','一线','lottery_ticket','fail','','','2018-04-13-15:27:23','V');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (36,'20180413152723','一线','lottery_ticket_ns','fail','','','2018-04-13-15:27:23','V');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (37,'20180413152756','一线','elixir_ns','fail','','','2018-04-13-15:27:56','V');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (38,'20180413152758','一线','gs_party_anni','gs_to_ccs','','2018-04-13-15:27:58','1','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (39,'20180413154751','ccs_daili','CCS_PASSPOD_D','update_blank_orders','0','','','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (40,'20180413154807','一线','pet','repair_pet_func10','',':5A9D150800010151784D:','青衣仙子','([\"life\":13202,\"own_ti\":1520243976,\"penetrate\":0,\"def_effect\":-4,\"type\":32768,\"phy_effect\":-46,\"exp_to_next_level\":877697,\"longevity\":13060,\"master\":V,\"ignore_def\":12,\"con\":127,\"str\":95,\"wiz\":90,\"pet_life_shape\":60,\"dex\":186,\"def\":4731,\"phy_absorb\":-15,\"repair_ver\":9,\"init\":([\"dex\":186,\"con\":127,\"str\":95,\"wiz\":90,]),\"phy_power\":969,\"basic_effect\":([\"speed\":18,\"life\":20,\"mana\":38,\"mag\":20,\"phy\":-46,]),\"mag_power\":2541,\"org_owner\":V,\"attack_eff\":-2,\"pet_mana_shape\":78,\"init_level\":75,\"dunwu_left_times\":7,\"shape\":250,\"top_data\":([\"speed\":463,\"def\":4731,\"phy_power\":969,\"mag_power\":2541,]),\"mag_effect\":20,\"resist_confusion\":30,\"mag_absorb\":-15,\"iid\"::5A9D150800010151784D:,\"rank\":1,\"resist_point\":45,\"speed\":463,\"mana\":6390,\"boss_monster\":1,\"name\":\"青衣仙子\",\"accurate\":0,\"dunwu_total_times\":7,\"pet_mag_shape\":60,\"attrib_point\":0,\"level\":75,\"life_effect\":20,\"pet_phy_shape\":-6,\"max_life\":13202,\"exp\":0,\"pet_speed_shape\":58,\"max_mana\":6390,\"imp_item\":0,\"mana_effect\":38,\"speed_effect\":18,\"loyalty\":100,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (41,'20180413154808','一线','pet','repair_pet_func10','',':5A9D1508000101517850:','白衣仙子','([\"life\":14805,\"own_ti\":1520243976,\"penetrate\":0,\"def_effect\":-7,\"type\":32768,\"phy_effect\":44,\"exp_to_next_level\":877697,\"longevity\":13449,\"master\":V,\"ignore_def\":12,\"con\":115,\"str\":133,\"wiz\":97,\"pet_life_shape\":77,\"dex\":171,\"def\":4827,\"phy_absorb\":-15,\"repair_ver\":9,\"init\":([\"dex\":171,\"con\":115,\"str\":133,\"wiz\":97,]),\"phy_power\":3443,\"basic_effect\":([\"speed\":16,\"life\":37,\"mana\":-1,\"mag\":-47,\"phy\":44,]),\"mag_power\":1244,\"org_owner\":V,\"attack_eff\":-6,\"pet_mana_shape\":39,\"init_level\":75,\"dunwu_left_times\":7,\"shape\":249,\"top_data\":([\"speed\":421,\"def\":4827,\"phy_power\":3443,\"mag_power\":1244,]),\"mag_effect\":-47,\"mag_absorb\":-15,\"iid\"::5A9D1508000101517850:,\"rank\":1,\"resist_point\":45,\"speed\":421,\"mana\":4665,\"boss_monster\":1,\"name\":\"白衣仙子\",\"accurate\":0,\"dunwu_total_times\":7,\"pet_mag_shape\":-7,\"attrib_point\":0,\"level\":75,\"life_effect\":37,\"resist_frozen\":30,\"pet_phy_shape\":84,\"max_life\":14805,\"exp\":0,\"pet_speed_shape\":56,\"max_mana\":4665,\"imp_item\":0,\"mana_effect\":-1,\"speed_effect\":16,\"loyalty\":100,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (42,'20180413154808','一线','pet','repair_pet_func10','',':5A9D150800010151789C:','红衣仙子','([\"life\":12890,\"own_ti\":1520243976,\"penetrate\":0,\"def_effect\":-8,\"type\":32768,\"phy_effect\":-45,\"exp_to_next_level\":877697,\"longevity\":10640,\"master\":V,\"ignore_def\":12,\"con\":111,\"resist_forgotten\":30,\"str\":139,\"wiz\":107,\"pet_life_shape\":60,\"dex\":123,\"def\":4651,\"phy_absorb\":-15,\"repair_ver\":9,\"init\":([\"dex\":123,\"con\":111,\"str\":139,\"wiz\":107,]),\"phy_power\":1413,\"basic_effect\":([\"speed\":15,\"life\":20,\"mana\":36,\"mag\":19,\"phy\":-45,]),\"mag_power\":2984,\"org_owner\":V,\"attack_eff\":-3,\"pet_mana_shape\":76,\"init_level\":75,\"dunwu_left_times\":7,\"shape\":245,\"top_data\":([\"speed\":310,\"def\":4651,\"phy_power\":1413,\"mag_power\":2984,]),\"mag_effect\":19,\"mag_absorb\":-15,\"iid\"::5A9D150800010151789C:,\"rank\":1,\"resist_point\":45,\"speed\":310,\"mana\":6568,\"boss_monster\":1,\"name\":\"红衣仙子\",\"accurate\":0,\"dunwu_total_times\":7,\"pet_mag_shape\":59,\"attrib_point\":0,\"level\":75,\"life_effect\":20,\"pet_phy_shape\":-5,\"max_life\":12890,\"exp\":0,\"pet_speed_shape\":55,\"max_mana\":6568,\"imp_item\":0,\"mana_effect\":36,\"speed_effect\":15,\"loyalty\":100,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (43,'20180413154808','一线','pet','repair_pet_func10','',':5A9D150800010151789F:','黄衣仙子','([\"life\":14619,\"own_ti\":1520243976,\"penetrate\":0,\"def_effect\":0,\"type\":32768,\"phy_effect\":-43,\"exp_to_next_level\":877697,\"longevity\":12588,\"master\":V,\"ignore_def\":12,\"con\":142,\"str\":145,\"resist_poison\":30,\"wiz\":111,\"pet_life_shape\":70,\"dex\":142,\"def\":4898,\"phy_absorb\":-15,\"repair_ver\":9,\"init\":([\"dex\":142,\"con\":142,\"str\":145,\"wiz\":111,]),\"phy_power\":1522,\"basic_effect\":([\"speed\":20,\"life\":30,\"mana\":34,\"mag\":18,\"phy\":-43,]),\"mag_power\":3068,\"org_owner\":V,\"attack_eff\":-7,\"pet_mana_shape\":74,\"init_level\":75,\"dunwu_left_times\":7,\"shape\":259,\"top_data\":([\"speed\":368,\"def\":4898,\"phy_power\":1522,\"mag_power\":3068,]),\"mag_effect\":18,\"mag_absorb\":-15,\"iid\"::5A9D150800010151789F:,\"rank\":1,\"resist_point\":45,\"speed\":368,\"mana\":6535,\"boss_monster\":1,\"name\":\"黄衣仙子\",\"accurate\":0,\"dunwu_total_times\":7,\"pet_mag_shape\":58,\"attrib_point\":0,\"level\":75,\"life_effect\":30,\"pet_phy_shape\":-3,\"max_life\":14619,\"exp\":0,\"pet_speed_shape\":60,\"max_mana\":6535,\"imp_item\":0,\"mana_effect\":34,\"speed_effect\":20,\"loyalty\":100,])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (44,'20180413154808','一线','活动','帮战','debug','forward_schedule_status','enable_war_a','current_time: 2018-04-13-15:48:08 next_ti: 2018-04-13-15:48:08');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (45,'20180413154808','一线','活动','帮战','debug','forward_schedule_status','forward_schedule_status','cur_time: 2018-04-13-15:48:08 cur_status: wait_next_war\nnext_time: 2018-04-13-15:48:08 next_status: biding\n');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (46,'20180413154808','一线','活动','帮战','debug','forward_schedule_status','forward_schedule_status','cur_time: 2018-04-13-15:48:08 cur_status: biding\nnext_time: 2018-04-16-00:00:00 next_status: wait_next_war\n');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (47,'20180413154810','一线','task_stat','double_by_ip','get_time','一线','-1','({({1217520000,1217692800,}),({1218124800,1218297600,}),({1218729600,1218902400,}),({1219296600,1219296720,}),({1219296780,1219296900,}),({1219296960,1219297020,}),})');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (48,'20180413154833','一线','GAME_CFG_D','prepare_for_this_week','一线','2018-04-13-15:48:33','2018-04-16-00:00:00','({({1251288000,7200,604800,2147483647,([\"max_level\":129,\"min_level\":1,]),0,-1,}),({1229083200,7200,604800,2147483647,([]),0,-1,}),({1229148000,7200,604800,2147483647,([]),0,-1,}),({1229169600,7200,604800,2147483647,([\"max_level\":129,\"min_level\":1,]),0,-1,}),({1229234400,7200,604800,2147483647,([\"max_level\":99,\"min_level\":1,]),0,-1,}),})');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (49,'20180413154834','一线','treasureboxd','prepare','1523685600','1523692800','一线','2318;2319');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (50,'20180413154916','一线','lottery_ticket','fail','','','2018-04-13-15:49:16','V');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (51,'20180413154917','一线','lottery_ticket_ns','fail','','','2018-04-13-15:49:17','V');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (52,'20180413154949','一线','elixir_ns','fail','','','2018-04-13-15:49:49','V');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (53,'20180413154951','一线','gs_party_anni','gs_to_ccs','','2018-04-13-15:49:51','1','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (54,'20180413155302','一线','user','separate_data','0000000000000001','0','','([\"pets\":([]),\"guards\":([]),\"friends\":([\"5\":([]),\"4\":([]),\"3\":([]),\"2\":([]),\"1\":([]),\"6\":([]),]),\"children\":([]),\"practice_children\":([]),\"practice_pets\":([]),])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (55,'20180413155302','一线','user','separate_carry_data','0000000000000001','0','','([\"carry\":([]),])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (56,'20180413155302','一线','bonus','newbie_gift','0000000000000001',':5AD061DE00010198243C:','新手礼包（10级）','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (57,'20180413155549','一线','user','separate_data','0000000000000002','0','','([\"pets\":([]),\"guards\":([]),\"friends\":([\"5\":([]),\"4\":([]),\"3\":([]),\"2\":([]),\"1\":([]),\"6\":([]),]),\"children\":([]),\"practice_children\":([]),\"practice_pets\":([]),])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (58,'20180413155549','一线','user','separate_carry_data','0000000000000002','0','','([\"carry\":([]),])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (59,'20180413155549','一线','bonus','newbie_gift','0000000000000002',':5AD0628500010198243D:','新手礼包（10级）','');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (60,'20180413155716','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','会员卡','1','time:20180413155716, item_iid:({:5AD062DC00010198243F:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (61,'20180413155716','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','会员卡','1','time:20180413155716, item_iid:({:5AD062DC00010198243F:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (77,'20180413160337','一线','ONLINE_MALL_D','purchase_charge_item','test','特级八卦阴阳令','1','time:20180413160337, item_iid:({:5AD0645900010198249A:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (78,'20180413160337','一线','ONLINE_MALL_D','purchase_charge_item','test','特级八卦阴阳令','1','time:20180413160337, item_iid:({:5AD0645900010198249A:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (79,'20180413160348','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','高级道具套餐卡','1','time:20180413160348, item_iid:({:5AD0646400010198249C:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (80,'20180413160348','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','高级道具套餐卡','1','time:20180413160348, item_iid:({:5AD0646400010198249C:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (81,'20180413160349','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','高级道具套餐卡','1','time:20180413160349, item_iid:({:5AD0646500010198249E:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (82,'20180413160349','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','高级道具套餐卡','1','time:20180413160349, item_iid:({:5AD0646500010198249E:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (83,'20180413160349','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','高级道具套餐卡','1','time:20180413160349, item_iid:({:5AD064650001019824A0:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (84,'20180413160349','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','高级道具套餐卡','1','time:20180413160349, item_iid:({:5AD064650001019824A0:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (85,'20180413160350','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','高级道具套餐卡','1','time:20180413160350, item_iid:({:5AD064660001019824A2:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (86,'20180413160350','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','高级道具套餐卡','1','time:20180413160350, item_iid:({:5AD064660001019824A2:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (87,'20180413160426','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','360天年费会员卡','1','time:20180413160426, item_iid:({:5AD0648A0001019824A4:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (88,'20180413160426','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','360天年费会员卡','1','time:20180413160426, item_iid:({:5AD0648A0001019824A4:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (89,'20180413160553','一线','moodd','use_item','0000000000000001','西风','特殊表情激活包·三天','before_time : 1970-01-01-08:00:00');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (90,'20180413160604','一线','equip','chus_equip','0000000000000002',':5AD063A800010198248D:','布衣','([\"alias\":\"被强化的布衣\",\"own_ti\":1523606440,\"prop_rebuild\":([\"max_life\":100,\"def\":30,]),\"amount\":1,\"type\":8,\"iid\"::5AD063A800010198248D:,\"master\":\"0000000000000002\",\"gift\":1,\"position\":3,\"color\":\"蓝色\",\"repair_ver\":36,\"imp_item\":0,\"org_owner\":\"0000000000000002\",\"rebuild_level\":3,\"extra_desc\":\"已经被卜老板强化过的装备\",])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (91,'20180413160605','一线','equip','chus_equip','0000000000000002',':5AD063A800010198248F:','布带','([\"alias\":\"被强化的布带\",\"own_ti\":1523606440,\"prop_rebuild\":([\"max_life\":100,\"def\":30,]),\"amount\":1,\"type\":8,\"iid\"::5AD063A800010198248F:,\"master\":\"0000000000000002\",\"gift\":1,\"position\":51,\"color\":\"蓝色\",\"repair_ver\":36,\"imp_item\":0,\"org_owner\":\"0000000000000002\",\"rebuild_level\":3,\"extra_desc\":\"已经被卜老板强化过的装备\",])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (92,'20180413160606','一线','equip','chus_equip','0000000000000002',':5AD063A800010198248E:','麻鞋','([\"alias\":\"被强化的麻鞋\",\"own_ti\":1523606440,\"prop_rebuild\":([\"speed\":10,\"def\":30,]),\"amount\":1,\"type\":8,\"iid\"::5AD063A800010198248E:,\"master\":\"0000000000000002\",\"gift\":1,\"position\":10,\"color\":\"蓝色\",\"repair_ver\":36,\"imp_item\":0,\"org_owner\":\"0000000000000002\",\"rebuild_level\":3,\"extra_desc\":\"已经被卜老板强化过的装备\",])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (93,'20180413160607','一线','equip','chus_equip','0000000000000002',':5AD063A800010198248C:','方巾','([\"alias\":\"被强化的方巾\",\"own_ti\":1523606440,\"prop_rebuild\":([\"max_life\":50,\"def\":30,]),\"amount\":1,\"type\":8,\"iid\"::5AD063A800010198248C:,\"master\":\"0000000000000002\",\"gift\":1,\"position\":2,\"color\":\"蓝色\",\"repair_ver\":36,\"imp_item\":0,\"org_owner\":\"0000000000000002\",\"rebuild_level\":3,\"extra_desc\":\"已经被卜老板强化过的装备\",])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (94,'20180413160607','一线','equip','chus_equip','0000000000000002',':5AD063C6000101982492:','长枪','([\"durability\":219,\"alias\":\"被强化的长枪\",\"own_ti\":1523606470,\"prop_rebuild\":([\"phy_power\":48,\"mag_power\":36,]),\"amount\":1,\"type\":8,\"iid\"::5AD063C6000101982492:,\"master\":\"0000000000000002\",\"gift\":1,\"position\":1,\"color\":\"蓝色\",\"repair_ver\":36,\"org_owner\":\"0000000000000002\",\"rebuild_level\":3,\"extra_desc\":\"已经被张老板强化过的装备\",])');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (95,'20180413160609','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','喇叭','1','time:20180413160609, item_iid:({:5AD064F10001019824AD:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (96,'20180413160609','一线','ONLINE_MALL_D','purchase_charge_item','stanwind','喇叭','1','time:20180413160609, item_iid:({:5AD064F10001019824AD:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (97,'20180413160714','一线','ONLINE_MALL_D','purchase_charge_item','test','高级血池','1','time:20180413160714, item_iid:({:5AD065320001019824AF:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (98,'20180413160714','一线','ONLINE_MALL_D','purchase_charge_item','test','高级血池','1','time:20180413160714, item_iid:({:5AD065320001019824AF:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (99,'20180413160716','一线','ONLINE_MALL_D','purchase_charge_item','test','高级灵池','1','time:20180413160716, item_iid:({:5AD065340001019824B1:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (100,'20180413160716','一线','ONLINE_MALL_D','purchase_charge_item','test','高级灵池','1','time:20180413160716, item_iid:({:5AD065340001019824B1:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (101,'20180413160719','一线','ONLINE_MALL_D','purchase_charge_item','test','高级血池','1','time:20180413160719, item_iid:({:5AD065370001019824B3:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (102,'20180413160719','一线','ONLINE_MALL_D','purchase_charge_item','test','高级血池','1','time:20180413160719, item_iid:({:5AD065370001019824B3:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (103,'20180413160721','一线','ONLINE_MALL_D','purchase_charge_item','test','高级灵池','1','time:20180413160721, item_iid:({:5AD065390001019824B5:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (104,'20180413160721','一线','ONLINE_MALL_D','purchase_charge_item','test','高级灵池','1','time:20180413160721, item_iid:({:5AD065390001019824B5:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (105,'20180413160732','一线','ONLINE_MALL_D','purchase_charge_item','test','高级血池','1','time:20180413160732, item_iid:({:5AD065440001019824B7:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (106,'20180413160732','一线','ONLINE_MALL_D','purchase_charge_item','test','高级血池','1','time:20180413160732, item_iid:({:5AD065440001019824B7:,}) (before_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (107,'20180413160734','一线','ONLINE_MALL_D','purchase_charge_item','test','高级灵池','1','time:20180413160734, item_iid:({:5AD065460001019824B9:,}) (after_move)');
INSERT INTO `debug_log` (`id`, `update_time`, `server`, `type`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (108,'20180413160734','一线','ONLINE_MALL_D','purchase_charge_item','test','高级灵池','1','time:20180413160734, item_iid:({:5AD065460001019824B9:,}) (before_move)');
/*!40000 ALTER TABLE `debug_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encourage_detail_log`
--

DROP TABLE IF EXISTS `encourage_detail_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encourage_detail_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dist` varchar(16) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `update_time` char(14) NOT NULL DEFAULT '',
  `encourage_type` varchar(64) NOT NULL DEFAULT '',
  `bonus_name` varchar(32) NOT NULL DEFAULT '',
  `iid` varchar(32) NOT NULL DEFAULT '',
  `encourage_id` int(11) DEFAULT '0',
  `ip` varchar(16) DEFAULT '',
  `para1` varchar(32) DEFAULT '',
  `para2` varchar(255) DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encourage_detail_log`
--

LOCK TABLES `encourage_detail_log` WRITE;
/*!40000 ALTER TABLE `encourage_detail_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `encourage_detail_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment_log`
--

DROP TABLE IF EXISTS `equipment_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `item_name` varchar(32) NOT NULL DEFAULT '',
  `item_iid` varchar(32) DEFAULT '',
  `cost_item_name` varchar(32) DEFAULT '',
  `cost_item_iid` varchar(32) DEFAULT '',
  `cost` int(10) NOT NULL DEFAULT '0',
  `oper_result` tinyint(4) NOT NULL DEFAULT '0',
  `para1` varchar(32) DEFAULT '',
  `para2` varchar(128) DEFAULT '',
  `para3` varchar(255) DEFAULT '',
  `item_prop` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `action` (`action`) USING BTREE,
  KEY `equip_iid` (`item_iid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_log`
--

LOCK TABLES `equipment_log` WRITE;
/*!40000 ALTER TABLE `equipment_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `errand_log`
--

DROP TABLE IF EXISTS `errand_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errand_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `line` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `lv` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `party_gid` varchar(32) NOT NULL DEFAULT '',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `insider` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `para1` int(11) DEFAULT NULL,
  `para2` varchar(32) DEFAULT NULL,
  `para3` varchar(255) DEFAULT NULL,
  `bonus_type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `bonus_name` varchar(32) NOT NULL DEFAULT '0',
  `bonus_prop` varchar(32) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `action` (`action`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errand_log`
--

LOCK TABLES `errand_log` WRITE;
/*!40000 ALTER TABLE `errand_log` DISABLE KEYS */;
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (1,'20180305181834',1,11,'tianq','','',0,'',0,0,0,'','',101,'一线','乾元山','(undefined)');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (2,'20180305190000',1,11,'mietxc','','',0,'',0,0,0,'','',101,'2018-03-05-19:00:00','','(undefined)');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (3,'20180413155720',1,1,'chengjxt','stanwind','0000000000000001',1,'',499997200,13,0,'182.100.43.245','',101,'为了进一线？','1','0000001c42f48da8;2;team_num:1;ip_num:1;mac_num:1;0:1');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (85,'20180413160254',1,1,'chengjxt','test','0000000000000002',12,'',498629000,16,100,'116.208.216.141','',101,'今天，你绑了吗？','1','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;552:553');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (86,'20180413160254',1,2,'xinszy151_10','test','0000000000000002',12,'',498629000,16,100,'116.208.216.141','',8,'2500','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (87,'20180413160254',1,2,'xinszy151_10','test','0000000000000002',12,'',498629000,16,100,'116.208.216.141','',2,'1500','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (88,'20180413160254',1,12,'xinszy151_10','test','0000000000000002',12,'',498629000,16,100,'116.208.216.141','',14,':5AD0642E000101982498:','兔子','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (89,'20180413160324',1,2,'xinszy151_10','test','0000000000000002',13,'',498629000,16,100,'116.208.216.141','',8,'5000','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (90,'20180413160324',1,2,'xinszy151_10','test','0000000000000002',13,'',498629000,16,100,'116.208.216.141','',2,'1500','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (91,'20180413160353',1,1,'chengjxt','stanwind','0000000000000001',1,'',499620200,16,0,'182.100.43.245','',101,'这个更划算','1','0000001c42f48da8;2;team_num:1;ip_num:1;mac_num:1;554:555');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (92,'20180413160429',1,11,'wendnfhy','stanwind','0000000000000001',1,'',499054200,16,0,'182.100.43.245','',1,'360天年费会员卡',':5AD0648A0001019824A4:','0000001c42f48da8;2;team_num:1;ip_num:1;mac_num:1;nf_pre:0,nf_af:1554710669');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (93,'20180413160542',1,2,'xinszy151_10','test','0000000000000002',14,'',498628672,16,100,'116.208.216.141','',8,'5000','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (94,'20180413160542',1,2,'xinszy151_10','test','0000000000000002',14,'',498628672,16,100,'116.208.216.141','',2,'3000','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (95,'20180413160548',1,2,'xinszy151_10','test','0000000000000002',15,'',498628672,16,100,'116.208.216.141','',8,'8000','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (96,'20180413160548',1,2,'xinszy151_10','test','0000000000000002',15,'',498628672,16,100,'116.208.216.141','',2,'4000','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (97,'20180413160549',1,3,'jinn','stanwind','0000000000000001',1,'',499054200,16,0,'182.100.43.245','',1,'梦荷·震位','','0000001c42f48da8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (98,'20180413160550',1,3,'jinn','stanwind','0000000000000001',1,'',499054200,16,0,'182.100.43.245','',1,'特殊表情激活包·三天','','0000001c42f48da8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (99,'20180413160552',1,3,'jinn','stanwind','0000000000000001',1,'',499054200,16,0,'182.100.43.245','',1,'功能卷轴·移花接木','','0000001c42f48da8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (100,'20180413160557',1,12,'xinszy151_10','test','0000000000000002',16,'',498628672,16,100,'116.208.216.141','',1,'布鞋',':5AD064E50001019824A9:','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (101,'20180413160557',1,12,'xinszy151_10','test','0000000000000002',16,'',498628672,16,100,'116.208.216.141','',1,'铁枪',':5AD064E50001019824AA:','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (102,'20180413160557',1,12,'xinszy151_10','test','0000000000000002',16,'',498628672,16,100,'116.208.216.141','',1,'牛皮带',':5AD064E50001019824AB:','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (103,'20180413160557',1,2,'xinszy151_10','test','0000000000000002',16,'',498628672,16,100,'116.208.216.141','',8,'40000','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (104,'20180413160557',1,2,'xinszy151_10','test','0000000000000002',16,'',498628672,16,100,'116.208.216.141','',2,'6000','','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (105,'20180413160557',1,12,'xinszy151_10','test','0000000000000002',16,'',498628672,16,100,'116.208.216.141','',1,'皮帽',':5AD064E50001019824A7:','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (106,'20180413160557',1,12,'xinszy151_10','test','0000000000000002',16,'',498628672,16,100,'116.208.216.141','',1,'虎皮衣',':5AD064E50001019824A8:','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (107,'20180413160725',1,1,'chengjxt','test','0000000000000002',16,'',498622272,16,100,'116.208.216.141','',101,'貌似会很爽','1','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;553:554');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (108,'20180413160725',1,1,'chengjxt','test','0000000000000002',16,'',498622272,16,100,'116.208.216.141','',101,'挂机，能源不竭','5','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;554:559');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (109,'20180413160728',1,1,'chengjxt','test','0000000000000002',16,'',498622272,16,100,'116.208.216.141','',101,'有备无患','1','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;559:560');
INSERT INTO `errand_log` (`id`, `update_time`, `line`, `type`, `action`, `account`, `gid`, `lv`, `party_gid`, `gold_coin`, `insider`, `para1`, `para2`, `para3`, `bonus_type`, `bonus_name`, `bonus_prop`, `memo`) VALUES (110,'20180413160728',1,1,'chengjxt','test','0000000000000002',16,'',498622272,16,100,'116.208.216.141','',101,'挂机，性命无忧','5','0000b8975aaa87f8;2;team_num:1;ip_num:1;mac_num:1;560:565');
/*!40000 ALTER TABLE `errand_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_appraise_log`
--

DROP TABLE IF EXISTS `exchange_appraise_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_appraise_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `exchange_time` char(14) NOT NULL DEFAULT '',
  `account1` varchar(32) NOT NULL DEFAULT '',
  `name1` varchar(32) NOT NULL DEFAULT '',
  `gid1` varchar(32) NOT NULL DEFAULT '',
  `lv1` tinyint(4) NOT NULL DEFAULT '0',
  `tao1` int(11) NOT NULL DEFAULT '0',
  `gold_coin1` int(11) NOT NULL DEFAULT '0',
  `account2` varchar(32) NOT NULL DEFAULT '',
  `name2` varchar(32) NOT NULL DEFAULT '',
  `gid2` varchar(32) NOT NULL DEFAULT '',
  `lv2` tinyint(4) NOT NULL DEFAULT '0',
  `tao2` int(11) NOT NULL DEFAULT '0',
  `gold_coin2` int(11) NOT NULL DEFAULT '0',
  `report` tinyint(4) NOT NULL DEFAULT '0',
  `star` tinyint(4) NOT NULL DEFAULT '0',
  `content` varchar(255) NOT NULL DEFAULT '',
  `phone` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(255) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account1` (`account1`) USING BTREE,
  KEY `account2` (`account2`) USING BTREE,
  KEY `gid1` (`gid1`) USING BTREE,
  KEY `gid2` (`gid2`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_appraise_log`
--

LOCK TABLES `exchange_appraise_log` WRITE;
/*!40000 ALTER TABLE `exchange_appraise_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `exchange_appraise_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gbuy_action_log`
--

DROP TABLE IF EXISTS `gbuy_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gbuy_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `mac` char(16) NOT NULL DEFAULT '',
  `ip` char(15) NOT NULL DEFAULT '',
  `insider` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `lv` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `silver_coin` int(11) NOT NULL DEFAULT '0',
  `gbuy_gcoin` int(11) NOT NULL DEFAULT '0',
  `gbuy_scoin` int(11) NOT NULL DEFAULT '0',
  `action` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `coin_type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `coin` int(11) NOT NULL DEFAULT '0',
  `gbg_id` varchar(32) NOT NULL DEFAULT '',
  `gbg_name` varchar(32) NOT NULL DEFAULT '',
  `gbg_amount` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `gbg_id` (`gbg_id`) USING BTREE,
  KEY `action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gbuy_action_log`
--

LOCK TABLES `gbuy_action_log` WRITE;
/*!40000 ALTER TABLE `gbuy_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `gbuy_action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_log`
--

DROP TABLE IF EXISTS `gift_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '0',
  `gid` varchar(32) NOT NULL DEFAULT '0',
  `lv` int(11) unsigned NOT NULL DEFAULT '0',
  `tao` int(11) unsigned NOT NULL DEFAULT '0',
  `login_ip` varchar(32) NOT NULL DEFAULT '0',
  `mac` varchar(32) NOT NULL DEFAULT '0',
  `item_name` varchar(32) NOT NULL DEFAULT '0',
  `iid` varchar(32) NOT NULL DEFAULT '0',
  `gold_coin` int(11) unsigned NOT NULL DEFAULT '0',
  `insider` varchar(32) NOT NULL DEFAULT '0',
  `para1` varchar(128) NOT NULL DEFAULT '0',
  `para2` varchar(128) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gift_log`
--

LOCK TABLES `gift_log` WRITE;
/*!40000 ALTER TABLE `gift_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `gift_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gm_log`
--

DROP TABLE IF EXISTS `gm_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gm_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lv` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `cash` int(11) NOT NULL DEFAULT '0',
  `mode` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `action` int(11) unsigned NOT NULL DEFAULT '0',
  `operator` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(255) NOT NULL DEFAULT '',
  `para3` varchar(32) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `operator` (`operator`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `action` (`action`) USING BTREE,
  KEY `time_gid` (`update_time`,`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gm_log`
--

LOCK TABLES `gm_log` WRITE;
/*!40000 ALTER TABLE `gm_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `gm_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gs_log`
--

DROP TABLE IF EXISTS `gs_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gs_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT '0',
  `ctime` varchar(32) NOT NULL DEFAULT '',
  `count` int(11) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `server` (`server`) USING BTREE,
  KEY `time` (`time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gs_log`
--

LOCK TABLES `gs_log` WRITE;
/*!40000 ALTER TABLE `gs_log` DISABLE KEYS */;
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (1,'问道一区','问道一区','在线MAC数',1520243947,'20180305175907',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (2,'问道一区','问道一区','在线MAC数',1520244127,'20180305180207',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (3,'问道一区','问道一区','在线MAC数',1520244307,'20180305180507',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (4,'问道一区','问道一区','在线MAC数',1520244487,'20180305180807',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (5,'问道一区','问道一区','在线MAC数',1520244667,'20180305181107',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (6,'问道一区','问道一区','在线MAC数',1520244847,'20180305181407',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (7,'问道一区','问道一区','在线MAC数',1520245027,'20180305181707',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (8,'问道一区','问道一区','在线MAC数',1520245207,'20180305182007',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (9,'问道一区','问道一区','在线MAC数',1520245387,'20180305182307',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (10,'问道一区','问道一区','在线MAC数',1520245567,'20180305182607',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (11,'问道一区','问道一区','在线MAC数',1520245747,'20180305182907',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (12,'问道一区','问道一区','在线MAC数',1520245927,'20180305183207',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (13,'问道一区','问道一区','在线MAC数',1520246107,'20180305183507',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (14,'问道一区','问道一区','在线MAC数',1520246287,'20180305183807',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (15,'问道一区','问道一区','在线MAC数',1520246467,'20180305184107',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (16,'问道一区','问道一区','在线MAC数',1520246647,'20180305184407',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (17,'问道一区','问道一区','在线MAC数',1520246827,'20180305184707',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (18,'问道一区','问道一区','在线MAC数',1520247007,'20180305185007',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (19,'问道一区','问道一区','在线MAC数',1520247187,'20180305185307',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (20,'问道一区','问道一区','在线MAC数',1520247367,'20180305185607',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (21,'问道一区','问道一区','在线MAC数',1520247547,'20180305185907',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (22,'问道一区','问道一区','在线MAC数',1520247727,'20180305190207',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (23,'问道一区','问道一区','在线MAC数',1520247907,'20180305190507',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (24,'问道一区','问道一区','在线MAC数',1520248087,'20180305190807',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (25,'问道一区','问道一区','在线MAC数',1520248267,'20180305191107',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (26,'问道一区','问道一区','在线MAC数',1520248447,'20180305191407',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (27,'问道一区','问道一区','在线MAC数',1520248627,'20180305191707',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (28,'问道一区','问道一区','在线MAC数',1520248807,'20180305192007',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (29,'问道一区','问道一区','在线MAC数',1520248987,'20180305192307',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (30,'问道一区','问道一区','在线MAC数',1523601571,'20180413143931',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (31,'问道一区','问道一区','在线MAC数',1523601751,'20180413144231',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (32,'问道一区','问道一区','在线MAC数',1523601931,'20180413144531',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (33,'问道一区','问道一区','在线MAC数',1523602111,'20180413144831',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (34,'问道一区','问道一区','在线MAC数',1523602291,'20180413145131',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (35,'问道一区','问道一区','在线MAC数',1523602471,'20180413145431',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (36,'问道一区','问道一区','在线MAC数',1523602651,'20180413145731',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (37,'问道一区','问道一区','在线MAC数',1523602831,'20180413150031',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (38,'问道一区','问道一区','在线MAC数',1523603011,'20180413150331',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (39,'问道一区','问道一区','在线MAC数',1523603191,'20180413150631',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (40,'问道一区','问道一区','在线MAC数',1523603371,'20180413150931',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (41,'问道一区','问道一区','在线MAC数',1523603551,'20180413151231',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (42,'问道一区','问道一区','在线MAC数',1523603731,'20180413151531',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (43,'问道一区','问道一区','在线MAC数',1523603911,'20180413151831',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (44,'问道一区','问道一区','在线MAC数',1523604091,'20180413152131',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (45,'问道一区','问道一区','在线MAC数',1523604271,'20180413152431',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (46,'问道一区','问道一区','在线MAC数',1523604451,'20180413152731',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (47,'问道一区','问道一区','在线MAC数',1523604631,'20180413153031',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (48,'问道一区','问道一区','在线MAC数',1523604811,'20180413153331',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (49,'问道一区','问道一区','在线MAC数',1523604991,'20180413153631',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (50,'问道一区','问道一区','在线MAC数',1523605464,'20180413154424',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (51,'问道一区','问道一区','在线MAC数',1523605678,'20180413154758',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (52,'问道一区','问道一区','在线MAC数',1523605858,'20180413155058',0,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (53,'一线','问道一区','在线玩家数',1523606038,'20180413155358',1,'([\"online\":\"1\",\"max_user\":\"1200\",\"cpu_satisfy\":\"100\",\"available\":\"1\",\"cpu_cost\":\"63\",])');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (54,'问道一区','问道一区','在线MAC数',1523606038,'20180413155358',1,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (55,'问道一区','问道一区','在线MAC数',1523606218,'20180413155658',2,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (56,'一线','问道一区','在线玩家数',1523606218,'20180413155658',2,'([\"online\":\"2\",\"max_user\":\"1200\",\"cpu_satisfy\":\"99\",\"available\":\"1\",\"cpu_cost\":\"0\",])');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (57,'问道一区','问道一区','在线MAC数',1523606398,'20180413155958',2,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (58,'一线','问道一区','在线玩家数',1523606398,'20180413155958',2,'([\"online\":\"2\",\"max_user\":\"1200\",\"cpu_satisfy\":\"100\",\"available\":\"1\",\"cpu_cost\":\"0\",])');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (59,'一线','问道一区','在线玩家数',1523606578,'20180413160258',2,'([\"online\":\"2\",\"max_user\":\"1200\",\"cpu_satisfy\":\"100\",\"available\":\"1\",\"cpu_cost\":\"0\",])');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (60,'问道一区','问道一区','在线MAC数',1523606578,'20180413160258',2,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (61,'一线','问道一区','在线玩家数',1523606758,'20180413160558',2,'([\"online\":\"2\",\"max_user\":\"1200\",\"cpu_satisfy\":\"99\",\"available\":\"1\",\"cpu_cost\":\"0\",])');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (62,'问道一区','问道一区','在线MAC数',1523606758,'20180413160558',2,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (63,'问道一区','问道一区','在线MAC数',1523606938,'20180413160858',2,'');
INSERT INTO `gs_log` (`id`, `server`, `dist`, `type`, `time`, `ctime`, `count`, `memo`) VALUES (64,'一线','问道一区','在线玩家数',1523606938,'20180413160858',2,'([\"online\":\"2\",\"max_user\":\"1200\",\"cpu_satisfy\":\"100\",\"available\":\"1\",\"cpu_cost\":\"0\",])');
/*!40000 ALTER TABLE `gs_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_credit_log`
--

DROP TABLE IF EXISTS `history_credit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_credit_log` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `coin` int(11) NOT NULL DEFAULT '0',
  `used` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_credit_log`
--

LOCK TABLES `history_credit_log` WRITE;
/*!40000 ALTER TABLE `history_credit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_credit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `important_action_log`
--

DROP TABLE IF EXISTS `important_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `important_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lv` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `ip` char(15) NOT NULL DEFAULT '',
  `mac` char(32) NOT NULL DEFAULT '',
  `bonus_type` tinyint(4) NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL DEFAULT '0',
  `party_gid` char(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `important_action_log`
--

LOCK TABLES `important_action_log` WRITE;
/*!40000 ALTER TABLE `important_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `important_action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `important_log`
--

DROP TABLE IF EXISTS `important_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `important_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `severity` int(11) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(128) NOT NULL DEFAULT '',
  `para2` varchar(128) NOT NULL DEFAULT '',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type_action` (`type`,`action`) USING BTREE,
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `important_log`
--

LOCK TABLES `important_log` WRITE;
/*!40000 ALTER TABLE `important_log` DISABLE KEYS */;
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180305175852','ccs_daili','ccs_party_anniversary',3,'load_party_index error','','','','([])');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (2,'20180305175908','ccs_daili','ccs',1,'startup','','1.60.0912','','/ccs');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (3,'20180305180306','一线','gs',1,'startup','1','1.60.0912','183.136.204.183:8160','/gs');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (4,'20180413143923','ccs_daili','ccs_party_anniversary',3,'load_party_index error','','','','([])');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (5,'20180413143932','ccs_daili','ccs',1,'startup','','1.60.0912','','/home/centos/wd/ccs');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (6,'20180413152813','一线','gs',1,'startup','1','1.60.0912','118.24.7.124:8160','/home/centos/wd/gs');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (7,'20180413154751','ccs_daili','ccs_party_anniversary',3,'load_party_index error','','','','([])');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (8,'20180413154759','ccs_daili','ccs',1,'startup','','1.60.0912','','/home/centos/wd/ccs');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (9,'20180413155007','一线','gs',1,'startup','1','1.60.0912','118.24.7.124:8160','/home/centos/wd/gs');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (10,'20180413155930','一线','charge_pet',1,'get','0000000000000002',':5AD0636200010198246F:','重明','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606370,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":13603,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":20,\\\"mana\\\":20,\\\"mag\\\":40,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":4,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":40,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":100,\\\"name\\\":\\\"重明\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":100,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":8,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":118,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":118,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD0636200010198246F:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":80,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":20,\\\"mag_effect\\\":40,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (11,'20180413155930','一线','charge_pet',1,'get','0000000000000002',':5AD06362000101982471:','白泽','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":239,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606370,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":20,\\\"longevity\\\":12695,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":65,\\\"phy\\\":20,\\\"speed\\\":20,\\\"mana\\\":-10,\\\"mag\\\":-35,]),\\\"phy_power\\\":112,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":10,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":-35,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":75,\\\"name\\\":\\\"白泽\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":65,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":60,\\\"max_life\\\":239,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":75,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":0,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":105,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":108,\\\"pet_mana_shape\\\":30,\\\"dunwu_left_times\\\":0,\\\"shape\\\":260,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":112,\\\"mag_power\\\":108,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06362000101982471:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":5,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":-10,\\\"mag_effect\\\":-35,\\\"phy_effect\\\":20,\\\"special_skill\\\":([]),\\\"life_effect\\\":65,]),\\\"exp\\\":0,\\\"mana_effect\\\":-10,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (12,'20180413155932','一线','charge_pet',1,'get','0000000000000002',':5AD06364000101982472:','乘黄','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606372,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":13111,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":7,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":6,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06364000101982472:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (13,'20180413155947','一线','charge_pet',1,'drop','0000000000000002',':5AD06364000101982472:','乘黄','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606372,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":13111,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":7,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":6,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06364000101982472:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (14,'20180413155948','一线','charge_pet',1,'drop','0000000000000002',':5AD06362000101982471:','白泽','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":239,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606370,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":20,\\\"longevity\\\":12695,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":65,\\\"phy\\\":20,\\\"speed\\\":20,\\\"mana\\\":-10,\\\"mag\\\":-35,]),\\\"phy_power\\\":112,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":10,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":-35,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":75,\\\"name\\\":\\\"白泽\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":65,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":60,\\\"max_life\\\":239,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":75,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":0,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":105,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":108,\\\"pet_mana_shape\\\":30,\\\"dunwu_left_times\\\":0,\\\"shape\\\":260,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":112,\\\"mag_power\\\":108,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06362000101982471:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":5,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":-10,\\\"mag_effect\\\":-35,\\\"phy_effect\\\":20,\\\"special_skill\\\":([]),\\\"life_effect\\\":65,]),\\\"exp\\\":0,\\\"mana_effect\\\":-10,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (15,'20180413155952','一线','charge_pet',1,'get','0000000000000002',':5AD06378000101982473:','白泽','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":239,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606392,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":20,\\\"longevity\\\":12587,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":65,\\\"phy\\\":20,\\\"speed\\\":20,\\\"mana\\\":-10,\\\"mag\\\":-35,]),\\\"phy_power\\\":112,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":7,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":-35,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":75,\\\"name\\\":\\\"白泽\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":65,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":60,\\\"max_life\\\":239,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":75,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":2,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":105,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":108,\\\"pet_mana_shape\\\":30,\\\"dunwu_left_times\\\":0,\\\"shape\\\":260,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":112,\\\"mag_power\\\":108,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06378000101982473:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":5,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":-10,\\\"mag_effect\\\":-35,\\\"phy_effect\\\":20,\\\"special_skill\\\":([]),\\\"life_effect\\\":65,]),\\\"exp\\\":0,\\\"mana_effect\\\":-10,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (16,'20180413155952','一线','charge_pet',1,'get','0000000000000002',':5AD06378000101982474:','乘黄','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606392,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":10165,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":1,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":8,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06378000101982474:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (17,'20180413155957','一线','charge_pet',1,'drop','0000000000000002',':5AD06378000101982474:','乘黄','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606392,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":10165,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":1,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":8,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06378000101982474:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (18,'20180413155958','一线','charge_pet',1,'drop','0000000000000002',':5AD06378000101982473:','白泽','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":239,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606392,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":20,\\\"longevity\\\":12587,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":65,\\\"phy\\\":20,\\\"speed\\\":20,\\\"mana\\\":-10,\\\"mag\\\":-35,]),\\\"phy_power\\\":112,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":7,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":-35,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":75,\\\"name\\\":\\\"白泽\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":65,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":60,\\\"max_life\\\":239,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":75,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":2,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":105,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":108,\\\"pet_mana_shape\\\":30,\\\"dunwu_left_times\\\":0,\\\"shape\\\":260,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":112,\\\"mag_power\\\":108,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06378000101982473:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":5,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":-10,\\\"mag_effect\\\":-35,\\\"phy_effect\\\":20,\\\"special_skill\\\":([]),\\\"life_effect\\\":65,]),\\\"exp\\\":0,\\\"mana_effect\\\":-10,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (19,'20180413160001','一线','charge_pet',1,'get','0000000000000002',':5AD06381000101982475:','乘黄','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606401,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":12167,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":6,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":1,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06381000101982475:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (20,'20180413160002','一线','charge_pet',1,'get','0000000000000002',':5AD06382000101982476:','伶俐鼠','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606402,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":12263,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":50,\\\"mag\\\":30,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":9,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":30,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":126,\\\"name\\\":\\\"伶俐鼠\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":126,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":7,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":116,\\\"pet_mana_shape\\\":90,\\\"dunwu_left_times\\\":0,\\\"shape\\\":340,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":116,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06382000101982476:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":70,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":50,\\\"mag_effect\\\":30,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":50,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (21,'20180413160007','一线','charge_pet',1,'get','0000000000000001',':5AD06387000101982478:','北极熊','\"([\\\"carry\\\":([]),\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000001\\\",\\\"life\\\":224,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606407,\\\"type\\\":32768,\\\"phy_effect\\\":-38,\\\"resist_wood\\\":0,\\\"longevity\\\":13560,\\\"master\\\":\\\"0000000000000001\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"mount_type\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":55,\\\"phy\\\":-38,\\\"speed\\\":10,\\\"mana\\\":34,\\\"mag\\\":36,]),\\\"phy_power\\\":106,\\\"resist_metal\\\":0,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"org_owner\\\":\\\"0000000000000001\\\",\\\"attack_eff\\\":0,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":36,\\\"resist_lock\\\":0,\\\"rank\\\":2,\\\"resist_point\\\":0,\\\"speed\\\":55,\\\"mana\\\":112,\\\"name\\\":\\\"北极熊\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":55,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":2,\\\"max_life\\\":224,\\\"pet_speed_shape\\\":50,\\\"max_mana\\\":112,\\\"speed_effect\\\":10,\\\"resist_earth\\\":0,\\\"def_effect\\\":3,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":95,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"sub_type\\\":4,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":117,\\\"pet_mana_shape\\\":74,\\\"dunwu_left_times\\\":0,\\\"shape\\\":297,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":55,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":117,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06387000101982478:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":76,\\\"exp\\\":0,\\\"mana_effect\\\":34,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (22,'20180413160033','一线','charge_pet',1,'get','0000000000000001',':5AD063A1000101982488:','乘黄','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000001\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606433,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":12380,\\\"master\\\":\\\"0000000000000001\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000001\\\",\\\"attack_eff\\\":0,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":1,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD063A1000101982488:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (23,'20180413160036','一线','charge_pet',1,'get','0000000000000001',':5AD063A400010198248B:','白泽','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000001\\\",\\\"life\\\":239,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606436,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":20,\\\"longevity\\\":13610,\\\"master\\\":\\\"0000000000000001\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":65,\\\"phy\\\":20,\\\"speed\\\":20,\\\"mana\\\":-10,\\\"mag\\\":-35,]),\\\"phy_power\\\":112,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000001\\\",\\\"attack_eff\\\":6,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":-35,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":75,\\\"name\\\":\\\"白泽\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":65,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":60,\\\"max_life\\\":239,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":75,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":3,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":105,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":108,\\\"pet_mana_shape\\\":30,\\\"dunwu_left_times\\\":0,\\\"shape\\\":260,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":112,\\\"mag_power\\\":108,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD063A400010198248B:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":5,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":-10,\\\"mag_effect\\\":-35,\\\"phy_effect\\\":20,\\\"special_skill\\\":([]),\\\"life_effect\\\":65,]),\\\"exp\\\":0,\\\"mana_effect\\\":-10,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (24,'20180413160046','一线','charge_pet',1,'drop','0000000000000001',':5AD063A400010198248B:','白泽','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000001\\\",\\\"life\\\":239,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606436,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":20,\\\"longevity\\\":13610,\\\"master\\\":\\\"0000000000000001\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":65,\\\"phy\\\":20,\\\"speed\\\":20,\\\"mana\\\":-10,\\\"mag\\\":-35,]),\\\"phy_power\\\":112,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000001\\\",\\\"attack_eff\\\":6,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":-35,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":75,\\\"name\\\":\\\"白泽\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":65,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":60,\\\"max_life\\\":239,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":75,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":3,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":105,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":108,\\\"pet_mana_shape\\\":30,\\\"dunwu_left_times\\\":0,\\\"shape\\\":260,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":112,\\\"mag_power\\\":108,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD063A400010198248B:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":5,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":-10,\\\"mag_effect\\\":-35,\\\"phy_effect\\\":20,\\\"special_skill\\\":([]),\\\"life_effect\\\":65,]),\\\"exp\\\":0,\\\"mana_effect\\\":-10,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (25,'20180413160050','一线','charge_pet',1,'drop','0000000000000001',':5AD063A1000101982488:','乘黄','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000001\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606433,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":12380,\\\"master\\\":\\\"0000000000000001\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000001\\\",\\\"attack_eff\\\":0,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":1,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD063A1000101982488:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `important_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (26,'20180413160251','一线','charge_pet',1,'drop','0000000000000002',':5AD06381000101982475:','乘黄','\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606401,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":12167,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"intimacy\\\":900,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":6,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":1,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06381000101982475:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
/*!40000 ALTER TABLE `important_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `important_pet_log`
--

DROP TABLE IF EXISTS `important_pet_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `important_pet_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `account_from` varchar(32) NOT NULL DEFAULT '',
  `account_to` varchar(32) NOT NULL DEFAULT '',
  `gid_from` char(16) NOT NULL DEFAULT '',
  `gid_to` char(16) NOT NULL DEFAULT '',
  `lv_from` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `lv_to` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `pet_iid` varchar(32) NOT NULL DEFAULT '',
  `pet_name` varchar(32) NOT NULL DEFAULT '',
  `pet_property` text NOT NULL,
  `para1` varchar(255) NOT NULL DEFAULT '',
  `para2` varchar(255) NOT NULL DEFAULT '',
  `para3` int(11) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `account_to` (`account_to`) USING BTREE,
  KEY `gid_to` (`gid_to`) USING BTREE,
  KEY `pet_iid` (`pet_iid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `important_pet_log`
--

LOCK TABLES `important_pet_log` WRITE;
/*!40000 ALTER TABLE `important_pet_log` DISABLE KEYS */;
INSERT INTO `important_pet_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `pet_iid`, `pet_name`, `pet_property`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180413155947',1,2,'yiq','test','0','0000000000000002','0',3,0,':5AD06364000101982472:','乘黄','([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606372,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:40,53:20,47:60,35:3,17:([]),31:20,5:-40,]),90:-15,89:([36:70,22:115,21:106,16:54,]),83:-15,66:([108:-40,107:20,37:20,36:40,2:60,]),54:100,52:40,53:20,51:100,50:80,49:0,48:232,58:0,\"imp_item\":0,45:0,46:0,47:60,44:1,42:4,43:0,41:60,40:0,38:0,39:\"乘黄\",37:100,36:70,34:0,35:3,32:0,33::5AD06364000101982472:,29:0,31:20,28:300,26:([55:0,]),25:1,24:60,23:7,22:115,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:106,17:1,16:54,15:1,14:100,13:0,12:1,11:1,10:0,9:1,8:13111,7:10,5:-40,6:0,3:6,2:232,1:0,]),\"skills_map\":([]),\"skills\":([]),])','','',0,'');
INSERT INTO `important_pet_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `pet_iid`, `pet_name`, `pet_property`, `para1`, `para2`, `para3`, `memo`) VALUES (2,'20180413155948',1,2,'yiq','test','0','0000000000000002','0',3,0,':5AD06362000101982471:','白泽','([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606370,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:20,53:-10,47:65,35:3,17:([]),31:-35,5:20,]),90:-15,89:([36:60,22:108,21:112,16:54,]),83:-15,66:([108:20,107:-35,37:-10,36:20,2:65,]),54:100,52:20,53:-10,51:75,50:60,49:0,48:239,58:0,\"imp_item\":0,45:60,46:0,47:65,44:1,42:4,43:0,41:5,40:0,38:0,39:\"白泽\",37:75,36:60,34:0,35:3,32:0,33::5AD06362000101982471:,29:0,31:-35,28:260,26:([55:0,]),25:1,24:30,23:10,22:108,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:112,17:1,16:54,15:1,14:105,13:0,12:1,11:1,10:0,9:1,8:12695,7:10,5:20,6:0,3:0,2:239,1:0,]),\"skills_map\":([]),\"skills\":([]),])','','',0,'');
INSERT INTO `important_pet_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `pet_iid`, `pet_name`, `pet_property`, `para1`, `para2`, `para3`, `memo`) VALUES (3,'20180413155957',1,2,'yiq','test','0','0000000000000002','0',3,0,':5AD06378000101982474:','乘黄','([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606392,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:40,53:20,47:60,35:3,17:([]),31:20,5:-40,]),90:-15,89:([36:70,22:115,21:106,16:54,]),83:-15,66:([108:-40,107:20,37:20,36:40,2:60,]),54:100,52:40,53:20,51:100,50:80,49:0,48:232,58:0,\"imp_item\":0,45:0,46:0,47:60,44:1,42:4,43:0,41:60,40:0,38:0,39:\"乘黄\",37:100,36:70,34:0,35:3,32:0,33::5AD06378000101982474:,29:0,31:20,28:300,26:([55:0,]),25:1,24:60,23:1,22:115,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:106,17:1,16:54,15:1,14:100,13:0,12:1,11:1,10:0,9:1,8:10165,7:10,5:-40,6:0,3:8,2:232,1:0,]),\"skills_map\":([]),\"skills\":([]),])','','',0,'');
INSERT INTO `important_pet_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `pet_iid`, `pet_name`, `pet_property`, `para1`, `para2`, `para3`, `memo`) VALUES (4,'20180413155958',1,2,'yiq','test','0','0000000000000002','0',3,0,':5AD06378000101982473:','白泽','([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606392,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:20,53:-10,47:65,35:3,17:([]),31:-35,5:20,]),90:-15,89:([36:60,22:108,21:112,16:54,]),83:-15,66:([108:20,107:-35,37:-10,36:20,2:65,]),54:100,52:20,53:-10,51:75,50:60,49:0,48:239,58:0,\"imp_item\":0,45:60,46:0,47:65,44:1,42:4,43:0,41:5,40:0,38:0,39:\"白泽\",37:75,36:60,34:0,35:3,32:0,33::5AD06378000101982473:,29:0,31:-35,28:260,26:([55:0,]),25:1,24:30,23:7,22:108,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:112,17:1,16:54,15:1,14:105,13:0,12:1,11:1,10:0,9:1,8:12587,7:10,5:20,6:0,3:2,2:239,1:0,]),\"skills_map\":([]),\"skills\":([]),])','','',0,'');
INSERT INTO `important_pet_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `pet_iid`, `pet_name`, `pet_property`, `para1`, `para2`, `para3`, `memo`) VALUES (5,'20180413160046',1,2,'yiq','stanwind','0','0000000000000001','0',1,0,':5AD063A400010198248B:','白泽','([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000001\",179:0,180:0,178:0,190:\"0000000000000001\",189:1523606436,182:0,175:0,174:0,153:\"0000000000000001\",114:12,92:([52:20,53:-10,47:65,35:3,17:([]),31:-35,5:20,]),90:-15,89:([36:60,22:108,21:112,16:54,]),83:-15,66:([108:20,107:-35,37:-10,36:20,2:65,]),54:100,52:20,53:-10,51:75,50:60,49:0,48:239,58:0,\"imp_item\":0,45:60,46:0,47:65,44:1,42:4,43:0,41:5,40:0,38:0,39:\"白泽\",37:75,36:60,34:0,35:3,32:0,33::5AD063A400010198248B:,29:0,31:-35,28:260,26:([55:0,]),25:1,24:30,23:6,22:108,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:112,17:1,16:54,15:1,14:105,13:0,12:1,11:1,10:0,9:1,8:13610,7:10,5:20,6:0,3:3,2:239,1:0,]),\"skills_map\":([]),\"skills\":([]),])','','',0,'');
INSERT INTO `important_pet_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `pet_iid`, `pet_name`, `pet_property`, `para1`, `para2`, `para3`, `memo`) VALUES (6,'20180413160050',1,2,'yiq','stanwind','0','0000000000000001','0',1,0,':5AD063A1000101982488:','乘黄','([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000001\",179:0,180:0,178:0,190:\"0000000000000001\",189:1523606433,182:0,175:0,174:0,153:\"0000000000000001\",114:12,92:([52:40,53:20,47:60,35:3,17:([]),31:20,5:-40,]),90:-15,89:([36:70,22:115,21:106,16:54,]),83:-15,66:([108:-40,107:20,37:20,36:40,2:60,]),54:100,52:40,53:20,51:100,50:80,49:0,48:232,58:0,\"imp_item\":0,45:0,46:0,47:60,44:1,42:4,43:0,41:60,40:0,38:0,39:\"乘黄\",37:100,36:70,34:0,35:3,32:0,33::5AD063A1000101982488:,29:0,31:20,28:300,26:([55:0,]),25:1,24:60,23:0,22:115,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:106,17:1,16:54,15:1,14:100,13:0,12:1,11:1,10:0,9:1,8:12380,7:10,5:-40,6:0,3:1,2:232,1:0,]),\"skills_map\":([]),\"skills\":([]),])','','',0,'');
INSERT INTO `important_pet_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `pet_iid`, `pet_name`, `pet_property`, `para1`, `para2`, `para3`, `memo`) VALUES (7,'20180413160251',1,2,'yiq','test','0','0000000000000002','0',11,0,':5AD06381000101982475:','乘黄','([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606401,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:40,53:20,47:60,35:3,17:([]),31:20,5:-40,]),90:-15,89:([36:70,22:115,21:106,16:54,]),83:-15,66:([108:-40,107:20,37:20,36:40,2:60,]),54:100,52:40,53:20,51:100,50:80,49:0,48:232,63:900,58:0,\"imp_item\":0,45:0,46:0,47:60,44:1,42:4,43:0,41:60,40:0,38:0,39:\"乘黄\",37:100,36:70,34:0,35:3,32:0,33::5AD06381000101982475:,29:0,31:20,28:300,26:([55:0,]),25:1,24:60,23:6,22:115,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:106,17:1,16:54,15:1,14:100,13:0,12:1,11:1,10:0,9:1,8:12167,7:10,5:-40,6:0,3:1,2:232,1:0,]),\"skills_map\":([]),\"skills\":([]),])','','',0,'');
/*!40000 ALTER TABLE `important_pet_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_task_log`
--

DROP TABLE IF EXISTS `ip_task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_task_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` char(14) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `line` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(32) NOT NULL DEFAULT '',
  `task` varchar(32) NOT NULL DEFAULT '',
  `num` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`time`) USING BTREE,
  KEY `ip` (`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_task_log`
--

LOCK TABLES `ip_task_log` WRITE;
/*!40000 ALTER TABLE `ip_task_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_transfer_log`
--

DROP TABLE IF EXISTS `item_transfer_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_transfer_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `line` tinyint(3) unsigned DEFAULT NULL,
  `type` tinyint(3) unsigned DEFAULT NULL,
  `action` varchar(32) NOT NULL DEFAULT '',
  `account_from` varchar(32) DEFAULT NULL,
  `account_to` varchar(32) DEFAULT NULL,
  `gid_from` varchar(16) DEFAULT NULL,
  `gid_to` varchar(16) DEFAULT NULL,
  `lv_from` tinyint(3) unsigned DEFAULT NULL,
  `lv_to` tinyint(3) unsigned DEFAULT NULL,
  `gold_coin_from` int(10) unsigned DEFAULT NULL,
  `gold_coin_to` int(10) unsigned DEFAULT NULL,
  `mac_from` char(16) DEFAULT NULL,
  `mac_to` char(16) DEFAULT NULL,
  `ip_from` varchar(15) DEFAULT NULL,
  `ip_to` varchar(15) DEFAULT NULL,
  `locality_from` varchar(64) DEFAULT NULL,
  `locality_to` varchar(64) DEFAULT NULL,
  `item_iid` varchar(32) DEFAULT NULL,
  `item_name` varchar(32) DEFAULT NULL,
  `item_amount` int(10) unsigned DEFAULT NULL,
  `transfer_type` tinyint(3) unsigned DEFAULT NULL,
  `transfer_id` varchar(32) DEFAULT NULL,
  `para1` varchar(32) DEFAULT NULL,
  `para2` varchar(255) DEFAULT NULL,
  `para3` int(10) unsigned DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `account` (`account_from`) USING BTREE,
  KEY `gid` (`gid_from`) USING BTREE,
  KEY `iid` (`item_iid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_transfer_log`
--

LOCK TABLES `item_transfer_log` WRITE;
/*!40000 ALTER TABLE `item_transfer_log` DISABLE KEYS */;
INSERT INTO `item_transfer_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `gold_coin_from`, `gold_coin_to`, `mac_from`, `mac_to`, `ip_from`, `ip_to`, `locality_from`, `locality_to`, `item_iid`, `item_name`, `item_amount`, `transfer_type`, `transfer_id`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180413155947',1,2,'diuqsq','test','','0000000000000002','(undefined)',3,0,498634000,0,'0000b8975aaa87f8','','116.208.216.141','','1000,132,136','',':5AD06364000101982472:','乘黄',1,0,'0000005ad063735ad060b000000001','','',0,'([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606372,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:40,53:20,47:60,35:3,17:([]),31:20,5:-40,]),90:-15,89:([36:70,22:115,21:106,16:54,]),83:-15,66:([108:-40,107:20,37:20,36:40,2:60,]),54:100,52:40,53:20,51:100,50:80,49:0,48:232,58:0,\"imp_item\":0,45:0,46:0,47:60,44:1,42:4,43:0,41:60,40:0,38:0,39:\"乘黄\",37:100,36:70,34:0,35:3,32:0,33::5AD06364000101982472:,29:0,31:20,28:300,26:([55:0,]),25:1,24:60,23:7,22:115,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:106,17:1,16:54,15:1,14:100,13:0,12:1,11:1,10:0,9:1,8:13111,7:10,5:-40,6:0,3:6,2:232,1:0,]),\"skills_map\":([]),\"skills\":([]),])');
INSERT INTO `item_transfer_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `gold_coin_from`, `gold_coin_to`, `mac_from`, `mac_to`, `ip_from`, `ip_to`, `locality_from`, `locality_to`, `item_iid`, `item_name`, `item_amount`, `transfer_type`, `transfer_id`, `para1`, `para2`, `para3`, `memo`) VALUES (2,'20180413155948',1,2,'diuqsq','test','','0000000000000002','(undefined)',3,0,498634000,0,'0000b8975aaa87f8','','116.208.216.141','','1000,132,136','',':5AD06362000101982471:','白泽',1,0,'0000005ad063745ad060b000000002','','',0,'([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606370,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:20,53:-10,47:65,35:3,17:([]),31:-35,5:20,]),90:-15,89:([36:60,22:108,21:112,16:54,]),83:-15,66:([108:20,107:-35,37:-10,36:20,2:65,]),54:100,52:20,53:-10,51:75,50:60,49:0,48:239,58:0,\"imp_item\":0,45:60,46:0,47:65,44:1,42:4,43:0,41:5,40:0,38:0,39:\"白泽\",37:75,36:60,34:0,35:3,32:0,33::5AD06362000101982471:,29:0,31:-35,28:260,26:([55:0,]),25:1,24:30,23:10,22:108,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:112,17:1,16:54,15:1,14:105,13:0,12:1,11:1,10:0,9:1,8:12695,7:10,5:20,6:0,3:0,2:239,1:0,]),\"skills_map\":([]),\"skills\":([]),])');
INSERT INTO `item_transfer_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `gold_coin_from`, `gold_coin_to`, `mac_from`, `mac_to`, `ip_from`, `ip_to`, `locality_from`, `locality_to`, `item_iid`, `item_name`, `item_amount`, `transfer_type`, `transfer_id`, `para1`, `para2`, `para3`, `memo`) VALUES (3,'20180413155957',1,2,'diuqsq','test','','0000000000000002','(undefined)',3,0,498634000,0,'0000b8975aaa87f8','','116.208.216.141','','1000,132,136','',':5AD06378000101982474:','乘黄',1,0,'0000005ad0637d5ad060b000000003','','',0,'([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606392,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:40,53:20,47:60,35:3,17:([]),31:20,5:-40,]),90:-15,89:([36:70,22:115,21:106,16:54,]),83:-15,66:([108:-40,107:20,37:20,36:40,2:60,]),54:100,52:40,53:20,51:100,50:80,49:0,48:232,58:0,\"imp_item\":0,45:0,46:0,47:60,44:1,42:4,43:0,41:60,40:0,38:0,39:\"乘黄\",37:100,36:70,34:0,35:3,32:0,33::5AD06378000101982474:,29:0,31:20,28:300,26:([55:0,]),25:1,24:60,23:1,22:115,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:106,17:1,16:54,15:1,14:100,13:0,12:1,11:1,10:0,9:1,8:10165,7:10,5:-40,6:0,3:8,2:232,1:0,]),\"skills_map\":([]),\"skills\":([]),])');
INSERT INTO `item_transfer_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `gold_coin_from`, `gold_coin_to`, `mac_from`, `mac_to`, `ip_from`, `ip_to`, `locality_from`, `locality_to`, `item_iid`, `item_name`, `item_amount`, `transfer_type`, `transfer_id`, `para1`, `para2`, `para3`, `memo`) VALUES (4,'20180413155958',1,2,'diuqsq','test','','0000000000000002','(undefined)',3,0,498634000,0,'0000b8975aaa87f8','','116.208.216.141','','1000,132,136','',':5AD06378000101982473:','白泽',1,0,'0000005ad0637e5ad060b000000004','','',0,'([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606392,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:20,53:-10,47:65,35:3,17:([]),31:-35,5:20,]),90:-15,89:([36:60,22:108,21:112,16:54,]),83:-15,66:([108:20,107:-35,37:-10,36:20,2:65,]),54:100,52:20,53:-10,51:75,50:60,49:0,48:239,58:0,\"imp_item\":0,45:60,46:0,47:65,44:1,42:4,43:0,41:5,40:0,38:0,39:\"白泽\",37:75,36:60,34:0,35:3,32:0,33::5AD06378000101982473:,29:0,31:-35,28:260,26:([55:0,]),25:1,24:30,23:7,22:108,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:112,17:1,16:54,15:1,14:105,13:0,12:1,11:1,10:0,9:1,8:12587,7:10,5:20,6:0,3:2,2:239,1:0,]),\"skills_map\":([]),\"skills\":([]),])');
INSERT INTO `item_transfer_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `gold_coin_from`, `gold_coin_to`, `mac_from`, `mac_to`, `ip_from`, `ip_to`, `locality_from`, `locality_to`, `item_iid`, `item_name`, `item_amount`, `transfer_type`, `transfer_id`, `para1`, `para2`, `para3`, `memo`) VALUES (5,'20180413160046',1,2,'diuqsq','stanwind','','0000000000000001','(undefined)',1,0,499657200,0,'0000001c42f48da8','','182.100.43.245','','1000,197,186','',':5AD063A400010198248B:','白泽',1,0,'0000005ad063ae5ad060b000000005','','',0,'([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000001\",179:0,180:0,178:0,190:\"0000000000000001\",189:1523606436,182:0,175:0,174:0,153:\"0000000000000001\",114:12,92:([52:20,53:-10,47:65,35:3,17:([]),31:-35,5:20,]),90:-15,89:([36:60,22:108,21:112,16:54,]),83:-15,66:([108:20,107:-35,37:-10,36:20,2:65,]),54:100,52:20,53:-10,51:75,50:60,49:0,48:239,58:0,\"imp_item\":0,45:60,46:0,47:65,44:1,42:4,43:0,41:5,40:0,38:0,39:\"白泽\",37:75,36:60,34:0,35:3,32:0,33::5AD063A400010198248B:,29:0,31:-35,28:260,26:([55:0,]),25:1,24:30,23:6,22:108,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:112,17:1,16:54,15:1,14:105,13:0,12:1,11:1,10:0,9:1,8:13610,7:10,5:20,6:0,3:3,2:239,1:0,]),\"skills_map\":([]),\"skills\":([]),])');
INSERT INTO `item_transfer_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `gold_coin_from`, `gold_coin_to`, `mac_from`, `mac_to`, `ip_from`, `ip_to`, `locality_from`, `locality_to`, `item_iid`, `item_name`, `item_amount`, `transfer_type`, `transfer_id`, `para1`, `para2`, `para3`, `memo`) VALUES (6,'20180413160050',1,2,'diuqsq','stanwind','','0000000000000001','(undefined)',1,0,499657200,0,'0000001c42f48da8','','182.100.43.245','','1000,197,186','',':5AD063A1000101982488:','乘黄',1,0,'0000005ad063b25ad060b000000006','','',0,'([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000001\",179:0,180:0,178:0,190:\"0000000000000001\",189:1523606433,182:0,175:0,174:0,153:\"0000000000000001\",114:12,92:([52:40,53:20,47:60,35:3,17:([]),31:20,5:-40,]),90:-15,89:([36:70,22:115,21:106,16:54,]),83:-15,66:([108:-40,107:20,37:20,36:40,2:60,]),54:100,52:40,53:20,51:100,50:80,49:0,48:232,58:0,\"imp_item\":0,45:0,46:0,47:60,44:1,42:4,43:0,41:60,40:0,38:0,39:\"乘黄\",37:100,36:70,34:0,35:3,32:0,33::5AD063A1000101982488:,29:0,31:20,28:300,26:([55:0,]),25:1,24:60,23:0,22:115,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:106,17:1,16:54,15:1,14:100,13:0,12:1,11:1,10:0,9:1,8:12380,7:10,5:-40,6:0,3:1,2:232,1:0,]),\"skills_map\":([]),\"skills\":([]),])');
INSERT INTO `item_transfer_log` (`id`, `update_time`, `line`, `type`, `action`, `account_from`, `account_to`, `gid_from`, `gid_to`, `lv_from`, `lv_to`, `gold_coin_from`, `gold_coin_to`, `mac_from`, `mac_to`, `ip_from`, `ip_to`, `locality_from`, `locality_to`, `item_iid`, `item_name`, `item_amount`, `transfer_type`, `transfer_id`, `para1`, `para2`, `para3`, `memo`) VALUES (7,'20180413160251',1,2,'diuqsq','test','','0000000000000002','(undefined)',11,0,498629000,0,'0000b8975aaa87f8','','116.208.216.141','','10001,20,46','',':5AD06381000101982475:','乘黄',1,0,'0000005ad0642b5ad060b000000007','','',0,'([\"attrib\":([\"type\":32768,\"init_fairy_skill\":1,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606401,182:0,175:0,174:0,153:\"0000000000000002\",114:12,92:([52:40,53:20,47:60,35:3,17:([]),31:20,5:-40,]),90:-15,89:([36:70,22:115,21:106,16:54,]),83:-15,66:([108:-40,107:20,37:20,36:40,2:60,]),54:100,52:40,53:20,51:100,50:80,49:0,48:232,63:900,58:0,\"imp_item\":0,45:0,46:0,47:60,44:1,42:4,43:0,41:60,40:0,38:0,39:\"乘黄\",37:100,36:70,34:0,35:3,32:0,33::5AD06381000101982475:,29:0,31:20,28:300,26:([55:0,]),25:1,24:60,23:6,22:115,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:106,17:1,16:54,15:1,14:100,13:0,12:1,11:1,10:0,9:1,8:12167,7:10,5:-40,6:0,3:1,2:232,1:0,]),\"skills_map\":([]),\"skills\":([]),])');
/*!40000 ALTER TABLE `item_transfer_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `level_up_log`
--

DROP TABLE IF EXISTS `level_up_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `level_up_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `line` varchar(16) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `lv` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `insider` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `upgrade_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(32) NOT NULL DEFAULT '',
  `mac` varchar(32) NOT NULL DEFAULT '',
  `time_used` bigint(20) DEFAULT NULL,
  `last_lv_up` varchar(14) NOT NULL DEFAULT '',
  `create_time` varchar(14) NOT NULL DEFAULT '',
  `newbie` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `para1` int(11) DEFAULT NULL,
  `para2` varchar(32) DEFAULT NULL,
  `para3` varchar(255) DEFAULT NULL,
  `para4` bigint(20) DEFAULT NULL,
  `para5` varchar(255) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level_up_log`
--

LOCK TABLES `level_up_log` WRITE;
/*!40000 ALTER TABLE `level_up_log` DISABLE KEYS */;
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (1,'20180413155735','一线','test','0000000000000002',1,0,0,0,'116.208.216.141','0000b8975aaa87f8',106,'19700101080000','20180413155547',0,2,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (2,'20180413155834','一线','test','0000000000000002',2,0,0,0,'116.208.216.141','0000b8975aaa87f8',165,'20180413155735','20180413155547',0,3,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (3,'20180413160040','一线','test','0000000000000002',3,498634000,1,0,'116.208.216.141','0000b8975aaa87f8',291,'20180413155834','20180413155547',0,4,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (4,'20180413160041','一线','test','0000000000000002',4,498634000,1,0,'116.208.216.141','0000b8975aaa87f8',292,'20180413160040','20180413155547',0,5,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (5,'20180413160110','一线','test','0000000000000002',5,498629000,1,0,'116.208.216.141','0000b8975aaa87f8',321,'20180413160041','20180413155547',0,6,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (6,'20180413160112','一线','test','0000000000000002',6,498629000,1,0,'116.208.216.141','0000b8975aaa87f8',323,'20180413160110','20180413155547',0,7,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (7,'20180413160130','一线','test','0000000000000002',7,498629000,1,0,'116.208.216.141','0000b8975aaa87f8',340,'20180413160112','20180413155547',0,8,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (8,'20180413160140','一线','test','0000000000000002',8,498629000,1,0,'116.208.216.141','0000b8975aaa87f8',351,'20180413160129','20180413155547',0,9,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (9,'20180413160206','一线','test','0000000000000002',9,498629000,1,0,'116.208.216.141','0000b8975aaa87f8',377,'20180413160140','20180413155547',0,10,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (10,'20180413160221','一线','test','0000000000000002',10,498629000,1,0,'116.208.216.141','0000b8975aaa87f8',392,'20180413160206','20180413155547',0,11,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (11,'20180413160254','一线','test','0000000000000002',11,498629000,1,0,'116.208.216.141','0000b8975aaa87f8',425,'20180413160221','20180413155547',2,12,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (12,'20180413160324','一线','test','0000000000000002',12,498629000,1,0,'116.208.216.141','0000b8975aaa87f8',455,'20180413160254','20180413155547',2,13,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (13,'20180413160542','一线','test','0000000000000002',13,498628672,1,0,'116.208.216.141','0000b8975aaa87f8',593,'20180413160324','20180413155547',2,14,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (14,'20180413160548','一线','test','0000000000000002',14,498628672,1,0,'116.208.216.141','0000b8975aaa87f8',599,'20180413160542','20180413155547',2,15,'','',0,'','');
INSERT INTO `level_up_log` (`id`, `update_time`, `line`, `account`, `gid`, `lv`, `gold_coin`, `insider`, `upgrade_type`, `ip`, `mac`, `time_used`, `last_lv_up`, `create_time`, `newbie`, `para1`, `para2`, `para3`, `para4`, `para5`, `memo`) VALUES (15,'20180413160557','一线','test','0000000000000002',15,498628672,1,0,'116.208.216.141','0000b8975aaa87f8',608,'20180413160548','20180413155547',2,16,'','',0,'','');
/*!40000 ALTER TABLE `level_up_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_log`
--

DROP TABLE IF EXISTS `login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `ip` varchar(18) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `privilege` int(11) NOT NULL DEFAULT '0',
  `login_mode` int(11) NOT NULL DEFAULT '0',
  `time_used` int(11) NOT NULL DEFAULT '0',
  `login_ip` varchar(15) NOT NULL DEFAULT '',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `silver_coin` int(11) NOT NULL DEFAULT '0',
  `insider` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `party` varchar(32) NOT NULL DEFAULT '',
  `family` varchar(32) NOT NULL DEFAULT '',
  `create_time` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `protect_type` varchar(32) NOT NULL DEFAULT '',
  `upgrade_state` int(11) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `login_ip` (`login_ip`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_log`
--

LOCK TABLES `login_log` WRITE;
/*!40000 ALTER TABLE `login_log` DISABLE KEYS */;
INSERT INTO `login_log` (`id`, `update_time`, `ip`, `account`, `char_name`, `dist`, `server`, `privilege`, `login_mode`, `time_used`, `login_ip`, `last_login_ip`, `gold_coin`, `silver_coin`, `insider`, `level`, `tao`, `party`, `family`, `create_time`, `gid`, `protect_type`, `upgrade_state`, `memo`) VALUES (1,'20180413155302','一线','stanwind','西风','问道一区','0000001c42f48da8',0,1,0,'182.100.43.245','(undefined)',0,50000,11,1,0,'','','20180413155300','0000000000000001','',1000,'([45:\"\",44:0,43:0,42:\"A68215140A19B8668D73DF8DFA5256A1063D58C81D267447AA9BBF76FAC3767DD5843DCE568C5AE89109FE4EEB4FD35D906BBB8311B480BA\",41:\"2\",40:0,39:-1,38:0,37:0,36:0,35:0,34:0,33:0,32:0,28:84,27:105,26:25,25:45,24:45,23:1,22:1,21:1,20:1,29:0,30:0,31:0,19:0,18:0,17:0,16:0,15:0,14:0,13:0,12:0,11:0,10:0,9:0,8:0,7:0,6:0,5:0,4:0,3:0,2:0,1:0,])');
INSERT INTO `login_log` (`id`, `update_time`, `ip`, `account`, `char_name`, `dist`, `server`, `privilege`, `login_mode`, `time_used`, `login_ip`, `last_login_ip`, `gold_coin`, `silver_coin`, `insider`, `level`, `tao`, `party`, `family`, `create_time`, `gid`, `protect_type`, `upgrade_state`, `memo`) VALUES (2,'20180413155550','一线','test','大坝坝','问道一区','0000b8975aaa87f8',0,1,0,'116.208.216.141','(undefined)',0,50000,11,1,0,'','','20180413155547','0000000000000002','',1000,'([45:\"5AA2C9AA7463834FB9318F7B452C87B2\",44:0,43:0,42:\"A68215140A19B8662DF0890BAC5D9ABCCBFEFBD5445BAFCD33208BC2217906F6CF9FA737EA61D4A88EF05A51228328A2885C1F679CDD9EE1\",41:\"2\",40:0,39:-1,38:0,37:0,36:0,35:0,34:0,33:0,32:0,28:84,27:105,26:25,25:45,24:45,23:1,22:1,21:1,20:1,29:0,30:0,31:0,19:0,18:0,17:0,16:0,15:0,14:0,13:0,12:0,11:0,10:0,9:0,8:0,7:0,6:0,5:0,4:0,3:0,2:0,1:0,])');
/*!40000 ALTER TABLE `login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material1_log`
--

DROP TABLE IF EXISTS `material1_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material1_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `line` tinyint(4) NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '0',
  `lv` int(11) unsigned NOT NULL DEFAULT '0',
  `tao` int(11) unsigned NOT NULL DEFAULT '0',
  `login_ip` varchar(32) NOT NULL DEFAULT '0',
  `mac` varchar(32) NOT NULL DEFAULT '0',
  `gold_coin` int(11) unsigned NOT NULL DEFAULT '0',
  `insider` varchar(32) NOT NULL DEFAULT '0',
  `map` varchar(32) NOT NULL DEFAULT '0',
  `amount` int(11) unsigned NOT NULL DEFAULT '0',
  `lasted_time` int(11) unsigned NOT NULL DEFAULT '0',
  `para1` varchar(128) NOT NULL DEFAULT '0',
  `para2` varchar(128) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material1_log`
--

LOCK TABLES `material1_log` WRITE;
/*!40000 ALTER TABLE `material1_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `material1_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_log`
--

DROP TABLE IF EXISTS `material_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '0',
  `gid` varchar(32) NOT NULL DEFAULT '0',
  `lv` int(11) unsigned NOT NULL DEFAULT '0',
  `tao` int(11) unsigned NOT NULL DEFAULT '0',
  `login_ip` varchar(32) NOT NULL DEFAULT '0',
  `mac` varchar(32) NOT NULL DEFAULT '0',
  `gold_coin` int(11) unsigned NOT NULL DEFAULT '0',
  `silver_coin` int(11) unsigned NOT NULL DEFAULT '0',
  `insider` varchar(32) NOT NULL DEFAULT '0',
  `map` varchar(32) NOT NULL DEFAULT '0',
  `item_name` varchar(32) NOT NULL DEFAULT '0',
  `amount` int(11) unsigned NOT NULL DEFAULT '0',
  `lasted_time` int(11) unsigned NOT NULL DEFAULT '0',
  `para1` varchar(128) NOT NULL DEFAULT '0',
  `para2` varchar(128) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_log`
--

LOCK TABLES `material_log` WRITE;
/*!40000 ALTER TABLE `material_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `material_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `money1_log`
--

DROP TABLE IF EXISTS `money1_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `money1_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lv` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `ip` char(15) NOT NULL DEFAULT '',
  `mac` char(32) NOT NULL DEFAULT '',
  `cash_type` tinyint(4) NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `money1_log`
--

LOCK TABLES `money1_log` WRITE;
/*!40000 ALTER TABLE `money1_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `money1_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `money_log`
--

DROP TABLE IF EXISTS `money_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `money_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `gid` char(16) NOT NULL DEFAULT '',
  `gid_op` char(16) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `voucher` int(11) DEFAULT NULL,
  `after_value` varchar(64) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `action` (`action`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `money_log`
--

LOCK TABLES `money_log` WRITE;
/*!40000 ALTER TABLE `money_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `money_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nummary_log`
--

DROP TABLE IF EXISTS `nummary_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nummary_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `type` tinyint(4) unsigned DEFAULT NULL,
  `action` varchar(32) NOT NULL DEFAULT '',
  `totality` bigint(20) unsigned NOT NULL DEFAULT '0',
  `times` mediumint(9) unsigned DEFAULT NULL,
  `gids` mediumint(9) unsigned DEFAULT NULL,
  `para1` int(11) DEFAULT NULL,
  `para2` varchar(32) DEFAULT NULL,
  `para3` varchar(255) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `type_action` (`type`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nummary_log`
--

LOCK TABLES `nummary_log` WRITE;
/*!40000 ALTER TABLE `nummary_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `nummary_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_level_up_log`
--

DROP TABLE IF EXISTS `pet_level_up_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_level_up_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `iid` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `lv` int(4) NOT NULL DEFAULT '0',
  `last_lv_up` varchar(14) NOT NULL DEFAULT '',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) DEFAULT '',
  `para3` varchar(255) DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `iid` (`iid`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_level_up_log`
--

LOCK TABLES `pet_level_up_log` WRITE;
/*!40000 ALTER TABLE `pet_level_up_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `pet_level_up_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_log`
--

DROP TABLE IF EXISTS `pet_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `pet_name` varchar(16) NOT NULL DEFAULT '',
  `pet_iid` varchar(32) NOT NULL DEFAULT '',
  `cost_item` varchar(16) NOT NULL DEFAULT '',
  `item_iid` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `pet_memo` text,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `pet_iid` (`pet_iid`) USING BTREE,
  KEY `item_iid` (`item_iid`) USING BTREE,
  KEY `action` (`action`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_log`
--

LOCK TABLES `pet_log` WRITE;
/*!40000 ALTER TABLE `pet_log` DISABLE KEYS */;
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (1,'20180413155930','问道一区','0000000000000002','huod','jianglcw','重明',':5AD0636200010198246F:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":232,\"own_ti\":1523606370,\"penetrate\":0,\"def_effect\":8,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":13603,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":20,\"mana\":20,\"phy\":-40,\"mag\":40,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":118,\"attack_eff\":4,\"pet_mana_shape\":60,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":300,\"resist_confusion\":0,\"top_data\":([\"speed\":60,\"def\":54,\"phy_power\":106,\"mag_power\":118,]),\"mag_effect\":40,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD0636200010198246F:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":60,\"mana\":100,\"resist_water\":0,\"name\":\"重明\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":80,\"init_attrib\":([\"rank\":3,\"speed_effect\":20,\"mana_effect\":20,\"mag_effect\":40,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":100,\"pet_speed_shape\":60,\"imp_item\":0,\"speed_effect\":20,\"mana_effect\":20,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (2,'20180413155930','问道一区','0000000000000002','huod','jianglcw','白泽',':5AD06362000101982471:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":239,\"own_ti\":1523606370,\"penetrate\":0,\"def_effect\":0,\"type\":32768,\"phy_effect\":20,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":12695,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":105,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":112,\"basic_effect\":([\"life\":65,\"speed\":20,\"mana\":-10,\"phy\":20,\"mag\":-35,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":108,\"attack_eff\":10,\"pet_mana_shape\":30,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":260,\"resist_confusion\":0,\"top_data\":([\"speed\":60,\"def\":54,\"phy_power\":112,\"mag_power\":108,]),\"mag_effect\":-35,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06362000101982471:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":60,\"mana\":75,\"resist_water\":0,\"name\":\"白泽\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":5,\"init_attrib\":([\"rank\":3,\"speed_effect\":20,\"mana_effect\":-10,\"mag_effect\":-35,\"special_skill\":([]),\"phy_effect\":20,\"life_effect\":65,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":60,\"resist_frozen\":0,\"life_effect\":65,\"max_life\":239,\"exp\":0,\"max_mana\":75,\"pet_speed_shape\":60,\"imp_item\":0,\"speed_effect\":20,\"mana_effect\":-10,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (3,'20180413155932','问道一区','0000000000000002','huod','jianglcw','乘黄',':5AD06364000101982472:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":232,\"own_ti\":1523606372,\"penetrate\":0,\"def_effect\":6,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":13111,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":40,\"mana\":20,\"phy\":-40,\"mag\":20,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":115,\"attack_eff\":7,\"pet_mana_shape\":60,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":300,\"resist_confusion\":0,\"top_data\":([\"speed\":70,\"def\":54,\"phy_power\":106,\"mag_power\":115,]),\"mag_effect\":20,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06364000101982472:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":70,\"mana\":100,\"resist_water\":0,\"name\":\"乘黄\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":60,\"init_attrib\":([\"rank\":3,\"speed_effect\":40,\"mana_effect\":20,\"mag_effect\":20,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":100,\"pet_speed_shape\":80,\"imp_item\":0,\"speed_effect\":40,\"mana_effect\":20,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (4,'20180413155947','问道一区','0000000000000002','','yiq','乘黄',':5AD06364000101982472:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":232,\"own_ti\":1523606372,\"penetrate\":0,\"def_effect\":6,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":13111,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":40,\"mana\":20,\"phy\":-40,\"mag\":20,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":115,\"attack_eff\":7,\"pet_mana_shape\":60,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":300,\"resist_confusion\":0,\"top_data\":([\"speed\":70,\"def\":54,\"phy_power\":106,\"mag_power\":115,]),\"mag_effect\":20,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06364000101982472:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":70,\"mana\":100,\"resist_water\":0,\"name\":\"乘黄\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":60,\"init_attrib\":([\"rank\":3,\"speed_effect\":40,\"mana_effect\":20,\"mag_effect\":20,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":100,\"pet_speed_shape\":80,\"imp_item\":0,\"speed_effect\":40,\"mana_effect\":20,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (5,'20180413155948','问道一区','0000000000000002','','yiq','白泽',':5AD06362000101982471:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":239,\"own_ti\":1523606370,\"penetrate\":0,\"def_effect\":0,\"type\":32768,\"phy_effect\":20,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":12695,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":105,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":112,\"basic_effect\":([\"life\":65,\"speed\":20,\"mana\":-10,\"phy\":20,\"mag\":-35,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":108,\"attack_eff\":10,\"pet_mana_shape\":30,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":260,\"resist_confusion\":0,\"top_data\":([\"speed\":60,\"def\":54,\"phy_power\":112,\"mag_power\":108,]),\"mag_effect\":-35,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06362000101982471:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":60,\"mana\":75,\"resist_water\":0,\"name\":\"白泽\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":5,\"init_attrib\":([\"rank\":3,\"speed_effect\":20,\"mana_effect\":-10,\"mag_effect\":-35,\"special_skill\":([]),\"phy_effect\":20,\"life_effect\":65,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":60,\"resist_frozen\":0,\"life_effect\":65,\"max_life\":239,\"exp\":0,\"max_mana\":75,\"pet_speed_shape\":60,\"imp_item\":0,\"speed_effect\":20,\"mana_effect\":-10,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (6,'20180413155952','问道一区','0000000000000002','huod','jianglcw','白泽',':5AD06378000101982473:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":239,\"own_ti\":1523606392,\"penetrate\":0,\"def_effect\":2,\"type\":32768,\"phy_effect\":20,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":12587,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":105,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":112,\"basic_effect\":([\"life\":65,\"speed\":20,\"mana\":-10,\"phy\":20,\"mag\":-35,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":108,\"attack_eff\":7,\"pet_mana_shape\":30,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":260,\"resist_confusion\":0,\"top_data\":([\"speed\":60,\"def\":54,\"phy_power\":112,\"mag_power\":108,]),\"mag_effect\":-35,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06378000101982473:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":60,\"mana\":75,\"resist_water\":0,\"name\":\"白泽\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":5,\"init_attrib\":([\"rank\":3,\"speed_effect\":20,\"mana_effect\":-10,\"mag_effect\":-35,\"special_skill\":([]),\"phy_effect\":20,\"life_effect\":65,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":60,\"resist_frozen\":0,\"life_effect\":65,\"max_life\":239,\"exp\":0,\"max_mana\":75,\"pet_speed_shape\":60,\"imp_item\":0,\"speed_effect\":20,\"mana_effect\":-10,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (7,'20180413155952','问道一区','0000000000000002','huod','jianglcw','乘黄',':5AD06378000101982474:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":232,\"own_ti\":1523606392,\"penetrate\":0,\"def_effect\":8,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":10165,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":40,\"mana\":20,\"phy\":-40,\"mag\":20,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":115,\"attack_eff\":1,\"pet_mana_shape\":60,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":300,\"resist_confusion\":0,\"top_data\":([\"speed\":70,\"def\":54,\"phy_power\":106,\"mag_power\":115,]),\"mag_effect\":20,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06378000101982474:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":70,\"mana\":100,\"resist_water\":0,\"name\":\"乘黄\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":60,\"init_attrib\":([\"rank\":3,\"speed_effect\":40,\"mana_effect\":20,\"mag_effect\":20,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":100,\"pet_speed_shape\":80,\"imp_item\":0,\"speed_effect\":40,\"mana_effect\":20,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (8,'20180413155957','问道一区','0000000000000002','','yiq','乘黄',':5AD06378000101982474:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":232,\"own_ti\":1523606392,\"penetrate\":0,\"def_effect\":8,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":10165,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":40,\"mana\":20,\"phy\":-40,\"mag\":20,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":115,\"attack_eff\":1,\"pet_mana_shape\":60,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":300,\"resist_confusion\":0,\"top_data\":([\"speed\":70,\"def\":54,\"phy_power\":106,\"mag_power\":115,]),\"mag_effect\":20,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06378000101982474:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":70,\"mana\":100,\"resist_water\":0,\"name\":\"乘黄\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":60,\"init_attrib\":([\"rank\":3,\"speed_effect\":40,\"mana_effect\":20,\"mag_effect\":20,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":100,\"pet_speed_shape\":80,\"imp_item\":0,\"speed_effect\":40,\"mana_effect\":20,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (9,'20180413155958','问道一区','0000000000000002','','yiq','白泽',':5AD06378000101982473:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":239,\"own_ti\":1523606392,\"penetrate\":0,\"def_effect\":2,\"type\":32768,\"phy_effect\":20,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":12587,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":105,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":112,\"basic_effect\":([\"life\":65,\"speed\":20,\"mana\":-10,\"phy\":20,\"mag\":-35,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":108,\"attack_eff\":7,\"pet_mana_shape\":30,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":260,\"resist_confusion\":0,\"top_data\":([\"speed\":60,\"def\":54,\"phy_power\":112,\"mag_power\":108,]),\"mag_effect\":-35,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06378000101982473:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":60,\"mana\":75,\"resist_water\":0,\"name\":\"白泽\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":5,\"init_attrib\":([\"rank\":3,\"speed_effect\":20,\"mana_effect\":-10,\"mag_effect\":-35,\"special_skill\":([]),\"phy_effect\":20,\"life_effect\":65,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":60,\"resist_frozen\":0,\"life_effect\":65,\"max_life\":239,\"exp\":0,\"max_mana\":75,\"pet_speed_shape\":60,\"imp_item\":0,\"speed_effect\":20,\"mana_effect\":-10,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (10,'20180413160001','问道一区','0000000000000002','huod','jianglcw','乘黄',':5AD06381000101982475:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":232,\"own_ti\":1523606401,\"penetrate\":0,\"def_effect\":1,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":12167,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":40,\"mana\":20,\"phy\":-40,\"mag\":20,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":115,\"attack_eff\":6,\"pet_mana_shape\":60,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":300,\"resist_confusion\":0,\"top_data\":([\"speed\":70,\"def\":54,\"phy_power\":106,\"mag_power\":115,]),\"mag_effect\":20,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06381000101982475:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":70,\"mana\":100,\"resist_water\":0,\"name\":\"乘黄\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":60,\"init_attrib\":([\"rank\":3,\"speed_effect\":40,\"mana_effect\":20,\"mag_effect\":20,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":100,\"pet_speed_shape\":80,\"imp_item\":0,\"speed_effect\":40,\"mana_effect\":20,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (11,'20180413160002','问道一区','0000000000000002','huod','jianglcw','伶俐鼠',':5AD06382000101982476:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":232,\"own_ti\":1523606402,\"penetrate\":0,\"def_effect\":7,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":12263,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":40,\"mana\":50,\"phy\":-40,\"mag\":30,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":116,\"attack_eff\":9,\"pet_mana_shape\":90,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":340,\"resist_confusion\":0,\"top_data\":([\"speed\":70,\"def\":54,\"phy_power\":106,\"mag_power\":116,]),\"mag_effect\":30,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06382000101982476:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":70,\"mana\":126,\"resist_water\":0,\"name\":\"伶俐鼠\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":70,\"init_attrib\":([\"rank\":3,\"speed_effect\":40,\"mana_effect\":50,\"mag_effect\":30,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":126,\"pet_speed_shape\":80,\"imp_item\":0,\"speed_effect\":40,\"mana_effect\":50,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (12,'20180413160033','问道一区','0000000000000001','huod','jianglcw','乘黄',':5AD063A1000101982488:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000001\",\"life\":232,\"own_ti\":1523606433,\"penetrate\":0,\"def_effect\":1,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":12380,\"init_fairy_skill\":1,\"master\":\"0000000000000001\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":40,\"mana\":20,\"phy\":-40,\"mag\":20,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000001\",\"mag_power\":115,\"attack_eff\":0,\"pet_mana_shape\":60,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":300,\"resist_confusion\":0,\"top_data\":([\"speed\":70,\"def\":54,\"phy_power\":106,\"mag_power\":115,]),\"mag_effect\":20,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD063A1000101982488:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":70,\"mana\":100,\"resist_water\":0,\"name\":\"乘黄\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":60,\"init_attrib\":([\"rank\":3,\"speed_effect\":40,\"mana_effect\":20,\"mag_effect\":20,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":100,\"pet_speed_shape\":80,\"imp_item\":0,\"speed_effect\":40,\"mana_effect\":20,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (13,'20180413160036','问道一区','0000000000000001','huod','jianglcw','白泽',':5AD063A400010198248B:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000001\",\"life\":239,\"own_ti\":1523606436,\"penetrate\":0,\"def_effect\":3,\"type\":32768,\"phy_effect\":20,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":13610,\"init_fairy_skill\":1,\"master\":\"0000000000000001\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":105,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":112,\"basic_effect\":([\"life\":65,\"speed\":20,\"mana\":-10,\"phy\":20,\"mag\":-35,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000001\",\"mag_power\":108,\"attack_eff\":6,\"pet_mana_shape\":30,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":260,\"resist_confusion\":0,\"top_data\":([\"speed\":60,\"def\":54,\"phy_power\":112,\"mag_power\":108,]),\"mag_effect\":-35,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD063A400010198248B:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":60,\"mana\":75,\"resist_water\":0,\"name\":\"白泽\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":5,\"init_attrib\":([\"rank\":3,\"speed_effect\":20,\"mana_effect\":-10,\"mag_effect\":-35,\"special_skill\":([]),\"phy_effect\":20,\"life_effect\":65,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":60,\"resist_frozen\":0,\"life_effect\":65,\"max_life\":239,\"exp\":0,\"max_mana\":75,\"pet_speed_shape\":60,\"imp_item\":0,\"speed_effect\":20,\"mana_effect\":-10,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (14,'20180413160046','问道一区','0000000000000001','','yiq','白泽',':5AD063A400010198248B:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000001\",\"life\":239,\"own_ti\":1523606436,\"penetrate\":0,\"def_effect\":3,\"type\":32768,\"phy_effect\":20,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":13610,\"init_fairy_skill\":1,\"master\":\"0000000000000001\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":105,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":112,\"basic_effect\":([\"life\":65,\"speed\":20,\"mana\":-10,\"phy\":20,\"mag\":-35,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000001\",\"mag_power\":108,\"attack_eff\":6,\"pet_mana_shape\":30,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":260,\"resist_confusion\":0,\"top_data\":([\"speed\":60,\"def\":54,\"phy_power\":112,\"mag_power\":108,]),\"mag_effect\":-35,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD063A400010198248B:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":60,\"mana\":75,\"resist_water\":0,\"name\":\"白泽\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":5,\"init_attrib\":([\"rank\":3,\"speed_effect\":20,\"mana_effect\":-10,\"mag_effect\":-35,\"special_skill\":([]),\"phy_effect\":20,\"life_effect\":65,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":60,\"resist_frozen\":0,\"life_effect\":65,\"max_life\":239,\"exp\":0,\"max_mana\":75,\"pet_speed_shape\":60,\"imp_item\":0,\"speed_effect\":20,\"mana_effect\":-10,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (15,'20180413160050','问道一区','0000000000000001','','yiq','乘黄',':5AD063A1000101982488:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000001\",\"life\":232,\"own_ti\":1523606433,\"penetrate\":0,\"def_effect\":1,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":12380,\"init_fairy_skill\":1,\"master\":\"0000000000000001\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":40,\"mana\":20,\"phy\":-40,\"mag\":20,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000001\",\"mag_power\":115,\"attack_eff\":0,\"pet_mana_shape\":60,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":300,\"resist_confusion\":0,\"top_data\":([\"speed\":70,\"def\":54,\"phy_power\":106,\"mag_power\":115,]),\"mag_effect\":20,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD063A1000101982488:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":70,\"mana\":100,\"resist_water\":0,\"name\":\"乘黄\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":60,\"init_attrib\":([\"rank\":3,\"speed_effect\":40,\"mana_effect\":20,\"mag_effect\":20,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":100,\"pet_speed_shape\":80,\"imp_item\":0,\"speed_effect\":40,\"mana_effect\":20,\"loyalty\":100,])');
INSERT INTO `pet_log` (`id`, `update_time`, `dist`, `gid`, `type`, `action`, `pet_name`, `pet_iid`, `cost_item`, `item_iid`, `para1`, `para2`, `para3`, `pet_memo`, `memo`) VALUES (16,'20180413160251','问道一区','0000000000000002','','yiq','乘黄',':5AD06381000101982475:','','','','','','','([\"resist_lost\":0,\"resist_earth\":0,\"log_owner_gid\":\"0000000000000002\",\"life\":232,\"own_ti\":1523606401,\"penetrate\":0,\"def_effect\":1,\"type\":32768,\"phy_effect\":-40,\"resist_wood\":0,\"exp_to_next_level\":10,\"longevity\":12167,\"init_fairy_skill\":1,\"master\":\"0000000000000002\",\"ignore_def\":12,\"con\":1,\"resist_forgotten\":0,\"str\":1,\"wiz\":1,\"resist_poison\":0,\"pet_life_shape\":100,\"dex\":1,\"phy_absorb\":-15,\"def\":54,\"special_skill\":1,\"resist_repress\":0,\"intimacy\":900,\"resist_cage\":0,\"phy_power\":106,\"basic_effect\":([\"life\":60,\"speed\":40,\"mana\":20,\"phy\":-40,\"mag\":20,]),\"init\":([\"dex\":1,\"con\":1,\"attrib_point\":4,\"str\":1,\"wiz\":1,]),\"resist_metal\":0,\"resist_melt\":0,\"org_owner\":\"0000000000000002\",\"mag_power\":115,\"attack_eff\":6,\"pet_mana_shape\":60,\"init_level\":1,\"resist_already\":([\"total\":0,]),\"dunwu_left_times\":0,\"shape\":300,\"resist_confusion\":0,\"top_data\":([\"speed\":70,\"def\":54,\"phy_power\":106,\"mag_power\":115,]),\"mag_effect\":20,\"mag_absorb\":-15,\"resist_sleep\":0,\"iid\"::5AD06381000101982475:,\"resist_point\":0,\"resist_lock\":0,\"rank\":3,\"speed\":70,\"mana\":100,\"resist_water\":0,\"name\":\"乘黄\",\"accurate\":0,\"dunwu_total_times\":0,\"pet_mag_shape\":60,\"init_attrib\":([\"rank\":3,\"speed_effect\":40,\"mana_effect\":20,\"mag_effect\":20,\"special_skill\":([]),\"phy_effect\":-40,\"life_effect\":60,]),\"attrib_point\":4,\"resist_fire\":0,\"level\":1,\"pet_phy_shape\":0,\"resist_frozen\":0,\"life_effect\":60,\"max_life\":232,\"exp\":0,\"max_mana\":100,\"pet_speed_shape\":80,\"imp_item\":0,\"speed_effect\":40,\"mana_effect\":20,\"loyalty\":100,])');
/*!40000 ALTER TABLE `pet_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plug_log`
--

DROP TABLE IF EXISTS `plug_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plug_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tool` int(11) NOT NULL DEFAULT '0',
  `time` varchar(14) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `ip` char(15) NOT NULL DEFAULT '',
  `level` int(11) NOT NULL DEFAULT '0',
  `coins` int(11) NOT NULL DEFAULT '0',
  `relevance` int(11) NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `tool` (`tool`) USING BTREE,
  KEY `time` (`time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plug_log`
--

LOCK TABLES `plug_log` WRITE;
/*!40000 ALTER TABLE `plug_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `plug_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_bind_log`
--

DROP TABLE IF EXISTS `property_bind_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_bind_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `owner` varchar(16) NOT NULL DEFAULT '',
  `iid` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `para` varchar(32) DEFAULT NULL,
  `main` tinyint(4) unsigned DEFAULT '0',
  `data` text,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `iid` (`iid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_bind_log`
--

LOCK TABLES `property_bind_log` WRITE;
/*!40000 ALTER TABLE `property_bind_log` DISABLE KEYS */;
INSERT INTO `property_bind_log` (`id`, `update_time`, `type`, `owner`, `iid`, `name`, `para`, `main`, `data`, `memo`) VALUES (1,'20180413160254','bind','0000000000000002','5AD0642E000101982498','兔子','',0,'兔子:0:0:([\"attrib\":([\"type\":32768,\"property_bind\":([\"attrib\":3,\"time\":1523606574,]),\"init_fairy_skill\":1,\"bind_intimacy\":10100,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606574,182:0,175:1,174:1,114:12,92:([17:([]),]),90:-15,89:([36:72,22:245,21:173,16:524,]),83:-15,66:([108:-38,107:-6,37:20,36:-6,2:31,]),54:100,52:-6,53:20,51:520,50:34,49:0,48:1281,63:10100,58:0,\"imp_item\":0,45:2,46:0,47:31,44:10,42:40,43:0,41:34,40:0,38:0,39:\"兔子\",37:520,36:72,34:5,35:2,32:0,33::5AD0642E000101982498:,29:0,31:-6,28:201,26:([55:0,]),25:1,24:60,23:2,22:245,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:173,17:1,16:524,15:10,14:71,13:0,12:10,11:10,10:0,9:10,8:13585,7:455,6:0,5:-38,3:8,2:1281,1:0,]),\"skills_map\":([]),\"skills\":([]),])','');
/*!40000 ALTER TABLE `property_bind_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_platform_log`
--

DROP TABLE IF EXISTS `purchase_platform_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_platform_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `insider` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `lv` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `order_id` varchar(32) NOT NULL DEFAULT '',
  `order_time` int(11) unsigned NOT NULL DEFAULT '0',
  `commodity_type` int(11) unsigned NOT NULL DEFAULT '0',
  `commodity_name` varchar(64) NOT NULL DEFAULT '0',
  `commodity_iid` varchar(32) NOT NULL DEFAULT '',
  `commodity_amount` int(11) NOT NULL DEFAULT '0',
  `unit_price` int(11) NOT NULL DEFAULT '0',
  `turnover` int(11) NOT NULL DEFAULT '0',
  `tax` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '0',
  `para3` varchar(32) NOT NULL DEFAULT '0',
  `para4` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gid` (`gid`) USING BTREE,
  KEY `order_id` (`order_id`) USING BTREE,
  KEY `time_account` (`update_time`,`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_platform_log`
--

LOCK TABLES `purchase_platform_log` WRITE;
/*!40000 ALTER TABLE `purchase_platform_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_platform_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_log`
--

DROP TABLE IF EXISTS `report_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account1` varchar(32) NOT NULL DEFAULT '',
  `name1` varchar(32) NOT NULL DEFAULT '',
  `gid1` varchar(32) NOT NULL DEFAULT '',
  `lv1` tinyint(4) NOT NULL DEFAULT '0',
  `tao1` int(11) NOT NULL DEFAULT '0',
  `gold_coin1` int(11) NOT NULL DEFAULT '0',
  `account2` varchar(32) NOT NULL DEFAULT '',
  `name2` varchar(32) NOT NULL DEFAULT '',
  `gid2` varchar(32) NOT NULL DEFAULT '',
  `lv2` tinyint(4) NOT NULL DEFAULT '0',
  `tao2` int(11) NOT NULL DEFAULT '0',
  `gold_coin2` int(11) NOT NULL DEFAULT '0',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(255) NOT NULL DEFAULT '',
  `para4` varchar(255) NOT NULL DEFAULT '',
  `para5` varchar(255) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account1` (`account1`) USING BTREE,
  KEY `account2` (`account2`) USING BTREE,
  KEY `name2` (`name2`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_log`
--

LOCK TABLES `report_log` WRITE;
/*!40000 ALTER TABLE `report_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `safe_log`
--

DROP TABLE IF EXISTS `safe_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `safe_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `lv` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `tao` int(10) unsigned NOT NULL DEFAULT '0',
  `ob_iid` varchar(32) NOT NULL DEFAULT '',
  `ob_name` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) DEFAULT NULL,
  `para2` varchar(255) DEFAULT NULL,
  `para3` int(11) DEFAULT NULL,
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `action` (`action`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `safe_log`
--

LOCK TABLES `safe_log` WRITE;
/*!40000 ALTER TABLE `safe_log` DISABLE KEYS */;
INSERT INTO `safe_log` (`id`, `update_time`, `dist`, `account`, `gid`, `name`, `type`, `action`, `ip`, `lv`, `tao`, `ob_iid`, `ob_name`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180413160254','问道一区','test','0000000000000002','大坝坝',3,'bangd','116.208.216.141',12,100,':5AD0642E000101982498:','兔子','','',0,'([\"attrib\":([\"type\":32768,\"property_bind\":([\"attrib\":3,\"time\":1523606574,]),\"init_fairy_skill\":1,\"bind_intimacy\":10100,181:0,188:\"0000000000000002\",179:0,180:0,178:0,190:\"0000000000000002\",189:1523606574,182:0,175:1,174:1,114:12,92:([17:([]),]),90:-15,89:([36:72,22:245,21:173,16:524,]),83:-15,66:([108:-38,107:-6,37:20,36:-6,2:31,]),54:100,52:-6,53:20,51:520,50:34,49:0,48:1281,63:10100,58:0,\"imp_item\":0,45:2,46:0,47:31,44:10,42:40,43:0,41:34,40:0,38:0,39:\"兔子\",37:520,36:72,34:5,35:2,32:0,33::5AD0642E000101982498:,29:0,31:-6,28:201,26:([55:0,]),25:1,24:60,23:2,22:245,20:0,19:([42:4,12:1,11:1,9:1,15:1,]),21:173,17:1,16:524,15:10,14:71,13:0,12:10,11:10,10:0,9:10,8:13585,7:455,6:0,5:-38,3:8,2:1281,1:0,]),\"skills_map\":([]),\"skills\":([]),])');
/*!40000 ALTER TABLE `safe_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_log`
--

DROP TABLE IF EXISTS `sale_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `dist` varchar(16) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `item_name` varchar(32) NOT NULL DEFAULT '',
  `amount` int(11) NOT NULL DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `type` (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_log`
--

LOCK TABLES `sale_log` WRITE;
/*!40000 ALTER TABLE `sale_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stat`
--

DROP TABLE IF EXISTS `stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) DEFAULT NULL,
  `pid` varchar(6) DEFAULT NULL,
  `server` varchar(20) DEFAULT NULL,
  `cpu` varchar(6) DEFAULT NULL,
  `vmem` varchar(6) DEFAULT NULL,
  `rmem` varchar(6) DEFAULT NULL,
  `cpu2` varchar(6) DEFAULT NULL,
  `para1` varchar(6) DEFAULT NULL,
  `para2` varchar(32) DEFAULT NULL,
  `para3` varchar(32) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stat`
--

LOCK TABLES `stat` WRITE;
/*!40000 ALTER TABLE `stat` DISABLE KEYS */;
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180305180939','','一线','0.838','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (2,'20180305181439','','一线','0.8003','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (3,'20180305181939','','一线','0.8183','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (4,'20180305182439','','一线','0.8270','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (5,'20180305182939','','一线','0.7993','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (6,'20180305183439','','一线','0.9636','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (7,'20180305183939','','一线','0.7413','','301','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (8,'20180305184439','','一线','0.7703','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (9,'20180305184939','','一线','0.7839','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (10,'20180305185439','','一线','0.8196','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (11,'20180305185939','','一线','0.7390','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (12,'20180305190439','','一线','0.9390','','301','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (13,'20180305190939','','一线','0.7820','','301','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (14,'20180305191439','','一线','0.8433','','301','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (15,'20180305191939','','一线','0.8676','','301','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (16,'20180413153616','','一线','0.6460','','300','','0','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (17,'20180413155810','','一线','0.6476','','300','','2','0','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (18,'20180413160310','','一线','0.7343','','300','','2','1','0','');
INSERT INTO `stat` (`id`, `update_time`, `pid`, `server`, `cpu`, `vmem`, `rmem`, `cpu2`, `para1`, `para2`, `para3`, `memo`) VALUES (19,'20180413160810','','一线','0.7279','','300','','2','0','0','');
/*!40000 ALTER TABLE `stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `switch_log`
--

DROP TABLE IF EXISTS `switch_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `switch_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `login_mode` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `time_used` int(11) NOT NULL DEFAULT '0',
  `login_ip` varchar(15) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `switch_log`
--

LOCK TABLES `switch_log` WRITE;
/*!40000 ALTER TABLE `switch_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `switch_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_monitor_log`
--

DROP TABLE IF EXISTS `system_monitor_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_monitor_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `number_ih` int(11) NOT NULL DEFAULT '0',
  `number_il` int(11) NOT NULL DEFAULT '0',
  `degree` tinyint(4) NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lv` tinyint(4) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(32) NOT NULL DEFAULT '',
  `mac` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(255) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `degree` (`degree`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `action` (`action`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_monitor_log`
--

LOCK TABLES `system_monitor_log` WRITE;
/*!40000 ALTER TABLE `system_monitor_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_monitor_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tao_stat_log`
--

DROP TABLE IF EXISTS `tao_stat_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tao_stat_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `finish_date` char(8) NOT NULL DEFAULT '',
  `dist_id` int(11) NOT NULL DEFAULT '0',
  `dist_name` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lv` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `ip` char(15) NOT NULL DEFAULT '',
  `gid_times` int(11) NOT NULL DEFAULT '0',
  `gid_charge_times` int(11) NOT NULL DEFAULT '0',
  `lv_charge_times` int(11) NOT NULL DEFAULT '0',
  `ip_times` int(11) NOT NULL DEFAULT '0',
  `ip_gids` int(11) NOT NULL DEFAULT '0',
  `punish` tinyint(4) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `finish_date` (`finish_date`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `ip` (`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tao_stat_log`
--

LOCK TABLES `tao_stat_log` WRITE;
/*!40000 ALTER TABLE `tao_stat_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tao_stat_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tao_task_log`
--

DROP TABLE IF EXISTS `tao_task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tao_task_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `dist_id` int(11) NOT NULL DEFAULT '0',
  `dist_name` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lv` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `ip` char(15) NOT NULL DEFAULT '',
  `mac` char(16) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `use_charge` tinyint(4) NOT NULL DEFAULT '0',
  `lv_charge` tinyint(4) NOT NULL DEFAULT '0',
  `lv_cha` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `ip` (`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tao_task_log`
--

LOCK TABLES `tao_task_log` WRITE;
/*!40000 ALTER TABLE `tao_task_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tao_task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_log`
--

DROP TABLE IF EXISTS `task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(16) NOT NULL DEFAULT '',
  `dist` varchar(16) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `task_type` varchar(16) NOT NULL DEFAULT '',
  `task_name` varchar(32) NOT NULL DEFAULT '',
  `action` varchar(64) NOT NULL DEFAULT '',
  `ip` varchar(16) NOT NULL DEFAULT '',
  `line` varchar(16) NOT NULL DEFAULT '',
  `level` int(11) NOT NULL DEFAULT '0',
  `tao` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `insider` int(11) NOT NULL DEFAULT '0',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `task_type` (`task_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_log`
--

LOCK TABLES `task_log` WRITE;
/*!40000 ALTER TABLE `task_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_log`
--

DROP TABLE IF EXISTS `user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '0',
  `severity` int(11) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '0',
  `para1` varchar(128) NOT NULL DEFAULT '0',
  `para2` varchar(128) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_log`
--

LOCK TABLES `user_log` WRITE;
/*!40000 ALTER TABLE `user_log` DISABLE KEYS */;
INSERT INTO `user_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (1,'20180413155947','一线','pet',1,'drop_pet','0000000000000002',':5AD06364000101982472:','乘黄','大坝坝丢弃宠物乘黄(原始名字：乘黄)：\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606372,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":13111,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":7,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":6,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06364000101982472:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `user_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (2,'20180413155948','一线','pet',1,'drop_pet','0000000000000002',':5AD06362000101982471:','白泽','大坝坝丢弃宠物白泽(原始名字：白泽)：\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":239,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606370,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":20,\\\"longevity\\\":12695,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":65,\\\"phy\\\":20,\\\"speed\\\":20,\\\"mana\\\":-10,\\\"mag\\\":-35,]),\\\"phy_power\\\":112,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":10,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":-35,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":75,\\\"name\\\":\\\"白泽\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":65,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":60,\\\"max_life\\\":239,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":75,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":0,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":105,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":108,\\\"pet_mana_shape\\\":30,\\\"dunwu_left_times\\\":0,\\\"shape\\\":260,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":112,\\\"mag_power\\\":108,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06362000101982471:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":5,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":-10,\\\"mag_effect\\\":-35,\\\"phy_effect\\\":20,\\\"special_skill\\\":([]),\\\"life_effect\\\":65,]),\\\"exp\\\":0,\\\"mana_effect\\\":-10,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `user_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (3,'20180413155957','一线','pet',1,'drop_pet','0000000000000002',':5AD06378000101982474:','乘黄','大坝坝丢弃宠物乘黄(原始名字：乘黄)：\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606392,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":10165,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":1,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":8,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06378000101982474:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `user_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (4,'20180413155958','一线','pet',1,'drop_pet','0000000000000002',':5AD06378000101982473:','白泽','大坝坝丢弃宠物白泽(原始名字：白泽)：\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":239,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606392,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":20,\\\"longevity\\\":12587,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":65,\\\"phy\\\":20,\\\"speed\\\":20,\\\"mana\\\":-10,\\\"mag\\\":-35,]),\\\"phy_power\\\":112,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":7,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":-35,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":75,\\\"name\\\":\\\"白泽\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":65,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":60,\\\"max_life\\\":239,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":75,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":2,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":105,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":108,\\\"pet_mana_shape\\\":30,\\\"dunwu_left_times\\\":0,\\\"shape\\\":260,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":112,\\\"mag_power\\\":108,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06378000101982473:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":5,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":-10,\\\"mag_effect\\\":-35,\\\"phy_effect\\\":20,\\\"special_skill\\\":([]),\\\"life_effect\\\":65,]),\\\"exp\\\":0,\\\"mana_effect\\\":-10,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `user_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (5,'20180413160046','一线','pet',1,'drop_pet','0000000000000001',':5AD063A400010198248B:','白泽','西风丢弃宠物白泽(原始名字：白泽)：\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000001\\\",\\\"life\\\":239,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606436,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":20,\\\"longevity\\\":13610,\\\"master\\\":\\\"0000000000000001\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":65,\\\"phy\\\":20,\\\"speed\\\":20,\\\"mana\\\":-10,\\\"mag\\\":-35,]),\\\"phy_power\\\":112,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000001\\\",\\\"attack_eff\\\":6,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":-35,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":60,\\\"mana\\\":75,\\\"name\\\":\\\"白泽\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":65,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":60,\\\"max_life\\\":239,\\\"pet_speed_shape\\\":60,\\\"max_mana\\\":75,\\\"speed_effect\\\":20,\\\"resist_earth\\\":0,\\\"def_effect\\\":3,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":105,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":108,\\\"pet_mana_shape\\\":30,\\\"dunwu_left_times\\\":0,\\\"shape\\\":260,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":60,\\\"def\\\":54,\\\"phy_power\\\":112,\\\"mag_power\\\":108,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD063A400010198248B:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":5,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":20,\\\"mana_effect\\\":-10,\\\"mag_effect\\\":-35,\\\"phy_effect\\\":20,\\\"special_skill\\\":([]),\\\"life_effect\\\":65,]),\\\"exp\\\":0,\\\"mana_effect\\\":-10,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `user_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (6,'20180413160050','一线','pet',1,'drop_pet','0000000000000001',':5AD063A1000101982488:','乘黄','西风丢弃宠物乘黄(原始名字：乘黄)：\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000001\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606433,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":12380,\\\"master\\\":\\\"0000000000000001\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000001\\\",\\\"attack_eff\\\":0,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":1,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD063A1000101982488:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `user_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (7,'20180413160251','一线','pet',1,'drop_pet','0000000000000002',':5AD06381000101982475:','乘黄','大坝坝丢弃宠物乘黄(原始名字：乘黄)：\"([\\\"skills_map\\\":([]),\\\"attrib\\\":([\\\"resist_lost\\\":0,\\\"log_owner_gid\\\":\\\"0000000000000002\\\",\\\"life\\\":232,\\\"penetrate\\\":0,\\\"own_ti\\\":1523606401,\\\"type\\\":32768,\\\"resist_wood\\\":0,\\\"phy_effect\\\":-40,\\\"longevity\\\":12167,\\\"master\\\":\\\"0000000000000002\\\",\\\"ignore_def\\\":12,\\\"con\\\":1,\\\"resist_poison\\\":0,\\\"dex\\\":1,\\\"intimacy\\\":900,\\\"basic_effect\\\":([\\\"life\\\":60,\\\"phy\\\":-40,\\\"speed\\\":40,\\\"mana\\\":20,\\\"mag\\\":20,]),\\\"phy_power\\\":106,\\\"init\\\":([\\\"dex\\\":1,\\\"con\\\":1,\\\"attrib_point\\\":4,\\\"str\\\":1,\\\"wiz\\\":1,]),\\\"resist_metal\\\":0,\\\"org_owner\\\":\\\"0000000000000002\\\",\\\"attack_eff\\\":6,\\\"init_level\\\":1,\\\"resist_already\\\":([\\\"total\\\":0,]),\\\"mag_effect\\\":20,\\\"resist_lock\\\":0,\\\"rank\\\":3,\\\"resist_point\\\":0,\\\"speed\\\":70,\\\"mana\\\":100,\\\"name\\\":\\\"乘黄\\\",\\\"accurate\\\":0,\\\"dunwu_total_times\\\":0,\\\"resist_fire\\\":0,\\\"attrib_point\\\":4,\\\"level\\\":1,\\\"life_effect\\\":60,\\\"resist_frozen\\\":0,\\\"pet_phy_shape\\\":0,\\\"max_life\\\":232,\\\"pet_speed_shape\\\":80,\\\"max_mana\\\":100,\\\"speed_effect\\\":40,\\\"resist_earth\\\":0,\\\"def_effect\\\":1,\\\"exp_to_next_level\\\":10,\\\"init_fairy_skill\\\":1,\\\"resist_forgotten\\\":0,\\\"str\\\":1,\\\"wiz\\\":1,\\\"pet_life_shape\\\":100,\\\"def\\\":54,\\\"phy_absorb\\\":-15,\\\"special_skill\\\":1,\\\"resist_repress\\\":0,\\\"resist_cage\\\":0,\\\"resist_melt\\\":0,\\\"mag_power\\\":115,\\\"pet_mana_shape\\\":60,\\\"dunwu_left_times\\\":0,\\\"shape\\\":300,\\\"resist_confusion\\\":0,\\\"top_data\\\":([\\\"speed\\\":70,\\\"def\\\":54,\\\"phy_power\\\":106,\\\"mag_power\\\":115,]),\\\"mag_absorb\\\":-15,\\\"resist_sleep\\\":0,\\\"iid\\\"::5AD06381000101982475:,\\\"resist_water\\\":0,\\\"pet_mag_shape\\\":60,\\\"init_attrib\\\":([\\\"rank\\\":3,\\\"speed_effect\\\":40,\\\"mana_effect\\\":20,\\\"mag_effect\\\":20,\\\"phy_effect\\\":-40,\\\"special_skill\\\":([]),\\\"life_effect\\\":60,]),\\\"exp\\\":0,\\\"mana_effect\\\":20,\\\"imp_item\\\":0,\\\"loyalty\\\":100,]),\\\"skills\\\":([]),])\"');
INSERT INTO `user_log` (`id`, `update_time`, `server`, `type`, `severity`, `action`, `para1`, `para2`, `para3`, `memo`) VALUES (8,'20180413160846','一线','nice_state',1,'die','0000000000000002','0','0','');
/*!40000 ALTER TABLE `user_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_report_ip_log`
--

DROP TABLE IF EXISTS `user_report_ip_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_report_ip_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `lv` tinyint(4) NOT NULL DEFAULT '0',
  `para1` varchar(255) NOT NULL DEFAULT '',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(32) NOT NULL DEFAULT '',
  `para4` varchar(32) NOT NULL DEFAULT '',
  `para5` varchar(32) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_report_ip_log`
--

LOCK TABLES `user_report_ip_log` WRITE;
/*!40000 ALTER TABLE `user_report_ip_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_report_ip_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishing_log`
--

DROP TABLE IF EXISTS `wishing_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishing_log` (
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `score` int(11) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`gid`),
  KEY `update_time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishing_log`
--

LOCK TABLES `wishing_log` WRITE;
/*!40000 ALTER TABLE `wishing_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishing_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zq_add_point_log`
--

DROP TABLE IF EXISTS `zq_add_point_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zq_add_point_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(4) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `create_time` char(14) NOT NULL DEFAULT '',
  `ip` varchar(18) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `point_before` int(11) NOT NULL DEFAULT '0',
  `point_after` int(11) NOT NULL DEFAULT '0',
  `point_add` int(11) NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zq_add_point_log`
--

LOCK TABLES `zq_add_point_log` WRITE;
/*!40000 ALTER TABLE `zq_add_point_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `zq_add_point_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zq_card_log`
--

DROP TABLE IF EXISTS `zq_card_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zq_card_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(4) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `create_time` char(14) NOT NULL DEFAULT '',
  `ip` varchar(18) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '0',
  `bonus_name` varchar(32) NOT NULL DEFAULT '0',
  `bonus_prop` varchar(32) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zq_card_log`
--

LOCK TABLES `zq_card_log` WRITE;
/*!40000 ALTER TABLE `zq_card_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `zq_card_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zq_combat_log`
--

DROP TABLE IF EXISTS `zq_combat_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zq_combat_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(4) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `create_time` char(14) NOT NULL DEFAULT '',
  `ip` varchar(18) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `total_round` int(11) NOT NULL DEFAULT '0',
  `hero_name` varchar(32) NOT NULL DEFAULT '',
  `hero_lv` int(11) NOT NULL DEFAULT '0',
  `result` tinyint(4) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zq_combat_log`
--

LOCK TABLES `zq_combat_log` WRITE;
/*!40000 ALTER TABLE `zq_combat_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `zq_combat_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zq_cost_point_log`
--

DROP TABLE IF EXISTS `zq_cost_point_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zq_cost_point_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(4) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `create_time` char(14) NOT NULL DEFAULT '',
  `ip` varchar(18) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `point_before` int(11) NOT NULL DEFAULT '0',
  `point_after` int(11) NOT NULL DEFAULT '0',
  `point_cost` int(11) NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `item_name` varchar(32) NOT NULL DEFAULT '',
  `amount` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zq_cost_point_log`
--

LOCK TABLES `zq_cost_point_log` WRITE;
/*!40000 ALTER TABLE `zq_cost_point_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `zq_cost_point_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zq_errand_log`
--

DROP TABLE IF EXISTS `zq_errand_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zq_errand_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(4) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `create_time` char(14) NOT NULL DEFAULT '',
  `ip` varchar(18) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '0',
  `bonus_type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `bonus_name` varchar(32) NOT NULL DEFAULT '0',
  `bonus_prop` varchar(32) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zq_errand_log`
--

LOCK TABLES `zq_errand_log` WRITE;
/*!40000 ALTER TABLE `zq_errand_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `zq_errand_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zq_login_log`
--

DROP TABLE IF EXISTS `zq_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zq_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(4) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `create_time` char(14) NOT NULL DEFAULT '',
  `ip` varchar(18) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `privilege` int(11) NOT NULL DEFAULT '0',
  `login_mode` int(11) NOT NULL DEFAULT '0',
  `time_used` int(11) NOT NULL DEFAULT '0',
  `hero_lv` int(11) NOT NULL DEFAULT '0',
  `xg_point` int(11) NOT NULL DEFAULT '0',
  `card_num` int(11) NOT NULL DEFAULT '0',
  `fragment_num` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zq_login_log`
--

LOCK TABLES `zq_login_log` WRITE;
/*!40000 ALTER TABLE `zq_login_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `zq_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zq_lv_up_log`
--

DROP TABLE IF EXISTS `zq_lv_up_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zq_lv_up_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `line` tinyint(4) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `char_name` varchar(32) NOT NULL DEFAULT '',
  `create_time` char(14) NOT NULL DEFAULT '',
  `ip` varchar(18) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `hero_name` varchar(32) NOT NULL DEFAULT '',
  `lv` int(11) NOT NULL DEFAULT '0',
  `bonus_name` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `account` (`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zq_lv_up_log`
--

LOCK TABLES `zq_lv_up_log` WRITE;
/*!40000 ALTER TABLE `zq_lv_up_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `zq_lv_up_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dl_ldb_1'
--

--
-- Dumping routines for database 'dl_ldb_1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-25  2:15:58
