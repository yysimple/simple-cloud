package com.simple.common.swagger.annotation;

import com.simple.common.swagger.config.SwaggerAutoConfiguration;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: swagger的注解
 *
 * @author: WuChengXing
 * @create: 2021-03-17 23:58
 **/
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@Import({SwaggerAutoConfiguration.class})
public @interface EnableCustomSwagger2 {
}
