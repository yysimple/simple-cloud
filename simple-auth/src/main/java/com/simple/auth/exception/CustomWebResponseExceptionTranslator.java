package com.simple.auth.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.common.exceptions.OAuth2Exception;
import org.springframework.security.oauth2.provider.error.WebResponseExceptionTranslator;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: Oauth2 自定义异常
 *
 * @author: WuChengXing
 * @create: 2021-03-29 22:59
 **/
public class CustomWebResponseExceptionTranslator implements WebResponseExceptionTranslator<OAuth2Exception> {
    @Override
    public ResponseEntity<OAuth2Exception> translate(Exception e) {
        return ResponseEntity.status(HttpStatus.OK).body(new CustomOauthException(e.getMessage()));
    }
}
