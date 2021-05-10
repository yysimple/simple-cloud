package com.simple.base.api.feign;

import com.simple.base.api.factory.RemoteUserFallbackFactory;
import com.simple.base.api.model.UserInfo;
import com.simple.common.core.constant.ServiceNameConstants;
import com.simple.common.core.domain.Result;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 调用远程接口
 *
 * @author: WuChengXing
 * @create: 2021-03-18 20:15
 **/
@FeignClient(contextId = "remoteUserService", value = ServiceNameConstants.BUSINESS_SERVICE, fallbackFactory = RemoteUserFallbackFactory.class)
public interface RemoteUserService {

    /**
     * 通过用户名查询用户信息
     *
     * @param username 用户名
     * @return 结果
     */
    @GetMapping(value = "/user/info/{username}")
    Result<UserInfo> getUserInfo(@PathVariable("username") String username);

}
