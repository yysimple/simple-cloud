package com.simple.auth.handler;

import com.simple.base.api.feign.RemoteLogService;
import com.simple.common.core.constant.CommonConstants;
import com.simple.common.core.util.StringUtils;
import com.simple.common.security.domain.LoginUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.security.authentication.event.AuthenticationSuccessEvent;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 认证成功处理
 *
 * @author: WuChengXing
 * @create: 2021-03-31 10:37
 **/
@Component
public class AuthenticationSuccessEventHandler implements ApplicationListener<AuthenticationSuccessEvent> {
    @Resource
    private RemoteLogService remoteLogService;

    @Override
    public void onApplicationEvent(AuthenticationSuccessEvent event) {
        Authentication authentication = (Authentication) event.getSource();
        if (StringUtils.isNotEmpty(authentication.getAuthorities())
                && authentication.getPrincipal() instanceof LoginUser) {
            LoginUser user = (LoginUser) authentication.getPrincipal();

            String username = user.getUsername();

            // 记录用户登录日志
            remoteLogService.saveLogininfor(username, CommonConstants.LOGIN_SUCCESS, "登录成功");
        }
    }
}
