package com.simple.common.log.service;

import com.simple.base.api.domain.SysOperLog;
import com.simple.base.api.feign.RemoteLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 异步调用日志服务
 *
 * @author: WuChengXing
 * @create: 2021-03-19 23:04
 **/
@Service
public class AsyncLogService {
    @Autowired
    private RemoteLogService remoteLogService;

    /**
     * 保存系统日志记录
     */
    @Async
    public void saveSysLog(SysOperLog sysOperLog) {
        remoteLogService.saveLog(sysOperLog);
    }
}
