package com.simple.auth.controller;

import com.simple.base.api.feign.RemoteLogService;
import com.simple.common.core.constant.CommonConstants;
import com.simple.common.core.constant.SecurityConstants;
import com.simple.common.core.domain.Result;
import com.simple.common.core.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.common.OAuth2RefreshToken;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: token的处理（退出并清空token）
 *
 * @author: WuChengXing
 * @create: 2021-03-31 13:43
 **/
@RestController
@RequestMapping("/token")
public class TokenController {

    @Autowired
    private TokenStore tokenStore;

    @Autowired
    private RemoteLogService remoteLogService;

    @DeleteMapping("/logout")
    public Result<?> logout(@RequestHeader(value = HttpHeaders.AUTHORIZATION, required = false) String authHeader) {
        // 判断token是否存在请求头中
        if (StringUtils.isEmpty(authHeader)) {
            return Result.ok();
        }

        String tokenValue = authHeader.replace(OAuth2AccessToken.BEARER_TYPE, StringUtils.EMPTY).trim();
        OAuth2AccessToken accessToken = tokenStore.readAccessToken(tokenValue);
        // 校验token是否有效
        if (accessToken == null || StringUtils.isEmpty(accessToken.getValue())) {
            return Result.ok();
        }

        // 清空 access token
        tokenStore.removeAccessToken(accessToken);

        // 清空 refresh token
        OAuth2RefreshToken refreshToken = accessToken.getRefreshToken();
        tokenStore.removeRefreshToken(refreshToken);
        Map<String, ?> map = accessToken.getAdditionalInformation();
        if (map.containsKey(SecurityConstants.DETAILS_USERNAME)) {
            String username = (String) map.get(SecurityConstants.DETAILS_USERNAME);
            // 记录用户退出日志
            remoteLogService.saveLogininfor(username, CommonConstants.LOGOUT, "退出成功");
        }
        return Result.ok();
    }
}
