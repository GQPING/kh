package com.zyjd.kh.controller;

import java.util.Date;
import java.util.List;

import cn.hutool.core.date.DateUtil;
import com.zyjd.kh.util.FlowloadUtils;
import com.zyjd.kh.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.kh.model.Customer;
import com.zyjd.kh.util.Layui;
import com.zyjd.kh.service.CustomerService;

/**
 * 客户控制器
 * 处理客户相关操作
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;

	@Autowired
	private HelperController helperController;

	// 档案界面
	@RequestMapping(value = "/record", method = RequestMethod.GET)
	public String Record() {
		return "customer/list/customerRecord";
	}

	// 获取档案(实现流加载数据，参数为检索条件)
	@RequestMapping(value = "/getRecord", method = RequestMethod.POST)
	@ResponseBody
	public Object GetRecord(@RequestParam(value = "page") Integer page,
							@RequestParam(value = "timeStart") String timeStart,
							@RequestParam(value = "timeFinal") String timeFinal,
							@RequestParam(value = "searchString") String searchString) {
		Customer customer = new Customer();
		customer.setPage(page);
		customer.setSearchString(searchString==""?null:searchString);
		customer.setTimeStart(timeStart==""?null:DateUtil.parse(timeStart));
		customer.setTimeFinal(timeFinal==""?null:DateUtil.parse(timeFinal));
		// 设置地址
		customer.setStart((customer.getPage() - 1) * customer.getLimit());
		// 总记录
		List<Customer> alls = customerService.findByCondition(customer);
		// 总页数
		int pages =  alls.size() / customer.getLimit();
		if(alls.size() % customer.getLimit() != 0){
			pages++;//不足一页，也算一页
		}
		// 当页记录
		List<Customer> customers = customerService.findByConditionPage(customer);
		if(customers != null && !customers.isEmpty()) {
			return FlowloadUtils.buildResult(pages, customers);
		}
		return Layui.data(0, null);
	}

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "customer/list/customerList";
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Customer customer) {
		// 设置地址
		customer.setStart((customer.getPage()-1)*customer.getLimit());
		// 查询记录
		List<Customer> alls = customerService.findByCondition(customer);
		// 当页记录
		List<Customer> customers = customerService.findByConditionPage(customer);
		if (customers != null && !customers.isEmpty()) {
			return Layui.data(alls.size(), customers);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Customer customer) {
		List<Customer> alls = customerService.findByCondition(customer);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}
	
	// 查询操作(获取指定名称的客户ID)
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public int Search(@RequestParam(value = "customerName", required = false) String customerName) {
		Customer customer = customerService.findByName(customerName);
		if(customer!=null){
			return customer.getId();
		}
		return -1;// 无效值
	}
	
	// 获取列表
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Customer> GetList(@RequestBody Customer customer) {
		return customerService.findByConditions(customer);
	}

	// 添加操作
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Customer customer) {
		try {
			if (customerService.add(customer) > 0) {
				helperController.AddLog("创建","添加了新客户["+customer.getCustomerName()+"]");
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
		// 原始
		Customer origin = customerService.findById(id);
		try {
			if (customerService.delete(id) > 0) {
				helperController.AddLog("删除","删除了客户["+origin.getCustomerName()+"]");
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
	public String Update(@RequestBody Customer customer) {
		// 原始
		Customer origin = customerService.findById(customer.getId());
		try {
			if (customerService.update(customer) > 0) {
				helperController.AddLog("修改","客户["+origin.getCustomerName()+"]信息变更如下："+GetUpdateString(origin,customer));
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			return "0";// 失败
		}
	}

	// 拼接日志
	private String GetUpdateString(Customer origin, Customer update){
		StringBuilder builder = new StringBuilder();
		// 客户名称
		if(StringUtils.ComparerString(origin.getCustomerName(),update.getCustomerName())) {
			builder.append("["+origin.getCustomerName()+"名称变更为"+update.getCustomerName()+"]");
		}
		// 联系人
		if(StringUtils.ComparerString(origin.getCustomerPerson(),update.getCustomerPerson())) {
			builder.append("["+origin.getCustomerPerson()+"联系人变更为"+update.getCustomerPerson()+"]");
		}
		// 联系电话
		if(StringUtils.ComparerString(origin.getCustomerPhone(),update.getCustomerPhone())) {
			builder.append("["+origin.getCustomerPhone()+"联系电话变更为"+update.getCustomerPhone()+"]");
		}
		// 联系地址
		if(StringUtils.ComparerString(origin.getCustomerAddress(),update.getCustomerAddress())) {
			builder.append("["+origin.getCustomerAddress()+"联系地址变更为"+update.getCustomerAddress()+"]");
		}
		// 备注信息
		if(StringUtils.ComparerString(origin.getRemarkDescription(),update.getRemarkDescription())) {
			builder.append("["+origin.getRemarkDescription()+"备注变更为"+update.getRemarkDescription()+"]");
		}
		return builder.toString();
	}
}
