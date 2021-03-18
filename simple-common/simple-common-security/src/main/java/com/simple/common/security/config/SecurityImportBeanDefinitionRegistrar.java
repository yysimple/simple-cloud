package com.simple.common.security.config;

import com.simple.common.core.util.StringUtils;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.context.annotation.ImportBeanDefinitionRegistrar;
import org.springframework.core.type.AnnotationMetadata;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 导入 SecurityImportBeanDefinitionRegistrar 自动加载类
 *
 * @author: WuChengXing
 * @create: 2021-03-18 21:17
 **/
public class SecurityImportBeanDefinitionRegistrar implements ImportBeanDefinitionRegistrar {
    @Override
    public void registerBeanDefinitions(AnnotationMetadata metadata, BeanDefinitionRegistry registry) {
        Class<ResourceServerConfig> aClass = ResourceServerConfig.class;
        String beanName = StringUtils.uncapitalize(aClass.getSimpleName());
        BeanDefinitionBuilder beanDefinitionBuilder = BeanDefinitionBuilder.genericBeanDefinition(ResourceServerConfig.class);
        registry.registerBeanDefinition(beanName, beanDefinitionBuilder.getBeanDefinition());
    }
}
