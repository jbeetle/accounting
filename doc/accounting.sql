-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.10 - MySQL Community Server (GPL)
-- 服务器操作系统:                      osx10.9
-- HeidiSQL 版本:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 accounting.account 结构
CREATE TABLE IF NOT EXISTS `account` (
  `accountId` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录标识',
  `memberNo` varchar(50) NOT NULL COMMENT '账户所属会员号',
  `accountNo` char(32) NOT NULL COMMENT '账号21位固定号码，账户对应科目号（6位，不足补0）+机器码（3位，不足补0）+时间戳（13位）',
  `accountName` varchar(50) NOT NULL COMMENT '账户名称',
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='账户表';

-- 正在导出表  accounting.account 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`accountId`, `memberNo`, `accountNo`, `accountName`, `accountStatus`, `password`, `subjectNo`, `subjectDirect`, `passwordCheck`, `balance`, `updateTime`, `createTime`) VALUES
	(1, '100000000001', '2241009981486700756248', '个人会员投资账户', 1, '888888', '2241', 'CR', 1, 20000, '2017-02-10 12:35:24', '2017-02-10 12:25:56'),
	(2, '99999999999999', '1001011421486701113573', '平台资金', 1, '', '100101', 'DR', 0, 20000, '2017-02-10 12:35:24', '2017-02-10 12:31:54');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;

-- 导出  表 accounting.subject 结构
CREATE TABLE IF NOT EXISTS `subject` (
  `subjectNo` varchar(20) NOT NULL COMMENT '科目号',
  `subjectName` varchar(100) NOT NULL COMMENT '科目名称',
  `subjectType` smallint(6) NOT NULL COMMENT '1-ASSETS资产\r2-LIABILITY负债\r3-EQUITY所有者权益类\r4-Cost成本类\r5-损益类 Profit and loss\r6-OUTFORM表外',
  `subjectDirect` char(2) NOT NULL COMMENT '科目借贷方向；DR-借;CR-贷',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`subjectNo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='科目表\r\n';

-- 正在导出表  accounting.subject 的数据：0 rows
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` (`subjectNo`, `subjectName`, `subjectType`, `subjectDirect`, `remark`) VALUES
	('2241', '客户平台账号', 2, 'CR', '客户平台账号-个人会员资金-人民币'),
	('100101', '平台资金', 1, 'DR', '平台资金-客户');
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;

-- 导出  表 accounting.water 结构
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='账户记账流水表';

-- 正在导出表  accounting.water 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `water` DISABLE KEYS */;
INSERT INTO `water` (`waterId`, `accountId`, `accountNo`, `orderNo`, `subjectNo`, `directFlag`, `amount`, `foreBalance`, `aftBalance`, `createTime`) VALUES
	(1, 2, '1001011421486701113573', 'ORDER000000000001', '100101', 'DR', 20000, 0, 20000, '2017-02-10 12:35:24'),
	(2, 1, '2241009981486700756248', 'ORDER000000000001', '2241', 'CR', 20000, 0, 20000, '2017-02-10 12:35:24');
/*!40000 ALTER TABLE `water` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
