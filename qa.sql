/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : menu

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2015-12-31 14:08:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `ID` int(11) NOT NULL,
  `PID` int(11) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `ISPARENT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('1', null, 'MBPQ&A管理', '1');
INSERT INTO `dept` VALUES ('11', '1', 'Q&Aホームページ', '0');
INSERT INTO `dept` VALUES ('12', '1', '新規', '0');
INSERT INTO `dept` VALUES ('13', '1', '検索オプション', '0');
INSERT INTO `dept` VALUES ('14', '1', '定義済み檢索', '1');
INSERT INTO `dept` VALUES ('141', '14', '私が提出したQ&A', '0');
INSERT INTO `dept` VALUES ('142', '14', '私が回答するQ&A', '0');
INSERT INTO `dept` VALUES ('143', '14', '全て未回答のQ&A', '0');
INSERT INTO `dept` VALUES ('144', '14', '全て未承認のQ&A', '0');
INSERT INTO `dept` VALUES ('145', '14', '全てのQ&A', '0');
INSERT INTO `dept` VALUES ('146', '14', '項目によって', '1');
INSERT INTO `dept` VALUES ('1461', '146', '不具合管理システム', '0');
