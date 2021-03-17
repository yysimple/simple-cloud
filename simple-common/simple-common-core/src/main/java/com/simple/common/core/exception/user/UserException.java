package com.simple.common.core.exception.user;

import com.simple.common.core.exception.BaseException;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 用户相关异常
 *
 * @author: WuChengXing
 * @create: 2021-03-17 22:57
 **/
public class UserException extends BaseException {
    private static final long serialVersionUID = 1L;

    public UserException(String code, Object[] args) {
        super("user", code, args, null);
    }
}
