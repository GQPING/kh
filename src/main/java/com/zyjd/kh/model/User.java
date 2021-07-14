package com.zyjd.kh.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 用户数据模型
 */
public class User extends Base{
	
	private Integer id;// 主键，编号
	
	private Integer roleID;// 外键，角色编号
	
    private String nickName;// 登录账户

    private String password;// 登录密码

	private String userName;// 用户名称
    
    private Date createDate;// 创建日期
    
    private String remarkDescription;// 备注信息
    
    private Role role = new Role();// 关联角色
    
    private List<Permission> permissions = new ArrayList<Permission>();// 一个角色:多个权限

    public User() {
		super();
	}
    
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRoleID() {
		return roleID;
	}

	public void setRoleID(Integer roleID) {
		this.roleID = roleID;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getRemarkDescription() {
		return remarkDescription;
	}

	public void setRemarkDescription(String remarkDescription) {
		this.remarkDescription = remarkDescription;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public List<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}

	public String getUserName() { return userName; }

	public void setUserName(String userName) { this.userName = userName; }

	@Override
	public String toString() {
		return "User{" +
				"id=" + id +
				", roleID=" + roleID +
				", nickName='" + nickName + '\'' +
				", password='" + password + '\'' +
				", userName='" + userName + '\'' +
				", createDate=" + createDate +
				", remarkDescription='" + remarkDescription + '\'' +
				", role=" + role +
				", permissions=" + permissions +
				'}';
	}
}