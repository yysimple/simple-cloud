package com.simple.base.service;

import java.util.Set;

/**
 * 权限
 * @author wcx
 */
public interface ISysPermissionService {
    /**
     * 获取角色数据权限
     *
     * @param userId 用户Id
     * @return 角色权限信息
     */
    Set<String> getRolePermission(Long userId);

    /**
     * 获取菜单数据权限
     *
     * @param userId 用户Id
     * @return 菜单权限信息
     */
    Set<String> getMenuPermission(Long userId);
}
