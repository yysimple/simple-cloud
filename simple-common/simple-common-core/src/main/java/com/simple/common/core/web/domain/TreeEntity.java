package com.simple.common.core.web.domain;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述:
 *
 * @author: WuChengXing
 * @create: 2021-03-17 23:41
 **/
@Data
public class TreeEntity extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 父菜单名称
     */
    private String parentName;

    /**
     * 父菜单ID
     */
    private Long parentId;

    /**
     * 显示顺序
     */
    private Integer orderNum;

    /**
     * 祖级列表
     */
    private String ancestors;

    /**
     * 子部门
     */
    private List<?> children = new ArrayList<>();
}
