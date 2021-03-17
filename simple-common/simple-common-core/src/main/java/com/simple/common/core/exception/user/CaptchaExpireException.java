package com.simple.common.core.exception.user;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 验证码失效异常类
 *
 * @author: WuChengXing
 * @create: 2021-03-17 22:58
 **/

public class CaptchaExpireException extends UserException {
    private static final long serialVersionUID = 1L;

    public CaptchaExpireException() {
        super("user.jcaptcha.expire", null);
    }
}
