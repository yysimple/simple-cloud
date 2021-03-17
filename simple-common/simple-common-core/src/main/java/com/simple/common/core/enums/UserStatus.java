package com.simple.common.core.enums;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 用户状态枚举
 *
 * @author: WuChengXing
 * @create: 2021-03-17 21:01
 **/
public enum UserStatus {
    /**
     * 用户状态
     */
    OK("0", "正常"), DISABLE("1", "停用"), DELETED("2", "删除");

    private final String code;
    private final String info;

    UserStatus(String code, String info) {
        this.code = code;
        this.info = info;
    }

    public String getCode() {
        return code;
    }

    public String getInfo() {
        return info;
    }
}
