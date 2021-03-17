package com.simple.common.core.web.page;

import com.simple.common.core.util.StringUtils;
import lombok.Data;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 分页数据
 *
 * @author: WuChengXing
 * @create: 2021-03-17 23:42
 **/
@Data
public class PageDomain {
    /**
     * 当前记录起始索引
     */
    private Integer pageNum;

    /**
     * 每页显示记录数
     */
    private Integer pageSize;

    /**
     * 排序列
     */
    private String orderByColumn;

    /**
     * 排序的方向 "desc" 或者 "asc".
     */
    private String isAsc;

    public String getOrderBy() {
        if (StringUtils.isEmpty(orderByColumn)) {
            return "";
        }
        return StringUtils.toUnderScoreCase(orderByColumn) + " " + isAsc;
    }

}
