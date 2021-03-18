package com.simple.common.data.datascope.service;

import com.simple.base.api.feign.RemoteUserService;
import com.simple.base.api.model.UserInfo;
import com.simple.common.core.domain.Result;
import com.simple.common.core.util.StringUtils;
import com.simple.common.security.util.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 同步调用用户服务
 *
 * @author: WuChengXing
 * @create: 2021-03-18 21:00
 **/
public class AwaitUserService {
    private static final Logger log = LoggerFactory.getLogger(AwaitUserService.class);

    @Autowired
    private RemoteUserService remoteUserService;

    /**
     * 查询当前用户信息
     *
     * @return 用户基本信息
     */
    public UserInfo info() {
        String username = SecurityUtils.getUsername();
        Result<UserInfo> userResult = remoteUserService.getUserInfo(username);
        if (StringUtils.isNull(userResult) || StringUtils.isNull(userResult.getData())) {
            log.info("数据权限范围查询用户：{} 不存在.", username);
            return null;
        }
        return userResult.getData();
    }
}
