package com.zyjd.kh.model;

import java.util.Date;

/**
 * 项目数据模型
 */
public class Project extends Base{
	
	private Integer id;// 主键，编号
	
	private Integer customerID;// 外键，客户编号

	private Date signDate;// 签订日期

	private String projectNumber;// 项目编号

	private String projectType;// 项目类型

	private String projectName;// 项目名称

	private String projectAddress;// 项目地址

	private String projectDescription;// 项目概况

	private String projectPerson;// 项目负责人

	private Date projectStartDate;// 进场日期

	private Date projectFinalDate;// 完工日期

	private Double projectCycle;// 项目周期

	private Double projectPrice;// 项目单价

	private Double projectArea;// 开荒面积

	private Double projectDelay;// 项目滞纳

	private Double projectBudget;// 应收款项

	private Double projectCost;// 预算

	private Double projectIncome;// 收入

	private Double projectInQuota;// 回款

	private Double projectBadQuota;// 坏账

	private Double projectUnQuota;// 余款

	private Date deadLineDate;// 截止日期

	private String projectPayState;// 回款状态

	private String remarkDescription;// 备注信息

	private Integer projectRemindDays;// 提醒限制

	private Integer hasBill;// 是否开票

	private Integer hasApplyBill;// 是否申请开票

	private Customer customer = new Customer();// 关联客户

	public Project() {
		super();
	}

	public Project(Integer customerID) {
		this.customerID = customerID;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCustomerID() {
		return customerID;
	}

	public void setCustomerID(Integer customerID) {
		this.customerID = customerID;
	}

	public Date getSignDate() {
		return signDate;
	}

	public void setSignDate(Date signDate) { this.signDate = signDate; }

	public String getProjectNumber() {
		return projectNumber;
	}

	public void setProjectNumber(String projectNumber) {
		this.projectNumber = projectNumber;
	}

	public String getProjectType() {
		return projectType;
	}

	public void setProjectType(String projectType) {
		this.projectType = projectType;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectAddress() {
		return projectAddress;
	}

	public void setProjectAddress(String projectAddress) { this.projectAddress = projectAddress; }

	public String getProjectDescription() {
		return projectDescription;
	}

	public void setProjectDescription(String projectDescription) {
		this.projectDescription = projectDescription;
	}

	public String getProjectPerson() {
		return projectPerson;
	}

	public void setProjectPerson(String projectPerson) {
		this.projectPerson = projectPerson;
	}

	public Date getProjectStartDate() {
		return projectStartDate;
	}

	public void setProjectStartDate(Date projectStartDate) {
		this.projectStartDate = projectStartDate;
	}

	public Date getProjectFinalDate() {
		return projectFinalDate;
	}

	public void setProjectFinalDate(Date projectFinalDate) {
		this.projectFinalDate = projectFinalDate;
	}

	public Double getProjectCycle() {
		return projectCycle;
	}

	public void setProjectCycle(Double projectCycle) {
		this.projectCycle = projectCycle;
	}

	public Double getProjectPrice() {
		return projectPrice;
	}

	public void setProjectPrice(Double projectPrice) {
		this.projectPrice = projectPrice;
	}

	public Double getProjectArea() {
		return projectArea;
	}

	public void setProjectArea(Double projectArea) {
		this.projectArea = projectArea;
	}

	public Double getProjectBudget() {
		return projectBudget;
	}

	public void setProjectBudget(Double projectBudget) {
		this.projectBudget = projectBudget;
	}

	public Double getProjectCost() {
		return projectCost;
	}

	public void setProjectCost(Double projectCost) {
		this.projectCost = projectCost;
	}

	public Double getProjectIncome() {
		return projectIncome;
	}

	public void setProjectIncome(Double projectIncome) {
		this.projectIncome = projectIncome;
	}

	public Double getProjectInQuota() {
		return projectInQuota;
	}

	public void setProjectInQuota(Double projectInQuota) { this.projectInQuota = projectInQuota; }

	public Double getProjectUnQuota() {
		return projectUnQuota;
	}

	public void setProjectUnQuota(Double projectUnQuota) { this.projectUnQuota = projectUnQuota; }

	public Date getDeadLineDate() {
		return deadLineDate;
	}

	public void setDeadLineDate(Date deadLineDate) {
		this.deadLineDate = deadLineDate;
	}

	public Double getProjectDelay() {
		return projectDelay;
	}

	public void setProjectDelay(Double projectDelay) {
		this.projectDelay = projectDelay;
	}

	public String getProjectPayState() {
		return projectPayState;
	}

	public void setProjectPayState(String projectPayState) {
		this.projectPayState = projectPayState;
	}

	public String getRemarkDescription() {
		return remarkDescription;
	}

	public void setRemarkDescription(String remarkDescription) {
		this.remarkDescription = remarkDescription;
	}

	public Integer getProjectRemindDays() { return projectRemindDays; }

	public void setProjectRemindDays(Integer projectRemindDays) { this.projectRemindDays = projectRemindDays; }

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Double getProjectBadQuota() { return projectBadQuota; }

	public void setProjectBadQuota(Double projectBadQuota) { this.projectBadQuota = projectBadQuota; }

	public Integer getHasBill() { return hasBill; }

	public void setHasBill(Integer hasBill) { this.hasBill = hasBill; }

	public Integer getHasApplyBill() { return hasApplyBill; }

	public void setHasApplyBill(Integer hasApplyBill) { this.hasApplyBill = hasApplyBill; }

	@Override
	public String toString() {
		return "Project{" +
				"id=" + id +
				", customerID=" + customerID +
				", signDate=" + signDate +
				", projectNumber='" + projectNumber + '\'' +
				", projectType='" + projectType + '\'' +
				", projectName='" + projectName + '\'' +
				", projectAddress='" + projectAddress + '\'' +
				", projectDescription='" + projectDescription + '\'' +
				", projectPerson='" + projectPerson + '\'' +
				", projectStartDate=" + projectStartDate +
				", projectFinalDate=" + projectFinalDate +
				", projectCycle=" + projectCycle +
				", projectPrice=" + projectPrice +
				", projectArea=" + projectArea +
				", projectDelay=" + projectDelay +
				", projectBudget=" + projectBudget +
				", projectCost=" + projectCost +
				", projectIncome=" + projectIncome +
				", projectInQuota=" + projectInQuota +
				", projectBadQuota=" + projectBadQuota +
				", projectUnQuota=" + projectUnQuota +
				", deadLineDate=" + deadLineDate +
				", projectPayState='" + projectPayState + '\'' +
				", remarkDescription='" + remarkDescription + '\'' +
				", projectRemindDays=" + projectRemindDays +
				", hasBill=" + hasBill +
				", hasApplyBill=" + hasApplyBill +
				", customer=" + customer +
				'}';
	}
}