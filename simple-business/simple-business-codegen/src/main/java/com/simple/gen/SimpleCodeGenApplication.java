package com.simple.gen;

import com.simple.common.security.annotation.EnableCustomConfig;
import com.simple.common.security.annotation.EnableSimpleFeignClients;
import com.simple.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述:
 *
 * @author: WuChengXing
 * @create: 2021-05-03 19:28
 **/
@EnableCustomConfig
@EnableCustomSwagger2
@EnableSimpleFeignClients
@SpringCloudApplication
public class SimpleCodeGenApplication {
    public static void main(String[] args) {
        SpringApplication.run(SimpleCodeGenApplication.class, args);
        System.out.println("=================代码生成模块启动成功===============");
    }
}
