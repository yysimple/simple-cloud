package com.simple.base.api.factory;

import com.simple.base.api.domain.SysOperLog;
import com.simple.base.api.feign.RemoteLogService;
import com.simple.common.core.domain.Result;
import feign.hystrix.FallbackFactory;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述:
 *
 * @author: WuChengXing
 * @create: 2021-03-18 20:27
 **/
public class RemoteLogFallbackFactory implements FallbackFactory<RemoteLogService> {
    @Override
    public RemoteLogService create(Throwable cause) {
        return new RemoteLogService() {
            @Override
            public Result<Boolean> saveLog(SysOperLog sysOperLog) {
                return null;
            }

            @Override
            public Result<Boolean> saveLogininfor(String username, String status, String message) {
                return null;
            }
        };
    }
}
