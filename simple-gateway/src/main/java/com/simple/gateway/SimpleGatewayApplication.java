package com.simple.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 网关的启动类
 *
 * @author: WuChengXing
 * @create: 2021-03-31 14:04
 **/
@EnableDiscoveryClient
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class SimpleGatewayApplication {
    public static void main(String[] args) {
        SpringApplication.run(SimpleGatewayApplication.class, args);
        System.out.println("=================网关模块启动成功===============");
    }
}
