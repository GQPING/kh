package com.zyjd.kh.controller;

import java.util.List;
import cn.hutool.core.date.DateUtil;
import com.zyjd.kh.model.Contact;
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
import com.zyjd.kh.model.Bill;
import com.zyjd.kh.util.Layui;
import com.zyjd.kh.service.BillService;

/**
 * 开票控制器
 * 处理开票相关操作
 */
@Controller
@RequestMapping("/bill")
public class BillController {
	
	@Autowired
	private BillService billService;

	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private HelperController helperController;

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "contract/list/billList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Bill bill) {
		// 设置地址
		bill.setStart((bill.getPage() - 1) * bill.getLimit());
		// 查询记录
		List<Bill> alls = billService.findByCondition(bill);
		// 当页记录
		List<Bill> bills = billService.findByConditionPage(bill);
		if (bills != null && !bills.isEmpty()) {
			return Layui.data(alls.size(), bills);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Bill bill) {
		List<Bill> alls = billService.findByCondition(bill);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 获取列表
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Bill> GetList(@RequestBody Bill bill) {
		return billService.findByConditions(bill);
	}
	
	// 添加操作
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Bill bill) {
		try {
			if (billService.add(bill) > 0) {
				Bill origin = billService.findById(bill.getId());
				helperController.AddLog("创建",origin.getProject().getProjectName()+"中添加了开票["+ DateUtil.formatDate(bill.getBillDate()) +","+bill.getBillType()+","+bill.getBillQuota()+"]");
				Project project = new Project();
				project.setId(bill.getProjectID());
				project.setHasBill(1);// 标志为已开票
				projectService.update(project);
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
		// 查找需要删除的指定开票记录
		Bill bill = billService.findById(id);
		try {
			if (billService.delete(bill.getId()) > 0) {
				helperController.AddLog("删除",bill.getProject().getProjectName()+ "中删除了开票["+ DateUtil.formatDate(bill.getBillDate()) +","+bill.getBillType()+","+bill.getBillQuota()+"]");
				Bill condition = new Bill();
				condition.setProjectID(bill.getProjectID());
				List<Bill> bills = billService.findByCondition(condition);// 当前项目是否有开票信息，无开票时，需要重置开票状态字段
				if(bills==null || bills.isEmpty()){
					Project project = new Project();
					project.setId(bill.getProjectID());
					project.setHasBill(0);// 标志为未开票
					projectService.update(project);
				}
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
	public String update(@RequestBody Bill bill) {
		Bill origin = billService.findById(bill.getId());
		try {
			if (billService.update(bill) > 0) {
				helperController.AddLog("修改",origin.getProject().getProjectName() + "中开票["+ DateUtil.formatDate(bill.getBillDate()) +","+bill.getBillType()+","+bill.getBillQuota()+"]信息变更如下："+GetUpdateString(origin,bill));
				return "1";// 成功修改
			} else {
				return "0";// 语法异常
			}
		} catch (Exception e) {
			return "0";// 服务器异常
		}
	}

	// 拼接日志
	private String GetUpdateString(Bill origin, Bill update){
		StringBuilder builder = new StringBuilder();
		// 开票金额
		if(DigitUtils.ComparerDouble(origin.getBillQuota(), update.getBillQuota())) {
			builder.append("["+origin.getBillQuota()+"开票金额变更为"+update.getBillQuota()+"]");
		}
		// 开票类型
		if(StringUtils.ComparerString(origin.getBillType(),update.getBillType())) {
			builder.append("["+origin.getBillType()+"开票类型变更为"+update.getBillType()+"]");
		}
		// 开票日期
		if(DateUtils.sameDate(origin.getBillDate(), update.getBillDate())) {
			builder.append("["+origin.getBillDate()+"开票日期变更为"+update.getBillDate()+"]");
		}
		// 备注信息
		if(StringUtils.ComparerString(origin.getRemarkDescription(),update.getRemarkDescription())) {
			builder.append("["+origin.getRemarkDescription()+"备注变更为"+update.getRemarkDescription()+"]");
		}
		return builder.toString();
	}
}