/**
 * 
 */
/**
 * @author 10329
 *
 */
package com.Guo.database;

import java.sql.Connection;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

public class DataSource {
	private static String url = "jdbc:mysql://localhost:3306/logreg";
	private static String user = "root";
	private static String password = "750808";

	/**
	 * 打开数据库兵返回连接
	 */
	public static Connection getConnection() {
		try {
			// 创建Mysql数据源对象
			MysqlDataSource dataSource = new MysqlDataSource();
			dataSource.setUrl(url);
			dataSource.setUser(user);
			dataSource.setPassword(password);
			// 打开并返回连接
			return dataSource.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
			/* 在命令行打印异常信息在程序中出错的位置及原因 */
		}
		return null;
	}
}