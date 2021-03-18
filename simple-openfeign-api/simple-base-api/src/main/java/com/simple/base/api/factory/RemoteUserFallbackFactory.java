package com.simple.base.api.factory;

import com.simple.base.api.feign.RemoteUserService;
import com.simple.base.api.model.UserInfo;
import com.simple.common.core.domain.Result;
import feign.hystrix.FallbackFactory;
import org.springframework.stereotype.Component;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述:
 *
 * @author: WuChengXing
 * @create: 2021-03-18 20:21
 **/
@Component
public class RemoteUserFallbackFactory implements FallbackFactory<RemoteUserService> {

    @Override
    public RemoteUserService create(Throwable cause) {
        return new RemoteUserService() {
            @Override
            public Result<UserInfo> getUserInfo(String username) {
                return null;
            }
        };
    }
}
