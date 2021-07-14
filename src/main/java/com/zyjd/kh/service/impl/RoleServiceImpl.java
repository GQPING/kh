package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.RoleDao;
import com.zyjd.kh.model.Permission;
import com.zyjd.kh.model.Role;
import com.zyjd.kh.service.RoleService;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {

	@Resource
	private RoleDao roleDao;

	@Override
	public int add(Role role) {
		return roleDao.add(role);
	}

	@Override
	public int delete(int id) {
		return roleDao.delete(id);
	}

	@Override
	public int update(Role role) {
		return roleDao.update(role);
	}

	@Override
	public Role findById(int id) {
		return roleDao.findById(id);
	}

	@Override
	public List<Role> findAll() {
		return roleDao.findAll();
	}

	@Override
	public List<Role> findByCondition(Role role) {
		return roleDao.findByCondition(role);
	}

	@Override
	public List<Role> findByConditions(Role obj) { return roleDao.findByConditions(obj); }

	@Override
	public List<Role> findByConditionPage(Role role) {
		return roleDao.findByConditionPage(role);
	}

	@Override
	public List<Permission> findByRolePermissions(Role role) {
		return roleDao.findByRolePermissions(role);
	}

	@Override
	public Role findByName(String roleName) {
		Role role = new Role();
		role.setRoleName(roleName);
		List<Role> roles = roleDao.findByConditions(role);
		if(roles!=null && !roles.isEmpty() && roles.size()==1){
			return roles.get(0);
		}
		return  null;
	}
}
