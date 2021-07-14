package com.zyjd.kh.model;

import java.util.ArrayList;
import java.util.List;

/**
 * 角色数据模型
 */
public class Role extends Base{
	
	private Integer id;// 主键，编号
	
    private String roleName;// 角色名称

	private String remarkDescription;// 角色备注

    private List<Permission> permissions = new ArrayList<Permission>();// 一个角色:多个权限

	public Role() { super(); }

	public Role(Integer id) { super(); this.id = id; }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public List<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}

	public String getRemarkDescription() {
		return remarkDescription;
	}

	public void setRemarkDescription(String remarkDescription) {
		this.remarkDescription = remarkDescription;
	}

	@Override
	public String toString() {
		return "Role{" +
				"id=" + id +
				", roleName='" + roleName + '\'' +
				", remarkDescription='" + remarkDescription + '\'' +
				", permissions=" + permissions +
				'}';
	}
}