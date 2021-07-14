package com.zyjd.kh.controller;

import java.util.List;

import com.zyjd.kh.model.Project;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import com.zyjd.kh.util.mail.MailClient;
import cn.hutool.core.date.DateUtil;

/**
 * 邮箱发送项目回款到期信息
 */
//@Controller
public class TaskTimerController {

	//@Autowired
	private MailClient mailClient;

	//@Autowired
	private HelperController helperController;

	// 定时任务执行方法
	// “0 0 12 * * ?” 每天中午十二点触发
	// “0 15 10 ? * *” 每天早上10：15触发
	// “0 15 10 * * ?” 每天早上10：15触发
	// “0 15 10 * * ? *” 每天早上10：15触发
	// “0 15 10 * * ? 2005” 2005年的每天早上10：15触发
	// “0 * 14 * * ?” 每天从下午2点开始到2点59分每分钟一次触发
	// “0 0/5 14 * * ?” 每天从下午2点开始到2：55分结束每5分钟一次触发
	// “0 0/5 14,18 * * ?” 每天的下午2点至2：55和6点至6点55分两个时间段内每5分钟一次触发
	// “0 0-5 14 * * ?” 每天14:00至14:05每分钟一次触发
	// “0 10,44 14 ? 3 WED” 三月的每周三的14：10和14：44触发
	// “0 15 10 ? * MON-FRI” 每个周一、周二、周三、周四、周五的10：15触发
	// "0/10 * * * * ?" 间隔10秒执行
	// "0 */1 * * * ?"每隔1分钟执行一次
	@Scheduled(cron = "0/10 * * * * ?")
	public void execute() {		
		StringBuilder title = new StringBuilder("【到期预警】项目回款到期提醒");
		StringBuilder header = new StringBuilder("<h1>以下项目回款已到期或过期，请及时处理!</h1>\n\r"
				+ "<table style='background-color: #dedede;text-align:center;"
				+ "font-family:verdana,arial,sans-serif;font-size:14px;color:#333333;"
				+ "border:1px solid #ccc'><thead>"
				        + "<tr>"
				             + "<th style='border-bottom:1px solid black;'>项目名称</th>"
				             + "<th style='border-bottom:1px solid black;'>项目余款</th>"
				             + "<th style='border-bottom:1px solid black;' width='150'>回款截止时间</th>"
				        + "</tr>" 
				+ "</thead>" 
				+ "<tbody>");
		StringBuilder content = new StringBuilder("");
		List<Project> projects = helperController.GetProjectToDate();// 获取到期项目数据
		if (projects != null && ! projects.isEmpty()) {
			for(Project project : projects) {
				content.append("<tr><td style='border-bottom:1px solid #ccc;'>"+ project.getProjectName() +"</td>"
						+ "<td style='border-bottom:1px solid #ccc;'>"+ project.getProjectUnQuota() +"</td>"
						+ "<td style='border-bottom:1px solid #ccc;'>"+ DateUtil.formatDate(project.getDeadLineDate()) +"</td></tr>");
			}
		}
		String footer = "</tbody></table>";
		header.append(content.toString());
		header.append(footer);
		mailClient.sendHtml("m15649865121@163.com", title.toString() , header.toString());// 指定邮箱发送，自行查找此API用法
	}	
}
