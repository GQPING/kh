package com.zyjd.kh.service;

import com.zyjd.kh.dao.UserDao;
import com.zyjd.kh.model.User;

public interface UserService extends UserDao{
	User findByName(String nickName);
}
