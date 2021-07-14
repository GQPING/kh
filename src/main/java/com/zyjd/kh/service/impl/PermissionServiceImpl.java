package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.PermissionDao;
import com.zyjd.kh.model.Permission;
import com.zyjd.kh.service.PermissionService;

@Service
@Transactional
public class PermissionServiceImpl implements PermissionService {

    @Resource
	private PermissionDao permissionDao;
	
	@Override
	public int add(Permission permission) {
		return permissionDao.add(permission);
	}

	@Override
	public int delete(int id) {
		return permissionDao.delete(id);
	}
	
	@Override
	public int update(Permission permission) {
		return permissionDao.update(permission);
	}

	@Override
	public Permission findById(int id) {
		return permissionDao.findById(id);
	}
	
	@Override
	public List<Permission> findAll() {
		return permissionDao.findAll();
	}

	@Override
	public List<Permission> findByCondition(Permission permission) {
		return permissionDao.findByCondition(permission);
	}

	@Override
	public List<Permission> findByConditions(Permission obj) { return permissionDao.findByConditions(obj); }

	@Override
	public List<Permission> findByConditionPage(Permission permission) {
		return permissionDao.findByConditionPage(permission);
	}

	@Override
	public Permission findByName(String permissionName) {
		Permission permission = new Permission();
		permission.setPermissionName(permissionName);
		List<Permission> permissions = permissionDao.findByConditions(permission);
		if(permissions!=null && !permissions.isEmpty() && permissions.size()==1){
			return permissions.get(0);
		}
		return  null;
	}
}
