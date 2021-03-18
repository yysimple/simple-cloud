package com.simple.base.api.model;

import com.simple.base.api.domain.SysUser;
import lombok.Data;

import java.io.Serializable;
import java.util.Set;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 用户信息
 *
 * @author: WuChengXing
 * @create: 2021-03-18 19:31
 **/
@Data
public class UserInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户基本信息
     */
    private SysUser sysUser;

    /**
     * 权限标识集合
     */
    private Set<String> permissions;

    /**
     * 角色集合
     */
    private Set<String> roles;
}
