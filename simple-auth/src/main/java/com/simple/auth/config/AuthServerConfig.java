package com.simple.auth.config;

import com.simple.auth.exception.CustomWebResponseExceptionTranslator;
import com.simple.common.core.constant.CacheConstants;
import com.simple.common.core.constant.SecurityConstants;
import com.simple.common.security.domain.LoginUser;
import com.simple.common.security.service.RedisClientDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.TokenEnhancer;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.oauth2.provider.token.store.redis.RedisTokenStore;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: OAuth2 认证服务配置
 *
 * @author: WuChengXing
 * @create: 2021-03-29 22:49
 **/
@Configuration
@EnableAuthorizationServer
public class AuthServerConfig extends AuthorizationServerConfigurerAdapter {

    @Resource
    private AuthenticationManager authenticationManager;

    @Autowired
    private DataSource dataSource;

    @Autowired
    private RedisConnectionFactory redisConnectionFactory;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private TokenEnhancer tokenEnhancer;

    /**
     * private String checkTokenAccess = "denyAll()";
     * 配置默认释放规则，默认是拒绝所有
     *
     * @param security
     * @throws Exception
     */
    @Override
    public void configure(AuthorizationServerSecurityConfigurer security) throws Exception {
        security.allowFormAuthenticationForClients().checkTokenAccess("permitAll()");
    }

    /**
     * 配置客户端详情
     *
     * @param clients
     * @throws Exception
     */
    @Override
    public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
        clients.withClientDetails(clientDetailsService());
    }

    /**
     * 声明 ClientDetails实现
     *
     * @return
     */
    public RedisClientDetailsService clientDetailsService() {
        return new RedisClientDetailsService(dataSource);
    }

    /**
     * 定义授权和令牌端点以及令牌服务
     *
     * @param endpoints
     * @throws Exception
     */
    @Override
    public void configure(AuthorizationServerEndpointsConfigurer endpoints) throws Exception {
        endpoints
                // 请求方式
                .allowedTokenEndpointRequestMethods(HttpMethod.GET, HttpMethod.POST)
                // 指定token存储位置
                .tokenStore(tokenStore())
                // 自定义生成令牌
                .tokenEnhancer(tokenEnhancer)
                // 用户账号密码认证
                .userDetailsService(userDetailsService)
                // 指定认证管理器
                .authenticationManager(authenticationManager)
                // 是否重复使用 refresh_token
                .reuseRefreshTokens(false)
                // 自定义异常处理
                .exceptionTranslator(new CustomWebResponseExceptionTranslator());
    }

    /**
     * 基于 Redis 实现，令牌保存到缓存
     */
    @Bean
    public TokenStore tokenStore() {
        RedisTokenStore tokenStore = new RedisTokenStore(redisConnectionFactory);
        // 设置redis中的key前缀
        tokenStore.setPrefix(CacheConstants.OAUTH_ACCESS);
        return tokenStore;
    }

    /**
     * 自定义生成令牌
     */
    @Bean
    public TokenEnhancer tokenEnhancer() {
        // 重写方法
        return (accessToken, authentication) -> {
            if (authentication.getUserAuthentication() != null) {
                Map<String, Object> additionalInformation = new LinkedHashMap<>();
                LoginUser user = (LoginUser) authentication.getUserAuthentication().getPrincipal();
                // 存入用户的id和用户名
                additionalInformation.put(SecurityConstants.DETAILS_USER_ID, user.getUserId());
                additionalInformation.put(SecurityConstants.DETAILS_USERNAME, user.getUsername());
                // 往之后的token中放入一些附加信息
                ((DefaultOAuth2AccessToken) accessToken).setAdditionalInformation(additionalInformation);
            }
            return accessToken;
        };
    }
}
