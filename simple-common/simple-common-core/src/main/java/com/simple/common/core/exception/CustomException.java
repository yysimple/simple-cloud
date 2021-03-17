package com.simple.common.core.exception;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 自定义的异常
 *
 * @author: WuChengXing
 * @create: 2021-03-17 22:52
 **/
public class CustomException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    private Integer code;

    private final String message;

    public CustomException(String message) {
        this.message = message;
    }

    public CustomException(String message, Integer code) {
        this.message = message;
        this.code = code;
    }

    public CustomException(String message, Throwable e) {
        super(message, e);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public Integer getCode() {
        return code;
    }
}
