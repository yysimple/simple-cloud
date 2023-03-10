package com.simple.common.core.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: excel 注解集
 *
 * @author: WuChengXing
 * @create: 2021-03-17 20:06
 **/
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Excels {
    Excel[] value();
}
