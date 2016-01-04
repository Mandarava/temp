SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bugmenu
-- ----------------------------
DROP TABLE IF EXISTS `bugmenu`;
CREATE TABLE `bugmenu` (
  `ID` int(11) NOT NULL,
  `PID` int(11) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `ISPARENT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bugmenu
-- ----------------------------
INSERT INTO `bugmenu` VALUES ('1', null, 'MBP不具合管理(开发中)', '1');
INSERT INTO `bugmenu` VALUES ('2', null, '管理', '1');
INSERT INTO `bugmenu` VALUES ('11', '1', '不具合ホームページ', '0');
INSERT INTO `bugmenu` VALUES ('12', '1', '新規', '0');
INSERT INTO `bugmenu` VALUES ('13', '1', '検索オプション', '0');
INSERT INTO `bugmenu` VALUES ('14', '1', '定義済み檢索', '1');
INSERT INTO `bugmenu` VALUES ('15', '1', '統計', '1');
INSERT INTO `bugmenu` VALUES ('21', '2', 'ユーザー管理', '0');
INSERT INTO `bugmenu` VALUES ('22', '2', 'プロジェクト管理', '0');
INSERT INTO `bugmenu` VALUES ('23', '2', '汎用マスタ管理', '0');
INSERT INTO `bugmenu` VALUES ('24', '2', '得意先管理', '0');
INSERT INTO `bugmenu` VALUES ('141', '14', '私が発行した不具合', '0');
INSERT INTO `bugmenu` VALUES ('142', '14', '私が担当する不具合', '0');
INSERT INTO `bugmenu` VALUES ('143', '14', '私が検証する不具合', '0');
INSERT INTO `bugmenu` VALUES ('144', '14', '全て未完成の不具合', '0');
INSERT INTO `bugmenu` VALUES ('145', '14', '全て未修正の不具合', '0');
INSERT INTO `bugmenu` VALUES ('146', '14', '全ての不具合', '0');
INSERT INTO `bugmenu` VALUES ('147', '14', '項目によって', '1');
INSERT INTO `bugmenu` VALUES ('151', '15', 'バグ総数統計', '0');
INSERT INTO `bugmenu` VALUES ('152', '15', '人員バグ数統計', '0');
INSERT INTO `bugmenu` VALUES ('153', '15', '摘出作業别バグ数統計', '0');
INSERT INTO `bugmenu` VALUES ('154', '15', '現象别バグ数統計', '0');
INSERT INTO `bugmenu` VALUES ('155', '15', '原因区别バグ数統計', '0');
INSERT INTO `bugmenu` VALUES ('156', '15', '障害種別别バグ数統計', '0');
INSERT INTO `bugmenu` VALUES ('157', '15', '条件区分バグ数統計', '0');
INSERT INTO `bugmenu` VALUES ('158', '15', '処置区分バグ数統計', '0');
