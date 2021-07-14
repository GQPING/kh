package com.zyjd.kh.model;

/**
 * 权限数据模型
 */
public class Permission extends Base{

	private Integer id;// 主键，编号
	
	private Integer menuID;// 外键，菜单ID

	private Integer operateID;// 外键，操作ID

	private String permissionName;// 权限名称

	private String permissionHref;// 权限链接

	private String remarkDescription;// 权限备注

	private Menu menu = new Menu();                // 一个权限 ：一个菜单
	
	private Operation operation = new Operation(); // 一个权限 ：一个操作

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getMenuID() {
		return menuID;
	}

	public void setMenuID(Integer menuID) {
		this.menuID = menuID;
	}

	public Integer getOperateID() {
		return operateID;
	}

	public void setOperateID(Integer operateID) {
		this.operateID = operateID;
	}

	public String getPermissionName() {
		return permissionName;
	}

	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public Operation getOperation() {
		return operation;
	}

	public void setOperation(Operation operation) {
		this.operation = operation;
	}

	public String getRemarkDescription() {
		return remarkDescription;
	}

	public void setRemarkDescription(String remarkDescription) {
		this.remarkDescription = remarkDescription;
	}

	public String getPermissionHref() { return permissionHref; }

	public void setPermissionHref(String permissionHref) { this.permissionHref = permissionHref; }

	@Override
	public String toString() {
		return "Permission{" +
				"id=" + id +
				", menuID=" + menuID +
				", operateID=" + operateID +
				", permissionName='" + permissionName + '\'' +
				", permissionHref='" + permissionHref + '\'' +
				", remarkDescription='" + remarkDescription + '\'' +
				", menu=" + menu +
				", operation=" + operation +
				'}';
	}
}