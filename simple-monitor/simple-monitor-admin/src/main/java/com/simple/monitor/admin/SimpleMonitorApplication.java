package com.simple.monitor.admin;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 监控中心
 *
 * @author: WuChengXing
 * @create: 2021-05-03 23:08
 **/
@EnableAdminServer
@SpringCloudApplication
public class SimpleMonitorApplication {
    public static void main(String[] args) {
        SpringApplication.run(SimpleMonitorApplication.class, args);
        System.out.println("=================监控模块启动成功===============");
    }
}
