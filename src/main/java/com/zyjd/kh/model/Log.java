package com.zyjd.kh.model;

import java.util.Date;

/**
 * 日志数据模型
 */
public class Log extends  Base{

	private Integer id;// 主键，编号
	
	private Integer userID;// 外键，用户ID

	private String operateType;// 操作类型

	private String operateDetail;// 操作明细

	private String logsIpAddress;// 操作IP地址

	private Date createDate;// 创建日期
	
	private User user = new User();// 关联用户

	public Log() {
		super();
	}

	public Log(Integer userID, String operateType, String operateDetail, String logsIpAddress,Date createDate) {
		this.userID = userID;
		this.operateType = operateType;
		this.operateDetail = operateDetail;
		this.logsIpAddress = logsIpAddress;
		this.createDate = createDate;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public String getOperateType() { return operateType; }

	public void setOperateType(String operateType) { this.operateType = operateType; }

	public String getOperateDetail() {
		return operateDetail;
	}

	public void setOperateDetail(String operateDetail) {
		this.operateDetail = operateDetail;
	}

	public String getLogsIpAddress() {
		return logsIpAddress;
	}

	public void setLogsIpAddress(String logsIpAddress) {
		this.logsIpAddress = logsIpAddress;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Log{" +
				"id=" + id +
				", userID=" + userID +
				", operateType='" + operateType + '\'' +
				", operateDetail='" + operateDetail + '\'' +
				", logsIpAddress='" + logsIpAddress + '\'' +
				", createDate=" + createDate +
				", user=" + user +
				'}';
	}
}
