package com.zyjd.kh.controller;

import java.util.Date;
import java.util.List;
import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import com.zyjd.kh.model.Contact;
import com.zyjd.kh.model.Customer;
import com.zyjd.kh.service.ContactService;
import com.zyjd.kh.service.CustomerService;
import com.zyjd.kh.util.*;
import com.zyjd.kh.vo.SalesBean;
import com.zyjd.kh.vo.UnitsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.kh.model.Project;
import com.zyjd.kh.service.ProjectService;

/**
 * 项目控制器
 * 处理项目相关操作
 */
@Controller
@RequestMapping("/project")
public class ProjectController {

	@Autowired
	private ContactService contactService;

	@Autowired
	private ProjectService projectService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private HelperController helperController;

	// 档案界面
	@RequestMapping(value = "/record", method = RequestMethod.GET)
	public String Record() {
		// 同步状态刷新
		helperController.SyncProjectState();
		return "contract/list/projectRecord";
	}

	// 获取档案(实现流加载数据，参数为检索条件)
	@RequestMapping(value = "/getRecord", method = RequestMethod.POST)
	@ResponseBody
	public Object GetRecord(@RequestParam(value = "page") Integer page,
							@RequestParam(value = "timeStart") String timeStart,
							@RequestParam(value = "timeFinal") String timeFinal,
							@RequestParam(value = "searchString") String searchString) {
		Project project = new Project();
		project.setPage(page);
		project.setSearchString(searchString==""?null:searchString);
		project.setTimeStart(timeStart==""?null:DateUtil.parse(timeStart));
		project.setTimeFinal(timeFinal==""?null:DateUtil.parse(timeFinal));
		// 设置地址
		project.setStart((project.getPage() - 1) * project.getLimit());
		// 总记录
		List<Project> alls = projectService.findByCondition(project);
		// 总页数
		int pages =  alls.size() / project.getLimit();
		if(alls.size() % project.getLimit() != 0){
			pages++;//不足一页，也算一页
		}
		// 当页记录
		List<Project> projects = projectService.findByConditionPage(project);
		if(projects != null && !projects.isEmpty()) {
			return FlowloadUtils.buildResult(pages, projects);
		}
		return Layui.data(0, null);
	}

	// 列表管理界面（管理项目的添加/修改/删除）
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String Admin() {
		// 同步状态刷新
		helperController.SyncProjectState();
		return "contract/list/projectAdmin";
	}

	// 列表管理(分页)
	@RequestMapping(value = "/searchAdmin", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAdmin(@RequestBody Project project) {
		// 设置地址
		project.setStart((project.getPage()-1)*project.getLimit());
		// 查询记录
		List<Project> alls = projectService.findByCondition(project);
		// 当页记录
		List<Project> projects = projectService.findByConditionPage(project);
		if (projects != null && !projects.isEmpty()) {
			return Layui.data(alls.size(), projects);
		}
		return Layui.data(0, null);
	}
	
	// 列表界面(只管理项目的收款开票)
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		// 同步状态刷新
		helperController.SyncProjectState();
		return "contract/list/projectList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Project project) {
		// 设置地址
		project.setStart((project.getPage()-1)*project.getLimit());
		// 查询记录
		List<Project> alls = projectService.findByCondition(project);
		// 当页记录
		List<Project> projects = projectService.findByConditionPage(project);
		if (projects != null && !projects.isEmpty()) { 
			return Layui.data(alls.size(), projects);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchALL(@RequestBody Project project) {
		List<Project> alls = projectService.findByCondition(project);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 查询操作(获取指定条件的项目)
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public Project Search(@RequestBody Project project) {
		List<Project> projects = projectService.findByConditions(project);
		if(projects!=null && !projects.isEmpty()){
			return projects.get(0);
		}
		return null;
	}
	
	// 获取列表
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Project> GetList(@RequestBody Project project) {
		return projectService.findByConditions(project);
	}
	
	// 添加操作(后两个参数是默认创建初始项目联系人信息)
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Project project,
					  @RequestParam(value = "contactName", required = false, defaultValue = "") String contactName,
					  @RequestParam(value = "contactPhone", required = false, defaultValue = "") String contactPhone) {
		try {
			if (projectService.add(project) > 0) {
				Customer customer = customerService.findById(project.getCustomerID());
				helperController.AddLog("创建",customer.getCustomerName()+"下添加了新项目["+project.getProjectName()+"]");
				// 添加项目联系人
				contactService.add(new Contact(project.getId(),contactName,contactPhone,new Date()));
				helperController.AddLog("创建",project.getProjectName()+"中添加了联系人["+contactName+"]");
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "0";// 失败
		}
	}

	// 修改操作(后两个参数是默认修改初始项目联系人信息)
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Project project,
						 @RequestParam(value = "contactName", required = false, defaultValue = "") String contactName,
						 @RequestParam(value = "contactPhone", required = false, defaultValue = "") String contactPhone) {
		Project origin = projectService.findById(project.getId());
		try {
			if (projectService.update(project) > 0) {
				helperController.AddLog("修改","["+origin.getProjectName()+"]信息变更如下："+GetUpdateString(origin,project));
				List<Contact> contacts = contactService.findByConditions(new Contact(project.getId(),contactName));
				if(contacts!=null && !contacts.isEmpty()) {
					Contact contact = contacts.get(0);
					if(!contactPhone.equals(contact.getContactPhone())){// 电话不相等时进行更新
						contact.setContactPhone(contactPhone);
						helperController.AddLog("修改",project.getProjectName()+"中联系人["+contactName+"]电话变更为："+contactPhone);
						contactService.update(contact);
					}
				}else {
					// 添加项目联系人
					contactService.add(new Contact(project.getId(),contactName,contactPhone,new Date()));
					helperController.AddLog("创建",project.getProjectName()+"中添加了联系人["+contactName+"]");
				}
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "0";// 失败
		}
	}

	// 删除操作
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		// 原始
		Project origin = projectService.findById(id);
		// 执行
		try {
			if (projectService.delete(id) > 0) {
				helperController.AddLog("删除",origin.getCustomer().getCustomerName()+"下删除了项目["+origin.getProjectName()+"]");
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "0";// 失败
		}
	}

	// 刷新操作
	@RequestMapping(value = "/flush", method = RequestMethod.POST)
	@ResponseBody
	public String Flush(@RequestBody Project project) {
		Project origin = projectService.findById(project.getId());
		try {
			if (projectService.update(project) > 0) {
				helperController.AddLog("修改","["+origin.getProjectName()+"]信息变更如下："+GetUpdateString(origin,project));
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "0";// 失败
		}
	}

	// 项目数量明细，项目数、到期数、未到期数、到期已结清数、到期未结清数汇总(柱状图-12月)
	@RequestMapping(value = "/summary0", method = RequestMethod.GET)
	public String Summary0() {
		return "contract/other/summary0";
	}

	// 项目数量明细，项目数、到期数、未到期数、到期已结清数、到期未结清数汇总(柱状图-12月)
	@RequestMapping(value = "/searchSummary0", method = RequestMethod.POST)
	@ResponseBody
	public List<UnitsBean> SearchSummary0(@RequestParam(value = "time") String time) {
		int year = DateUtil.year(new Date());// 取得当年年份
		if(!"".equals(time)){
			try {
				year = Integer.parseInt(time);// 字符串转化成年份条件
			}catch(Exception e){
				year = DateUtil.year(new Date());// 发生异常时，默认当年
			}
		}
		return helperController.GetSummary0(year);
	}

	// 项目收支明细，预算、成本、收入汇总(柱状图-12月)
	@RequestMapping(value = "/summary1", method = RequestMethod.GET)
	public String Summary1() {
		return "contract/other/summary1";
	}

	// 项目收支明细，预算、成本、收入汇总(柱状图-12月)
	@RequestMapping(value = "/searchSummary1", method = RequestMethod.POST)
	@ResponseBody
	public List<SalesBean> SearchSummary1(@RequestParam(value = "time") String time) {
		int year = DateUtil.year(new Date());// 取得当年年份
		if(!"".equals(time)){
			try {
				year = Integer.parseInt(time);// 字符串转化成年份条件
			}catch(Exception e){
				year = DateUtil.year(new Date());// 发生异常时，默认当年
			}
		}
		return helperController.GetSummary1(year);
	}

	// 项目回款明细，预算、回款、余款汇总(柱状图-12月)
	@RequestMapping(value = "/summary2", method = RequestMethod.GET)
	public String Summary2() {
		return "contract/other/summary2";
	}

	// 项目回款明细，预算、回款、余款汇总(柱状图-12月)
	@RequestMapping(value = "/searchSummary2", method = RequestMethod.POST)
	@ResponseBody
	public List<SalesBean> SearchSummary2(@RequestParam(value = "time") String time) {
		int year = DateUtil.year(new Date());// 取得当年年份
		if(!"".equals(time)){
			try {
				year = Integer.parseInt(time);// 字符串转化成年份条件
			}catch(Exception e){
				year = DateUtil.year(new Date());// 发生异常时，默认当年
			}
		}
		return helperController.GetSummary2(year);
	}

	// 客户交易明细，预算、回款、余款、滞纳、到期已收、到期未收(饼状图-按年，按月)
	@RequestMapping(value = "/summary3", method = RequestMethod.GET)
	public String Summary3() {
		return "contract/other/summary3";
	}

	// 客户交易明细，预算、回款、余款、滞纳、到期已收、到期未收(饼状图-按年，按月)
	@RequestMapping(value = "/searchSummary3", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchSummary3(@RequestParam(value = "id") Integer id,@RequestParam(value = "time") String time) {
		int year = DateUtil.year(new Date());// 取得当年年份
		if(!"".equals(time)){
			try {
				year = Integer.parseInt(time);// 字符串转化成年份条件
			}catch(Exception e){
				year = DateUtil.year(new Date());// 发生异常时，默认当年
			}
		}
		List<SalesBean> lists = helperController.GetSummary3(id,year);
		if (lists != null && !lists.isEmpty()) {
			return Layui.data(lists.size(), lists);
		}
		return Layui.data(0, null);
	}
	
	// 拼接变更日志
	private String GetUpdateString(Project origin, Project update){
		StringBuilder builder = new StringBuilder();
		// 客户编号
		if(DigitUtils.ComparerInteger(origin.getCustomerID(), update.getCustomerID())) {
			Customer customer1 = customerService.findById(origin.getCustomerID());
			Customer customer2 = customerService.findById(update.getCustomerID());
			builder.append("["+customer1.getCustomerName()+"客户变更为"+customer2.getCustomerName()+"]");
		}
		// 签订日期
		if(DateUtils.sameDate(origin.getSignDate(), update.getSignDate())) {
			builder.append("["+origin.getSignDate()+"签订日期变更为"+update.getSignDate()+"]");
		}
		// 项目号
		if(StringUtils.ComparerString(origin.getProjectNumber(),update.getProjectNumber())) {
			builder.append("["+origin.getProjectNumber()+"项目号变更为"+update.getProjectNumber()+"]");
		}
		// 项目类型
		if(StringUtils.ComparerString(origin.getProjectType(),update.getProjectType())) {
			builder.append("["+origin.getProjectType()+"项目类型变更为"+update.getProjectType()+"]");
		}
		// 项目名称
		if(StringUtils.ComparerString(origin.getProjectName(),update.getProjectName())) {
			builder.append("["+origin.getProjectName()+"项目名称变更为"+update.getProjectName()+"]");
		}
		// 项目地址
		if(StringUtils.ComparerString(origin.getProjectAddress(),update.getProjectAddress())) {
			builder.append("["+origin.getProjectAddress()+"项目地址变更为"+update.getProjectAddress()+"]");
		}
		// 项目概况
		if(StringUtils.ComparerString(origin.getProjectDescription(),update.getProjectDescription())) {
			builder.append("["+origin.getProjectDescription()+"项目概况变更为"+update.getProjectDescription()+"]");
		}
		// 项目负责人
		if(StringUtils.ComparerString(origin.getProjectPerson(),update.getProjectPerson())) {
			builder.append("["+origin.getProjectPerson()+"项目负责人变更为"+update.getProjectPerson()+"]");
		}
		// 进场日期
		if(DateUtils.sameDate(origin.getProjectStartDate(), update.getProjectStartDate())) {
			builder.append("["+origin.getProjectStartDate()+"进场日期变更为"+update.getProjectStartDate()+"]");
		}
		// 完工日期
		if(DateUtils.sameDate(origin.getProjectFinalDate(), update.getProjectFinalDate())) {
			builder.append("["+origin.getProjectFinalDate()+"完工日期变更为"+update.getProjectFinalDate()+"]");
		}
		// 项目周期
		if(DigitUtils.ComparerDouble(origin.getProjectCycle(), update.getProjectCycle())) {
			builder.append("["+origin.getProjectCycle()+"项目周期变更为"+update.getProjectCycle()+"]");
		}
		// 项目单价
		if(DigitUtils.ComparerDouble(origin.getProjectPrice(), update.getProjectPrice())) {
			builder.append("["+origin.getProjectPrice()+"项目单价变更为"+update.getProjectPrice()+"]");
		}
		// 开荒面积
		if(DigitUtils.ComparerDouble(origin.getProjectArea(), update.getProjectArea())) {
			builder.append("["+origin.getProjectArea()+"开荒面积变更为"+update.getProjectArea()+"]");
		}
		// 项目预算
		if(DigitUtils.ComparerDouble(origin.getProjectBudget(), update.getProjectBudget())) {
			builder.append("["+origin.getProjectBudget()+"项目预算变更为"+update.getProjectBudget()+"]");
		}
		// 项目成本
		if(DigitUtils.ComparerDouble(origin.getProjectCost(), update.getProjectCost())) {
			builder.append("["+origin.getProjectCost()+"项目成本变更为"+update.getProjectCost()+"]");
		}
		// 项目收入
		if(DigitUtils.ComparerDouble(origin.getProjectIncome(), update.getProjectIncome())) {
			builder.append("["+origin.getProjectIncome()+"项目收入变更为"+update.getProjectIncome()+"]");
		}
		// 项目回款
		if(DigitUtils.ComparerDouble(origin.getProjectInQuota(), update.getProjectInQuota())) {
			builder.append("["+origin.getProjectInQuota()+"项目回款变更为"+update.getProjectInQuota()+"]");
		}
		// 项目余款
		if(DigitUtils.ComparerDouble(origin.getProjectUnQuota(), update.getProjectUnQuota())) {
			builder.append("["+origin.getProjectUnQuota()+"项目余款变更为"+update.getProjectUnQuota()+"]");
		}
		// 截止日期
		if(DateUtils.sameDate(origin.getDeadLineDate(), update.getDeadLineDate())) {
			builder.append("["+origin.getDeadLineDate()+"截止日期变更为"+update.getDeadLineDate()+"]");
		}
		// 项目滞纳
		if(DigitUtils.ComparerDouble(origin.getProjectDelay(), update.getProjectDelay())) {
			builder.append("["+origin.getProjectDelay()+"项目滞纳变更为"+update.getProjectDelay()+"]");
		}
		// 回款状态
		if(StringUtils.ComparerString(origin.getProjectPayState(),update.getProjectPayState())) {
			builder.append("["+origin.getProjectPayState()+"回款状态变更为"+update.getProjectPayState()+"]");
		}
		// 备注信息
		if(StringUtils.ComparerString(origin.getRemarkDescription(),update.getRemarkDescription())) {
			builder.append("["+origin.getRemarkDescription()+"备注变更为"+update.getRemarkDescription()+"]");
		}
		return builder.toString();
	}
}
