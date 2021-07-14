package com.zyjd.kh.dao;

import java.util.List;

import com.zyjd.kh.model.Permission;
import com.zyjd.kh.model.Role;

/**
 * 角色数据接口
 */
public interface RoleDao extends Base<Role> {
	List<Permission> findByRolePermissions(Role role);// 查询角色附属权限
}
