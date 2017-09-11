package com.Guo.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Guo.User.User;
import com.Guo.impl.UserDaoServer;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String oprateType = request.getParameter("oprateType");
		if ("register".equals(oprateType)) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", 0);
			try {
				int userId = Integer.parseInt(request.getParameter("userId"));
				String userName = request.getParameter("userName");
				String password = request.getParameter("password");
				String email = request.getParameter("email");
				String registerTime = request.getParameter("registerTime");
				User user = new User();
				user.setUserId(userId);
				user.setUserName(userName);
				user.setUserPassword(password);
				user.setUserEmail(email);
				user.setRegisterTime(registerTime);
				UserDaoServer userDao = new UserDaoServer();
				userDao.add(user);
			} catch (Exception e) {
				map.put("code", 1);
				e.printStackTrace();
			}
			/* map集合转换成json代码 */
			JSONObject jsonObject = JSONObject.fromObject(map);
			/* servlet接到request请求后，用pw返回结果 */
			PrintWriter pw = response.getWriter();
			pw.write(jsonObject.toString());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
