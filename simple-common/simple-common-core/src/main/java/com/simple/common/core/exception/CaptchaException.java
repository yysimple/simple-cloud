package com.simple.common.core.exception;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 验证码错误相关异常
 *
 * @author: WuChengXing
 * @create: 2021-03-17 22:47
 **/
public class CaptchaException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public CaptchaException(String msg) {
        super(msg);
    }
}
