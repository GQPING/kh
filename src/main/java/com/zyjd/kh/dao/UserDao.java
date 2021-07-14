package com.zyjd.kh.dao;

import com.zyjd.kh.model.User;

/**
 * 用户数据接口
 */
public interface UserDao extends Base<User>{
	Integer findCountByCondition(User user);// 条件数量查询
}
