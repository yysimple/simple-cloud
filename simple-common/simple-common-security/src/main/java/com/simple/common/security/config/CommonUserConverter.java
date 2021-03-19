package com.simple.common.security.config;

import com.simple.common.core.constant.SecurityConstants;
import com.simple.common.core.text.Convert;
import com.simple.common.security.domain.LoginUser;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.oauth2.provider.token.UserAuthenticationConverter;
import org.springframework.util.StringUtils;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 项目: simple-cloud
 * <p>
 * 功能描述: 为了避免一直进行 check-token，
 * check-token的目的：
 *   就是为了最后拿到用户的信息，当用户携带token 请求资源服务器的资源时,
 *   OAuth2AuthenticationProcessingFilter 拦截token，进行token 和userdetails 过程，
 *   把无状态的token 转化成用户信息。
 *
 * - 用户携带token 请求资源服务器
 * - 资源服务器拦截器 携带token 去认证服务器 调用tokenstore 对token 合法性校验
 * - 资源服务器拿到token，默认只会含有用户名信息
 * - 通过用户名调用userdetailsservice.loadbyusername 查询用户全部信息
 * 如上步骤在实际使用，会造成认证中心的负载压力过大，成为造成整个系统瓶颈的关键点。
 *
 * @author: WuChengXing
 * @create: 2021-03-18 22:28
 **/
public class CommonUserConverter implements UserAuthenticationConverter {
    private static final String N_A = "N/A";

    /**
     * 将授权信息返回到资源服务
     */
    @Override
    public Map<String, ?> convertUserAuthentication(Authentication userAuthentication) {
        Map<String, Object> authMap = new LinkedHashMap<>();
        authMap.put(USERNAME, userAuthentication.getName());
        if (userAuthentication.getAuthorities() != null && !userAuthentication.getAuthorities().isEmpty()) {
            authMap.put(AUTHORITIES, AuthorityUtils.authorityListToSet(userAuthentication.getAuthorities()));
        }
        return authMap;
    }

    /**
     * 获取用户认证信息
     */
    @Override
    public Authentication extractAuthentication(Map<String, ?> map) {
        if (map.containsKey(USERNAME)) {
            Collection<? extends GrantedAuthority> authorities = getAuthorities(map);

            Long userId = Convert.toLong(map.get(SecurityConstants.DETAILS_USER_ID));
            String username = (String) map.get(SecurityConstants.DETAILS_USERNAME);
            LoginUser user = new LoginUser(userId, username, N_A, true, true, true, true, authorities);
            return new UsernamePasswordAuthenticationToken(user, N_A, authorities);
        }
        return null;
    }

    /**
     * 获取权限资源信息
     */
    private Collection<? extends GrantedAuthority> getAuthorities(Map<String, ?> map) {
        Object authorities = map.get(AUTHORITIES);
        if (authorities instanceof String) {
            return AuthorityUtils.commaSeparatedStringToAuthorityList((String) authorities);
        }
        if (authorities instanceof Collection) {
            return AuthorityUtils.commaSeparatedStringToAuthorityList(
                    StringUtils.collectionToCommaDelimitedString((Collection<?>) authorities));
        }
        throw new IllegalArgumentException("Authorities must be either a String or a Collection");
    }
}
