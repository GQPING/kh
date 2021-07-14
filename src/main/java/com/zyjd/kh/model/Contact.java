package com.zyjd.kh.model;

import java.util.Date;

/**
 * 联系人数据模型
 */
public class Contact extends Base{

	private Integer id;// 主键，编号

	private Integer projectID;// 外键，项目编号

	private String contactName;// 联系人

	private String contactPhone;// 联系电话

	private Date createDate;// 创建日期

	private String remarkDescription;// 备注信息

	private Project project = new Project();// 关联项目

	public Contact() { super(); }

	public Contact(Integer projectID, String contactName) {
		this.projectID = projectID;
		this.contactName = contactName;
	}

	public Contact(Integer projectID, String contactName, String contactPhone, Date createDate) {
		this.projectID = projectID;
		this.contactName = contactName;
		this.contactPhone = contactPhone;
		this.createDate = createDate;
	}

	public Integer getId() { return id; }

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProjectID() {
		return projectID;
	}

	public void setProjectID(Integer projectID) {
		this.projectID = projectID;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
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

	public Date getCreateDate() { return createDate; }

	public void setCreateDate(Date createDate) { this.createDate = createDate; }

	@Override
	public String toString() {
		return "Contact{" +
				"id=" + id +
				", projectID=" + projectID +
				", contactName='" + contactName + '\'' +
				", contactPhone='" + contactPhone + '\'' +
				", createDate=" + createDate +
				", remarkDescription='" + remarkDescription + '\'' +
				", project=" + project +
				'}';
	}
}
