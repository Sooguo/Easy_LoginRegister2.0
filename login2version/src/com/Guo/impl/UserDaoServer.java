/**
 * 
 */
/**
 * @author 10329
 *
 */
package com.Guo.impl;

import java.sql.ResultSet;
import java.sql.Statement;

import com.Guo.DaoService.UserDaoService;
import com.Guo.User.User;
import com.Guo.database.DataSource;
import com.mysql.jdbc.Connection;

/*查询用户输入的数据是否存在*/
public class UserDaoServer implements UserDaoService {
	@Override
	/* 继承DAO接口的函数 */
	public User check(String userName, String userPassword) throws Exception {
		/* 使用数据源取得数据库链接 */
		Connection conn = (Connection) DataSource.getConnection();
		/* 创建数据库操作的语句对象 */
		Statement stm = conn.createStatement();
		/* 查询数据库返回结果集 */
		ResultSet rs = stm.executeQuery(
				"select * from data" + " where user_name='" + userName + "'and password='" + userPassword + "'");
		User user = null;
		/* 遍历结果集，封装用户数据 */
		if (rs.next()) {
			user = new User();
			/* 设置用户的属性值 */
			user.setUserId(rs.getInt("user_id"));
			user.setUserName(rs.getString("user_name"));
			user.setUserPassword(rs.getString("password"));
			user.setUserEmail(rs.getString("email"));
			user.setRegisterTime(rs.getString("registerTime"));
		}
		conn.close();
		return user;// 如果没有查询到此用户，那么将返回空指针
	}

	/* 往数据库添加数据完成注册 */
	public void add(User user) throws Exception {
		Connection conn = (Connection) DataSource.getConnection();
		Statement stmt = conn.createStatement();
		String sql = "insert into data(user_id,user_name,password,email,registerTime)values('" + user.getUserId()
				+ "','" + user.getUserName() + "','" + user.getUserPassword() + "','" + user.getUserEmail() + "','"
				+ user.getRegisterTime() + "')";
		/* 执行查询 */
		stmt.executeUpdate(sql);
		stmt.close();
		conn.close();
	}
}