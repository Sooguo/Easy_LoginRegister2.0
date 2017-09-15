/**
 * 
 */
/**
 * @author 10329
 *
 */
package com.Guo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Guo.LoginService.LoginService;
import com.Guo.impl.LoginServer;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LoginService service = new LoginServer();// 新建bean服务类
		// 设置请求中数据的编码格式
		request.setCharacterEncoding("utf-8"); // 解决中文乱码问题，只支持post模式
		try {
			String path = service.login(request);// 访问业务Bean，验证登录
			request.getRequestDispatcher(path).forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}