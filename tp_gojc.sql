/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : tp_gojc

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 05/08/2020 00:26:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for case
-- ----------------------------
DROP TABLE IF EXISTS `case`;
CREATE TABLE `case`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '测试案例ID',
  `pid` int(11) NOT NULL COMMENT '问题ID',
  `in` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '输入数据',
  `out` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '输出数据',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of case
-- ----------------------------
INSERT INTO `case` VALUES (1, 1, '1,2', '3', 1596282902, 1596282902, NULL);
INSERT INTO `case` VALUES (2, 1, '1000,5555', '6555', 1596282902, 1596282902, NULL);
INSERT INTO `case` VALUES (3, 2, '100,101', '-1', 1596282902, 1596282902, NULL);
INSERT INTO `case` VALUES (4, 2, '11,10', '1', 1596282902, 1596282902, NULL);

-- ----------------------------
-- Table structure for cate
-- ----------------------------
DROP TABLE IF EXISTS `cate`;
CREATE TABLE `cate`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cate
-- ----------------------------
INSERT INTO `cate` VALUES (1, '基础题', 1596282902, 1596282902, NULL);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `pid` int(11) NOT NULL COMMENT '问题ID',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论的内容',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 1, 1, '第一条评论', 1596379390, 1596379390, NULL);
INSERT INTO `comment` VALUES (2, 1, 1, '22222', 1596379391, 1596379391, NULL);
INSERT INTO `comment` VALUES (3, 1, 1, '11111', 1596381020, 1596381020, NULL);

-- ----------------------------
-- Table structure for commit
-- ----------------------------
DROP TABLE IF EXISTS `commit`;
CREATE TABLE `commit`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '提交表ID',
  `uid` int(11) NOT NULL COMMENT '提交用户ID',
  `pid` int(11) NOT NULL COMMENT '问题ID',
  `code_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '代码存放的位置',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '{0:判断中，1:正确，2:错误，3:超时}',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of commit
-- ----------------------------
INSERT INTO `commit` VALUES (1, 1, 1, 'url', '1', 1596285466, 1596285466, NULL);
INSERT INTO `commit` VALUES (2, 2, 1, 'url', '2', 1596285466, 1596285466, NULL);
INSERT INTO `commit` VALUES (3, 2, 1, 'url', '1', 1596285467, 1596285467, NULL);
INSERT INTO `commit` VALUES (7, 1, 1, 'static/commit/7922b842a8bb7a3125d4266300ce37dc.php', '1', 1596550685, 1596550685, NULL);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '新闻表ID',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '正文',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, 1, 'news1', 'Hi getcharzps! I\'m excited to announce the Forethought Future Cup! It will consist of two rounds, an online round on April 20th, 11:05am PDT, and an onsite round on May 4th, 10:05am PDT for the top 25 local contestants near San Francisco. Both of these rounds will be rated for all participants.Each round will be a combined round. In the first round, there will be 8 problems in 2.5 hours. There will be at least one interactive problem in this round. Please read the interactive problem guide if you haven’t already.The problems in this round were all written by me. Thanks to ismagilov.code, mohammedehab2002, Jeel_Vaishnav, Learner99, dojiboy9, fortune, y0105w49, KAN, arsijo for testing and coordination. Of course, thanks to MikeMirzayanov for Codeforces and Polygon, and for allowing us to host the round.', 1596251929, 1596251929, NULL);
INSERT INTO `news` VALUES (2, 1, 'news2', 'Hi <b>getcharzps!</b> I\'m excited to announce the Forethought Future Cup! It will consist of two rounds, an online round on April 20th, 11:05am PDT, and an onsite round on May 4th, 10:05am PDT for the top 25 local contestants near San Francisco. Both of these rounds will be rated for all participants.Each round will be a combined round. In the first round, there will be 8 problems in 2.5 hours. There will be at least one interactive problem in this round. Please read the interactive problem guide if you haven’t already.The problems in this round were all written by me. Thanks to ismagilov.code, mohammedehab2002, Jeel_Vaishnav, Learner99, dojiboy9, fortune, y0105w49, KAN, arsijo for testing and coordination. Of course, thanks to MikeMirzayanov for Codeforces and Polygon, and for allowing us to host the round.', 1596251930, 1596251930, NULL);

-- ----------------------------
-- Table structure for problem
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '问题ID',
  `uid` int(11) NOT NULL COMMENT '管理员ID',
  `cid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类ID，多个分类时用逗号分割',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `max_time` int(11) NULL DEFAULT NULL COMMENT '判题时间、秒级',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '正文',
  `total_num` int(11) NULL DEFAULT 0 COMMENT '总提交个数',
  `right_num` int(11) NULL DEFAULT 0 COMMENT '正确个数',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem
-- ----------------------------
INSERT INTO `problem` VALUES (1, 1, '1', 'A+B', 3, '给出A和B两个数，计算出它们的和', 3, 2, 1596282902, 1596282902, NULL);
INSERT INTO `problem` VALUES (2, 1, '1', 'A-B', 3, '给出A和B两个数，计算出A-B的值', 0, 0, 1596282902, 1596282902, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `qq` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Email',
  `sign` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `solve_num` int(11) NULL DEFAULT 0 COMMENT '正确个数',
  `total_num` int(11) NULL DEFAULT 0 COMMENT '题目的总个数',
  `is_admin` tinyint(3) NULL DEFAULT NULL COMMENT '{0:普通用户， 1:管理员}',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '修改时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'GetcharZp', 'e10adc3949ba59abbe56e057f20f883e', '1', '11@qq.com', '1', 1, 2, 1, 1, 1, NULL);
INSERT INTO `user` VALUES (2, 'A-zero', 'e10adc3949ba59abbe56e057f20f883e', NULL, '22727958141@qq.com', NULL, 1, 2, NULL, 1596206857, 1596206857, NULL);

SET FOREIGN_KEY_CHECKS = 1;
