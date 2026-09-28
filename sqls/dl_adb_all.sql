-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: dl_adb_all
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
-- Current Database: `dl_adb_all`
--

/*!40000 DROP DATABASE IF EXISTS `dl_adb_all`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dl_adb_all` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `dl_adb_all`;

--
-- Table structure for table `aaa`
--

DROP TABLE IF EXISTS `aaa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aaa` (
  `aaa` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `attrib` varchar(255) DEFAULT NULL,
  `server_key` varchar(32) NOT NULL DEFAULT '',
  `num` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `error_password_times` int(11) NOT NULL DEFAULT '5',
  `busy_time` int(11) NOT NULL DEFAULT '600',
  `client_per_ip` int(11) NOT NULL DEFAULT '0',
  `activate_url` varchar(255) NOT NULL DEFAULT '',
  `activate_aaa_ip` varchar(15) NOT NULL DEFAULT '',
  `ecard_fill_url` varchar(255) NOT NULL DEFAULT '',
  `ecard_resend_url` varchar(255) NOT NULL DEFAULT '',
  `ecard_web_status_url` varchar(255) NOT NULL DEFAULT '',
  `antibot_server` varchar(255) DEFAULT NULL,
  `antibot_action` varchar(255) DEFAULT NULL,
  `passpod_server` varchar(255) DEFAULT NULL,
  `auth_server` varchar(255) DEFAULT NULL,
  `coin_trade_server` varchar(255) DEFAULT 'transfer.gyyx.cn:81',
  `recharge_url` varchar(255) NOT NULL DEFAULT '',
  `inquiry_url` varchar(255) NOT NULL DEFAULT '',
  `sms_auth_url` varchar(255) NOT NULL DEFAULT 'http://interface.message.gyyx.cn/v1/Send/Account',
  `memo` text,
  PRIMARY KEY (`aaa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aaa`
--

LOCK TABLES `aaa` WRITE;
/*!40000 ALTER TABLE `aaa` DISABLE KEYS */;
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_coding','10.2.50.30',8300,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_daili','118.24.7.124',8101,NULL,'',1,1,5,30,0,'http://127.0.0.1/','','127.0.0.1','127.0.0.1','127.0.0.1',NULL,NULL,'127.0.0.1',NULL,'transfer.gyyx.cn:81','127.0.0.1','127.0.0.1','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_dongsh','10.3.4.35',8300,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_jiangw_30','10.2.50.30',8001,NULL,'',1,1,3,600,0,'http://10.2.50.58/simulateforum/vipsms_jiangw.php','10.2.50.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_jiangw_pk','10.2.50.30',8003,NULL,'',1,2,5,30,0,'http://10.2.50.58/simulateforum/vipsms_jiangw.php','','127.0.0.1','127.0.0.1','127.0.0.1',NULL,NULL,'127.0.0.1',NULL,'transfer.gyyx.cn:81','127.0.0.1','127.0.0.1','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_liy','10.3.102.75',8000,NULL,'',1,1,3,600,0,'','10.2.48.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_luoyh','10.3.4.25',8001,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_quls_30','10.3.4.5',8300,NULL,'',1,1,3,600,0,'http://transfer.gyyx.cn:81/WenDaoServiceV2/Register.ashx','10.2.48.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_test','10.2.50.57',12054,NULL,'',1,1,3,600,0,'http://transfer.gyyx.cn:81/WenDaoServiceV2/Register.ashx','10.2.50.57','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_weism','10.3.35.4',8300,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_wuxl','10.3.4.20',8001,NULL,'',0,0,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_xg_liy','10.3.4.22',8001,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_xg_quls','10.3.4.5',9300,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_xuj','10.3.4.10',8300,NULL,'',1,1,3,600,0,'http://transfer.gyyx.cn:81/WenDaoServiceV2/Register.ashx','10.2.48.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_xuj_30','10.2.50.30',8300,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_yugq','10.3.4.26',8021,NULL,'',1,1,3,600,0,'http://transfer.gyyx.cn:81/WenDaoServiceV2/Register.ashx','10.2.48.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_zenghh','10.3.4.30',8001,NULL,'',1,1,3,600,0,'http://transfer.gyyx.cn:81/WenDaoServiceV2/Register.ashx','10.2.48.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_zenghh_1','10.3.4.30',9001,NULL,'',1,1,3,600,0,'','10.3.4.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('aaa_zhangq3_30','10.3.102.39',8300,NULL,'',1,1,3,600,0,'http://transfer.gyyx.cn:81/WenDaoServiceV2/Register.ashx','10.2.48.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('p01g_aaa_pack','10.2.50.57',8857,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,'http://10.2.50.58/simulateforum/passpod.php',NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('p01g_aaa_pack58','10.2.50.58',8857,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('p01_aaa_hong','10.3.4.4',10001,NULL,'',1,1,3,600,0,'','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('p01_aaa_hongjs','10.3.4.4',8001,NULL,'',1,1,3,600,0,'http://transfer.gyyx.cn:81/WenDaoServiceV2/Register.ashx','','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('p01_aaa_shuxx','10.3.4.12',8001,NULL,'',1,1,30,1,0,'http://transfer.gyyx.cn:81/WenDaoServiceV2/Register.ashx','10.2.48.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
INSERT INTO `aaa` (`aaa`, `ip`, `port`, `attrib`, `server_key`, `num`, `id`, `error_password_times`, `busy_time`, `client_per_ip`, `activate_url`, `activate_aaa_ip`, `ecard_fill_url`, `ecard_resend_url`, `ecard_web_status_url`, `antibot_server`, `antibot_action`, `passpod_server`, `auth_server`, `coin_trade_server`, `recharge_url`, `inquiry_url`, `sms_auth_url`, `memo`) VALUES ('p01_aaa_yeyh2','10.3.102.24',8054,NULL,'',1,1,3,600,0,'http://transfer.gyyx.cn:81/WenDaoServiceV2/Register.ashx','10.2.48.30','','','',NULL,NULL,NULL,NULL,'transfer.gyyx.cn:81','','','http:// interface.message.gyyx.cn/v1/Send/Account',NULL);
/*!40000 ALTER TABLE `aaa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_comp`
--

DROP TABLE IF EXISTS `acc_comp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_comp` (
  `dist` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `branch` varchar(128) NOT NULL DEFAULT '',
  `comp` varchar(128) NOT NULL DEFAULT '',
  `time` varchar(14) NOT NULL DEFAULT '',
  `gid` varchar(128) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dist`,`account`,`branch`,`comp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_comp`
--

LOCK TABLES `acc_comp` WRITE;
/*!40000 ALTER TABLE `acc_comp` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_comp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_log`
--

DROP TABLE IF EXISTS `acc_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(15) NOT NULL DEFAULT '',
  `time` varchar(14) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `msg` text,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`) USING BTREE,
  KEY `account` (`account`) USING BTREE,
  KEY `time` (`time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_log`
--

LOCK TABLES `acc_log` WRITE;
/*!40000 ALTER TABLE `acc_log` DISABLE KEYS */;
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (1,'','20180305180352','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"0D0B6AA0F3D5B7A1F5B6CD835A6C8566\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:01:43\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"3AB1E404355FA9680275241BD0CCE506\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (2,'','20180305180403','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"0D0B6AA0F3D5B7A1F5B6CD835A6C8566\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:01:43\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"3AB1E404355FA9680275241BD0CCE506\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (3,'','20180305180931','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"0D0B6AA0F3D5B7A1F5B6CD835A6C8566\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:01:43\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"3AB1E404355FA9680275241BD0CCE506\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (4,'','20180305181014','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"0D0B6AA0F3D5B7A1F5B6CD835A6C8566\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:01:43\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"3AB1E404355FA9680275241BD0CCE506\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (5,'','20180305181122','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:11:10\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (6,'','20180305181250','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"EBFFBDFF22F1529BA068F64AFCEA4D53\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:12:36\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"4CF2C75CC6002B50A5F85B6A293627BD\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (7,'','20180305181855','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"EBFFBDFF22F1529BA068F64AFCEA4D53\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:18:46\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"4CF2C75CC6002B50A5F85B6A293627BD\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (8,'','20180305182106','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"20170728030802\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"EBFFBDFF22F1529BA068F64AFCEA4D53\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:20:59\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"4CF2C75CC6002B50A5F85B6A293627BD\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (9,'','20180305182352','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"20170728030802\",\"presentee\":\"0\",\"last_login_time\":\"20180201110737\",\"org_permit_ip\":\"\",\"blocked_time\":\"\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"EBFFBDFF22F1529BA068F64AFCEA4D53\",\"last_login_ip\":\"127.0.0.1\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:23:48\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"4CF2C75CC6002B50A5F85B6A293627BD\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (10,'','20180305183710','q762373','','bad_checksum','([\"protect\":\"\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"8AE5D735AC61A70561794DA1F6E7B29C\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:36:59\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"EB54F700EA6710597529D3707D645CC9\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (11,'','20180305183720','q762373','','bad_checksum','([\"protect\":\"\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"8AE5D735AC61A70561794DA1F6E7B29C\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:36:59\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"EB54F700EA6710597529D3707D645CC9\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (12,'','20180305185623','q762373','','bad_checksum','([\"protect\":\"\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"8AE5D735AC61A70561794DA1F6E7B29C\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:56:13\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"D0E494213FC5A6F66700AE1E8751A62C\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (13,'','20180305185909','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"8AE5D735AC61A70561794DA1F6E7B29C\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 18:58:58\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"D0E494213FC5A6F66700AE1E8751A62C\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (14,'','20180305190034','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"8AE5D735AC61A70561794DA1F6E7B29C\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 19:00:28\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"688116B4D517BFC33428CD7EC13CFE8B\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (15,'','20180305190116','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"8AE5D735AC61A70561794DA1F6E7B29C\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 19:01:12\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"EB54F700EA6710597529D3707D645CC9\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
INSERT INTO `acc_log` (`id`, `ip`, `time`, `account`, `dist`, `type`, `msg`, `memo`) VALUES (16,'','20180305191855','q762373','','bad_checksum','([\"protect\":\"300\",\"account_id\":\"\",\"active_time\":\"\",\"mobile\":\"\",\"trade_lock_time\":\"\",\"gold_coin\":\"0\",\"ip\":\"\",\"permit_id\":\"\",\"last_trade_coin\":\"\",\"first_login_time\":\"\",\"presentee\":\"0\",\"last_login_time\":\"\",\"org_permit_ip\":\"\",\"blocked_time\":\"0\",\"id_num\":\"\",\"time\":\"0\",\"tel\":\"\",\"password\":\"8AE5D735AC61A70561794DA1F6E7B29C\",\"last_login_ip\":\"\",\"adult\":\"1\",\"locked\":\"\",\"update_time\":\"2018-03-05 19:01:12\",\"limit_trade_coin\":\"0\",\"birthday\":\"\",\"memo\":\"\",\"trade_coin\":\"0\",\"id_type\":\"\",\"email\":\"\",\"silver_coin\":\"0\",\"unlock_coin_password_time\":\"\",\"auto_lock\":\"0\",\"temp_blocked_time\":\"\",\"coin_password\":\"\",\"privilege\":\"0\",\"name\":\"\",\"permit_ip\":\"\",\"first_login_mac\":\"\",\"last_consum_coin\":\"\",\"consum_coin\":\"0\",\"last_login_id\":\"\",\"blocked_reason\":\"\",\"org_password\":\"\",\"checksum\":\"EB54F700EA6710597529D3707D645CC9\",\"temp_blocked_reason\":\"\",\"active_path\":\"0\",\"reg_date\":\"\",\"account\":\"q762373\",])','');
/*!40000 ALTER TABLE `acc_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `blocked_time` varchar(14) NOT NULL DEFAULT '0',
  `blocked_reason` varchar(128) NOT NULL DEFAULT '',
  `temp_blocked_time` varchar(14) NOT NULL DEFAULT '',
  `temp_blocked_reason` varchar(128) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `protect` varchar(32) NOT NULL DEFAULT '',
  `auto_lock` int(11) NOT NULL DEFAULT '0',
  `locked` varchar(14) NOT NULL DEFAULT '',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `silver_coin` int(11) NOT NULL DEFAULT '0',
  `limit_trade_coin` int(11) NOT NULL DEFAULT '0',
  `trade_lock_time` varchar(14) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `birthday` varchar(8) NOT NULL DEFAULT '',
  `id_type` varchar(32) NOT NULL DEFAULT '',
  `id_num` varchar(32) NOT NULL DEFAULT '',
  `tel` varchar(32) NOT NULL DEFAULT '',
  `mobile` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(32) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT '0',
  `active_time` varchar(14) NOT NULL DEFAULT '',
  `first_login_time` varchar(14) NOT NULL DEFAULT '',
  `first_login_mac` varchar(32) NOT NULL DEFAULT '',
  `privilege` int(11) unsigned NOT NULL DEFAULT '0',
  `account_id` varchar(32) NOT NULL DEFAULT '',
  `permit_ip` varchar(128) NOT NULL DEFAULT '',
  `permit_id` varchar(128) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `adult` tinyint(4) NOT NULL DEFAULT '1',
  `checksum` varchar(32) NOT NULL DEFAULT '',
  `coin_password` varchar(32) NOT NULL DEFAULT '',
  `unlock_coin_password_time` varchar(14) NOT NULL DEFAULT '',
  `org_password` varchar(32) NOT NULL DEFAULT '',
  `org_permit_ip` varchar(128) NOT NULL DEFAULT '',
  `last_login_time` varchar(14) NOT NULL DEFAULT '',
  `last_login_ip` varchar(128) NOT NULL DEFAULT '',
  `last_login_id` varchar(32) NOT NULL DEFAULT '',
  `presentee` tinyint(4) NOT NULL DEFAULT '0',
  `reg_date` varchar(14) NOT NULL DEFAULT '',
  `active_path` tinyint(4) NOT NULL DEFAULT '0',
  `trade_coin` int(11) NOT NULL DEFAULT '0',
  `last_trade_coin` char(14) NOT NULL DEFAULT '',
  `consum_coin` int(11) NOT NULL DEFAULT '0',
  `last_consum_coin` char(14) NOT NULL DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `memo` text,
  PRIMARY KEY (`account`),
  KEY `last_login_time` (`last_login_time`) USING BTREE,
  KEY `update_time` (`update_time`) USING BTREE,
  KEY `active_time` (`active_time`) USING BTREE,
  KEY `reg_date` (`reg_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`account`, `blocked_time`, `blocked_reason`, `temp_blocked_time`, `temp_blocked_reason`, `password`, `protect`, `auto_lock`, `locked`, `gold_coin`, `silver_coin`, `limit_trade_coin`, `trade_lock_time`, `name`, `birthday`, `id_type`, `id_num`, `tel`, `mobile`, `email`, `time`, `active_time`, `first_login_time`, `first_login_mac`, `privilege`, `account_id`, `permit_ip`, `permit_id`, `ip`, `adult`, `checksum`, `coin_password`, `unlock_coin_password_time`, `org_password`, `org_permit_ip`, `last_login_time`, `last_login_ip`, `last_login_id`, `presentee`, `reg_date`, `active_path`, `trade_coin`, `last_trade_coin`, `consum_coin`, `last_consum_coin`, `update_time`, `memo`) VALUES ('a123123','','','','','801B9C334F2D516BCE32753668109524','',0,'',1000000000,50000,0,'','','','','','','','',0,'','','',0,'','','','',1,'6856F9B5A0C291FDA10AE5D36133A03F','','','','','','','',0,'',0,0,'',0,'20170912191444','2018-04-13 08:07:09','xf_gateway [123123]');
INSERT INTO `account` (`account`, `blocked_time`, `blocked_reason`, `temp_blocked_time`, `temp_blocked_reason`, `password`, `protect`, `auto_lock`, `locked`, `gold_coin`, `silver_coin`, `limit_trade_coin`, `trade_lock_time`, `name`, `birthday`, `id_type`, `id_num`, `tel`, `mobile`, `email`, `time`, `active_time`, `first_login_time`, `first_login_mac`, `privilege`, `account_id`, `permit_ip`, `permit_id`, `ip`, `adult`, `checksum`, `coin_password`, `unlock_coin_password_time`, `org_password`, `org_permit_ip`, `last_login_time`, `last_login_ip`, `last_login_id`, `presentee`, `reg_date`, `active_path`, `trade_coin`, `last_trade_coin`, `consum_coin`, `last_consum_coin`, `update_time`, `memo`) VALUES ('q762373','0','','','','8AE5D735AC61A70561794DA1F6E7B29C','300',0,'',0,0,0,'','','','','','','','',0,'','','',0,'','','','',1,'EB54F700EA6710597529D3707D645CC9','','','','','','','',0,'',0,0,'',0,'','2018-03-05 11:01:12',NULL);
INSERT INTO `account` (`account`, `blocked_time`, `blocked_reason`, `temp_blocked_time`, `temp_blocked_reason`, `password`, `protect`, `auto_lock`, `locked`, `gold_coin`, `silver_coin`, `limit_trade_coin`, `trade_lock_time`, `name`, `birthday`, `id_type`, `id_num`, `tel`, `mobile`, `email`, `time`, `active_time`, `first_login_time`, `first_login_mac`, `privilege`, `account_id`, `permit_ip`, `permit_id`, `ip`, `adult`, `checksum`, `coin_password`, `unlock_coin_password_time`, `org_password`, `org_permit_ip`, `last_login_time`, `last_login_ip`, `last_login_id`, `presentee`, `reg_date`, `active_path`, `trade_coin`, `last_trade_coin`, `consum_coin`, `last_consum_coin`, `update_time`, `memo`) VALUES ('stanwind','','','','','5A453BE895F282271E1FAFB6877D5924','',0,'',499046200,50000,0,'','','','','','','','',0,'','20180413155302','0000001c42f48da8',0,'','','','',1,'619E7D0B800B79C4F301981CBF933504','','','','','20180413155255','182.100.43.245','0000001c42f48da8',0,'',0,0,'',953800,'20180413160609','2018-04-13 07:56:58','xf_gateway [szdhmwqsxd]');
INSERT INTO `account` (`account`, `blocked_time`, `blocked_reason`, `temp_blocked_time`, `temp_blocked_reason`, `password`, `protect`, `auto_lock`, `locked`, `gold_coin`, `silver_coin`, `limit_trade_coin`, `trade_lock_time`, `name`, `birthday`, `id_type`, `id_num`, `tel`, `mobile`, `email`, `time`, `active_time`, `first_login_time`, `first_login_mac`, `privilege`, `account_id`, `permit_ip`, `permit_id`, `ip`, `adult`, `checksum`, `coin_password`, `unlock_coin_password_time`, `org_password`, `org_permit_ip`, `last_login_time`, `last_login_ip`, `last_login_id`, `presentee`, `reg_date`, `active_path`, `trade_coin`, `last_trade_coin`, `consum_coin`, `last_consum_coin`, `update_time`, `memo`) VALUES ('test','','','','','CCE77B0DB6F881BF119A7F14C4FCDE50','',0,'',498609072,50000,0,'','','','','','','','',0,'','20180413155549','0000b8975aaa87f8',0,'','','','',1,'8FFE5BF7482C414FF82B251DD1BD0369','','','','','20180413155540','116.208.216.141','0000b8975aaa87f8',0,'',0,0,'',1390928,'20180413160907','2018-04-13 07:58:02','xf_gateway [123123]');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_code`
--

DROP TABLE IF EXISTS `account_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_code` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `account_code` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_code`
--

LOCK TABLES `account_code` WRITE;
/*!40000 ALTER TABLE `account_code` DISABLE KEYS */;
INSERT INTO `account_code` (`id`, `account`, `password`, `account_code`, `update_time`, `create_time`) VALUES (1,'q7623731','123456789',0,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `account_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_coin_trade`
--

DROP TABLE IF EXISTS `account_coin_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_coin_trade` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `checksum` varchar(32) NOT NULL DEFAULT '0',
  `update_time` char(14) NOT NULL DEFAULT '',
  `memo` text NOT NULL,
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_coin_trade`
--

LOCK TABLES `account_coin_trade` WRITE;
/*!40000 ALTER TABLE `account_coin_trade` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_coin_trade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_account`
--

DROP TABLE IF EXISTS `activity_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_account` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `activity` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_account`
--

LOCK TABLES `activity_account` WRITE;
/*!40000 ALTER TABLE `activity_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `add_coin_log`
--

DROP TABLE IF EXISTS `add_coin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `add_coin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `add_time` varchar(14) NOT NULL DEFAULT '',
  `silver_coin_left` int(11) NOT NULL DEFAULT '0',
  `gold_coin_left` int(11) NOT NULL DEFAULT '0',
  `add_silver_coin` int(11) NOT NULL DEFAULT '0',
  `add_gold_coin` int(11) NOT NULL DEFAULT '0',
  `cur_gold_coin` int(11) NOT NULL DEFAULT '0',
  `cur_silver_coin` int(11) NOT NULL DEFAULT '0',
  `gs_memo` text,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `account` (`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `add_coin_log`
--

LOCK TABLES `add_coin_log` WRITE;
/*!40000 ALTER TABLE `add_coin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `add_coin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `add_gold_coin_log`
--

DROP TABLE IF EXISTS `add_gold_coin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `add_gold_coin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `cost_time` varchar(14) NOT NULL DEFAULT '',
  `cost_platform` tinyint(4) NOT NULL DEFAULT '0',
  `cost_coin` int(11) NOT NULL DEFAULT '0',
  `item_price` int(11) NOT NULL DEFAULT '0',
  `buy_item` varchar(32) NOT NULL DEFAULT '',
  `buy_item_amount` int(11) NOT NULL DEFAULT '0',
  `silver_coin_cost` int(11) NOT NULL DEFAULT '0',
  `silver_coin_left` int(11) NOT NULL DEFAULT '0',
  `gold_coin_cost` int(11) NOT NULL DEFAULT '0',
  `gold_coin_left` int(11) NOT NULL DEFAULT '0',
  `cur_state` int(11) NOT NULL DEFAULT '0',
  `uid` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(32) NOT NULL DEFAULT '',
  `gs_memo` text,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `account` (`account`) USING BTREE,
  KEY `cost_time` (`cost_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `add_gold_coin_log`
--

LOCK TABLES `add_gold_coin_log` WRITE;
/*!40000 ALTER TABLE `add_gold_coin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `add_gold_coin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_acc`
--

DROP TABLE IF EXISTS `admin_acc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_acc` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `privilege` text NOT NULL,
  `permit_ip` varchar(128) NOT NULL DEFAULT '',
  `permit_id` varchar(128) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_acc`
--

LOCK TABLES `admin_acc` WRITE;
/*!40000 ALTER TABLE `admin_acc` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_acc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ahserver`
--

DROP TABLE IF EXISTS `ahserver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ahserver` (
  `ahserver` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`ahserver`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ahserver`
--

LOCK TABLES `ahserver` WRITE;
/*!40000 ALTER TABLE `ahserver` DISABLE KEYS */;
/*!40000 ALTER TABLE `ahserver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alipay_account`
--

DROP TABLE IF EXISTS `alipay_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alipay_account` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `alipay_account` varchar(255) NOT NULL DEFAULT '',
  `bind_time` char(14) NOT NULL DEFAULT '',
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `update_time` char(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alipay_account`
--

LOCK TABLES `alipay_account` WRITE;
/*!40000 ALTER TABLE `alipay_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `alipay_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antiaddiction`
--

DROP TABLE IF EXISTS `antiaddiction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `antiaddiction` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `last_offline` int(10) NOT NULL DEFAULT '0',
  `total_offline` int(10) NOT NULL DEFAULT '0',
  `total_online` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antiaddiction`
--

LOCK TABLES `antiaddiction` WRITE;
/*!40000 ALTER TABLE `antiaddiction` DISABLE KEYS */;
/*!40000 ALTER TABLE `antiaddiction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antibot_log`
--

DROP TABLE IF EXISTS `antibot_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `antibot_log` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) NOT NULL DEFAULT '',
  `account` varchar(32) DEFAULT NULL,
  `bot_type` varchar(16) DEFAULT NULL,
  `bot_content` text,
  `time` varchar(14) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`no`),
  KEY `bot_type` (`bot_type`) USING BTREE,
  KEY `ip` (`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antibot_log`
--

LOCK TABLES `antibot_log` WRITE;
/*!40000 ALTER TABLE `antibot_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `antibot_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_bind`
--

DROP TABLE IF EXISTS `app_bind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_bind` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `bind_type` tinyint(4) NOT NULL DEFAULT '1',
  `bind_time` char(14) NOT NULL DEFAULT '',
  `update_time` char(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_bind`
--

LOCK TABLES `app_bind` WRITE;
/*!40000 ALTER TABLE `app_bind` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_bind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arena_account`
--

DROP TABLE IF EXISTS `arena_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arena_account` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arena_account`
--

LOCK TABLES `arena_account` WRITE;
/*!40000 ALTER TABLE `arena_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `arena_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_info`
--

DROP TABLE IF EXISTS `card_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_info` (
  `number` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `count` int(11) NOT NULL DEFAULT '0',
  `used` int(11) NOT NULL DEFAULT '0',
  `locked` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_info`
--

LOCK TABLES `card_info` WRITE;
/*!40000 ALTER TABLE `card_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `card_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ccs`
--

DROP TABLE IF EXISTS `ccs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs` (
  `ccs` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(31) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL DEFAULT '0',
  `server_key` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`ccs`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ccs`
--

LOCK TABLES `ccs` WRITE;
/*!40000 ALTER TABLE `ccs` DISABLE KEYS */;
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('','',0,'',0,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_coding','10.2.50.30',8100,'coding',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_daili','118.24.7.124',8110,'问道一区',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_dongsh','10.3.4.35',8100,'dongsh',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_jiangw_30','10.2.50.30',8010,'jiangw_30',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_jiangw_pk','10.2.50.30',8012,'pk',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_luoyh','10.3.4.25',8010,'luoyh',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_quls_30','10.3.4.5',8100,'quls_30',0,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_test','10.2.50.57',12087,'test',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_weism','10.3.35.4',8100,'weism',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_wuxl','10.3.4.20',8004,'wuxl',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_wuxl2','10.3.4.20',8014,'wuxl2',2,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_xg_liy','10.3.4.22',8303,'xg_liy',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_xg_quls','10.3.4.5',9100,'quls_xg',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_xg_zenghh','10.3.4.2',9100,'zenghh_xg',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_xuj','10.3.4.10',8100,'xuj',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_xuj_30','10.2.50.30',8100,'xuj_30',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_yugq','10.3.4.26',8002,'yugq',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_zenghh','10.3.4.30',8005,'zenghh',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('ccs_zhangq3_30','10.3.102.39',8100,'zhangq3',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('p01g_ccs_pack','10.2.50.57',9887,'gy_pack',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('p01g_ccs_pack58','10.2.50.58',9887,'gy_pack58',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('p01_ccs_hong','10.3.4.4',10005,'hong',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('p01_ccs_hongjs','10.3.4.4',8005,'hongjs',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('p01_ccs_shuxx','10.3.4.12',8005,'shuxx',1,'',NULL);
INSERT INTO `ccs` (`ccs`, `ip`, `port`, `dist`, `id`, `server_key`, `memo`) VALUES ('p01_ccs_yeyh2','10.3.4.2',8087,'yeyh2',1,'',NULL);
/*!40000 ALTER TABLE `ccs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge`
--

DROP TABLE IF EXISTS `charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `count` int(11) NOT NULL DEFAULT '0',
  `end_time` varchar(14) NOT NULL DEFAULT '',
  `card_bonus` int(11) NOT NULL DEFAULT '0',
  `gender` int(11) NOT NULL DEFAULT '0',
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`account`,`dist`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge`
--

LOCK TABLES `charge` WRITE;
/*!40000 ALTER TABLE `charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_encourage`
--

DROP TABLE IF EXISTS `charge_encourage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_encourage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `encourage` varchar(128) NOT NULL DEFAULT '0',
  `start_time` char(14) NOT NULL DEFAULT '0',
  `end_time` char(14) NOT NULL DEFAULT '',
  `checksum` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `gold_coin` (`gold_coin`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_encourage`
--

LOCK TABLES `charge_encourage` WRITE;
/*!40000 ALTER TABLE `charge_encourage` DISABLE KEYS */;
/*!40000 ALTER TABLE `charge_encourage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_log`
--

DROP TABLE IF EXISTS `charge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `charge_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `src_ip` varchar(15) NOT NULL DEFAULT '',
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `number` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `delta_count` int(11) NOT NULL DEFAULT '0',
  `delta_time` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `end_time` varchar(14) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `account` (`account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_log`
--

LOCK TABLES `charge_log` WRITE;
/*!40000 ALTER TABLE `charge_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `charge_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citywar_account`
--

DROP TABLE IF EXISTS `citywar_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citywar_account` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citywar_account`
--

LOCK TABLES `citywar_account` WRITE;
/*!40000 ALTER TABLE `citywar_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `citywar_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coin_red_packets_log`
--

DROP TABLE IF EXISTS `coin_red_packets_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coin_red_packets_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(12) NOT NULL DEFAULT '',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL DEFAULT '0',
  `gold_coin_before` int(11) NOT NULL DEFAULT '0',
  `gold_coin_after` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coin_red_packets_log`
--

LOCK TABLES `coin_red_packets_log` WRITE;
/*!40000 ALTER TABLE `coin_red_packets_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `coin_red_packets_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coin_trade_log`
--

DROP TABLE IF EXISTS `coin_trade_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coin_trade_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(12) NOT NULL DEFAULT '',
  `order_id` varchar(15) NOT NULL DEFAULT '',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL DEFAULT '0',
  `gold_coin_before` int(11) NOT NULL DEFAULT '0',
  `gold_coin_after` int(11) NOT NULL DEFAULT '0',
  `store_coin_before` int(11) NOT NULL DEFAULT '0',
  `store_coin_after` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coin_trade_log`
--

LOCK TABLES `coin_trade_log` WRITE;
/*!40000 ALTER TABLE `coin_trade_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `coin_trade_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `version` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(255) NOT NULL DEFAULT '',
  `section` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  `checksum` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`version`,`dist`,`section`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','门派比武大会','三线:金系/三线:木系/二线:水系/二线:火系/三线:土系','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','baishou_shengyan','([\"一线\":({40,79,}),\"一线\":({80,99,}),\"一线\":({100,119,}),\"一线\":({120,159,}),])','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','chongzhi_fanli','({\"2017-03-18-00:00:00\",\"2017-03-20-17:14:59\", 1})','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','CITY_WAR_SERVER','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','dongfu_tiaozhan','一线','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','douchong_dahui','一线','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','试道大会','三线:60-69,70-79,80-89/三线:90-99,100-109,110-119/二线:120-129,130-139,140-149,150-159,160-169','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','fishing_server','({\"一线\",\"二线\" })','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','group_buying_server','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','hero_boss_server','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','journey_of_asktao','([ \"date\" : \"20160713\", \"checksum\" : \"5FA8074842CF18DF6DDBEEB02BC8E289\" ])','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','ldb_host','127.0.0.1:','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','lgxy_server','一线','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','longxue_boss_server','一线','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','map_decorate_server','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','mdb_host','127.0.0.1:','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','party_qkbgz','([4:\"三线\",3:\"二线\",2:\"一线\",])','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','party_qql','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','party_sell_servers','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','red_envelope','([ \"start_time\" : \"2016-01-09-00:00:00\", \"sort_end_time\" : \"2016-02-27-23:59:59\", \"end_time\" : \"2016-02-28-23:59:59\", \"envelope_list\" : ({ ([\"time\" : \"2016-01-18-14:00:00\",\"coin\" : 3000000,\"amount\" : 3000,]),([\"time\" : \"2016-01-18-16:00:00\",\"coin\" : 3000000,\"amount\" : 3000,]),([\"time\" : \"2016-01-23-14:00:00\",\"coin\" : 100000,\"amount\" : 100,]),([\"time\" : \"2016-01-23-16:00:00\",\"coin\" : 100000,\"amount\" : 100,]),([\"time\" : \"2016-01-24-14:00:00\",\"coin\" : 100000,\"amount\" : 100,]),([\"time\" : \"2016-01-24-16:00:00\",\"coin\" : 100000,\"amount\" : 100,]) }), \"sys_name\" : \"ê??ü?ê\", \"version\" : 3 ])','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','send_exp_online','([\"end_time\":\"2010-06-29-12:00:00\",\"start_time\":\"2010-06-29-10:00:00\",\"interval\":0,\"duration\":0,])','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','shengsidou','1','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','sncbc_open_gs','({\"一线\",\"二线\" })','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','super_boss_server','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','task_control_server','一线','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','vendue_place','一线','','NULL');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','WAR_GROUP_A','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','WAR_GROUP_B','二线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','WAR_GROUP_C','三线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','wedding_server','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','world_boss_server','一线','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','world_level_config','0','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','wuzhuangyuan','一线:60-69,70-79/一线:80-89,90-99/一线:100-109,110-119/一线:120-129,130-139,140-149,150-159,160-169','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','xinfjjwz','([ \"start_time\" : \"2017-07-01-20:00:00\", \"end_time\" : \"问道一区-08-21-19:59:59\" ])','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','xinfu_chongbang','([ \"start_time\" : \"2016-08-08-00:00:00\", \"end_time\" : \"2016-08-31-23:59:59\", \"bonus_time\" : \"2016-09-06-23:59:59\", \"order_end_time\" : \"2016-09-10-23:59:59\", \"url\" : \"http://wd.gyyx.cn/huodong/wdxf/tf/bwcx/cbbs/index.html\" ])','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','xiygc_zhenyz','({\"一线\"})','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','xiygc_zhenyzb','([\"40-69\":1,\"70-79\":1,\"80-89\":1,\"90-99\":1,\"100-109\":1,\"110-119\":1,\"120-129\":1,\"130-139\":1,\"140-149\":1,\"150-159\":1,\"160-169\":1])','','');
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','yuqing_shandian_challenge','一线','',NULL);
INSERT INTO `config` (`version`, `dist`, `section`, `name`, `value`, `checksum`, `memo`) VALUES ('','问道一区','global','比武大会','三线:60-69,70-79/一线:80-89,90-99/二线:100-109,110-119/三线:120-129,130-139,140-149','',NULL);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cost_log`
--

DROP TABLE IF EXISTS `cost_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cost_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `cost_time` varchar(14) NOT NULL DEFAULT '',
  `cost_platform` tinyint(4) NOT NULL DEFAULT '0',
  `cost_coin` int(11) NOT NULL DEFAULT '0',
  `item_price` int(11) NOT NULL DEFAULT '0',
  `buy_item` varchar(32) NOT NULL DEFAULT '',
  `buy_item_amount` int(11) NOT NULL DEFAULT '0',
  `silver_coin_cost` int(11) NOT NULL DEFAULT '0',
  `silver_coin_left` int(11) NOT NULL DEFAULT '0',
  `gold_coin_cost` int(11) NOT NULL DEFAULT '0',
  `gold_coin_left` int(11) NOT NULL DEFAULT '0',
  `cur_state` int(11) NOT NULL DEFAULT '0',
  `uid` varchar(32) NOT NULL DEFAULT '',
  `para1` varchar(32) NOT NULL DEFAULT '',
  `para2` varchar(32) NOT NULL DEFAULT '',
  `para3` varchar(32) NOT NULL DEFAULT '',
  `gs_memo` text,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `account` (`account`) USING BTREE,
  KEY `cost_time` (`cost_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cost_log`
--

LOCK TABLES `cost_log` WRITE;
/*!40000 ALTER TABLE `cost_log` DISABLE KEYS */;
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (1,'0000000000000001','stanwind','一线','问道一区','20180413155716',0,2800,2800,'会员卡',1,0,50000,2800,499997200,0,'5AD062DC00010198243E','1','','','type=在线商城/name=会员卡/amount=1/price=2800/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (2,'0000000000000002','test','一线','问道一区','20180413155904',0,566000,566000,'360天年费会员卡',1,0,50000,566000,499434000,0,'5AD06348000101982440','3','','','type=在线商城/name=360天年费会员卡/amount=1/price=566000/level=3/level=3',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (3,'0000000000000002','test','一线','问道一区','20180413155923',0,800000,20000,'锦囊',40,0,50000,800000,498634000,0,'5AD0635B000101982442','3','','','type=在线商城/name=锦囊/amount=40/price=20000/level=3/level=3',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (4,'0000000000000001','stanwind','一线','问道一区','20180413160007',0,100000,100000,'北极熊',1,0,50000,100000,499897200,0,'5AD06387000101982477','1','','','type=在线商城/name=北极熊/amount=1/price=100000/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (5,'0000000000000001','stanwind','一线','问道一区','20180413160023',0,240000,20000,'锦囊',12,0,50000,240000,499657200,0,'5AD06397000101982479','1','','','type=在线商城/name=锦囊/amount=12/price=20000/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (6,'0000000000000002','test','一线','问道一区','20180413160048',0,5000,5000,'喇叭',1,0,50000,5000,498629000,0,'5AD063B0000101982490','5','','','type=在线商城/name=喇叭/amount=1/price=5000/level=5/level=5',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (7,'0000000000000001','stanwind','一线','问道一区','20180413160128',0,5000,5000,'喇叭',1,0,50000,5000,499652200,0,'5AD063D8000101982493','1','','','type=在线商城/name=喇叭/amount=1/price=5000/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (8,'0000000000000002','test','一线','问道一区','20180413160337',0,328,328,'特级八卦阴阳令',1,0,50000,328,498628672,0,'5AD06459000101982499','13','','','type=在线商城/name=特级八卦阴阳令/amount=1/price=328/level=13/level=13',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (9,'0000000000000001','stanwind','一线','问道一区','20180413160348',0,8000,8000,'高级道具套餐卡',1,0,50000,8000,499644200,0,'5AD0646400010198249B','1','','','type=在线商城/name=高级道具套餐卡/amount=1/price=8000/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (10,'0000000000000001','stanwind','一线','问道一区','20180413160349',0,8000,8000,'高级道具套餐卡',1,0,50000,8000,499636200,0,'5AD0646500010198249D','1','','','type=在线商城/name=高级道具套餐卡/amount=1/price=8000/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (11,'0000000000000001','stanwind','一线','问道一区','20180413160349',0,8000,8000,'高级道具套餐卡',1,0,50000,8000,499628200,0,'5AD0646500010198249F','1','','','type=在线商城/name=高级道具套餐卡/amount=1/price=8000/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (12,'0000000000000001','stanwind','一线','问道一区','20180413160350',0,8000,8000,'高级道具套餐卡',1,0,50000,8000,499620200,0,'5AD064660001019824A1','1','','','type=在线商城/name=高级道具套餐卡/amount=1/price=8000/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (13,'0000000000000001','stanwind','一线','问道一区','20180413160426',0,566000,566000,'360天年费会员卡',1,0,50000,566000,499054200,0,'5AD0648A0001019824A3','1','','','type=在线商城/name=360天年费会员卡/amount=1/price=566000/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (14,'0000000000000001','stanwind','一线','问道一区','20180413160609',0,8000,8000,'喇叭',1,0,50000,8000,499046200,0,'5AD064F10001019824AC','1','','','type=在线商城/name=喇叭/amount=1/price=8000/level=1/level=1',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (15,'0000000000000002','test','一线','问道一区','20180413160714',0,800,800,'高级血池',1,0,50000,800,498627872,0,'5AD065320001019824AE','16','','','type=在线商城/name=高级血池/amount=1/price=800/level=16/level=16',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (16,'0000000000000002','test','一线','问道一区','20180413160716',0,2400,2400,'高级灵池',1,0,50000,2400,498625472,0,'5AD065340001019824B0','16','','','type=在线商城/name=高级灵池/amount=1/price=2400/level=16/level=16',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (17,'0000000000000002','test','一线','问道一区','20180413160719',0,800,800,'高级血池',1,0,50000,800,498624672,0,'5AD065370001019824B2','16','','','type=在线商城/name=高级血池/amount=1/price=800/level=16/level=16',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (18,'0000000000000002','test','一线','问道一区','20180413160721',0,2400,2400,'高级灵池',1,0,50000,2400,498622272,0,'5AD065390001019824B4','16','','','type=在线商城/name=高级灵池/amount=1/price=2400/level=16/level=16',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (19,'0000000000000002','test','一线','问道一区','20180413160732',0,800,800,'高级血池',1,0,50000,800,498621472,0,'5AD065440001019824B6','16','','','type=在线商城/name=高级血池/amount=1/price=800/level=16/level=16',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (20,'0000000000000002','test','一线','问道一区','20180413160734',0,2400,2400,'高级灵池',1,0,50000,2400,498619072,0,'5AD065460001019824B8','16','','','type=在线商城/name=高级灵池/amount=1/price=2400/level=16/level=16',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (21,'0000000000000002','test','一线','问道一区','20180413160906',0,5000,5000,'喇叭',1,0,50000,5000,498614072,0,'5AD065A20001019824BB','16','','','type=在线商城/name=喇叭/amount=1/price=5000/level=16/level=16',NULL);
INSERT INTO `cost_log` (`id`, `gid`, `account`, `server`, `dist`, `cost_time`, `cost_platform`, `cost_coin`, `item_price`, `buy_item`, `buy_item_amount`, `silver_coin_cost`, `silver_coin_left`, `gold_coin_cost`, `gold_coin_left`, `cur_state`, `uid`, `para1`, `para2`, `para3`, `gs_memo`, `memo`) VALUES (22,'0000000000000002','test','一线','问道一区','20180413160907',0,5000,5000,'喇叭',1,0,50000,5000,498609072,0,'5AD065A30001019824BD','16','','','type=在线商城/name=喇叭/amount=1/price=5000/level=16/level=16',NULL);
/*!40000 ALTER TABLE `cost_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_info`
--

DROP TABLE IF EXISTS `coupon_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupon_info` (
  `code` varchar(32) NOT NULL DEFAULT '',
  `gid` bigint(20) NOT NULL DEFAULT '0',
  `type` varchar(32) NOT NULL DEFAULT '',
  `used` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_info`
--

LOCK TABLES `coupon_info` WRITE;
/*!40000 ALTER TABLE `coupon_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupon_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_log`
--

DROP TABLE IF EXISTS `credit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `silver_coin` int(11) NOT NULL DEFAULT '0',
  `coupon_gold_used` int(11) NOT NULL DEFAULT '0',
  `coupon_silver_used` int(11) NOT NULL DEFAULT '0',
  `checksum` varchar(32) NOT NULL DEFAULT '',
  `time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `source` tinyint(4) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` int(11) NOT NULL DEFAULT '0',
  `para3` varchar(32) NOT NULL DEFAULT '',
  `para4` varchar(32) NOT NULL DEFAULT '',
  `para5` varchar(255) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`,`transaction_id`),
  KEY `account` (`account`) USING BTREE,
  KEY `time` (`time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_log`
--

LOCK TABLES `credit_log` WRITE;
/*!40000 ALTER TABLE `credit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cs_ccs`
--

DROP TABLE IF EXISTS `cs_ccs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_ccs` (
  `ccs` varchar(32) NOT NULL DEFAULT '',
  `role` text NOT NULL,
  `privilege` text NOT NULL,
  `ip` varchar(31) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `server_key` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`ccs`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cs_ccs`
--

LOCK TABLES `cs_ccs` WRITE;
/*!40000 ALTER TABLE `cs_ccs` DISABLE KEYS */;
INSERT INTO `cs_ccs` (`ccs`, `role`, `privilege`, `ip`, `port`, `id`, `dist`, `server_key`, `memo`) VALUES ('ccs_daili','LEAGUE_SOURCE/PARTYWAR_SOURCE/ARENA_SOURCE/BOTTLE_SOURCE/DRAFT_SOURCE/SDDH_SOURCE/EVERYONE_PK_SOURCE/CELEBRITY_SOURCE/SAMSUNG_SOURCE/CITYWAR_SOURCE/XGAME_SOURCE/ACTIVITY_SOURCE\r\n','*','128.24.7.124',8110,1,'问道一区','',NULL);
INSERT INTO `cs_ccs` (`ccs`, `role`, `privilege`, `ip`, `port`, `id`, `dist`, `server_key`, `memo`) VALUES ('ccs_pk','LEAGUE_COMPETE/PARTYWAR_COMPETE/ARENA_COMPETE/SDDH_COMPETE/CELEBRITY_COMPETE/SAMSUNG_COMPETE/CITYWAR_COMPETE/XGAME_COMPETE/EVERYONE_PK_COMPETE/ACTIVITY_COMPETE\r\n','*','128.24.7.124',8012,1,'pk','',NULL);
INSERT INTO `cs_ccs` (`ccs`, `role`, `privilege`, `ip`, `port`, `id`, `dist`, `server_key`, `memo`) VALUES ('ccs_quls_30','ARENA_SOURCE','*','10.3.4.5',8100,1,'quls_30','',NULL);
INSERT INTO `cs_ccs` (`ccs`, `role`, `privilege`, `ip`, `port`, `id`, `dist`, `server_key`, `memo`) VALUES ('ccs_xuj','ARENA_COMPETE','cmd_league_oper/cmd_partywar_oper/cmd_bottle_oper/cmd_arena_oper/cmd_draft_oper/cmd_sddh_oper   ','10.3.4.10',8100,1,'xuj','',NULL);
INSERT INTO `cs_ccs` (`ccs`, `role`, `privilege`, `ip`, `port`, `id`, `dist`, `server_key`, `memo`) VALUES ('ccs_yugq','','*','10.3.4.9',8002,1,'yugq','',NULL);
INSERT INTO `cs_ccs` (`ccs`, `role`, `privilege`, `ip`, `port`, `id`, `dist`, `server_key`, `memo`) VALUES ('p01_ccs_shuxx','','*','10.3.4.12',8005,1,'shuxx','',NULL);
/*!40000 ALTER TABLE `cs_ccs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cs_everyone_pk_account`
--

DROP TABLE IF EXISTS `cs_everyone_pk_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_everyone_pk_account` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cs_everyone_pk_account`
--

LOCK TABLES `cs_everyone_pk_account` WRITE;
/*!40000 ALTER TABLE `cs_everyone_pk_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `cs_everyone_pk_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csa`
--

DROP TABLE IF EXISTS `csa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csa` (
  `csa` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(32) NOT NULL DEFAULT '',
  `port` varchar(15) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL DEFAULT '0',
  `cs_dist` varchar(255) NOT NULL DEFAULT '',
  `http_ip` varchar(255) NOT NULL DEFAULT '',
  `http_port` int(11) NOT NULL DEFAULT '0',
  `http_plat` varchar(255) NOT NULL DEFAULT '',
  `httpd_enable` int(1) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`csa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csa`
--

LOCK TABLES `csa` WRITE;
/*!40000 ALTER TABLE `csa` DISABLE KEYS */;
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('csa_daili','118.24.7.124','6101',7,'问道一区','',0,'',0,'');
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('csa_dongsh','10.3.4.35','6001',3,'csa_dongsh','',0,'',0,'');
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('csa_hongjs','10.3.4.4','9051',2,'csa_hongjs','',0,'',0,'');
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('csa_luoyh','10.3.4.25','6001',9,'csa_luoyh','',0,'',0,'');
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('csa_quls','10.3.4.5','6001',1,'csa_quls','',0,'',0,'');
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('csa_shuxx','10.3.4.12','4052',4,'??·t·t???÷','',0,'',0,'');
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('csa_xuj','10.3.4.10','9999',8,'csa_xuj','',0,'',0,'');
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('csa_yugq','10.3.4.26','6001',6,'csa_yugq','',0,'',0,'');
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('csa_zenghh','10.3.4.30','8051',5,'csa_zenghh','',0,'',0,'');
INSERT INTO `csa` (`csa`, `ip`, `port`, `id`, `cs_dist`, `http_ip`, `http_port`, `http_plat`, `httpd_enable`, `memo`) VALUES ('p01_csa_yeyh2','10.3.102.24','4080',1,'??·t?D×a·t???÷','',0,'',0,'');
/*!40000 ALTER TABLE `csa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csw_account`
--

DROP TABLE IF EXISTS `csw_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csw_account` (
  `account` varchar(64) NOT NULL DEFAULT '',
  `dist` varchar(64) NOT NULL DEFAULT '',
  `gid` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csw_account`
--

LOCK TABLES `csw_account` WRITE;
/*!40000 ALTER TABLE `csw_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `csw_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csw_config`
--

DROP TABLE IF EXISTS `csw_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csw_config` (
  `csw_name` varchar(128) NOT NULL DEFAULT '',
  `csw_key` varchar(128) NOT NULL DEFAULT '',
  `csw_value` text,
  `memo` text,
  PRIMARY KEY (`csw_name`,`csw_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csw_config`
--

LOCK TABLES `csw_config` WRITE;
/*!40000 ALTER TABLE `csw_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `csw_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csw_party_info`
--

DROP TABLE IF EXISTS `csw_party_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csw_party_info` (
  `name` varchar(128) NOT NULL DEFAULT '',
  `dist` varchar(64) NOT NULL DEFAULT '',
  `party` varchar(128) NOT NULL DEFAULT '',
  `score` int(8) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`dist`,`party`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csw_party_info`
--

LOCK TABLES `csw_party_info` WRITE;
/*!40000 ALTER TABLE `csw_party_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `csw_party_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cta`
--

DROP TABLE IF EXISTS `cta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cta` (
  `cta` varchar(32) NOT NULL DEFAULT '',
  `privilege` varchar(255) NOT NULL DEFAULT '',
  `ip` varchar(255) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `access_adb_user` varchar(32) NOT NULL DEFAULT '',
  `access_adb_password` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`cta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cta`
--

LOCK TABLES `cta` WRITE;
/*!40000 ALTER TABLE `cta` DISABLE KEYS */;
INSERT INTO `cta` (`cta`, `privilege`, `ip`, `port`, `dist`, `access_adb_user`, `access_adb_password`, `memo`) VALUES ('chenqs','*','10.3.4.7',0,'yugq','chenqs','81DC9BDB52D04DC20036DBD8313ED055',NULL);
INSERT INTO `cta` (`cta`, `privilege`, `ip`, `port`, `dist`, `access_adb_user`, `access_adb_password`, `memo`) VALUES ('dongsh','*','10.3.4.35',0,'普天同庆','dongsh','81DC9BDB52D04DC20036DBD8313ED055',NULL);
INSERT INTO `cta` (`cta`, `privilege`, `ip`, `port`, `dist`, `access_adb_user`, `access_adb_password`, `memo`) VALUES ('hongjs','*','10.3.4.4,10.3.4.7',0,'hongjs','hongjs','81DC9BDB52D04DC20036DBD8313ED055',NULL);
INSERT INTO `cta` (`cta`, `privilege`, `ip`, `port`, `dist`, `access_adb_user`, `access_adb_password`, `memo`) VALUES ('shuxx','*','10.3.4.12',0,'shuxx','shuxx','81DC9BDB52D04DC20036DBD8313ED055',NULL);
INSERT INTO `cta` (`cta`, `privilege`, `ip`, `port`, `dist`, `access_adb_user`, `access_adb_password`, `memo`) VALUES ('xuj','*','10.3.102.191,10.3.102.62',0,'xuj','xuj','81DC9BDB52D04DC20036DBD8313ED055',NULL);
INSERT INTO `cta` (`cta`, `privilege`, `ip`, `port`, `dist`, `access_adb_user`, `access_adb_password`, `memo`) VALUES ('yugq','*','10.3.4.26',0,'yugq','yugq','81DC9BDB52D04DC20036DBD8313ED055',NULL);
INSERT INTO `cta` (`cta`, `privilege`, `ip`, `port`, `dist`, `access_adb_user`, `access_adb_password`, `memo`) VALUES ('普天同庆','*','118.24.7.124',0,'普天同庆','root','81DC9BDB52D04DC20036DBD8313ED055',NULL);
/*!40000 ALTER TABLE `cta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dba`
--

DROP TABLE IF EXISTS `dba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dba` (
  `dba` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `server_key` varchar(32) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`dba`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dba`
--

LOCK TABLES `dba` WRITE;
/*!40000 ALTER TABLE `dba` DISABLE KEYS */;
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_coding','10.2.50.30',8200,'coding','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_daili','118.24.7.124',8120,'问道一区','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_dongsh','10.3.4.35',8200,'dongsh','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_jiangw_30','10.2.50.30',8020,'jiangw_30','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_jiangw_pk','118.24.7.124',8022,'pk','',2,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_liy','10.3.102.75',8020,'liy','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_luoyh','10.3.4.25',8020,'luoyh','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_quls_30','10.3.4.5',8200,'quls_30','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_test','10.2.50.57',12065,'test','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_weism','10.3.35.4',8200,'weism','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_wuxl','10.3.4.20',8003,'wuxl','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_xg_quls','10.3.4.5',9200,'quls_xg','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_xuj','10.3.4.10',8200,'xuj','',1,'');
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_xuj_30','10.2.50.30',8200,'xuj_30','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_zenghh','10.3.4.30',8003,'zenghh','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('dba_zhangq3_30','10.3.102.39',8200,'zhangq3','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('p01d_dba_yugq32','10.3.4.26',8005,'yugq','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('p01g_dba_pack','10.2.50.57',9867,'gy_pack','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('p01g_dba_pack58','10.2.50.58',9867,'gy_pack58','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('p01_dba_hong','10.3.4.4',10003,'hong','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('p01_dba_hongjs','10.3.4.4',8003,'hongjs','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('p01_dba_shuxx','10.3.4.12',8003,'shuxx','',1,NULL);
INSERT INTO `dba` (`dba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('p01_dba_yeyh2','10.3.102.24',8076,'yeyh2','',1,NULL);
/*!40000 ALTER TABLE `dba` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddb`
--

DROP TABLE IF EXISTS `ddb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ddb` (
  `ddb` varchar(32) NOT NULL DEFAULT '',
  `user` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `driver` varchar(64) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`ddb`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddb`
--

LOCK TABLES `ddb` WRITE;
/*!40000 ALTER TABLE `ddb` DISABLE KEYS */;
/*!40000 ALTER TABLE `ddb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `district` (
  `dist` varchar(32) NOT NULL DEFAULT '',
  `alias` varchar(32) NOT NULL DEFAULT '',
  `service` varchar(255) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL DEFAULT '0',
  `spa` varchar(32) NOT NULL DEFAULT '',
  `csa` varchar(32) NOT NULL DEFAULT '',
  `party_war_server` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`dist`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('coding','','login/new_char/permit_wizard/new_account',1,'spa_coding','','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('dongsh','','login/new_char/permit_wizard/new_account',1,'spa_dongsh','','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('gy_pack','','login/new_char/permit_wizard/new_account',1,'p01g_spa_pack','','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('gy_pack58','','login/new_char/permit_wizard/new_account',1,'p01g_spa_pack58','','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('hong','','login/new_char/permit_wizard/new_account',1,'p01_spa_hong','p01_csa_hong','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('hongjs','','login/new_char/permit_wizard/new_account',1,'p01_spa_hongjs','csa_hongjs','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('问道一区','','login/new_char/permit_wizard/new_account/new_party',1,'spa_jiangw','csa_daili','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('jiangw_30','','login/new_char/permit_wizard/new_account',1,'spa_jiangw_30','csa_jiangw','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('jiangw_pk','','login/new_char/permit_wizard/new_account',2,'spa_jiangw_pk','csa_jiangw','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('luoyh','','login/new_char/permit_wizard/new_account',1,'spa_luoyh','csa_luoyh','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('quls_30','','login/new_char/permit_wizard/new_account',1,'spa_quls_30','csa_quls','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('shuxx','','login/new_char/permit_wizard/new_account/new_party',1,'p01_spa_shuxx','csa_shuxx','p01_gs_shuxx',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('test','','login/new_char/permit_wizard/new_account',1,'spa_test','','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('weism','','login/new_char/permit_wizard/new_account',1,'spa_weism','','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('wuxl','','login/new_char/permit_wizard/new_account',1,'spa_wuxl','','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('xg_liy','','login/new_char/permit_wizard/new_account',1,'spa_xg_liy','csa_xg_liy','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('xuj','','login/new_char/permit_wizard/new_account',1,'spa_xuj','csa_xuj','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('xuj_30','','login/new_char/permit_wizard/new_account',1,'spa_xuj_30','','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('yeyh2','','login/new_char/permit_wizard/new_account',1,'spa_yeyh2','p01_csa_yeyh2','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('yugq','','login/new_char/permit_wizard/new_account',1,'spa_yugq','csa_yugq','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('zenghh','','login/new_char/permit_wizard/new_account',1,'spa_zenghh','csa_zenghh','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('zenghh_1','','login/new_char/permit_wizard/new_account',2,'spa_zenghh_1','','',NULL);
INSERT INTO `district` (`dist`, `alias`, `service`, `id`, `spa`, `csa`, `party_war_server`, `memo`) VALUES ('zhangq3','','login/new_char/permit_wizard/new_account',1,'spa_zhangq3_30','','','(NULL)');
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ecard_business`
--

DROP TABLE IF EXISTS `ecard_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecard_business` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `ecard_no` varchar(30) DEFAULT NULL,
  `ecard_id` varchar(100) DEFAULT NULL,
  `ecard_server` varchar(30) DEFAULT NULL,
  `ecard_seller` varchar(128) DEFAULT NULL,
  `ecard_buyer` varchar(128) DEFAULT NULL,
  `ecard_buyer_account` varchar(128) DEFAULT NULL,
  `ecard_price` int(11) DEFAULT NULL,
  `ecard_type` int(11) DEFAULT NULL,
  `ecard_time` varchar(30) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `buyer_done` int(11) DEFAULT NULL,
  `seller_done` int(11) DEFAULT NULL,
  `insert_time` varchar(14) DEFAULT NULL,
  `update_time` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ecard_seller` (`ecard_seller`,`seller_done`) USING BTREE,
  KEY `ecard_buyer` (`ecard_buyer`,`buyer_done`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecard_business`
--

LOCK TABLES `ecard_business` WRITE;
/*!40000 ALTER TABLE `ecard_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `ecard_business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ecard_log`
--

DROP TABLE IF EXISTS `ecard_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecard_log` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `ecard_no` varchar(30) DEFAULT NULL,
  `ecard_pwd` varchar(20) DEFAULT NULL,
  `ecard_id` varchar(100) DEFAULT NULL,
  `ecard_server` varchar(30) DEFAULT NULL,
  `ecard_seller` varchar(128) DEFAULT NULL,
  `ecard_buyer` varchar(128) DEFAULT NULL,
  `ecard_buyer_account` varchar(128) DEFAULT NULL,
  `ecard_price` int(11) DEFAULT NULL,
  `ecard_type` int(11) DEFAULT NULL,
  `ecard_time` varchar(30) DEFAULT NULL,
  `direction` varchar(10) DEFAULT NULL,
  `result` varchar(10) DEFAULT NULL,
  `insert_time` varchar(14) DEFAULT NULL,
  `update_time` varchar(14) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `ecard_id` (`ecard_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecard_log`
--

LOCK TABLES `ecard_log` WRITE;
/*!40000 ALTER TABLE `ecard_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ecard_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ecard_need_to_resend`
--

DROP TABLE IF EXISTS `ecard_need_to_resend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecard_need_to_resend` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `ecard_no` varchar(30) DEFAULT NULL,
  `ecard_pwd` varchar(20) DEFAULT NULL,
  `ecard_id` varchar(100) DEFAULT NULL,
  `ecard_server` varchar(30) DEFAULT NULL,
  `ecard_seller` varchar(128) DEFAULT NULL,
  `ecard_buyer` varchar(128) DEFAULT NULL,
  `ecard_buyer_account` varchar(128) DEFAULT NULL,
  `ecard_price` int(11) DEFAULT NULL,
  `ecard_type` int(11) DEFAULT NULL,
  `ecard_dist` varchar(30) DEFAULT NULL,
  `ecard_time` varchar(30) DEFAULT NULL,
  `ecard_order_id` text,
  `send_result` int(11) DEFAULT NULL,
  `insert_time` varchar(14) DEFAULT NULL,
  `update_time` varchar(14) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `ecard_id` (`ecard_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecard_need_to_resend`
--

LOCK TABLES `ecard_need_to_resend` WRITE;
/*!40000 ALTER TABLE `ecard_need_to_resend` DISABLE KEYS */;
/*!40000 ALTER TABLE `ecard_need_to_resend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encourage`
--

DROP TABLE IF EXISTS `encourage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encourage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(32) NOT NULL DEFAULT '',
  `encourage_type` varchar(255) NOT NULL DEFAULT '',
  `order_id` varchar(32) NOT NULL DEFAULT '',
  `checksum` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `expired_time` varchar(14) NOT NULL DEFAULT '',
  `used` int(11) NOT NULL DEFAULT '0',
  `request_time` varchar(14) NOT NULL DEFAULT '',
  `locked` int(11) NOT NULL DEFAULT '0',
  `insert_time` varchar(14) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `account` (`account`) USING BTREE,
  KEY `insert_time` (`insert_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encourage`
--

LOCK TABLES `encourage` WRITE;
/*!40000 ALTER TABLE `encourage` DISABLE KEYS */;
/*!40000 ALTER TABLE `encourage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encourage_log`
--

DROP TABLE IF EXISTS `encourage_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encourage_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dist` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `encourage_type` varchar(64) NOT NULL DEFAULT '',
  `request_time` varchar(14) NOT NULL DEFAULT '',
  `encourage_id` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `request_time` (`request_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encourage_log`
--

LOCK TABLES `encourage_log` WRITE;
/*!40000 ALTER TABLE `encourage_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `encourage_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `express_recharge`
--

DROP TABLE IF EXISTS `express_recharge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `express_recharge` (
  `order_id` varchar(32) NOT NULL DEFAULT '',
  `result` tinyint(2) DEFAULT NULL,
  `result_code` int(11) DEFAULT NULL,
  `gold` int(11) DEFAULT NULL,
  `inquiry_times` int(11) DEFAULT NULL,
  `card_no` varchar(30) DEFAULT NULL,
  `card_pwd` varchar(20) DEFAULT NULL,
  `user_name` varchar(128) DEFAULT NULL,
  `char_name` varchar(32) DEFAULT NULL,
  `server_name` varchar(30) DEFAULT NULL,
  `sales_name` varchar(128) DEFAULT NULL,
  `user_ip` varchar(15) DEFAULT NULL,
  `par_value` int(11) DEFAULT NULL,
  `pay_type` varchar(30) DEFAULT NULL,
  `card_type` tinyint(4) DEFAULT NULL,
  `update_time` varchar(14) DEFAULT NULL,
  `insert_time` varchar(14) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`order_id`),
  KEY `result_inquiry` (`result`,`inquiry_times`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `express_recharge`
--

LOCK TABLES `express_recharge` WRITE;
/*!40000 ALTER TABLE `express_recharge` DISABLE KEYS */;
/*!40000 ALTER TABLE `express_recharge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gbuy_coin_log`
--

DROP TABLE IF EXISTS `gbuy_coin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gbuy_coin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` char(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` char(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `silver_coin` int(11) NOT NULL DEFAULT '0',
  `gcoin_before` int(11) NOT NULL DEFAULT '0',
  `gcoin_after` int(11) NOT NULL DEFAULT '0',
  `scoin_before` int(11) NOT NULL DEFAULT '0',
  `scoin_after` int(11) NOT NULL DEFAULT '0',
  `gbuy_gcoin_before` int(11) NOT NULL DEFAULT '0',
  `gbuy_gcoin_after` int(11) NOT NULL DEFAULT '0',
  `gbuy_scoin_before` int(11) NOT NULL DEFAULT '0',
  `gbuy_scoin_after` int(11) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` varchar(32) NOT NULL DEFAULT '0',
  `para3` varchar(128) NOT NULL DEFAULT '0',
  `memo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`update_time`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gbuy_coin_log`
--

LOCK TABLES `gbuy_coin_log` WRITE;
/*!40000 ALTER TABLE `gbuy_coin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `gbuy_coin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_coin_log`
--

DROP TABLE IF EXISTS `gift_coin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_coin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gold_coin` int(11) NOT NULL DEFAULT '0',
  `silver_coin` int(11) NOT NULL DEFAULT '0',
  `coupon_gold_used` int(11) NOT NULL DEFAULT '0',
  `coupon_silver_used` int(11) NOT NULL DEFAULT '0',
  `checksum` varchar(32) NOT NULL DEFAULT '',
  `time` varchar(14) NOT NULL DEFAULT '',
  `server` varchar(32) NOT NULL DEFAULT '',
  `source` tinyint(4) NOT NULL DEFAULT '0',
  `para1` int(11) NOT NULL DEFAULT '0',
  `para2` int(11) NOT NULL DEFAULT '0',
  `para3` varchar(32) NOT NULL DEFAULT '',
  `para4` varchar(32) NOT NULL DEFAULT '',
  `para5` varchar(255) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`id`,`transaction_id`),
  KEY `account` (`account`) USING BTREE,
  KEY `transaction_id` (`transaction_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gift_coin_log`
--

LOCK TABLES `gift_coin_log` WRITE;
/*!40000 ALTER TABLE `gift_coin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `gift_coin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_valid_time`
--

DROP TABLE IF EXISTS `gift_valid_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_valid_time` (
  `gift_type` varchar(30) NOT NULL DEFAULT '',
  `start_time` varchar(14) NOT NULL DEFAULT '0',
  `end_time` varchar(14) NOT NULL DEFAULT '0',
  `checksum` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`gift_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gift_valid_time`
--

LOCK TABLES `gift_valid_time` WRITE;
/*!40000 ALTER TABLE `gift_valid_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `gift_valid_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip`
--

DROP TABLE IF EXISTS `ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip` (
  `start_ip` varchar(32) NOT NULL DEFAULT '',
  `end_ip` varchar(32) NOT NULL DEFAULT '',
  `country` varchar(32) DEFAULT NULL,
  `province` varchar(32) DEFAULT NULL,
  `city` varchar(32) DEFAULT NULL,
  `memo` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`start_ip`,`end_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip`
--

LOCK TABLES `ip` WRITE;
/*!40000 ALTER TABLE `ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_card`
--

DROP TABLE IF EXISTS `ip_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_card` (
  `card_no` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `used` int(11) NOT NULL DEFAULT '0',
  `account` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `request_time` varchar(14) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`card_no`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_card`
--

LOCK TABLES `ip_card` WRITE;
/*!40000 ALTER TABLE `ip_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_info`
--

DROP TABLE IF EXISTS `ip_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_info` (
  `start_ip_desc` varchar(16) NOT NULL DEFAULT '',
  `end_ip_desc` varchar(16) NOT NULL DEFAULT '',
  `start_ip` int(11) unsigned NOT NULL DEFAULT '0',
  `end_ip` int(11) unsigned NOT NULL DEFAULT '0',
  `country` varchar(64) DEFAULT NULL,
  `province` varchar(64) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`start_ip_desc`,`end_ip_desc`,`start_ip`,`end_ip`),
  KEY `start_ip` (`start_ip`) USING BTREE,
  KEY `end_ip` (`end_ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_info`
--

LOCK TABLES `ip_info` WRITE;
/*!40000 ALTER TABLE `ip_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ldba`
--

DROP TABLE IF EXISTS `ldba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ldba` (
  `ldba` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `server_key` varchar(32) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`ldba`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ldba`
--

LOCK TABLES `ldba` WRITE;
/*!40000 ALTER TABLE `ldba` DISABLE KEYS */;
INSERT INTO `ldba` (`ldba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('ldba_jiangw','118.24.7.124',8040,'内部测试','',2,NULL);
INSERT INTO `ldba` (`ldba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('ldba_jiangw_30','10.2.50.30',8040,'jiangw_30','',2,NULL);
INSERT INTO `ldba` (`ldba`, `ip`, `port`, `dist`, `server_key`, `id`, `memo`) VALUES ('ldba_jiangw_pk','118.24.7.124',8050,'pk','',2,NULL);
/*!40000 ALTER TABLE `ldba` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league_account`
--

DROP TABLE IF EXISTS `league_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league_account` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `level_section` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league_account`
--

LOCK TABLES `league_account` WRITE;
/*!40000 ALTER TABLE `league_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `league_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local_encrypt`
--

DROP TABLE IF EXISTS `local_encrypt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `local_encrypt` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `file_name` varchar(64) NOT NULL DEFAULT '',
  `local_encrypt_info` text NOT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  `time` varchar(32) NOT NULL DEFAULT '0',
  `checksum` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_encrypt`
--

LOCK TABLES `local_encrypt` WRITE;
/*!40000 ALTER TABLE `local_encrypt` DISABLE KEYS */;
/*!40000 ALTER TABLE `local_encrypt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrix`
--

DROP TABLE IF EXISTS `matrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrix` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `matrix` text NOT NULL,
  `bind_time` varchar(32) NOT NULL DEFAULT '',
  `expired_time` varchar(32) NOT NULL DEFAULT '',
  `claim_lost_off_time` varchar(32) NOT NULL DEFAULT '',
  `enable` int(11) NOT NULL DEFAULT '1',
  `checksum` varchar(32) NOT NULL DEFAULT '',
  `update_time` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrix`
--

LOCK TABLES `matrix` WRITE;
/*!40000 ALTER TABLE `matrix` DISABLE KEYS */;
/*!40000 ALTER TABLE `matrix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_device`
--

DROP TABLE IF EXISTS `mp_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mp_device` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `device` varchar(128) NOT NULL DEFAULT '',
  `os` tinyint(4) NOT NULL DEFAULT '0',
  `bind_time` char(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mp_device`
--

LOCK TABLES `mp_device` WRITE;
/*!40000 ALTER TABLE `mp_device` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partywar_account`
--

DROP TABLE IF EXISTS `partywar_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partywar_account` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `gid` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `party_name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partywar_account`
--

LOCK TABLES `partywar_account` WRITE;
/*!40000 ALTER TABLE `partywar_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `partywar_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_deposit`
--

DROP TABLE IF EXISTS `pet_deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet_deposit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pet_iid` varchar(32) NOT NULL DEFAULT '',
  `pet_name` varchar(128) NOT NULL DEFAULT '',
  `pet_level` int(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `pet_data` text NOT NULL,
  `org_owner_gid` varchar(16) NOT NULL DEFAULT '',
  `org_owner_name` varchar(32) NOT NULL DEFAULT '',
  `new_owner_gid` varchar(16) NOT NULL DEFAULT '',
  `new_owner_name` varchar(32) NOT NULL DEFAULT '',
  `deposit_owner` varchar(32) NOT NULL DEFAULT '',
  `deposit_time` varchar(14) NOT NULL DEFAULT '',
  `deposit_reason` text NOT NULL,
  `take_owner` varchar(32) NOT NULL DEFAULT '',
  `take_time` varchar(14) NOT NULL DEFAULT '',
  `take_reason` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pet_iid` (`pet_iid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_deposit`
--

LOCK TABLES `pet_deposit` WRITE;
/*!40000 ALTER TABLE `pet_deposit` DISABLE KEYS */;
/*!40000 ALTER TABLE `pet_deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_auth`
--

DROP TABLE IF EXISTS `phone_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_auth` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `bind_time` char(14) NOT NULL DEFAULT '',
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `bonus_info` text,
  `update_time` char(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_auth`
--

LOCK TABLES `phone_auth` WRITE;
/*!40000 ALTER TABLE `phone_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_bind`
--

DROP TABLE IF EXISTS `phone_bind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_bind` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `bind_time` char(14) NOT NULL DEFAULT '',
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `update_time` char(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_bind`
--

LOCK TABLES `phone_bind` WRITE;
/*!40000 ALTER TABLE `phone_bind` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_bind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilege_group`
--

DROP TABLE IF EXISTS `privilege_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privilege_group` (
  `privilege_group` varchar(15) NOT NULL DEFAULT '',
  `class` varchar(15) NOT NULL DEFAULT '',
  `privilege` varchar(255) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`privilege_group`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilege_group`
--

LOCK TABLES `privilege_group` WRITE;
/*!40000 ALTER TABLE `privilege_group` DISABLE KEYS */;
INSERT INTO `privilege_group` (`privilege_group`, `class`, `privilege`, `memo`) VALUES ('CS1','admintool','block_character/fetch_keywords/chat_attr/channel_silence/set_inspect_area/query_ddb/query_adb/query_mdb/query_ldb/query_tdb/monitor_signature/query_online_char','');
INSERT INTO `privilege_group` (`privilege_group`, `class`, `privilege`, `memo`) VALUES ('CS2','admintool','polling_char/ip_query/trace_iid/restrict_char/polling_account/throw_in_jail/jail_and_silence','');
INSERT INTO `privilege_group` (`privilege_group`, `class`, `privilege`, `memo`) VALUES ('CS3','admintool','control_account/oper_check/release_protected/transfer_pet/transfer_item/bind_roll_back/delete_pet/delete_item/polling_account/transfer_cash/delete_cash','');
INSERT INTO `privilege_group` (`privilege_group`, `class`, `privilege`, `memo`) VALUES ('CS4','admintool','update_keywords/add_keywords/delete_keywords','');
INSERT INTO `privilege_group` (`privilege_group`, `class`, `privilege`, `memo`) VALUES ('G1','admintool','query_ddb/query_adb/query_mdb/oper_character/block_account/block_character/delete_character/recover_character/release_character/delete_item/control_account/delete_pet/polling_char','');
/*!40000 ALTER TABLE `privilege_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_recall`
--

DROP TABLE IF EXISTS `property_recall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_recall` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `update_time` varchar(14) NOT NULL DEFAULT '',
  `type` varchar(16) NOT NULL DEFAULT '',
  `owner` varchar(16) NOT NULL DEFAULT '',
  `iid` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) DEFAULT '',
  `ob_type` tinyint(4) unsigned DEFAULT NULL,
  `take` tinyint(4) unsigned DEFAULT NULL,
  `exchange` tinyint(4) unsigned DEFAULT '0',
  `depend` varchar(16) DEFAULT NULL,
  `checksum` int(32) NOT NULL DEFAULT '0',
  `data` text,
  `memo` text,
  PRIMARY KEY (`id`),
  KEY `iid` (`iid`) USING BTREE,
  KEY `owner` (`update_time`,`owner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_recall`
--

LOCK TABLES `property_recall` WRITE;
/*!40000 ALTER TABLE `property_recall` DISABLE KEYS */;
/*!40000 ALTER TABLE `property_recall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protect_bonus`
--

DROP TABLE IF EXISTS `protect_bonus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protect_bonus` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `branch` varchar(7) NOT NULL DEFAULT '',
  `dist` varchar(32) DEFAULT NULL,
  `matrix_time` text,
  `passpod_time` text,
  `phone_time` text,
  `sm_time` text,
  `bonus_time` varchar(14) DEFAULT NULL,
  `bonus_type` varchar(10) DEFAULT NULL,
  `bonus_info` text,
  `insert_time` varchar(14) NOT NULL DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `memo` text,
  PRIMARY KEY (`account`,`branch`),
  KEY `update_time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `protect_bonus`
--

LOCK TABLES `protect_bonus` WRITE;
/*!40000 ALTER TABLE `protect_bonus` DISABLE KEYS */;
/*!40000 ALTER TABLE `protect_bonus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protect_range`
--

DROP TABLE IF EXISTS `protect_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protect_range` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `p_range` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `protect_range`
--

LOCK TABLES `protect_range` WRITE;
/*!40000 ALTER TABLE `protect_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `protect_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_store`
--

DROP TABLE IF EXISTS `purchase_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_store` (
  `order_id` varchar(32) NOT NULL DEFAULT '',
  `owner` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(16) NOT NULL DEFAULT '',
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `time` varchar(14) NOT NULL DEFAULT '0',
  `content` text,
  `sub_amount` int(11) unsigned DEFAULT NULL,
  `amount` int(11) unsigned DEFAULT NULL,
  `type` tinyint(2) unsigned DEFAULT NULL,
  `end_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`),
  KEY `owner` (`owner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_store`
--

LOCK TABLES `purchase_store` WRITE;
/*!40000 ALTER TABLE `purchase_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pwd_protect`
--

DROP TABLE IF EXISTS `pwd_protect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pwd_protect` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `protect_type` varchar(32) NOT NULL DEFAULT '',
  `protect_info` text,
  `checksum` varchar(32) DEFAULT NULL,
  `bind_time` varchar(14) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`account`,`protect_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pwd_protect`
--

LOCK TABLES `pwd_protect` WRITE;
/*!40000 ALTER TABLE `pwd_protect` DISABLE KEYS */;
/*!40000 ALTER TABLE `pwd_protect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qr_runtime`
--

DROP TABLE IF EXISTS `qr_runtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qr_runtime` (
  `qrid` varchar(32) NOT NULL DEFAULT '',
  `account` varchar(32) NOT NULL DEFAULT '',
  `update_time` char(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`qrid`),
  KEY `time` (`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qr_runtime`
--

LOCK TABLES `qr_runtime` WRITE;
/*!40000 ALTER TABLE `qr_runtime` DISABLE KEYS */;
/*!40000 ALTER TABLE `qr_runtime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `red_envelope`
--

DROP TABLE IF EXISTS `red_envelope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `red_envelope` (
  `name` varchar(32) NOT NULL DEFAULT '',
  `iid` varchar(32) NOT NULL DEFAULT '',
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `total_coin` int(11) NOT NULL DEFAULT '0',
  `cur_coin` int(11) NOT NULL DEFAULT '0',
  `total_num` int(11) NOT NULL DEFAULT '0',
  `cur_num` int(11) NOT NULL DEFAULT '0',
  `deadline` int(11) NOT NULL DEFAULT '0',
  `use` tinyint(4) NOT NULL DEFAULT '0',
  `checksum` int(32) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`name`,`iid`,`use`),
  KEY `iid` (`iid`,`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `red_envelope`
--

LOCK TABLES `red_envelope` WRITE;
/*!40000 ALTER TABLE `red_envelope` DISABLE KEYS */;
/*!40000 ALTER TABLE `red_envelope` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relative_acc`
--

DROP TABLE IF EXISTS `relative_acc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relative_acc` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `last_add_coin_cookie` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relative_acc`
--

LOCK TABLES `relative_acc` WRITE;
/*!40000 ALTER TABLE `relative_acc` DISABLE KEYS */;
/*!40000 ALTER TABLE `relative_acc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `safe_ctrl`
--

DROP TABLE IF EXISTS `safe_ctrl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `safe_ctrl` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `protect_type` varchar(32) NOT NULL DEFAULT '',
  `protect_info` text,
  `checksum` varchar(32) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`account`,`protect_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `safe_ctrl`
--

LOCK TABLES `safe_ctrl` WRITE;
/*!40000 ALTER TABLE `safe_ctrl` DISABLE KEYS */;
INSERT INTO `safe_ctrl` (`account`, `protect_type`, `protect_info`, `checksum`, `memo`) VALUES ('w04700115','total_switch','36','F94DEADFEE0F1C5339944EABABF108CE','');
/*!40000 ALTER TABLE `safe_ctrl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server` (
  `server` varchar(32) NOT NULL DEFAULT '',
  `alias` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `max_user` int(11) NOT NULL DEFAULT '1500',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `enable` int(11) NOT NULL DEFAULT '0',
  `server_key` varchar(32) NOT NULL DEFAULT '',
  `when_iid_duplicated` varchar(32) NOT NULL DEFAULT '',
  `when_challenge_failed` varchar(32) NOT NULL DEFAULT 'punish_ex',
  `when_found_cheater` varchar(32) NOT NULL DEFAULT '',
  `punish_id` int(11) NOT NULL DEFAULT '0',
  `save_when_coin_cost` int(11) NOT NULL DEFAULT '0',
  `charge_level` int(11) NOT NULL DEFAULT '0',
  `charge_interval` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `ahserver` varchar(32) NOT NULL DEFAULT '',
  `ip_wt` varchar(15) NOT NULL DEFAULT '',
  `ip_dx` varchar(15) NOT NULL DEFAULT '',
  `enable_multi_ip` tinyint(4) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`server`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server`
--

LOCK TABLES `server` WRITE;
/*!40000 ALTER TABLE `server` DISABLE KEYS */;
INSERT INTO `server` (`server`, `alias`, `ip`, `port`, `max_user`, `dist`, `enable`, `server_key`, `when_iid_duplicated`, `when_challenge_failed`, `when_found_cheater`, `punish_id`, `save_when_coin_cost`, `charge_level`, `charge_interval`, `id`, `ahserver`, `ip_wt`, `ip_dx`, `enable_multi_ip`, `memo`) VALUES ('三线','','118.24.7.124',8162,1200,'问道一区',1,'','','','',0,0,0,0,3,'','','',0,NULL);
INSERT INTO `server` (`server`, `alias`, `ip`, `port`, `max_user`, `dist`, `enable`, `server_key`, `when_iid_duplicated`, `when_challenge_failed`, `when_found_cheater`, `punish_id`, `save_when_coin_cost`, `charge_level`, `charge_interval`, `id`, `ahserver`, `ip_wt`, `ip_dx`, `enable_multi_ip`, `memo`) VALUES ('一线','','118.24.7.124',8160,1200,'问道一区',1,'network','','','',0,0,0,600,1,'apex1','','',0,NULL);
INSERT INTO `server` (`server`, `alias`, `ip`, `port`, `max_user`, `dist`, `enable`, `server_key`, `when_iid_duplicated`, `when_challenge_failed`, `when_found_cheater`, `punish_id`, `save_when_coin_cost`, `charge_level`, `charge_interval`, `id`, `ahserver`, `ip_wt`, `ip_dx`, `enable_multi_ip`, `memo`) VALUES ('二线','','118.24.7.124',8161,1200,'问道一区',1,'','','','',0,0,0,0,2,'','','',0,NULL);
/*!40000 ALTER TABLE `server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_status`
--

DROP TABLE IF EXISTS `server_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_status` (
  `server` varchar(32) NOT NULL DEFAULT '',
  `available` int(11) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `online` int(11) NOT NULL DEFAULT '0',
  `max_user` int(11) NOT NULL DEFAULT '0',
  `cpu_cost` int(11) NOT NULL DEFAULT '0',
  `cpu_satisfy` int(11) NOT NULL DEFAULT '0',
  `report_time` varchar(32) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`server`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_status`
--

LOCK TABLES `server_status` WRITE;
/*!40000 ALTER TABLE `server_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `permit` varchar(255) NOT NULL DEFAULT '',
  `forbid` varchar(255) NOT NULL DEFAULT '',
  `memo` text,
  PRIMARY KEY (`account`,`dist`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spa`
--

DROP TABLE IF EXISTS `spa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spa` (
  `spa` varchar(32) NOT NULL DEFAULT '',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `server_key` varchar(32) DEFAULT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL DEFAULT '0',
  `port` int(11) NOT NULL DEFAULT '0',
  `http_plat` varchar(255) DEFAULT NULL,
  `http_ip` varchar(255) DEFAULT NULL,
  `httpd_enable` int(1) DEFAULT NULL,
  `httpd_port` int(16) DEFAULT NULL,
  `memo` text,
  PRIMARY KEY (`spa`,`dist`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spa`
--

LOCK TABLES `spa` WRITE;
/*!40000 ALTER TABLE `spa` DISABLE KEYS */;
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('p01g_spa_pack','gy_pack',NULL,'10.2.50.57',1,9877,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('p01g_spa_pack58','gy_pack58',NULL,'10.2.50.58',1,9877,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('p01_spa_hong','hong',NULL,'10.3.4.4',1,10011,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('p01_spa_hongjs','hongjs',NULL,'10.3.4.4',1,8011,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('p01_spa_shuxx','shuxx',NULL,'10.3.4.12',1,8009,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_coding','coding',NULL,'10.2.50.30',1,8400,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_dongsh','dongsh',NULL,'10.3.4.35',1,8400,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_jiangw','普天同庆',NULL,'118.24.7.124',1,8030,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_jiangw_30','jiangw_30',NULL,'10.2.50.30',1,8030,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_jiangw_pk','jiangw_pk',NULL,'118.24.7.124',2,8032,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_luoyh','luoyh',NULL,'10.3.4.25',1,8030,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_quls_30','quls_30',NULL,'10.3.4.5',1,8400,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_test','test',NULL,'10.2.50.57',1,12076,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_weism','weism',NULL,'10.3.35.4',1,8400,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_wuxl','wuxl',NULL,'10.3.4.20',1,9877,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_xuj','xuj',NULL,'10.3.4.10',1,8400,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_xuj_30','xuj_30',NULL,'10.2.50.30',1,8400,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_yeyh2','yeyh2',NULL,'10.3.102.24',1,8066,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_yugq','yugq',NULL,'10.3.4.26',1,8400,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_zenghh','zenghh',NULL,'10.3.4.30',1,8400,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_zenghh_1','zenghh_1',NULL,'10.3.4.30',1,9400,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `spa` (`spa`, `dist`, `server_key`, `ip`, `id`, `port`, `http_plat`, `http_ip`, `httpd_enable`, `httpd_port`, `memo`) VALUES ('spa_zhangq3_30','zhangq3',NULL,'10.3.102.39',1,8400,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `spa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_9apay`
--

DROP TABLE IF EXISTS `t_9apay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_9apay` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `parter` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `orderno` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `orderid` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `cardno` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `amount` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `GameCurrency` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `appid` int(255) DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `server_id` int(255) DEFAULT NULL,
  `Processing` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_9apay`
--

LOCK TABLES `t_9apay` WRITE;
/*!40000 ALTER TABLE `t_9apay` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_9apay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `top_data`
--

DROP TABLE IF EXISTS `top_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `top_data` (
  `top_index` int(11) NOT NULL DEFAULT '0',
  `top_key` varchar(128) NOT NULL DEFAULT '',
  `top_content` text NOT NULL,
  `time` char(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`top_index`,`top_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `top_data`
--

LOCK TABLES `top_data` WRITE;
/*!40000 ALTER TABLE `top_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `top_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer_data`
--

DROP TABLE IF EXISTS `transfer_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transfer_data` (
  `transfer_id` varchar(32) NOT NULL DEFAULT '',
  `owner` varchar(16) NOT NULL DEFAULT '',
  `class` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `iid` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `data` text NOT NULL,
  `source` varchar(32) NOT NULL DEFAULT '',
  `title` varchar(128) NOT NULL DEFAULT '',
  `mesg_ok` varchar(255) NOT NULL DEFAULT '',
  `mesg_cht` varchar(255) NOT NULL DEFAULT '',
  `tip` varchar(255) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT '0',
  `limit_day` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `transfer_account` varchar(16) NOT NULL DEFAULT '',
  `transfer_time` varchar(14) NOT NULL DEFAULT '',
  `request_gid` varchar(16) NOT NULL DEFAULT '',
  `request_time` varchar(14) NOT NULL DEFAULT '',
  `checksum` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`transfer_id`),
  KEY `owner` (`owner`) USING BTREE,
  KEY `iid` (`iid`) USING BTREE,
  KEY `class` (`class`) USING BTREE,
  KEY `type` (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer_data`
--

LOCK TABLES `transfer_data` WRITE;
/*!40000 ALTER TABLE `transfer_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfer_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tts`
--

DROP TABLE IF EXISTS `tts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tts` (
  `tts` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(32) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `dist` varchar(32) NOT NULL DEFAULT '',
  `trading_url` varchar(255) NOT NULL DEFAULT '',
  `web_status_url` varchar(32) NOT NULL DEFAULT '',
  `http_ip` varchar(255) NOT NULL DEFAULT '',
  `http_plat` varchar(255) NOT NULL DEFAULT '',
  `httpd_enable` int(1) NOT NULL DEFAULT '0',
  `httpd_port` int(16) NOT NULL DEFAULT '0',
  `check_sum` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`tts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tts`
--

LOCK TABLES `tts` WRITE;
/*!40000 ALTER TABLE `tts` DISABLE KEYS */;
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('p01g_tts_pack','10.2.50.57',9897,1,'gy_pack','http://10.3.102.49','http://treasure.gyyx.com','*','1aó?',1,85,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('p01g_tts_pack58','10.2.50.58',9897,1,'gy_pack58','http://10.3.102.49','http://treasure.gyyx.com','*','1aó?',1,85,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('p01_tts_hongjs','10.3.4.4',8071,1,'hongjs','http://10.3.102.49','http://treasure.gyyx.com','*','1aó?',1,85,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('p01_tts_yeyh2','10.3.102.24',8600,1,'yeyh2','http://10.3.102.49','http://treasure.gyyx.com','*','1aó?',1,85,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('tte_test','10.2.50.57',12011,1,'test','http://10.3.102.49','http://treasure.gyyx.com','*','1aó?',1,85,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('tts_jiangw','118.24.7.124',8600,1,'普天同庆','http://10.2.50.58/simulateforum/trading.php','http://treasure.gyyx.com','*','1aó?',1,85,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('tts_quls','10.3.102.203',8600,1,'quls_30','http://10.3.102.49','http://treasure.gyyx.com','*','1aó?',1,85,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('tts_shuxx','10.3.4.12',9000,1,'shuxx','http://10.2.16.7','http://treasure.gyyx.com','*','1aó?',0,85,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('tts_xuj','10.3.4.10',8600,1,'xuj','','','','',0,9550,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('tts_yugq','10.3.4.26',9001,1,'yugq','','','','',0,0,'');
INSERT INTO `tts` (`tts`, `ip`, `port`, `id`, `dist`, `trading_url`, `web_status_url`, `http_ip`, `http_plat`, `httpd_enable`, `httpd_port`, `check_sum`) VALUES ('tts_zhangq3_30','10.3.102.39',8600,1,'zhangq3','http://10.3.102.49','http://treasure.gyyx.com','*','1aó?',1,85,'');
/*!40000 ALTER TABLE `tts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vip_sms_protect`
--

DROP TABLE IF EXISTS `vip_sms_protect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vip_sms_protect` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `p_coin_trade` int(11) NOT NULL DEFAULT '0',
  `p_coin_consum` int(11) NOT NULL DEFAULT '0',
  `p_prop_trade` int(11) NOT NULL DEFAULT '0',
  `p_block_account` int(11) NOT NULL DEFAULT '0',
  `p_oper_role` int(11) NOT NULL DEFAULT '0',
  `update_time` char(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vip_sms_protect`
--

LOCK TABLES `vip_sms_protect` WRITE;
/*!40000 ALTER TABLE `vip_sms_protect` DISABLE KEYS */;
/*!40000 ALTER TABLE `vip_sms_protect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wba`
--

DROP TABLE IF EXISTS `wba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wba` (
  `user` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `money` int(11) NOT NULL DEFAULT '0',
  `force_count` int(11) NOT NULL DEFAULT '0',
  `memo` text,
  PRIMARY KEY (`user`,`ip`,`password`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wba`
--

LOCK TABLES `wba` WRITE;
/*!40000 ALTER TABLE `wba` DISABLE KEYS */;
/*!40000 ALTER TABLE `wba` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xg_name`
--

DROP TABLE IF EXISTS `xg_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xg_name` (
  `account` varchar(32) NOT NULL DEFAULT '',
  `xg_type` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `time` char(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`account`,`xg_type`),
  KEY `xg_type` (`xg_type`,`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xg_name`
--

LOCK TABLES `xg_name` WRITE;
/*!40000 ALTER TABLE `xg_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `xg_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dl_adb_all'
--

--
-- Dumping routines for database 'dl_adb_all'
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
