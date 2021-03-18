package com.simple.common.security.annotation;

import org.springframework.cloud.openfeign.EnableFeignClients;

import java.lang.annotation.*;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 自定义开启feign的注解
 *
 * @author: WuChengXing
 * @create: 2021-03-18 21:19
 **/
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@EnableFeignClients
public @interface EnableSimpleFeignClients {

    String[] value() default {};

    /**
     * 扫描那些包下面的 feignclient
     * @return
     */
    String[] basePackages() default {"com.simple"};

    Class<?>[] basePackageClasses() default {};

    Class<?>[] defaultConfiguration() default {};

    Class<?>[] clients() default {};
}
