package com.simple.common.security.config;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 忽略服务间的认证
 *
 * @author: WuChengXing
 * @create: 2021-03-18 21:24
 **/
@Component
@Configurable
@ConfigurationProperties(prefix = "security.oauth2.ignore")
public class AuthIgnoreConfig {
    private List<String> urls = new ArrayList<>();

    /**
     * 功能描述: 从配置文件中读出所有放行的url
     *
     * @param
     * @return java.util.List<java.lang.String>
     * @author WuChengxing
     * @date 2021/3/18
     */
    public List<String> getUrls() {
        return urls;
    }

    public void setUrls(List<String> urls) {
        this.urls = urls;
    }
}
