package com.simple.timedtask.util;

import com.simple.timedtask.domain.SysJob;
import org.quartz.JobExecutionContext;

/**
 * 定时任务处理（允许并发执行）
 *
 * @author wcx
 */
public class QuartzJobExecution extends com.simple.timedtask.util.AbstractQuartzJob {
    @Override
    protected void doExecute(JobExecutionContext context, SysJob sysJob) throws Exception {
        com.simple.timedtask.util.JobInvokeUtil.invokeMethod(sysJob);
    }
}
