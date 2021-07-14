package com.zyjd.kh.controller;

import java.util.List;
import com.zyjd.kh.model.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.kh.util.Layui;
import com.zyjd.kh.model.Permission;
import com.zyjd.kh.service.PermissionService;

/**
 * 权限控制器
 * 处理权限相关操作
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {

	@Autowired
	private HelperController helperController;

	@Autowired
	private PermissionService permissionService;

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "rbac/list/permissionList";
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Permission permission) {
		// 设置地址
		permission.setStart((permission.getPage() - 1) * permission.getLimit());
		// 查询记录
		List<Permission> alls = permissionService.findByCondition(permission);
		// 当页记录
		List<Permission> permissions = permissionService.findByConditionPage(permission);
		if (permissions != null && !permissions.isEmpty()) {
			return Layui.data(alls.size(), permissions);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Permission permission) {
		List<Permission> alls = permissionService.findByCondition(permission);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}
	
	// 获取列表
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Permission> GetList(@RequestBody Permission permission) {
		return permissionService.findByConditions(permission);
	}

	// 获取权限树(配置角色权限时)
	@RequestMapping(value = "/getTree", method = RequestMethod.POST)
	@ResponseBody
	public Object GetTree(@RequestBody Role role){
		return helperController.GetPermissionTree(role);// 获取权限树结构
	}
	
	// 添加操作
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Permission permission) {
		try {
			if (permissionService.add(permission) > 0) {
				return "1";
			} else {
				return "0";
			}
		} catch (Exception e) {
			return "0";
		}
	}

	// 删除操作
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		try {
			if (permissionService.delete(id) > 0) {
				return "1";
			} else {
				return "0";
			}
		} catch (Exception e) {
			return "0";
		}
	}

	// 修改操作
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Permission permission) {
		try {
			if (permissionService.update(permission) > 0) {
				return "1";
			} else {
				return "0";
			}
		} catch (Exception e) {
			return "0";
		}
	}
}
