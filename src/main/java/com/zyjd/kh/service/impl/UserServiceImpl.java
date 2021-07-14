package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.UserDao;
import com.zyjd.kh.model.User;
import com.zyjd.kh.service.UserService;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserDao userDao;

	@Override
	public int add(User user) {
		return userDao.add(user);
	}
	
	@Override
	public int delete(int id) {
		return userDao.delete(id);
	}

	@Override
	public int update(User user) {
		return userDao.update(user);
	}
	
	@Override
	public User findById(int id) {
		return userDao.findById(id);
	}

	@Override
	public List<User> findAll() {
		return userDao.findAll();
	}
	
	@Override
	public List<User> findByCondition(User user) {
		return userDao.findByCondition(user);
	}

	@Override
	public List<User> findByConditions(User obj) { return userDao.findByConditions(obj); }

	@Override
	public List<User> findByConditionPage(User user) {
		return userDao.findByConditionPage(user);
	}

	@Override
	public Integer findCountByCondition(User user) { return userDao.findCountByCondition(user); }

	@Override
	public User findByName(String nickName) {
		User user = new User();
		user.setNickName(nickName);
		List<User> users = userDao.findByConditions(user);
		if(users!=null && !users.isEmpty() && users.size()==1){
			return users.get(0);
		}
		return  null;
	}
}
