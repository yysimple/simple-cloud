package com.simple.common.log.annotation;

import com.simple.common.log.enums.BusinessType;
import com.simple.common.log.enums.OperatorType;

import java.lang.annotation.*;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: log注解
 * 自定义操作日志记录注解
 *
 * @author: WuChengXing
 * @create: 2021-03-19 22:57
 **/
@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log {
    /**
     * 模块
     */
    String title() default "";

    /**
     * 功能
     */
    BusinessType businessType() default BusinessType.OTHER;

    /**
     * 操作人类别
     */
    OperatorType operatorType() default OperatorType.MANAGE;

    /**
     * 是否保存请求的参数
     */
    boolean isSaveRequestData() default true;
}
