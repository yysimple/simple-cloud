package com.simple.auth.exception;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;
import com.simple.common.core.constant.HttpStatus;
import com.simple.common.core.util.StringUtils;
import com.simple.common.core.web.domain.AjaxResult;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 自定义异常返回
 *
 * @author: WuChengXing
 * @create: 2021-03-29 23:00
 **/
@Slf4j
public class CustomOauthExceptionSerializer extends StdSerializer<CustomOauthException> {
    private static final long serialVersionUID = 1L;

    public static final String BAD_CREDENTIALS = "Bad credentials";

    public CustomOauthExceptionSerializer() {
        super(CustomOauthException.class);
    }

    @Override
    public void serialize(CustomOauthException e, JsonGenerator jsonGenerator, SerializerProvider serializerProvider)
            throws IOException {
        jsonGenerator.writeStartObject();
        jsonGenerator.writeNumberField(AjaxResult.CODE_TAG, HttpStatus.ERROR);
        if (StringUtils.equals(e.getMessage(), BAD_CREDENTIALS)) {
            jsonGenerator.writeStringField(AjaxResult.MSG_TAG, "用户名或密码错误");
        } else {
            log.warn("oauth2 认证异常 {} ", e);
            jsonGenerator.writeStringField(AjaxResult.MSG_TAG, e.getMessage());
        }
        jsonGenerator.writeEndObject();
    }
}

