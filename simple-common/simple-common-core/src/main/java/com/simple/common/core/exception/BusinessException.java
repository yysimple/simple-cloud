package com.simple.common.core.exception;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 业务异常
 *
 * @author: WuChengXing
 * @create: 2021-03-17 22:46
 **/
public class BusinessException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    protected final String message;

    public BusinessException(String message) {
        this.message = message;
    }

    public BusinessException(String message, Throwable e) {
        super(message, e);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }
}
