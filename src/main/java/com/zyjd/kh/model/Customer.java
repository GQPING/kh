package com.zyjd.kh.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 客户数据模型
 */
public class Customer extends Base{

	private Integer id;// 主键，编号

	private String customerName;// 客户名称

	private String customerPerson;// 联系人

	private String customerPhone;// 联系电话

	private String customerAddress;// 联系地址

	private Integer customerLevel;// 信用星级

	private Date createDate;// 创建日期

	private String remarkDescription;// 备注信息

	private List<Project> projects = new ArrayList<>();// 关联项目集合

	public Customer() { super(); }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerPerson() {
		return customerPerson;
	}

	public void setCustomerPerson(String customerPerson) {
		this.customerPerson = customerPerson;
	}

	public String getCustomerPhone() {
		return customerPhone;
	}

	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}

	public String getCustomerAddress() {
		return customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public Integer getCustomerLevel() {
		return customerLevel;
	}

	public void setCustomerLevel(Integer customerLevel) {
		this.customerLevel = customerLevel;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getRemarkDescription() {
		return remarkDescription;
	}

	public void setRemarkDescription(String remarkDescription) {
		this.remarkDescription = remarkDescription;
	}

	public List<Project> getProjects() {
		return projects;
	}

	public void setProjects(List<Project> projects) {
		this.projects = projects;
	}

	@Override
	public String toString() {
		return "Customer{" +
				"id=" + id +
				", customerName='" + customerName + '\'' +
				", customerPerson='" + customerPerson + '\'' +
				", customerPhone='" + customerPhone + '\'' +
				", customerAddress='" + customerAddress + '\'' +
				", customerLevel=" + customerLevel +
				", createDate=" + createDate +
				", remarkDescription='" + remarkDescription + '\'' +
				", projects=" + projects +
				'}';
	}
}