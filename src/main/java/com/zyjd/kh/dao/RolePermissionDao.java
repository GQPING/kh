package com.zyjd.kh.dao;

import com.zyjd.kh.model.RolePermission;

/**
 * 角色权限数据接口
 */
public interface RolePermissionDao extends Base<RolePermission>{
	int delete(RolePermission rolePermission);// 删除
	RolePermission findById(RolePermission rolePermission);// 查找指定角色权限
}
