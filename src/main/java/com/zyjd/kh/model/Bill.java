package com.zyjd.kh.model;

import java.util.Date;

/**
 * 开票数据模型
 */
public class Bill extends Base{

	private Integer id;// 主键，编号
	
	private Integer projectID;// 外键，项目编号

	private String billType;// 开票类型
	
	private Double billQuota;// 开票金额

	private Date billDate;// 开票日期

	private String remarkDescription;// 备注信息
	
	private Project project = new Project(); // 关联项目

	public Bill() { super(); }

	public Bill(Integer projectID) {
		this.projectID = projectID;
	}

	public Integer getId() {
		return id;
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

	public Double getBillQuota() {
		return billQuota;
	}

	public void setBillQuota(Double billQuota) {
		this.billQuota = billQuota;
	}

	public String getBillType() {
		return billType;
	}

	public void setBillType(String billType) {
		this.billType = billType;
	}

	public Date getBillDate() {
		return billDate;
	}

	public void setBillDate(Date billDate) {
		this.billDate = billDate;
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
		return "Bill{" +
				"id=" + id +
				", projectID=" + projectID +
				", billQuota=" + billQuota +
				", billType='" + billType + '\'' +
				", billDate=" + billDate +
				", remarkDescription='" + remarkDescription + '\'' +
				", project=" + project +
				'}';
	}
}
