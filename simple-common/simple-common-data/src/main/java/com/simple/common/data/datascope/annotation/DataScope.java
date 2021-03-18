package com.simple.common.data.datascope.annotation;

import java.lang.annotation.*;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 数据权限过滤注解
 *
 * @author: WuChengXing
 * @create: 2021-03-18 20:58
 **/
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface DataScope {
    /**
     * 部门表的别名
     */
    String deptAlias() default "";

    /**
     * 用户表的别名
     */
    String userAlias() default "";
}
