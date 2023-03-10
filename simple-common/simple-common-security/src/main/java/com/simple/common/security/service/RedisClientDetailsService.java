package com.simple.common.security.service;

import com.simple.common.core.constant.CacheConstants;
import com.simple.common.core.constant.SecurityConstants;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.oauth2.provider.ClientDetails;
import org.springframework.security.oauth2.provider.client.JdbcClientDetailsService;

import javax.sql.DataSource;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 重写原生方法支持redis缓存
 *
 * @author: WuChengXing
 * @create: 2021-03-19 10:39
 **/
public class RedisClientDetailsService extends JdbcClientDetailsService {

    public RedisClientDetailsService(DataSource dataSource) {
        super(dataSource);
        super.setSelectClientDetailsSql(SecurityConstants.DEFAULT_SELECT_STATEMENT);
        super.setFindClientDetailsSql(SecurityConstants.DEFAULT_FIND_STATEMENT);
    }

    @Override
    @Cacheable(value = CacheConstants.CLIENT_DETAILS_KEY, key = "#clientId", unless = "#result == null")
    public ClientDetails loadClientByClientId(String clientId) {
        return super.loadClientByClientId(clientId);
    }
}
