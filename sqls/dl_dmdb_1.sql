-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: dl_dmdb_1
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
-- Current Database: `dl_dmdb_1`
--

/*!40000 DROP DATABASE IF EXISTS `dl_dmdb_1`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dl_dmdb_1` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `dl_dmdb_1`;

--
-- Table structure for table `account_basic`
--

DROP TABLE IF EXISTS `account_basic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_basic` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `silver_coin` int(10) NOT NULL DEFAULT '0',
  `gold_coin` int(10) NOT NULL DEFAULT '0',
  `last_time` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`,`silver_coin`,`gold_coin`,`last_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_basic`
--

LOCK TABLES `account_basic` WRITE;
/*!40000 ALTER TABLE `account_basic` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_basic` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apply_log`
--

LOCK TABLES `apply_log` WRITE;
/*!40000 ALTER TABLE `apply_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_log`
--

LOCK TABLES `campaign_log` WRITE;
/*!40000 ALTER TABLE `campaign_log` DISABLE KEYS */;
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
-- Table structure for table `char_basic`
--

DROP TABLE IF EXISTS `char_basic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_basic` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `level` int(10) DEFAULT NULL,
  `cash` int(10) DEFAULT NULL,
  `balance` int(10) DEFAULT NULL,
  `reputation` int(10) DEFAULT NULL,
  `pot` int(10) DEFAULT NULL,
  `total_score` int(10) DEFAULT NULL,
  `party_contrib` int(10) DEFAULT NULL,
  `total_played_time` int(10) DEFAULT NULL,
  `char_name` varchar(32) DEFAULT NULL,
  `insider` int(2) DEFAULT NULL,
  `polar` int(2) DEFAULT NULL,
  `last_time` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`,`gid`,`last_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_basic`
--

LOCK TABLES `char_basic` WRITE;
/*!40000 ALTER TABLE `char_basic` DISABLE KEYS */;
/*!40000 ALTER TABLE `char_basic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `char_cost`
--

DROP TABLE IF EXISTS `char_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_cost` (
  `gid` varchar(32) NOT NULL DEFAULT '',
  `silver_coin` int(10) DEFAULT NULL,
  `gold_coin` int(10) DEFAULT NULL,
  `last_time` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`last_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_cost`
--

LOCK TABLES `char_cost` WRITE;
/*!40000 ALTER TABLE `char_cost` DISABLE KEYS */;
/*!40000 ALTER TABLE `char_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `char_incre`
--

DROP TABLE IF EXISTS `char_incre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_incre` (
  `gid` varchar(32) NOT NULL DEFAULT '',
  `exp` int(10) DEFAULT NULL,
  `cash` int(10) DEFAULT NULL,
  `tao` int(10) DEFAULT NULL,
  `reputation` int(10) DEFAULT NULL,
  `pot` int(10) DEFAULT NULL,
  `total_score` int(10) DEFAULT NULL,
  `party_contrib` int(10) DEFAULT NULL,
  `last_time` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`last_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_incre`
--

LOCK TABLES `char_incre` WRITE;
/*!40000 ALTER TABLE `char_incre` DISABLE KEYS */;
/*!40000 ALTER TABLE `char_incre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `char_salary`
--

DROP TABLE IF EXISTS `char_salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_salary` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `gid` varchar(32) DEFAULT NULL,
  `silver_coin` int(12) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  `glory` int(12) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_salary`
--

LOCK TABLES `char_salary` WRITE;
/*!40000 ALTER TABLE `char_salary` DISABLE KEYS */;
/*!40000 ALTER TABLE `char_salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_item_cost`
--

DROP TABLE IF EXISTS `charge_item_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_item_cost` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `item` varchar(32) DEFAULT NULL,
  `amount` int(12) DEFAULT NULL,
  `gid` varchar(32) DEFAULT NULL,
  `account` varchar(32) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`),
  KEY `item` (`item`,`last_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_item_cost`
--

LOCK TABLES `charge_item_cost` WRITE;
/*!40000 ALTER TABLE `charge_item_cost` DISABLE KEYS */;
/*!40000 ALTER TABLE `charge_item_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_item_sale`
--

DROP TABLE IF EXISTS `charge_item_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_item_sale` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `item` varchar(32) DEFAULT NULL,
  `amount` int(12) DEFAULT NULL,
  `coin` int(12) DEFAULT NULL,
  `coin_type` varchar(32) DEFAULT NULL,
  `account` varchar(32) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`),
  KEY `item` (`item`,`last_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_item_sale`
--

LOCK TABLES `charge_item_sale` WRITE;
/*!40000 ALTER TABLE `charge_item_sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `charge_item_sale` ENABLE KEYS */;
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
-- Table structure for table `coin_cost`
--

DROP TABLE IF EXISTS `coin_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coin_cost` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `coin` int(12) DEFAULT NULL,
  `coin_type` varchar(32) DEFAULT NULL,
  `gid` varchar(32) DEFAULT NULL,
  `account` varchar(32) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coin_cost`
--

LOCK TABLES `coin_cost` WRITE;
/*!40000 ALTER TABLE `coin_cost` DISABLE KEYS */;
/*!40000 ALTER TABLE `coin_cost` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect_data_log`
--

LOCK TABLES `collect_data_log` WRITE;
/*!40000 ALTER TABLE `collect_data_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common_log`
--

LOCK TABLES `common_log` WRITE;
/*!40000 ALTER TABLE `common_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cost_coin_log`
--

LOCK TABLES `cost_coin_log` WRITE;
/*!40000 ALTER TABLE `cost_coin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debug_log`
--

LOCK TABLES `debug_log` WRITE;
/*!40000 ALTER TABLE `debug_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errand_log`
--

LOCK TABLES `errand_log` WRITE;
/*!40000 ALTER TABLE `errand_log` DISABLE KEYS */;
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
-- Table structure for table `game_baiguidi`
--

DROP TABLE IF EXISTS `game_baiguidi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_baiguidi` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `gid` varchar(32) DEFAULT NULL,
  `level` varchar(12) DEFAULT NULL,
  `polar` int(2) DEFAULT NULL,
  `insider` int(2) DEFAULT NULL,
  `times` int(12) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_baiguidi`
--

LOCK TABLES `game_baiguidi` WRITE;
/*!40000 ALTER TABLE `game_baiguidi` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_baiguidi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_chongwutaowang`
--

DROP TABLE IF EXISTS `game_chongwutaowang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_chongwutaowang` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `gid` varchar(32) DEFAULT NULL,
  `level` varchar(12) DEFAULT NULL,
  `polar` int(2) DEFAULT NULL,
  `insider` int(2) DEFAULT NULL,
  `times` int(12) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_chongwutaowang`
--

LOCK TABLES `game_chongwutaowang` WRITE;
/*!40000 ALTER TABLE `game_chongwutaowang` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_chongwutaowang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_wanyaoku`
--

DROP TABLE IF EXISTS `game_wanyaoku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_wanyaoku` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `gid` varchar(32) DEFAULT NULL,
  `level` varchar(12) DEFAULT NULL,
  `polar` int(2) DEFAULT NULL,
  `insider` int(2) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_wanyaoku`
--

LOCK TABLES `game_wanyaoku` WRITE;
/*!40000 ALTER TABLE `game_wanyaoku` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_wanyaoku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_yabiao`
--

DROP TABLE IF EXISTS `game_yabiao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_yabiao` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `gid` varchar(32) DEFAULT NULL,
  `level` varchar(12) DEFAULT NULL,
  `polar` int(2) DEFAULT NULL,
  `insider` int(2) DEFAULT NULL,
  `times` int(12) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_yabiao`
--

LOCK TABLES `game_yabiao` WRITE;
/*!40000 ALTER TABLE `game_yabiao` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_yabiao` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gs_log`
--

LOCK TABLES `gs_log` WRITE;
/*!40000 ALTER TABLE `gs_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `important_log`
--

LOCK TABLES `important_log` WRITE;
/*!40000 ALTER TABLE `important_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `important_pet_log`
--

LOCK TABLES `important_pet_log` WRITE;
/*!40000 ALTER TABLE `important_pet_log` DISABLE KEYS */;
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
-- Table structure for table `item_exchange`
--

DROP TABLE IF EXISTS `item_exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_exchange` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(32) DEFAULT NULL,
  `amount` int(12) DEFAULT NULL,
  `total_price` int(12) DEFAULT NULL,
  `exchange_type` varchar(32) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_exchange`
--

LOCK TABLES `item_exchange` WRITE;
/*!40000 ALTER TABLE `item_exchange` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_exchange` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_transfer_log`
--

LOCK TABLES `item_transfer_log` WRITE;
/*!40000 ALTER TABLE `item_transfer_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level_up_log`
--

LOCK TABLES `level_up_log` WRITE;
/*!40000 ALTER TABLE `level_up_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_log`
--

LOCK TABLES `login_log` WRITE;
/*!40000 ALTER TABLE `login_log` DISABLE KEYS */;
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
-- Table structure for table `party_contrib_convert`
--

DROP TABLE IF EXISTS `party_contrib_convert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_contrib_convert` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `party_contrib` int(12) DEFAULT NULL,
  `got` int(12) DEFAULT NULL,
  `gid` varchar(32) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  `got_type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_contrib_convert`
--

LOCK TABLES `party_contrib_convert` WRITE;
/*!40000 ALTER TABLE `party_contrib_convert` DISABLE KEYS */;
/*!40000 ALTER TABLE `party_contrib_convert` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_log`
--

LOCK TABLES `pet_log` WRITE;
/*!40000 ALTER TABLE `pet_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_bind_log`
--

LOCK TABLES `property_bind_log` WRITE;
/*!40000 ALTER TABLE `property_bind_log` DISABLE KEYS */;
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
-- Table structure for table `reputation_convert`
--

DROP TABLE IF EXISTS `reputation_convert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reputation_convert` (
  `no` int(12) NOT NULL AUTO_INCREMENT,
  `reputation` int(12) DEFAULT NULL,
  `got` int(12) DEFAULT NULL,
  `got_type` varchar(32) DEFAULT NULL,
  `gid` varchar(32) DEFAULT NULL,
  `last_time` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`no`),
  KEY `gid` (`gid`,`last_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reputation_convert`
--

LOCK TABLES `reputation_convert` WRITE;
/*!40000 ALTER TABLE `reputation_convert` DISABLE KEYS */;
/*!40000 ALTER TABLE `reputation_convert` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `safe_log`
--

LOCK TABLES `safe_log` WRITE;
/*!40000 ALTER TABLE `safe_log` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stat`
--

LOCK TABLES `stat` WRITE;
/*!40000 ALTER TABLE `stat` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_log`
--

LOCK TABLES `user_log` WRITE;
/*!40000 ALTER TABLE `user_log` DISABLE KEYS */;
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
-- Dumping events for database 'dl_dmdb_1'
--

--
-- Dumping routines for database 'dl_dmdb_1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-25  2:15:57
