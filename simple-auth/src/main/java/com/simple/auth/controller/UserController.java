package com.simple.auth.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 获取认证后的用户信息
 *
 * @author: WuChengXing
 * @create: 2021-03-31 13:47
 **/
@RestController
@RequestMapping("/oauth")
public class UserController {

    @RequestMapping("/user")
    public Principal user(Principal user) {
        return user;
    }
}
