package com.simple.common.core.util.sql;

import com.simple.common.core.exception.BaseException;
import com.simple.common.core.util.StringUtils;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: sql操作的工具类
 *
 * @author: WuChengXing
 * @create: 2021-03-17 23:25
 **/
public class SqlUtil {
    /**
     * 仅支持字母、数字、下划线、空格、逗号、小数点（支持多个字段排序）
     */
    public static String SQL_PATTERN = "[a-zA-Z0-9_\\ \\,\\.]+";

    /**
     * 检查字符，防止注入绕过
     */
    public static String escapeOrderBySql(String value) {
        if (StringUtils.isNotEmpty(value) && !isValidOrderBySql(value)) {
            throw new BaseException("参数不符合规范，不能进行查询");
        }
        return value;
    }

    /**
     * 验证 order by 语法是否符合规范
     */
    public static boolean isValidOrderBySql(String value) {
        return value.matches(SQL_PATTERN);
    }
}
