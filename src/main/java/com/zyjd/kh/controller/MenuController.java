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
import com.zyjd.kh.model.Menu;
import com.zyjd.kh.service.MenuService;

/**
 * 菜单控制器
 * 处理菜单相关操作
 */
@Controller
@RequestMapping("/menu")
public class MenuController {

	@Autowired
	private MenuService menuService;

	@Autowired
	private HelperController helperController;

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "rbac/list/menuList";
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Menu menu) {
		// 设置地址
		menu.setStart((menu.getPage() - 1) * menu.getLimit());
		// 查询记录
		List<Menu> alls = menuService.findByCondition(menu);
		// 当页记录
		List<Menu> menus = menuService.findByConditionPage(menu);
		if (menus != null && !menus.isEmpty()) {
			return Layui.data(alls.size(), helperController.SyncParentChildren(menus));
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Menu menu) {
		List<Menu> alls = menuService.findByCondition(menu);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), helperController.SyncParentChildren(alls));
		}
		return Layui.data(0, null);
	}
	
	// 查询操作(获取指定名称菜单ID)
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public int Search(@RequestParam(value = "menuName", required = false) String menuName) {
		Menu menu = menuService.findByName(menuName);
		if(menu!=null){
			return menu.getId();
		}
		return -1;// 无效值
	}
	
	// 获取菜单
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Menu> GetList(@RequestBody Menu menu) {
		List<Menu> menus = menuService.findAll();
		if(menus!=null && !menus.isEmpty()) {
			return helperController.SyncParentChildren(menus);
		}
		return null;
	}

	// 添加操作
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Menu menu) {
		try {
			if (menuService.add(menu) > 0) {
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
			if (menuService.delete(id) > 0) {
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
	public String Update(@RequestBody Menu menu) {
		try {
			if (menuService.update(menu) > 0) {
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			return "0";// 失败
		}
	}
}
