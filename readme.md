### 自研cloud平台，用于做自己项目的脚手架

### 搭建问题记录
1、The Bean Validation API is on the classpath but no implementation could be found
这是如果你引入了spring的校验需要引入
碰到这个问题，是因为少了个jar包没引入（在common模块加入）
```xml
<dependency>
    <groupId>org.hibernate</groupId>
    <artifactId>hibernate-validator</artifactId>
    <!-- 这个版本在maven中可以找到 -->
    <version>6.0.18.Final</version>
</dependency>
```

2、引入了mybatis-plus时候，原生的mybatis的配置可能会失效，在nacos中将其改成
```yaml
# mybatis-plus 相关配置
mybatis-plus:
  type-aliases-package: cn.xxx.xxx
  mapper-locations: classpath*:mybatis/mapper/*.xml
  # mybatis-plus 的全局配置
  global-config:
    banner: false
  # mybatis 原生配置
  configuration:
    # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
    map-underscore-to-camel-case: true
    lazy-loading-enabled: false
# 分页配置
pagehelper:
  helper-dialect: mysql
  reasonable: true
  support-methods-arguments: true
  params: count=countSql
```
