package com.simple.auth.exception;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.springframework.security.oauth2.common.exceptions.OAuth2Exception;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述:
 *
 * @author: WuChengXing
 * @create: 2021-03-29 23:00
 **/
@JsonSerialize(using = CustomOauthExceptionSerializer.class)
public class CustomOauthException extends OAuth2Exception {
    private static final long serialVersionUID = 1L;

    public CustomOauthException(String message) {
        super(message);
    }
}
