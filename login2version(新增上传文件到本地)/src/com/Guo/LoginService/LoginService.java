/**
 * 
 */
/**
 * @author 10329
 *
 */
package com.Guo.LoginService;
/*Service中定义业务逻辑；*/

import javax.servlet.http.HttpServletRequest;

public interface LoginService {
	// 调用数据库服务类，具体查询
	public String login(HttpServletRequest request) throws Exception;
}