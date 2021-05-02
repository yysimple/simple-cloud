package com.simple.base.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.simple.common.core.annotation.Excel;
import com.simple.common.core.annotation.Excel.ColumnType;
import com.simple.common.core.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 系统访问记录表 sys_logininfor
 *
 * @author wcx
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysLogininfor extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @Excel(name = "序号", cellType = ColumnType.NUMERIC)
    private Long infoId;

    /**
     * 用户账号
     */
    @Excel(name = "用户账号")
    private String userName;

    /**
     * 状态 0成功 1失败
     */
    @Excel(name = "状态", readConverterExp = "0=成功,1=失败")
    private String status;

    /**
     * 地址
     */
    @Excel(name = "地址")
    private String ipaddr;

    /**
     * 描述
     */
    @Excel(name = "描述")
    private String msg;

    /**
     * 访问时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "访问时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date accessTime;
}