package com.simple.common.security.feign;

import feign.RequestInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: feign配置注册
 *
 * @author: WuChengXing
 * @create: 2021-03-18 22:50
 **/
@Configuration
public class OAuth2FeignConfig {

    @Bean
    public RequestInterceptor requestInterceptor() {
        return new OAuth2FeignRequestInterceptor();
    }
}
