package com.zyjd.kh.model;

/**
 * 角色权限数据模型
 * 角色:权限 多对多,中间表
 */
public class RolePermission extends Base{

	private Integer roleID;// 角色ID

	private Integer permissionID;// 权限ID
	
	private Role role = new Role();// 关联角色
	
	private Permission permission = new Permission();// 关联权限

	public RolePermission() {
		super();
	}

	public RolePermission(Integer roleID, Integer permissionID) {
		super();
		this.roleID = roleID;
		this.permissionID = permissionID;
	}

	public Integer getRoleID() {
		return roleID;
	}

	public void setRoleID(Integer roleID) {
		this.roleID = roleID;
	}

	public Integer getPermissionID() {
		return permissionID;
	}

	public void setPermissionID(Integer permissionID) {
		this.permissionID = permissionID;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Permission getPermission() {
		return permission;
	}

	public void setPermission(Permission permission) {
		this.permission = permission;
	}

	@Override
	public String toString() {
		return "RolePermission [roleID=" + roleID + ", permissionID=" + permissionID + ", role=" + role
				+ ", permission=" + permission + "]";
	}
}