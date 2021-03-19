package com.simple.common.security.handler;

import com.alibaba.fastjson.JSON;
import com.simple.common.core.constant.HttpStatus;
import com.simple.common.core.domain.Result;
import com.simple.common.core.util.ServletUtils;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.oauth2.provider.error.OAuth2AccessDeniedHandler;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 自定义无权限访问时的异常
 *
 * OAuth2AccessDeniedHandler：如果授权失败，已有请求接口访问，则此入口点可以发送一个标准的403状态。以通常的方式
 *
 * 这里继承已做为全局的未授权拦截并返回异常
 *
 * @author: WuChengXing
 * @create: 2021-03-19 10:25
 **/
@Component
@Slf4j
public class CustomAccessDeniedHandler extends OAuth2AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException authException)
    {
        log.info("权限不足，请联系管理员 {}", request.getRequestURI());

        String msg = authException.getMessage();
        // 这里会发送给请求者
        ServletUtils.renderString(response, JSON.toJSONString(Result.fail(HttpStatus.FORBIDDEN, msg)));
    }
}
