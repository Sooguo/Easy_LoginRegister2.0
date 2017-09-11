/**
 * 
 */
/**
 * @author 10329
 *
 */
package com.Guo.impl;

import javax.servlet.http.HttpServletRequest;

import com.Guo.DaoService.UserDaoService;
import com.Guo.LoginService.LoginService;
import com.Guo.User.User;

public class LoginServer implements LoginService {

	private UserDaoService dao = new UserDaoServer(); // 定义数据访问Dao对象

	@Override
	public String login(HttpServletRequest request) throws Exception {
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		/* 通过Dao接口，访问数据库，用户名与密码为条件查询用户数据 */
		User user = dao.check(userName, password);
		// 验证登录是否成功
		if (user != null) {
			System.out.println("userName= " + userName + " userPassword= " + password);
			request.setAttribute("userName", userName);
			request.setAttribute("password", password);
			return "/main.jsp";
		} else {
			// 请求中添加错误信息
			System.out.println("用户名或密码错误!");
			request.setAttribute("error", "用户名或密码错误!");
			return "/login.jsp";
		}
	}

}