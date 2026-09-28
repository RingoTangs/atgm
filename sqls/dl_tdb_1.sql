-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: dl_tdb_1
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
-- Current Database: `dl_tdb_1`
--

/*!40000 DROP DATABASE IF EXISTS `dl_tdb_1`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dl_tdb_1` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `dl_tdb_1`;

--
-- Table structure for table `lottery`
--

DROP TABLE IF EXISTS `lottery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lottery` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `lottery_iid` varchar(32) NOT NULL DEFAULT '',
  `lottery_no` varchar(32) NOT NULL DEFAULT '',
  `lottery_info` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(32) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lottery`
--

LOCK TABLES `lottery` WRITE;
/*!40000 ALTER TABLE `lottery` DISABLE KEYS */;
/*!40000 ALTER TABLE `lottery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merge_treasure_ids`
--

DROP TABLE IF EXISTS `merge_treasure_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merge_treasure_ids` (
  `id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merge_treasure_ids`
--

LOCK TABLES `merge_treasure_ids` WRITE;
/*!40000 ALTER TABLE `merge_treasure_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `merge_treasure_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trading_log`
--

DROP TABLE IF EXISTS `trading_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trading_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `action` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(128) NOT NULL DEFAULT '',
  `para3` varchar(128) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trading_log`
--

LOCK TABLES `trading_log` WRITE;
/*!40000 ALTER TABLE `trading_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `trading_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trading_platform_log`
--

DROP TABLE IF EXISTS `trading_platform_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trading_platform_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `mac` varchar(16) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `insider` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `lv` int(11) NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `commodity_type` int(11) unsigned NOT NULL DEFAULT '0',
  `commodity_id` varchar(64) NOT NULL DEFAULT '',
  `commodity_iid` varchar(128) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `service_costs` float NOT NULL DEFAULT '0',
  `tax` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '0',
  `para3` varchar(32) NOT NULL DEFAULT '0',
  `para4` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gid` (`gid`) USING BTREE,
  KEY `commodity_id` (`commodity_id`) USING BTREE,
  KEY `time_account` (`update_time`,`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trading_platform_log`
--

LOCK TABLES `trading_platform_log` WRITE;
/*!40000 ALTER TABLE `trading_platform_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `trading_platform_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trading_record`
--

DROP TABLE IF EXISTS `trading_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trading_record` (
  `id` varchar(255) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL DEFAULT '',
  `seller` varchar(32) NOT NULL DEFAULT '',
  `seller_account` varchar(32) NOT NULL DEFAULT '',
  `seller_dist` varchar(32) NOT NULL DEFAULT '',
  `buyer` varchar(32) NOT NULL DEFAULT '',
  `buyer_account` varchar(32) NOT NULL DEFAULT '',
  `buyer_dist` varchar(32) NOT NULL DEFAULT '',
  `price` int(11) NOT NULL DEFAULT '0',
  `service_charge` float NOT NULL DEFAULT '0',
  `item_order_id` varchar(255) NOT NULL DEFAULT '',
  `update_time` char(14) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trading_record`
--

LOCK TABLES `trading_record` WRITE;
/*!40000 ALTER TABLE `trading_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `trading_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_log`
--

DROP TABLE IF EXISTS `transaction_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_log` (
  `transaction_id` varchar(32) NOT NULL DEFAULT '',
  `goods_id` varchar(255) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `locked` tinyint(4) NOT NULL DEFAULT '0',
  `content` mediumtext,
  `module` varchar(32) DEFAULT NULL,
  `func` varchar(32) DEFAULT NULL,
  `para` varchar(255) DEFAULT NULL,
  `result` text,
  `http_got` tinyint(4) NOT NULL DEFAULT '0',
  `repeat_times` tinyint(4) NOT NULL DEFAULT '0',
  `update_time` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_log`
--

LOCK TABLES `transaction_log` WRITE;
/*!40000 ALTER TABLE `transaction_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treasure_info`
--

DROP TABLE IF EXISTS `treasure_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treasure_info` (
  `id` varchar(255) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `sale_duration` int(11) NOT NULL DEFAULT '0',
  `org_price` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `org_upset_price` int(11) NOT NULL DEFAULT '0',
  `upset_price` int(11) NOT NULL DEFAULT '0',
  `times` int(11) NOT NULL DEFAULT '0',
  `change_time` int(11) NOT NULL DEFAULT '0',
  `buyer` varchar(32) DEFAULT NULL,
  `buyer_account` varchar(32) DEFAULT NULL,
  `buyer_dist` varchar(32) NOT NULL DEFAULT '',
  `seller` varchar(32) NOT NULL DEFAULT '',
  `seller_account` varchar(32) NOT NULL DEFAULT '',
  `seller_dist` varchar(32) NOT NULL DEFAULT '',
  `simple_info` varchar(255) NOT NULL DEFAULT '',
  `particular_info` text,
  `snapshot` text,
  `xml` mediumtext NOT NULL,
  `unique_id` varchar(128) NOT NULL DEFAULT '',
  `issue_time` varchar(32) NOT NULL DEFAULT '',
  `appointer` varchar(32) NOT NULL DEFAULT '',
  `sale_method` tinyint(4) NOT NULL DEFAULT '0',
  `checksum` int(32) NOT NULL DEFAULT '0',
  `snapshot_upgrade` text,
  `snapshot_equip` text,
  `snapshot_upg_equip` text,
  `snapshot_item` text,
  `snapshot_pet` text,
  `snapshot_guard` text,
  `snapshot_child` text,
  PRIMARY KEY (`id`),
  KEY `seller` (`seller`) USING BTREE,
  KEY `buyer` (`buyer`) USING BTREE,
  KEY `appointer` (`appointer`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treasure_info`
--

LOCK TABLES `treasure_info` WRITE;
/*!40000 ALTER TABLE `treasure_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `treasure_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dl_tdb_1'
--

--
-- Dumping routines for database 'dl_tdb_1'
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
