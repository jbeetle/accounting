-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.10 - MySQL Community Server (GPL)
-- 服务器操作系统:                      osx10.9
-- HeidiSQL 版本:                  9.3.0.5083
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 accounting 的数据库结构
DROP DATABASE IF EXISTS `accounting`;
CREATE DATABASE IF NOT EXISTS `accounting` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `accounting`;

-- 导出  表 accounting.account 结构
DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `accountId` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录标识',
  `memberNo` varchar(50) NOT NULL COMMENT '账户所属会员号',
  `accountNo` char(32) NOT NULL COMMENT '账号32位固定号码',
  `accountName` varchar(50) NOT NULL COMMENT '账户名称',
  `accountType` smallint(6) NOT NULL COMMENT '账户类型，1-中间账户(特殊的科目账户)；2-科目账户；3-会员账户',
  `accountStatus` smallint(6) NOT NULL COMMENT '账务状态；1-正常；2-冻结；3-销户',
  `password` varchar(50) DEFAULT NULL COMMENT '账户支付密码',
  `subjectNo` varchar(20) NOT NULL COMMENT '科目号',
  `subjectDirect` char(2) NOT NULL COMMENT '科目借贷方向；DR-借;CR-贷',
  `passwordCheck` smallint(6) NOT NULL COMMENT '是否需要支付密码验证；1-需要；0-不需求',
  `balance` bigint(20) unsigned NOT NULL COMMENT '余额，单位为分',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户最新更新时间',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间创建就不变',
  PRIMARY KEY (`accountId`),
  UNIQUE KEY `accountNoUK` (`accountNo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='账户表';

-- 正在导出表  accounting.account 的数据：~4 rows (大约)
DELETE FROM `account`;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`accountId`, `memberNo`, `accountNo`, `accountName`, `accountType`, `accountStatus`, `password`, `subjectNo`, `subjectDirect`, `passwordCheck`, `balance`, `updateTime`, `createTime`) VALUES
	(5, '10000000000000001', '2B71ED871756400EAE6E51D2C8941F89', '个人会员资金账户', 3, 1, '888888', '201202', 'CR', 1, 9499997997, '2016-06-30 18:03:33', '2016-06-24 18:42:48'),
	(6, '10000000000000002', '8B4FB8803BF34AFE852192970ED8E6C3', '个人会员资金账户', 3, 1, '666666', '201202', 'CR', 1, 13003, '2016-08-17 17:53:32', '2016-06-24 18:52:54'),
	(7, '90000000000000009', '21E7CDC85FAD4CD0B957E382814A882E', '平台应收账款账户', 2, 1, '', '1231', 'DR', 0, 0, '2016-06-24 20:01:51', '2016-06-24 20:01:51'),
	(8, '90000000000000009', '0C6F1C26BF6343F9A9A26C9CA860C89D', '平台清算银行存款账户', 2, 1, '', '1002', 'DR', 0, 9500011000, '2016-08-17 17:53:32', '2016-06-24 20:03:14');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;

-- 导出  表 accounting.subject 结构
DROP TABLE IF EXISTS `subject`;
CREATE TABLE IF NOT EXISTS `subject` (
  `subjectNo` varchar(20) NOT NULL COMMENT '科目号',
  `subjectName` varchar(100) NOT NULL COMMENT '科目名称',
  `subjectType` smallint(6) NOT NULL COMMENT '1-ASSETS资产\r2-LIABILITY负债\r3-EQUITY所有者权益类\r4-Cost成本类\r5-损益类 Profit and loss\r6-OUTFORM表外',
  `subjectDirect` char(2) NOT NULL COMMENT '科目借贷方向；DR-借;CR-贷',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`subjectNo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='科目表\r\n';

-- 正在导出表  accounting.subject 的数据：8 rows
DELETE FROM `subject`;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` (`subjectNo`, `subjectName`, `subjectType`, `subjectDirect`, `remark`) VALUES
	('201202', '个人会员资金', 2, 'CR', '会员账号-个人会员资金-人民币'),
	('2012', '会员账号', 2, 'CR', NULL),
	('2241', '应付账款', 2, 'CR', NULL),
	('224102', '付款业务结算', 2, 'CR', NULL),
	('224103', '单位往来', 2, 'CR', NULL),
	('224101', '付款业务', 2, 'CR', NULL),
	('1231', '应收账款', 1, 'DR', NULL),
	('1002', '清算银行存款', 1, 'DR', NULL);
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;

-- 导出  表 accounting.water 结构
DROP TABLE IF EXISTS `water`;
CREATE TABLE IF NOT EXISTS `water` (
  `waterId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `accountId` bigint(20) unsigned NOT NULL COMMENT '账户标识',
  `accountNo` char(32) NOT NULL COMMENT '账户号',
  `orderNo` varchar(50) NOT NULL COMMENT '业务订单编号',
  `subjectNo` varchar(20) NOT NULL COMMENT '科目号',
  `directFlag` char(2) NOT NULL COMMENT '借贷方向标记;DR-借;CR-贷',
  `amount` bigint(20) unsigned NOT NULL COMMENT '交易金额，单位为分',
  `foreBalance` bigint(20) unsigned NOT NULL COMMENT '记账前账户余额，单位为分',
  `aftBalance` bigint(20) unsigned NOT NULL COMMENT '记账后账户余额，单位为分',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记账时间',
  PRIMARY KEY (`waterId`),
  KEY `subjectno` (`subjectNo`),
  KEY `accountId` (`accountId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='账户记账流水表';

-- 正在导出表  accounting.water 的数据：~17 rows (大约)
DELETE FROM `water`;
/*!40000 ALTER TABLE `water` DISABLE KEYS */;
INSERT INTO `water` (`waterId`, `accountId`, `accountNo`, `orderNo`, `subjectNo`, `directFlag`, `amount`, `foreBalance`, `aftBalance`, `createTime`) VALUES
	(1, 8, '0C6F1C26BF6343F9A9A26C9CA860C89D', 'ORDER7000000101', '1002', 'DR', 5000000000, 0, 5000000000, '2016-06-28 15:31:25'),
	(2, 5, '2B71ED871756400EAE6E51D2C8941F89', 'ORDER7000000101', '201202', 'CR', 5000000000, 0, 5000000000, '2016-06-28 15:31:25'),
	(3, 8, '0C6F1C26BF6343F9A9A26C9CA860C89D', 'ORDER7000000101', '1002', 'DR', 4500000000, 5000000000, 9500000000, '2016-06-28 15:39:19'),
	(4, 5, '2B71ED871756400EAE6E51D2C8941F89', 'ORDER7000000101', '201202', 'CR', 4500000000, 5000000000, 9500000000, '2016-06-28 15:39:19'),
	(5, 5, '2B71ED871756400EAE6E51D2C8941F89', 'ORDER8000000101', '201202', 'DR', 500, 9500000000, 9499999500, '2016-06-28 15:42:10'),
	(6, 6, '8B4FB8803BF34AFE852192970ED8E6C3', 'ORDER8000000101', '201202', 'CR', 500, 0, 500, '2016-06-28 15:42:10'),
	(7, 5, '2B71ED871756400EAE6E51D2C8941F89', 'ORDER8000000101', '201202', 'DR', 501, 9499999500, 9499998999, '2016-06-28 15:56:11'),
	(8, 6, '8B4FB8803BF34AFE852192970ED8E6C3', 'ORDER8000000101', '201202', 'CR', 501, 500, 1001, '2016-06-28 15:56:11'),
	(9, 5, '2B71ED871756400EAE6E51D2C8941F89', 'ORDER8000000103', '201202', 'DR', 501, 9499998999, 9499998498, '2016-06-29 18:41:55'),
	(10, 6, '8B4FB8803BF34AFE852192970ED8E6C3', 'ORDER8000000103', '201202', 'CR', 501, 1001, 1502, '2016-06-29 18:41:55'),
	(11, 5, '2B71ED871756400EAE6E51D2C8941F89', 'ORDER8000000103', '201202', 'DR', 501, 9499998498, 9499997997, '2016-06-30 18:03:33'),
	(12, 6, '8B4FB8803BF34AFE852192970ED8E6C3', 'ORDER8000000103', '201202', 'CR', 501, 1502, 2003, '2016-06-30 18:03:33'),
	(13, 8, '0C6F1C26BF6343F9A9A26C9CA860C89D', 'ORDER70000003001', '1002', 'DR', 3000, 9500000000, 9500003000, '2016-06-30 18:19:12'),
	(14, 6, '8B4FB8803BF34AFE852192970ED8E6C3', 'ORDER70000003001', '201202', 'CR', 3000, 2003, 5003, '2016-06-30 18:19:12'),
	(15, 8, '0C6F1C26BF6343F9A9A26C9CA860C89D', 'ORDER70000003001', '1002', 'DR', 3000, 9500003000, 9500006000, '2016-08-17 17:52:13'),
	(16, 6, '8B4FB8803BF34AFE852192970ED8E6C3', 'ORDER70000003001', '201202', 'CR', 3000, 5003, 8003, '2016-08-17 17:52:13'),
	(17, 8, '0C6F1C26BF6343F9A9A26C9CA860C89D', 'ORDER8000000345', '1002', 'DR', 5000, 9500006000, 9500011000, '2016-08-17 17:53:32'),
	(18, 6, '8B4FB8803BF34AFE852192970ED8E6C3', 'ORDER8000000345', '201202', 'CR', 5000, 8003, 13003, '2016-08-17 17:53:32');
/*!40000 ALTER TABLE `water` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
