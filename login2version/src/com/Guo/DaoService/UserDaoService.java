/**
 * 
 */
/**
 * @author 10329
 *
 */
package com.Guo.DaoService;

/*Dao接口中定义数据操作*/
import com.Guo.User.User;

public interface UserDaoService {
	/**
	 * 根据用户的昵称和密码查询用户
	 * 
	 * @param userName
	 * @param userPassword
	 * @return
	 * @throws Exception
	 */
	public User check(String userName, String userPassword) throws Exception;
}