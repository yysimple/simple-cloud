package com.simple.gateway.service;

import com.simple.common.core.exception.CaptchaException;
import com.simple.common.core.web.domain.AjaxResult;

import java.io.IOException;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 验证码处理
 *
 * @author: WuChengXing
 * @create: 2021-03-31 14:04
 **/
public interface ValidateCodeService {

    /**
     * 功能描述: 生成验证码
     *
     * @return
     * @throws IOException
     * @throws CaptchaException
     * @author WuChengxing
     * @date 2021/3/31
     */
    AjaxResult createCapcha() throws IOException, CaptchaException;

    /**
     * 功能描述: 校验验证码
     *
     * @param key
     * @param value
     * @throws CaptchaException
     * @author WuChengxing
     * @date 2021/3/31
     */
    void checkCapcha(String key, String value) throws CaptchaException;
}
