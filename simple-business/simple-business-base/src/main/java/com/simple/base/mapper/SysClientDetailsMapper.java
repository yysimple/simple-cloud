package com.simple.base.mapper;

import com.simple.base.domain.SysClientDetails;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 终端配置Mapper接口
 *
 * @author wcx
 */
@Repository
public interface SysClientDetailsMapper {
    /**
     * 查询终端配置
     *
     * @param clientId 终端配置ID
     * @return 终端配置
     */
    SysClientDetails selectSysClientDetailsById(String clientId);

    /**
     * 查询终端配置列表
     *
     * @param sysClientDetails 终端配置
     * @return 终端配置集合
     */
    List<SysClientDetails> selectSysClientDetailsList(SysClientDetails sysClientDetails);

    /**
     * 新增终端配置
     *
     * @param sysClientDetails 终端配置
     * @return 结果
     */
    int insertSysClientDetails(SysClientDetails sysClientDetails);

    /**
     * 修改终端配置
     *
     * @param sysClientDetails 终端配置
     * @return 结果
     */
    int updateSysClientDetails(SysClientDetails sysClientDetails);

    /**
     * 删除终端配置
     *
     * @param clientId 终端配置ID
     * @return 结果
     */
    int deleteSysClientDetailsById(String clientId);

    /**
     * 批量删除终端配置
     *
     * @param clientIds 需要删除的数据ID
     * @return 结果
     */
    int deleteSysClientDetailsByIds(String[] clientIds);
}
