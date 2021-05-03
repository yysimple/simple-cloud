package com.simple.timedtask.service.impl;

import com.simple.common.core.constant.ScheduleConstants;
import com.simple.common.core.exception.job.TaskException;
import com.simple.timedtask.domain.SysJob;
import com.simple.timedtask.mapper.SysJobMapper;
import com.simple.timedtask.service.ISysJobService;
import com.simple.timedtask.util.CronUtils;
import com.simple.timedtask.util.ScheduleUtils;
import org.quartz.JobDataMap;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;

/**
 * 定时任务调度信息 服务层
 *
 * @author simple
 */
@Service
public class SysJobServiceImpl implements ISysJobService {

    @Resource
    private Scheduler scheduler;

    @Autowired
    private SysJobMapper timedtaskMapper;

    /**
     * 项目启动时，初始化定时器 主要是防止手动修改数据库导致未同步到定时任务处理（注：不能手动修改数据库ID和任务组名，否则会导致脏数据）
     */
    @PostConstruct
    public void init() throws SchedulerException, TaskException {
        scheduler.clear();
        List<SysJob> timedtaskList = timedtaskMapper.selectJobAll();
        for (SysJob timedtask : timedtaskList) {
            ScheduleUtils.createScheduleJob(scheduler, timedtask);
        }
    }

    /**
     * 获取quartz调度器的计划任务列表
     *
     * @param timedtask 调度信息
     * @return
     */
    @Override
    public List<SysJob> selectJobList(SysJob timedtask) {
        return timedtaskMapper.selectJobList(timedtask);
    }

    /**
     * 通过调度任务ID查询调度信息
     *
     * @param timedtaskId 调度任务ID
     * @return 调度任务对象信息
     */
    @Override
    public SysJob selectJobById(Long timedtaskId) {
        return timedtaskMapper.selectJobById(timedtaskId);
    }

    /**
     * 暂停任务
     *
     * @param timedtask 调度信息
     */
    @Override
    @Transactional
    public int pauseJob(SysJob timedtask) throws SchedulerException {
        Long timedtaskId = timedtask.getJobId();
        String timedtaskGroup = timedtask.getJobGroup();
        timedtask.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        int rows = timedtaskMapper.updateJob(timedtask);
        if (rows > 0) {
            scheduler.pauseJob(ScheduleUtils.getJobKey(timedtaskId, timedtaskGroup));
        }
        return rows;
    }

    /**
     * 恢复任务
     *
     * @param timedtask 调度信息
     */
    @Override
    @Transactional
    public int resumeJob(SysJob timedtask) throws SchedulerException {
        Long timedtaskId = timedtask.getJobId();
        String timedtaskGroup = timedtask.getJobGroup();
        timedtask.setStatus(ScheduleConstants.Status.NORMAL.getValue());
        int rows = timedtaskMapper.updateJob(timedtask);
        if (rows > 0) {
            scheduler.resumeJob(ScheduleUtils.getJobKey(timedtaskId, timedtaskGroup));
        }
        return rows;
    }

    /**
     * 删除任务后，所对应的trigger也将被删除
     *
     * @param timedtask 调度信息
     */
    @Override
    @Transactional
    public int deleteJob(SysJob timedtask) throws SchedulerException {
        Long timedtaskId = timedtask.getJobId();
        String timedtaskGroup = timedtask.getJobGroup();
        int rows = timedtaskMapper.deleteJobById(timedtaskId);
        if (rows > 0) {
            scheduler.deleteJob(ScheduleUtils.getJobKey(timedtaskId, timedtaskGroup));
        }
        return rows;
    }

    /**
     * 批量删除调度信息
     *
     * @param timedtaskIds 需要删除的任务ID
     * @return 结果
     */
    @Override
    @Transactional
    public void deleteJobByIds(Long[] timedtaskIds) throws SchedulerException {
        for (Long timedtaskId : timedtaskIds) {
            SysJob timedtask = timedtaskMapper.selectJobById(timedtaskId);
            deleteJob(timedtask);
        }
    }

    /**
     * 任务调度状态修改
     *
     * @param timedtask 调度信息
     */
    @Override
    @Transactional
    public int changeStatus(SysJob timedtask) throws SchedulerException {
        int rows = 0;
        String status = timedtask.getStatus();
        if (ScheduleConstants.Status.NORMAL.getValue().equals(status)) {
            rows = resumeJob(timedtask);
        } else if (ScheduleConstants.Status.PAUSE.getValue().equals(status)) {
            rows = pauseJob(timedtask);
        }
        return rows;
    }

    /**
     * 立即运行任务
     *
     * @param timedtask 调度信息
     */
    @Override
    @Transactional
    public void run(SysJob timedtask) throws SchedulerException {
        Long timedtaskId = timedtask.getJobId();
        String timedtaskGroup = timedtask.getJobGroup();
        SysJob properties = selectJobById(timedtask.getJobId());
        // 参数
        JobDataMap dataMap = new JobDataMap();
        dataMap.put(ScheduleConstants.TASK_PROPERTIES, properties);
        scheduler.triggerJob(ScheduleUtils.getJobKey(timedtaskId, timedtaskGroup), dataMap);
    }

    /**
     * 新增任务
     *
     * @param timedtask 调度信息 调度信息
     */
    @Override
    @Transactional
    public int insertJob(SysJob timedtask) throws SchedulerException, TaskException {
        timedtask.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        int rows = timedtaskMapper.insertJob(timedtask);
        if (rows > 0) {
            ScheduleUtils.createScheduleJob(scheduler, timedtask);
        }
        return rows;
    }

    /**
     * 更新任务的时间表达式
     *
     * @param timedtask 调度信息
     */
    @Override
    @Transactional
    public int updateJob(SysJob timedtask) throws SchedulerException, TaskException {
        SysJob properties = selectJobById(timedtask.getJobId());
        int rows = timedtaskMapper.updateJob(timedtask);
        if (rows > 0) {
            updateSchedulerJob(timedtask, properties.getJobGroup());
        }
        return rows;
    }

    /**
     * 更新任务
     *
     * @param timedtask      任务对象
     * @param timedtaskGroup 任务组名
     */
    public void updateSchedulerJob(SysJob timedtask, String timedtaskGroup) throws SchedulerException, TaskException {
        Long timedtaskId = timedtask.getJobId();
        // 判断是否存在
        JobKey timedtaskKey = ScheduleUtils.getJobKey(timedtaskId, timedtaskGroup);
        if (scheduler.checkExists(timedtaskKey)) {
            // 防止创建时存在数据问题 先移除，然后在执行创建操作
            scheduler.deleteJob(timedtaskKey);
        }
        ScheduleUtils.createScheduleJob(scheduler, timedtask);
    }

    /**
     * 校验cron表达式是否有效
     *
     * @param cronExpression 表达式
     * @return 结果
     */
    @Override
    public boolean checkCronExpressionIsValid(String cronExpression) {
        return CronUtils.isValid(cronExpression);
    }
}