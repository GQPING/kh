package com.zyjd.kh.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.kh.util.Layui;
import com.zyjd.kh.model.Permission;
import com.zyjd.kh.model.Role;
import com.zyjd.kh.service.RoleService;

/**
 * 角色控制器
 * 处理角色相关操作
 */
@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	private RoleService roleService;

	@Autowired
	private HelperController helperController;
	
	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "rbac/list/roleList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Role role) {
		// 设置地址
		role.setStart((role.getPage()-1)*role.getLimit());
		// 查询记录
		List<Role> alls = roleService.findByCondition(role);
		// 当页记录
		List<Role> roles = roleService.findByConditionPage(role);
		if (roles != null && !roles.isEmpty()) {
			// 权限获取
			for(Role r : roles) {
				r.setPermissions(roleService.findByRolePermissions(r));
			}
			return Layui.data(alls.size(), roles);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Role role) {
		List<Role> alls = roleService.findByCondition(role);
		if (alls != null && !alls.isEmpty()) {
			// 权限获取
			for(Role r : alls) {
				r.setPermissions(roleService.findByRolePermissions(r));
			}
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}
	
	// 查询操作(获取指定名称的角色ID)
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public int Search(@RequestParam(value="roleName",required=false) String roleName) {
		Role role = roleService.findByName(roleName);
		if(role!=null){
			return role.getId();
		}
		return -1;// 无效值
	}	
	
	// 获取列表
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Role> GetList(@RequestBody Role role) {
		return roleService.findByConditions(role);
	}

	// 添加操作
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Role role) {
		try {
			if (roleService.add(role) > 0) {
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			return "0";// 失败
		}
	}
	
	// 删除操作
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		try {
			if (roleService.delete(id) > 0) {
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			return "0";// 失败
		}
	}
	
	// 修改操作
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Role role) {
		try {
			if (roleService.update(role) > 0) {
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			return "0";// 失败
		}
	}
}
