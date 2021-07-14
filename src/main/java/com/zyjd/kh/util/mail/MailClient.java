package com.zyjd.kh.util.mail;

import java.io.File;

import org.springframework.stereotype.Component;

import cn.hutool.extra.mail.MailUtil;

@Component
public class MailClient {

	/**
	 * 使用配置文件中设置的账户发送文本邮件，发送给单个或多个收件人<br>
	 * 多个收件人可以使用逗号“,”分隔，也可以通过分号“;”分隔
	 *
	 * @param to      收件人
	 * @param subject 标题
	 * @param content 正文
	 * @param files   附件列表
	 * @return message-id
	 * @since 3.2.0
	 */
	public String sendText(String to, String subject, String content, File... files) {
		return MailUtil.send(to, subject, content, false, files);
	}

	/**
	 * 使用配置文件中设置的账户发送HTML邮件，发送给单个或多个收件人<br>
	 * 多个收件人可以使用逗号“,”分隔，也可以通过分号“;”分隔
	 *
	 * @param to      收件人
	 * @param subject 标题
	 * @param content 正文
	 * @param files   附件列表
	 * @return message-id
	 * @since 3.2.0
	 */
	public String sendHtml(String to, String subject, String content, File... files) {
		return MailUtil.send(to, subject, content, true, files);
	}
}