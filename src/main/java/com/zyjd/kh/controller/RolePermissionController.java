package com.zyjd.kh.controller;

import com.zyjd.kh.model.Role;
import com.zyjd.kh.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.zyjd.kh.model.Permission;
import com.zyjd.kh.model.RolePermission;
import com.zyjd.kh.service.PermissionService;
import com.zyjd.kh.service.RolePermissionService;

import java.util.ArrayList;
import java.util.List;

/**
 * 角色权限控制器
 * 处理角色权限相关操作
 */
@Controller
@RequestMapping("/rolePermission")
public class RolePermissionController {

	@Autowired
	private RoleService roleService;
	
	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private RolePermissionService rolePermissionService;

	// 角色权限查询
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public List<Permission> Search(@RequestBody Role role) {
		return roleService.findByRolePermissions(role);
	}
	
	// 分配角色权限
	@RequestMapping(value = "/assign", method = RequestMethod.POST)
	@ResponseBody
	public String Assign(@RequestParam(value = "roleID", required = false) Integer roleID,
			@RequestParam(value = "permissionName", required = false) String permissionName) {
		try {
			Permission permission = permissionService.findByName(permissionName);// 所勾选权限节点
			List<Permission> rolePermissions = roleService.findByRolePermissions(new Role(roleID));// 当前角色所有权限
			if (permission != null) {
				boolean iscontain = false;// 状态标志
				// 遍历已有权限是否含有当前权限
				for(Permission rolePermission : rolePermissions){
					if(rolePermission.getId()==permission.getId()){
						iscontain = true;
						break;
					}
					continue;
				}
				// 角色无此权限，添加
				if(!iscontain){
					RolePermission temp = new RolePermission(roleID,permission.getId());
					RolePermission rolePermission = rolePermissionService.findById(temp);
					rolePermissionService.add(temp);
				}
			}
			return "1";
		} catch (Exception e) {
			return "0";
		}
	}

	// 删除角色权限
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "roleID", required = false) Integer roleID,
								   @RequestParam(value = "selecteds", required = false) String selecteds) {
		try {
			String selectedPermissionNames [] = selecteds.split(",");    // 实际已选中的权限名称
			List<Permission> selectedPermissions = new ArrayList<Permission>();// 实际已选中的权限节点
			List<Permission> rolePermissions = roleService.findByRolePermissions(new Role(roleID));// 当前角色所有权限
			boolean iscontain = false;
			for (Permission permission : rolePermissions) {
				for(String p : selectedPermissionNames){
                     if(permission.getPermissionName().equals(p)) {
						 selectedPermissions.add(permission);
						 break;// 找到后，跳出内层循环
					 }
                     continue;
				}
			}
			// 移除实际已选项
			rolePermissions.removeAll(selectedPermissions);
			// 角色无此权限，删除
			for(Permission permission : rolePermissions){
				RolePermission temp = new RolePermission(roleID, permission.getId());
				RolePermission rolePermission = rolePermissionService.findById(temp);
				rolePermissionService.delete(temp);
			}
			return "1";
		} catch (Exception e) {
			return "0";
		}
	}
}
