package com.zyjd.kh.controller;

import java.util.List;

import com.zyjd.kh.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.kh.util.Layui;
import com.zyjd.kh.service.ContactService;
import com.zyjd.kh.model.Contact;

/**
 * 联系人控制器
 * 处理客户联系人相关操作
 */
@Controller
@RequestMapping("/contact")
public class ContactController {

	@Autowired
	private ContactService contactService;

	@Autowired
	private HelperController helperController;

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "contract/list/contactList";
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Contact contact) {
		// 设置地址
		contact.setStart((contact.getPage() - 1) * contact.getLimit());
		// 查询记录
		List<Contact> alls = contactService.findByCondition(contact);
		// 当页记录
		List<Contact> contacts = contactService.findByConditionPage(contact);
		if (contacts != null && !contacts.isEmpty()) {
			return Layui.data(alls.size(), contacts);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Contact contact) {
		List<Contact> alls = contactService.findByCondition(contact);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 查询操作(指定条件的联系人)
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public Contact Search(@RequestBody Contact contact) {
		List<Contact> contacts = contactService.findByConditions(contact);
		if(contacts!=null && !contacts.isEmpty()){
			return contacts.get(0);
		}
		return null;
	}

	// 获取列表
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Contact> GetList(@RequestBody Contact contact) {
		return contactService.findByConditions(contact);
	}

	// 添加操作
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Contact contact) {
		try {
			if (contactService.add(contact) > 0) {
				// 原始
				Contact origin = contactService.findById(contact.getId());
				// 日志
				helperController.AddLog("创建",origin.getProject().getProjectName()+"中添加了联系人["+origin.getContactName()+"]");
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
		Contact origin = contactService.findById(id);
		try {
			if (contactService.delete(id) > 0) {
				// 日志
				helperController.AddLog("删除",origin.getProject().getProjectName()+"中删除了联系人["+origin.getContactName()+"]");
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
	public String Update(@RequestBody Contact contact) {
		// 原始
		Contact origin = contactService.findById(contact.getId());
		try {
			if (contactService.update(contact) > 0) {
				// 日志
				helperController.AddLog("修改",origin.getProject().getProjectName()+"中联系人["+origin.getContactName()+"]信息变更如下："+GetUpdateString(origin,contact));
				return "1";// 成功
			} else {
				return "0";// 失败
			}
		} catch (Exception e) {
			return "0";// 失败
		}
	}

    // 拼接日志
	private String GetUpdateString(Contact origin, Contact update){
		StringBuilder builder = new StringBuilder();
		// 联系名称
		if(StringUtils.ComparerString(origin.getContactName(),update.getContactName())) {
            builder.append("["+origin.getContactName()+"名称变更为"+update.getContactName()+"]");
		}
		// 联系电话
		if(StringUtils.ComparerString(origin.getContactPhone(),update.getContactPhone())) {
			builder.append("["+origin.getContactPhone()+"电话变更为"+update.getContactPhone()+"]");
		}
		// 备注信息
		if(StringUtils.ComparerString(origin.getRemarkDescription(),update.getRemarkDescription())) {
			builder.append("["+origin.getRemarkDescription()+"备注变更为"+update.getRemarkDescription()+"]");
		}
		return builder.toString();
	}
}
