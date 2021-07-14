package com.zyjd.kh.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.zyjd.kh.model.*;
import com.zyjd.kh.util.FlowloadUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.kh.util.Layui;
import com.zyjd.kh.service.CashingService;
import com.zyjd.kh.service.ProjectService;
import com.zyjd.kh.service.CustomerService;
import com.zyjd.kh.service.UserService;
import com.zyjd.kh.util.TreeVo;
import com.zyjd.kh.vo.TotalBean;

/**
 * 全局控制器
 * 处理全局相关操作
 */
@Controller
public class MyController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CashingService cashingService;
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private HelperController helperController;

	// 主页界面
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String Main(Model model, HttpSession session) {
		User currentUser = (User) session.getAttribute("CurrentUser");//判断是否存在登录会话
		if (currentUser == null) {
			return "redirect:user/login";// 未登录，重新登录
		} else {
			// 弹窗判断
			for(Permission permission : currentUser.getPermissions()) {
				switch (permission.getMenu().getMenuName()) {
					case "项目提醒弹窗":
						// 检测车辆是否到期，设置对应标志到模型中
						List<Project> list = helperController.GetProjectToDate();
						if (list != null && !list.isEmpty()) {
							model.addAttribute("data", 1);
						}else{
							model.addAttribute("data", 0);
						}
					break;
				}
			}
			return "main";
		}
	}

	// 项目回款到期弹窗
	@RequestMapping(value = "/remind", method = RequestMethod.GET)
	public String Remind() {
		return "contract/other/remind";
	}

	// 项目回款到期查询(获取到期数据列表)
	@RequestMapping(value = "/remindList", method = RequestMethod.POST)
	@ResponseBody
	public Layui RemindList(@RequestBody Project project) {
		List<Project> projectList = helperController.GetProjectToDate();//获取到期数据
		if (projectList!=null && !projectList.isEmpty()) {
			List<Project> temps = new ArrayList<Project>();
			// 筛选记录
			if(project.getCustomerID()!=null && project.getId()!=null){
				temps.addAll(projectList.stream().filter(s -> s.getCustomer().getId() == project.getCustomerID()
						&& s.getId() == project.getId()).collect(Collectors.toList()));
			}else if(project.getCustomerID()!=null && project.getId()==null){
				temps.addAll(projectList.stream().filter(s -> s.getCustomer().getId() == project.getCustomerID()).collect(Collectors.toList()));
			}else if(project.getCustomerID()==null && project.getId()!=null){
				temps.addAll(projectList.stream().filter(s -> s.getId() == project.getId()).collect(Collectors.toList()));
			}else{
				temps.addAll(projectList);
			}
			// 非空集合
			if (!temps.isEmpty()) {
				return Layui.data(temps.size(), temps);
			}
		}
		return Layui.data(0, null);
	}

	// 欢迎界面
	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String Welcome(Model model) {
		Totals total;// 汇总对象
		Project project = new Project();
		TotalBean bean = new TotalBean();
		// 设置合计查询
		total = projectService.findTotalByCondition(project);
		if (total != null) {
			// 项目
			bean.setTotalProjects(total.getProjects()==null?0:total.getProjects());
			// 预算
			bean.setTotalBudgets(total.getBudgets()==null?0.0:total.getBudgets());
			// 成本
			bean.setTotalCosts(total.getCosts()==null?0.0:total.getCosts());
			// 收入
			bean.setTotalIncomes(total.getIncomes()==null?0.0:total.getIncomes());
			// 回款
			bean.setTotalInQuotas(total.getInQuotas()==null?0.0:total.getInQuotas());
			// 余款
			bean.setTotalUnQuotas(total.getUnQuotas()==null?0.0:total.getUnQuotas());
		}
		// 设置今日查询
		project.setIsToday(1);
		total = projectService.findTotalByCondition(project);
		if (total != null) {
			// 项目
			bean.setTodayProjects(total.getProjects()==null?0:total.getProjects());
			// 预算
			bean.setTodayBudgets(total.getBudgets()==null?0.0:total.getBudgets());
			// 成本
			bean.setTodayCosts(total.getCosts()==null?0.0:total.getCosts());
			// 收入
			bean.setTodayIncomes(total.getIncomes()==null?0.0:total.getIncomes());
			// 回款
			bean.setTodayInQuotas(total.getInQuotas()==null?0.0:total.getInQuotas());
			// 余款
			bean.setTodayUnQuotas(total.getUnQuotas()==null?0.0:total.getUnQuotas());
		}
		// 临时变量
		Integer totals = 0 , todays = 0;
		// 合计客户
		Customer customer = new Customer();
		totals = customerService.findCountByCondition(customer);
		if (totals != null) {
			bean.setTotalCustomers(totals);
		}
		// 今日客户
		customer.setIsToday(1);
		todays = customerService.findCountByCondition(customer);
		if (todays != null) {
			bean.setTodayCustomers(todays);
		}
		// 合计用户
		User user = new User();
		totals = userService.findCountByCondition(user);
		if (totals != null) {
			bean.setTotalUsers(totals);
		}
		// 今日用户
		user.setIsToday(1);
		todays = userService.findCountByCondition(user);
		if (todays != null) {
			bean.setTodayUsers(todays);
		}
		model.addAttribute("bean", bean);
		return "other/welcome";
	}

	// 退出系统
	@RequestMapping(value = "/exit", method = RequestMethod.GET)
	public String Exit(HttpSession session) {
		User user = (User)session.getAttribute("CurrentUser");
		if(user!=null) {
			// 日志
			helperController.AddLog("退出","退出系统");
		}
		// 设置session失效
		session.invalidate();
		return "redirect:index.jsp";
		//return "redirect:user/login";
	}

	// 关闭标签(废弃)
	@RequestMapping(value = "/close", method = RequestMethod.GET)
	public void Close(HttpSession session) {
		User user = (User)session.getAttribute("CurrentUser");
		if(user!=null) {
			// 日志
			helperController.AddLog("退出","退出系统");
		}
		// 设置session失效
		session.invalidate();
	}
}
