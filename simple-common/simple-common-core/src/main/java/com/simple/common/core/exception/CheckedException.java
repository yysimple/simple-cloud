package com.simple.common.core.exception;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 检查异常
 *
 * @author: WuChengXing
 * @create: 2021-03-17 22:48
 **/
public class CheckedException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public CheckedException(String message) {
        super(message);
    }

    public CheckedException(Throwable cause) {
        super(cause);
    }

    public CheckedException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * 1.7 之后的异常
     * @param message 消息
     * @param cause 原因
     * @param enableSuppression 抑制启用或禁用
     * @param writableStackTrace 堆栈跟踪是否应可写
     */
    public CheckedException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
