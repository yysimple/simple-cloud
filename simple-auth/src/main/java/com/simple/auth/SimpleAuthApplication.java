package com.simple.auth;

import com.simple.common.security.annotation.EnableSimpleFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 认证模块启动类
 *
 * @author: WuChengXing
 * @create: 2021-03-26 15:09
 **/
@SpringBootApplication
@EnableSimpleFeignClients
public class SimpleAuthApplication {
    public static void main(String[] args) {
        SpringApplication.run(SimpleAuthApplication.class, args);
        System.out.println("=================授权模块启动成功===============");
    }
}
