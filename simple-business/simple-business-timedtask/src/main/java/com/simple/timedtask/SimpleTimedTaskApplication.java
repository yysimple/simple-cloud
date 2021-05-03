package com.simple.timedtask;

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
 * @create: 2021-05-03 22:41
 **/
@EnableCustomConfig
@EnableCustomSwagger2
@EnableSimpleFeignClients
@SpringCloudApplication
public class SimpleTimedTaskApplication {
    public static void main(String[] args) {
        SpringApplication.run(SimpleTimedTaskApplication.class, args);
        System.out.println("=================定时任务模块启动成功===============");
    }
}
