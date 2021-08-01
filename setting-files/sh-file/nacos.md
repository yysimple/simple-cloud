1. 拉取最新的版本nacos镜像

```shell
docker pull nacos/nacos-server
```

2. 启动nacos
- 新建启动脚本 nacos-start.sh
```shell
touch nacos-start.sh
chmod 777 nacos-start.sh
```

- 写入脚本
```shell
docker run -it -e MODE=standalone \
-e SPRING_DATASOURCE_PLATFORM=mysql \
-e MYSQL_MASTER_SERVICE_HOST=192.168.109.201 \
-e MYSQL_MASTER_SERVICE_DB_NAME=simple_nacos \
-e MYSQL_MASTER_SERVICE_PORT=3306 \
-e MYSQL_MASTER_SERVICE_USER=simple \
-e MYSQL_MASTER_SERVICE_PASSWORD=123456! \
-v /www/data/nacos/logs:/home/nacos/logs \
--restart=always \
--name nacos -p 8848:8848 nacos/nacos-server
```

- 启动脚本
```shell
sh nacos-start.sh
```

3. 进入容器，修改数据库配置文件

- 进入容器
```shell
# 查看启动的容器
docker ps -a 

# 进入容器 xxx = 容器id(2esa532das)，或者前三位就行 esa
docker exec -it esa /bin/bash
```

- 修改文件
```shell
cd conf/

ls

vim application.properties

# 修改 application.properties
server.servlet.contextPath=${SERVER_SERVLET_CONTEXTPATH:/nacos}
server.contextPath=/nacos
server.port=${NACOS_APPLICATION_PORT:8848}
# 这里加上 ”mysql“
spring.datasource.platform=${SPRING_DATASOURCE_PLATFORM:"mysql"}
nacos.cmdb.dumpTaskInterval=3600
nacos.cmdb.eventTaskInterval=10
nacos.cmdb.labelTaskInterval=300
nacos.cmdb.loadDataAtStart=false
db.num=${MYSQL_DATABASE_NUM:1}
# 这里配置上  host：192.168.109.201  数据库名：simple_nacos
db.url.0=jdbc:mysql://${MYSQL_SERVICE_HOST:192.168.109.201}:${MYSQL_SERVICE_PORT:3306}/${MYSQL_SERVICE_DB_NAME:simple_nacos}?${MYSQL_SERVICE_DB_PARAM:characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useSSL=false}
db.url.1=jdbc:mysql://${MYSQL_SERVICE_HOST:192.168.109.201}:${MYSQL_SERVICE_PORT:3306}/${MYSQL_SERVICE_DB_NAME:simple_nacos}?${MYSQL_SERVICE_DB_PARAM:characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useSSL=false}
# 这是用户名和密码
db.user=${MYSQL_SERVICE_USER:simple}
db.password=${MYSQL_SERVICE_PASSWORD:123456}

# 保存后退出容器
exit
```

- 重启docker-nacos
```shell
docker restart nacos

# 查看启动日志
docker logs <容器id>

# 成功的象征，最后一行打印
Nacos started successfully in stand alone mode. use external storage
```

- 访问nacos
192.168.109.201:8848/nacos   账号密码：nacos/nacos

