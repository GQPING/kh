package com.zyjd.kh.controller;

import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.zyjd.kh.model.Contact;
import com.zyjd.kh.model.Role;
import com.zyjd.kh.util.DigitUtils;
import com.zyjd.kh.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.kh.util.Layui;
import com.zyjd.kh.model.User;
import com.zyjd.kh.service.RoleService;
import com.zyjd.kh.service.UserService;

/**
 * 用户控制器
 * 处理用户相关操作
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;

	@Autowired
	private HelperController helperController;
	
	// 登录界面
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String Login(HttpServletRequest request) {
		if("".equals(helperController.IPAddress)){
			helperController.SetRemoteIP(request);// 记录IP
		}
		return "login/login";
	}
	
	// 用户登录
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody 
	public String Login(@RequestBody User user,HttpSession session) {
		User currentUser;
		try {
			currentUser = userService.findByName(user.getNickName());//找到指定用户
			if(currentUser == null) {
				return "2";// 账户错误
			}else {
				if (currentUser.getPassword().equals(user.getPassword())) {
					// 获取权限
					currentUser.setPermissions(roleService.findByRolePermissions(currentUser.getRole()));
					session.setAttribute("CurrentUser", currentUser);// 保存会话信息
					// 静态保存UserID
					helperController.SetUserID(currentUser.getId());
					// 日志
					helperController.AddLog("登录","登录了系统");
					return "1";// 登录成功
				} else {
					return "3";// 密码错误
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "0";// 服务器异常
		}
	}
	
	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "user/list/userList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody User user) {
		// 设置地址
		user.setStart((user.getPage()-1)*user.getLimit());
		// 查询记录
		List<User> alls = userService.findByCondition(user);
		// 当页记录
		List<User> users = userService.findByConditionPage(user);
		if (users != null && !users.isEmpty()) {
			// 不显示超级管理员
			//int count = users.size();
            //users.removeAll(users.stream().filter(x -> "超级管理员".equals(x.getRole().getRoleName())).collect(Collectors.toList()));
			//return Layui.data(alls.size()-(count-users.size()), users);
			return Layui.data(alls.size(), users);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody User user) {
		List<User> alls = userService.findByCondition(user);
		if (alls != null && !alls.isEmpty()) {
			// 不显示超级管理员
			//int count = alls.size();
			//alls.removeAll(alls.stream().filter(x -> "超级管理员".equals(x.getRole().getRoleName())).collect(Collectors.toList()));
			//return Layui.data(alls.size()-(count-alls.size()), alls);
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 获取列表
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody // 不可缺少
	public List<User> GetList(@RequestBody User user) {
		return userService.findByConditions(user);
	}
	
	// 添加操作
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody User user) {
		try {
			if (userService.add(user) > 0) {
				helperController.AddLog("创建","添加了新用户["+user.getNickName()+"]");
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
		User origin = userService.findById(id);
		try {
			if (userService.delete(id) > 0) {
				helperController.AddLog("删除","删除了用户["+origin.getNickName()+"]");
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
	public String Update(@RequestBody User user) {
		User origin = userService.findById(user.getId());
		try {
			if (userService.update(user) > 0) {
				helperController.AddLog("修改","用户["+origin.getUserName()+"]信息变更如下："+GetUpdateString(origin,user));
				return "1";// 修改成功
			} else {
				return "0";// 修改失败
			}
		} catch (Exception e) {
			return "0";// 服务器异常
		}
	}

	// 密码弹窗
	@RequestMapping(value = "/password", method = RequestMethod.GET)
	public String Password() {
		return "user/edit/editPassword";
	}

	// 修改密码
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	@ResponseBody
	public String UpdatePassword(@RequestBody User user,HttpSession session) {
		User origin = userService.findById(user.getId());
		try {
			if (userService.update(user) > 0) {
				// 设置session失效
				session.invalidate();
				// 日志
				helperController.AddLog("修改","用户"+origin.getUserName()+"信息变更如下："+GetUpdateString(origin,user));
				return "1";// 修改成功
			} else {
				return "0";// 修改失败
			}
		} catch (Exception e) {
			return "0";// 服务器异常
		}
	}

	// 拼接日志
	private String GetUpdateString(User origin, User update){
		StringBuilder builder = new StringBuilder();
		// 用户角色
		if(DigitUtils.ComparerInteger(origin.getRoleID(),update.getRoleID())) {
			Role role1 = roleService.findById(origin.getRoleID());
			Role role2 = roleService.findById(update.getRoleID());
			builder.append("["+role1.getRoleName()+"角色变更为"+role2.getRoleName()+"]");
		}
		// 登录账户
		if(StringUtils.ComparerString(origin.getNickName(),update.getNickName())) {
			builder.append("["+origin.getNickName()+"昵称变更为"+update.getNickName()+"]");
		}
		// 登录密码
		if(StringUtils.ComparerString(origin.getPassword(),update.getPassword())) {
			builder.append("["+origin.getPassword()+"密码变更为"+update.getPassword()+"]");
		}
		// 用户名称
		if(StringUtils.ComparerString(origin.getUserName(),update.getUserName())) {
			builder.append("["+origin.getUserName()+"姓名变更为"+update.getUserName()+"]");
		}
		// 备注信息
		if(StringUtils.ComparerString(origin.getRemarkDescription(),update.getRemarkDescription())) {
			builder.append("["+origin.getRemarkDescription()+"备注变更为"+update.getRemarkDescription()+"]");
		}
		return builder.toString();
	}
}
