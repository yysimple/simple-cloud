package com.simple.common.core.exception.user;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 用户名密码不匹配异常
 *
 * @author: WuChengXing
 * @create: 2021-03-17 22:59
 **/
public class UserPasswordNotMatchException extends UserException {
    private static final long serialVersionUID = 1L;

    public UserPasswordNotMatchException() {
        super("user.password.not.match", null);
    }
}
