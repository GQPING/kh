package com.zyjd.kh.model;

import java.util.Date;

/**
 * 收款数据模型
 */
public class Cashing extends Base{

	private Integer id;// 主键，编号

	private Integer projectID;// 外键，项目编号

	private String payType;// 收款类型

	private String payPerson;// 收款人

	private Double payQuota;// 收款金额

	private Date payDate;// 收款日期

	private String remarkDescription;// 备注信息
	
	private Project project = new Project();// 关联项目

	public Cashing() { super();}

	public Integer getId() {
		return id;
	}

	public Cashing(Integer projectID) {
		this.projectID = projectID;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProjectID() {
		return projectID;
	}

	public void setProjectID(Integer projectID) {
		this.projectID = projectID;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getPayPerson() {
		return payPerson;
	}

	public void setPayPerson(String payPerson) {
		this.payPerson = payPerson;
	}

	public Double getPayQuota() {
		return payQuota;
	}

	public void setPayQuota(Double payQuota) {
		this.payQuota = payQuota;
	}

	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public String getRemarkDescription() {
		return remarkDescription;
	}

	public void setRemarkDescription(String remarkDescription) {
		this.remarkDescription = remarkDescription;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	@Override
	public String toString() {
		return "Cashing{" +
				"id=" + id +
				", projectID=" + projectID +
				", payType='" + payType + '\'' +
				", payPerson='" + payPerson + '\'' +
				", payQuota=" + payQuota +
				", payDate=" + payDate +
				", remarkDescription='" + remarkDescription + '\'' +
				", project=" + project +
				'}';
	}
}