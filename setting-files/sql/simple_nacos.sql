/*
 Navicat Premium Data Transfer

 Source Server         : simple
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : 192.168.109.201:3306
 Source Schema         : simple_nacos

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 01/08/2021 00:48:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'application-dev.yml', 'DEFAULT_GROUP', '#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n# 认证配置\nsecurity:\n  oauth2:\n    client:\n      client-id: ruoyi\n      client-secret: 123456\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://ruoyi-auth/oauth/check_token\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n        - /user/info/*\n        - /operlog\n        - /logininfor\n', 'bf6cdf98474bf18c7ff697afbdf18e50', '2019-11-29 16:31:20', '2020-06-09 18:22:21', NULL, '0:0:0:0:0:0:0:1', '', '', '通用配置', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (2, 'simple-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:\n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: simple-auth\n          uri: lb://simple-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: simple-gen\n          uri: lb://simple-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: simple-timedtask\n          uri: lb://simple-timedtask\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 基础模块\n        - id: simple-base\n          uri: lb://simple-base\n          predicates:\n            - Path=/system/**\n          filters:\n            - name: BlackListUrlFilter\n              args:\n                blacklistUrl:\n                  - /user/info/*\n            - StripPrefix=1\n', '6fec2dec82fd83baa302b640b794ae2c', '2020-05-14 14:17:55', '2021-05-10 13:57:42', NULL, '192.168.109.1', '', '', '网关模块', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (3, 'simple-auth-dev.yml', 'DEFAULT_GROUP', 'spring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n', '95d2bb71aeff28b2387aba350bac6356', '2020-05-14 13:20:49', '2021-05-03 14:06:13', NULL, '192.168.109.1', '', '', '认证中心', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (4, 'simple-monitor-dev.yml', 'DEFAULT_GROUP', '# Spring\r\nspring: \r\n  security:\r\n    user:\r\n      name: ruoyi\r\n      password: 123456\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: 若依服务状态监控\r\n', '8e49d78998a7780d780305aeefe4fb1b', '2020-05-19 15:14:01', '2020-05-19 18:50:44', NULL, '0:0:0:0:0:0:0:1', '', '', '监控中心', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (5, 'simple-base-dev.yml', 'DEFAULT_GROUP', '# Spring\nspring: \n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\n# mybatis:\n    # 搜索指定包别名\n#    typeAliasesPackage: com.simple.base\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n#    mapperLocations: classpath:mapper/**/*.xml\n# mybatis-plus 相关配置\nmybatis-plus:\n  type-aliases-package: com.simple.base\n  mapper-locations: classpath*:mapper/**/*.xml\n  # mybatis-plus 的全局配置\n  global-config:\n    banner: false\n  # mybatis 原生配置\n  configuration:\n    # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n    map-underscore-to-camel-case: true\n    lazy-loading-enabled: false\n# 分页配置\npagehelper:\n  helper-dialect: mysql\n  reasonable: true\n  support-methods-arguments: true\n  params: count=countSql\n\n# swagger 配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', 'ebcbed8d553a2b697e38f9249e5a89ab', '2020-05-14 13:37:04', '2021-05-03 14:29:41', NULL, '192.168.109.1', '', '', '系统模块', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (6, 'simple-gen-dev.yml', 'DEFAULT_GROUP', '# Spring\nspring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\n#mybatis:\n    # 搜索指定包别名\n#    typeAliasesPackage: com.simple.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n#    mapperLocations: classpath:mapper/**/*.xml\n# mybatis-plus 相关配置\nmybatis-plus:\n  type-aliases-package: com.simple.gen.domain\n  mapper-locations: classpath*:mapper/**/*.xml\n  # mybatis-plus 的全局配置\n  global-config:\n    banner: false\n  # mybatis 原生配置\n  configuration:\n    # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n    map-underscore-to-camel-case: true\n    lazy-loading-enabled: false\n# 分页配置\npagehelper:\n  helper-dialect: mysql\n  reasonable: true\n  support-methods-arguments: true\n  params: count=countSql\n# swagger 配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n\n# 代码生成\ngen: \n  # 作者\n  author: simple\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.simple.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n', '9392cf041f4b2c2261a15a01c6c5ff9b', '2020-05-14 13:54:50', '2021-05-03 14:35:26', NULL, '192.168.109.1', '', '', '代码生成', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (7, 'simple-timedtask-dev.yml', 'DEFAULT_GROUP', '# Spring\nspring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\n#mybatis:\n    # 搜索指定包别名\n#    typeAliasesPackage: com.simple.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n#    mapperLocations: classpath:mapper/**/*.xml\n# mybatis-plus 相关配置\nmybatis-plus:\n  type-aliases-package: com.simple.timedtask.domain\n  mapper-locations: classpath*:mapper/**/*.xml\n  # mybatis-plus 的全局配置\n  global-config:\n    banner: false\n  # mybatis 原生配置\n  configuration:\n    # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n    map-underscore-to-camel-case: true\n    lazy-loading-enabled: false\n# 分页配置\npagehelper:\n  helper-dialect: mysql\n  reasonable: true\n  support-methods-arguments: true\n  params: count=countSql\n# swagger 配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', '708ab640b908fb76cdd01d5942dfdc59', '2020-05-14 13:58:46', '2021-05-03 15:00:39', NULL, '192.168.109.1', '', '', '定时任务', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (8, 'sentinel-simple-gateway', 'DEFAULT_GROUP', '[\r\n    {\r\n        \"resource\": \"ruoyi-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-system\",\r\n        \"count\": 1000,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"ruoyi-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', '9f3a3069261598f74220bc47958ec252', '2020-06-09 12:14:01', '2020-06-10 11:44:19', NULL, '0:0:0:0:0:0:0:1', '', '', 'null', 'null', 'null', 'json', 'null');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint UNSIGNED NOT NULL,
  `nid` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (2, 8, 'simple-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\r\n  redis:\r\n    host: 192.168.109.135\r\n    port: 6379\r\n    password: 970412@wcx.com\r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: ruoyi-auth\r\n          uri: lb://ruoyi-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            # 验证码处理\r\n            - ValidateCodeFilter\r\n            - StripPrefix=1\r\n        # 代码生成\r\n        - id: ruoyi-gen\r\n          uri: lb://ruoyi-gen\r\n          predicates:\r\n            - Path=/code/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 定时任务\r\n        - id: ruoyi-job\r\n          uri: lb://ruoyi-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 系统模块\r\n        # 系统模块\r\n        - id: ruoyi-system\r\n          uri: lb://ruoyi-system\r\n          predicates:\r\n            - Path=/system/**\r\n          filters:\r\n            - name: BlackListUrlFilter\r\n              args:\r\n                blacklistUrl:\r\n                  - /user/info/*\r\n            - StripPrefix=1\r\n', 'a98c2b314cbbde1e1c990e8b3822b3d7', '2021-05-02 14:54:22', '2021-05-02 06:54:23', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (3, 9, 'simple-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://192.168.109.135:3306/ruoyi?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: ruoyi\r\n    password: ruoyi\r\n  redis:\r\n    host: 192.168.109.135\r\n    port: 6379\r\n    password: 970412@wcx.com\r\n', 'fec576056ce65db363d86a573ab47f7c', '2021-05-02 15:01:09', '2021-05-02 07:01:10', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 10, 'simple-system-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  redis:\r\n    host: 192.168.109.135\r\n    port: 6379\r\n    password: 970412@wcx.com\r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://192.168.109.135:3306/ruoyi?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: ruoyi\r\n    password: ruoyi\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.system\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 系统模块接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n', '82a4cad9f0f8707c597ab08722b58825', '2021-05-02 15:10:49', '2021-05-02 07:10:50', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (6, 11, 'simple-gen-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://192.168.109.135:3306/ruoyi?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: ruoyi\r\n    password: ruoyi\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.gen.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 代码生成接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n\r\n# 代码生成\r\ngen: \r\n  # 作者\r\n  author: ruoyi\r\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\r\n  packageName: com.ruoyi.system\r\n  # 自动去除表前缀，默认是false\r\n  autoRemovePre: false\r\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\r\n  tablePrefix: sys_\r\n', 'af2c94c82cc64b94f2b0c054fd35730a', '2021-05-02 15:11:56', '2021-05-02 07:11:56', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (7, 12, 'simple-job-dev.yml', 'DEFAULT_GROUP', '', '# Spring\r\nspring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://192.168.109.135:3306/ruoyi?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: ruoyi\r\n    password: ruoyi\r\n\r\n# Mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.ruoyi.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger 配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: RuoYi OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n', '96ac41c0670b59c3746277b564e8cf32', '2021-05-02 15:12:30', '2021-05-02 07:12:30', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 13, 'simple-system-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.simple.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger 配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', 'ad6c3bf3dd838c0522603919cc37352e', '2021-05-02 21:57:01', '2021-05-02 13:57:01', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (6, 14, 'simple-gen-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.simple.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger 配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n\n# 代码生成\ngen: \n  # 作者\n  author: simple\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.simple.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n', '53baf7ab08a25733b1d2f5dba35038ea', '2021-05-03 22:05:56', '2021-05-03 14:05:56', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (3, 15, 'simple-auth-dev.yml', 'DEFAULT_GROUP', '', 'spring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n', '2c621c03c9349f18221e788ce0f7c35e', '2021-05-03 22:06:13', '2021-05-03 14:06:13', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 16, 'simple-base-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.simple.base\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger 配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', '5a99c143517c6128c804a5d9734e31be', '2021-05-03 22:06:28', '2021-05-03 14:06:28', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (7, 17, 'simple-job-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: simple\n\n# Mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.simple.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger 配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', '3187b0718373fdea2ebd20dc58c5c5d6', '2021-05-03 22:06:38', '2021-05-03 14:06:38', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 18, 'simple-base-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.simple.base\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger 配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', 'f56d924bff2c5607e06f5b07c49c2419', '2021-05-03 22:22:56', '2021-05-03 14:22:56', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 19, 'simple-base-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.simple\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger 配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', '62143c2c9202176fe2ce08fff6309ca9', '2021-05-03 22:25:57', '2021-05-03 14:25:58', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 20, 'simple-base-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.simple.base\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger 配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', 'f56d924bff2c5607e06f5b07c49c2419', '2021-05-03 22:29:40', '2021-05-03 14:29:41', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (6, 21, 'simple-gen-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.simple.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger 配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n\n# 代码生成\ngen: \n  # 作者\n  author: simple\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.simple.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n', '21fcbeeba0ab1f3e1fbe5ccab4d900f4', '2021-05-03 22:35:25', '2021-05-03 14:35:26', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (7, 22, 'simple-job-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: simple\n\n# Mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.simple.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger 配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', 'ef88cee9b9afc72042819001fe60e222', '2021-05-03 22:36:16', '2021-05-03 14:36:17', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (7, 23, 'simple-job-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: simple\n\n# Mybatis配置\n#mybatis:\n    # 搜索指定包别名\n#    typeAliasesPackage: com.simple.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n#    mapperLocations: classpath:mapper/**/*.xml\n# mybatis-plus 相关配置\nmybatis-plus:\n  type-aliases-package: com.simple.job.domain\n  mapper-locations: classpath*:mapper/**/*.xml\n  # mybatis-plus 的全局配置\n  global-config:\n    banner: false\n  # mybatis 原生配置\n  configuration:\n    # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n    map-underscore-to-camel-case: true\n    lazy-loading-enabled: false\n# 分页配置\npagehelper:\n  helper-dialect: mysql\n  reasonable: true\n  support-methods-arguments: true\n  params: count=countSql\n# swagger 配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', '5e8de988fb49f8346085f852967be315', '2021-05-03 22:57:41', '2021-05-03 14:57:42', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (7, 24, 'simple-timedtask-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.109.201:3306/simple_system?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: simple\n    password: 123456\n\n# Mybatis配置\n#mybatis:\n    # 搜索指定包别名\n#    typeAliasesPackage: com.simple.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n#    mapperLocations: classpath:mapper/**/*.xml\n# mybatis-plus 相关配置\nmybatis-plus:\n  type-aliases-package: com.simple.job.domain\n  mapper-locations: classpath*:mapper/**/*.xml\n  # mybatis-plus 的全局配置\n  global-config:\n    banner: false\n  # mybatis 原生配置\n  configuration:\n    # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n    map-underscore-to-camel-case: true\n    lazy-loading-enabled: false\n# 分页配置\npagehelper:\n  helper-dialect: mysql\n  reasonable: true\n  support-methods-arguments: true\n  params: count=countSql\n# swagger 配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By simple\n  licenseUrl: https://simple.vip\n  authorization:\n    name: RuoYi OAuth\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: 客户端授权范围\n    token-url-list:\n      - http://localhost:8080/auth/oauth/token\n', 'c5622d023f7cd626d0c6b76ea48917ad', '2021-05-03 23:00:39', '2021-05-03 15:00:39', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 25, 'simple-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: ruoyi-auth\n          uri: lb://ruoyi-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: ruoyi-gen\n          uri: lb://ruoyi-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: ruoyi-job\n          uri: lb://ruoyi-job\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        # 系统模块\n        - id: ruoyi-system\n          uri: lb://ruoyi-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - name: BlackListUrlFilter\n              args:\n                blacklistUrl:\n                  - /user/info/*\n            - StripPrefix=1\n', '555233117a8be9ba11fcb61bac662019', '2021-05-10 21:55:07', '2021-05-10 13:55:07', NULL, '192.168.109.1', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 26, 'simple-gateway-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  redis:\n    host: 192.168.109.201\n    port: 6379\n    password: 970412@wcx.com\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: ruoyi-auth\n          uri: lb://simple-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: ruoyi-gen\n          uri: lb://simple-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: ruoyi-job\n          uri: lb://simple-taskdtime\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        # 系统模块\n        - id: ruoyi-system\n          uri: lb://ruoyi-base\n          predicates:\n            - Path=/system/**\n          filters:\n            - name: BlackListUrlFilter\n              args:\n                blacklistUrl:\n                  - /user/info/*\n            - StripPrefix=1\n', 'c2b2acfdd66e9c20f454d6226e97a061', '2021-05-10 21:57:41', '2021-05-10 13:57:42', NULL, '192.168.109.1', 'U', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
