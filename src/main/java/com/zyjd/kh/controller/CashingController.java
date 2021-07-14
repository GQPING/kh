package com.zyjd.kh.controller;

import java.util.Date;
import java.util.List;
import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import cn.hutool.db.DbUtil;
import com.zyjd.kh.model.Bill;
import com.zyjd.kh.model.Project;
import com.zyjd.kh.service.ProjectService;
import com.zyjd.kh.util.DateUtils;
import com.zyjd.kh.util.DigitUtils;
import com.zyjd.kh.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.kh.model.Cashing;
import com.zyjd.kh.util.Layui;
import com.zyjd.kh.service.CashingService;

/**
 * 收款控制器
 * 处理收款相关操作
 */
@Controller
@RequestMapping("/cashing")
public class CashingController {
	
	@Autowired
	private CashingService cashingService;

	@Autowired
	private ProjectService projectService;

	@Autowired
	private HelperController helperController;

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "contract/list/cashingList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Cashing cashing) {
		// 设置地址
		cashing.setStart((cashing.getPage() - 1) * cashing.getLimit());
		// 查询记录
		List<Cashing> alls = cashingService.findByCondition(cashing);
		// 当页记录
		List<Cashing> customers = cashingService.findByConditionPage(cashing);
		if (customers != null && !customers.isEmpty()) {
			return Layui.data(alls.size(), customers);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Cashing cashing) {
		List<Cashing> alls = cashingService.findByCondition(cashing);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 获取列表
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Cashing> GetList(@RequestBody Cashing cashing) {
		return cashingService.findByConditions(cashing);
	}
	
	// 添加操作
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Cashing cashing) {
		try {
			if (cashingService.add(cashing) > 0) {
				SyncProjectCash(cashing);//同步项目的收款信息
				Cashing origin = cashingService.findById(cashing.getId());
				helperController.AddLog("创建",origin.getProject().getProjectName()+"中添加了收款["+ DateUtil.formatDate(cashing.getPayDate()) +","+cashing.getPayType()+","+cashing.getPayPerson()+","+cashing.getPayQuota()+"]");
				return "1";// 成功修改
			} else {
				return "0";// 语法异常
			}
		} catch (Exception e) {
			return "0";// 服务器异常
		}
	}
	
	// 删除操作
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		// 查找需要删除的指定收款记录
		Cashing cashing = cashingService.findById(id);
		try {
			if (cashingService.delete(id) > 0) {
				SyncProjectCash(cashing);//同步项目的收款信息
				helperController.AddLog("删除",cashing.getProject().getProjectName() +"中删除了收款["+ DateUtil.formatDate(cashing.getPayDate()) +","+cashing.getPayType()+","+cashing.getPayPerson()+","+cashing.getPayQuota()+"]");
				return "1";// 成功修改
			} else {
				return "0";// 语法异常
			}
		} catch (Exception e) {
			return "0";// 服务器异常
		}
	}

	// 修改操作
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Cashing cashing) {
		Cashing origin = cashingService.findById(cashing.getId());
		try {
			if (cashingService.update(cashing) > 0) {
				SyncProjectCash(cashing);//同步项目的收款信息
				helperController.AddLog("修改",origin.getProject().getProjectName() + "中["+ DateUtil.formatDate(cashing.getPayDate()) +","+cashing.getPayType()+","+cashing.getPayPerson()+","+cashing.getPayQuota()+"]信息变更如下："+GetUpdateString(origin,cashing));
				return "1";// 成功修改
			} else {
				return "0";// 语法异常
			}
		} catch (Exception e) {
			return "0";// 服务器异常
		}
	}

	// 拼接日志
	private String GetUpdateString(Cashing origin, Cashing update){
		StringBuilder builder = new StringBuilder();
		// 收款人
		if(StringUtils.ComparerString(origin.getPayPerson(),update.getPayPerson())) {
			builder.append("["+origin.getPayPerson()+"收款人变更为"+update.getPayPerson()+"]");
		}
		// 收款类型
		if(StringUtils.ComparerString(origin.getPayType(),update.getPayType())) {
			builder.append("["+origin.getPayType()+"收款类型变更为"+update.getPayType()+"]");
		}
		// 收款金额
		if(DigitUtils.ComparerDouble(origin.getPayQuota(), update.getPayQuota())) {
			builder.append("["+origin.getPayQuota()+"收款金额变更为"+update.getPayQuota()+"]");
		}
		// 收款日期
		if(DateUtils.sameDate(origin.getPayDate(), update.getPayDate())) {
			builder.append("["+origin.getPayDate()+"收款日期变更为"+update.getPayDate()+"]");
		}
		// 备注信息
		if(StringUtils.ComparerString(origin.getRemarkDescription(),update.getRemarkDescription())) {
			builder.append("["+origin.getRemarkDescription()+"备注变更为"+update.getRemarkDescription()+"]");
		}
		return builder.toString();
	}

	// 同步项目的收款信息
	private void SyncProjectCash(Cashing cashing) {
		Project project = projectService.findById(cashing.getProjectID());
		if (project != null) {
			Double totals = cashingService.findCashByCondition(cashing);// 获取项目回款汇总额
			if (totals != null) {
				// 项目回款
				project.setProjectInQuota(totals);
			} else {
				// 项目回款
				project.setProjectInQuota(0.0);
			}
			// 项目余款 = 应收款项 - 回款 - 坏账
			project.setProjectUnQuota(project.getProjectBudget()-project.getProjectInQuota()-project.getProjectBadQuota());
			if (project.getProjectUnQuota()<=0) {
				// 余款 <= 0 ,说明已付清
				project.setProjectPayState("已付清");
			} else {
				// 截止日期小于当前日期，拖欠中
				if(project.getDeadLineDate().getTime() < new Date().getTime()){
					project.setProjectPayState("拖欠中");
				}else{
					project.setProjectPayState("未付清");
				}
			}
			projectService.update(project);
		}
	}
}
