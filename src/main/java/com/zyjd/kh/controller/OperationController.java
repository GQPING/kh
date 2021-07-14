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
import com.zyjd.kh.model.Operation;
import com.zyjd.kh.service.OperationService;

/**
 * 操作控制器
 * 处理操作相关
 */
@Controller
@RequestMapping("/operation")
public class OperationController {
	
	@Autowired
	private OperationService operationService;
	
	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "rbac/list/operationList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Operation operation) {
		// 设置地址
		operation.setStart((operation.getPage()-1)*operation.getLimit());
		// 查询记录
		List<Operation> alls = operationService.findByCondition(operation);
		// 当页记录
		List<Operation> operations = operationService.findByConditionPage(operation);
		if (operations != null && !operations.isEmpty()) {
			return Layui.data(alls.size(), operations);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Operation operation) {
		List<Operation> alls = operationService.findByCondition(operation);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}
	
	// 查询操作(获取指定名称操作ID)
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public int Search(@RequestParam(value="operationName",required=false) String operationName) {
		Operation operation = operationService.findByName(operationName);
		if(operation!=null){
			return operation.getId();
		}
		return -1;// 无效值
	}
	
	// 获取操作
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Operation> GetList(@RequestBody Operation operation) {
		return operationService.findByConditions(operation);
	}
	
	// 添加操作
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Operation operation) {
		try {
			if (operationService.add(operation) > 0) {
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
			if (operationService.delete(id) > 0) {
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
	public String Update(@RequestBody Operation operation) {
		try {
			if (operationService.update(operation) > 0) {
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			return "0";// 失败
		}
	}
}
