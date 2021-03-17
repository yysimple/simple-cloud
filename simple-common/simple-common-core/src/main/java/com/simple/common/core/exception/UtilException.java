package com.simple.common.core.exception;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 工具类异常
 *
 * @author: WuChengXing
 * @create: 2021-03-17 22:53
 **/
public class UtilException extends RuntimeException {
    private static final long serialVersionUID = 8247610319171014183L;

    public UtilException(Throwable e) {
        super(e.getMessage(), e);
    }

    public UtilException(String message) {
        super(message);
    }

    public UtilException(String message, Throwable throwable) {
        super(message, throwable);
    }
}
