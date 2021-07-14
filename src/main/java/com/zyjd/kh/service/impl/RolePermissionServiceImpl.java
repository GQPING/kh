package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.RolePermissionDao;
import com.zyjd.kh.model.RolePermission;
import com.zyjd.kh.service.RolePermissionService;

@Service
@Transactional
public class RolePermissionServiceImpl implements RolePermissionService {

	@Resource
	private RolePermissionDao rolePermissionDao;

	@Override
	public int add(RolePermission rolePermission) {
		return rolePermissionDao.add(rolePermission);
	}

	@Override
	public int delete(RolePermission rolePermission) {
		return rolePermissionDao.delete(rolePermission);
	}

	@Override
	public RolePermission findById(RolePermission rolePermission) {
		return rolePermissionDao.findById(rolePermission);
	}

	@Override
	public List<RolePermission> findAll() {
		return rolePermissionDao.findAll();
	}

	@Override
	public List<RolePermission> findByCondition(RolePermission rolePermission) { return rolePermissionDao.findByCondition(rolePermission); }

	@Override
	public List<RolePermission> findByConditions(RolePermission obj) { return rolePermissionDao.findByConditions(obj); }

	@Override
	public int update(RolePermission obj) {
		return rolePermissionDao.update(obj);
	}

	@Override
	public int delete(int id) {
		return rolePermissionDao.delete(id);
	}

	@Override
	public RolePermission findById(int id) {
		return rolePermissionDao.findById(id);
	}

	@Override
	public List<RolePermission> findByConditionPage(RolePermission obj) { return rolePermissionDao.findByConditionPage(obj); }
}
