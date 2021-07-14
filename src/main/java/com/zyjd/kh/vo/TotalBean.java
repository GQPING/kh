package com.zyjd.kh.vo;

/**
 * 合计Bean
 */
public class TotalBean {

	private Integer totalProjects = 0; // 总项目
	private Integer todayProjects = 0; // 今日项目
	
	private Double totalBudgets = 0.0; // 总预算
	private Double todayBudgets = 0.0; // 今日预算

	private Double totalCosts = 0.0; // 总成本
	private Double todayCosts = 0.0; // 今日成本

	private Double totalIncomes = 0.0; // 总收入
	private Double todayIncomes = 0.0; // 今日收入
	
	private Double totalInQuotas = 0.0; // 总回款
	private Double todayInQuotas = 0.0; // 今日回款

	private Double totalUnQuotas = 0.0; // 总余款
	private Double todayUnQuotas = 0.0; // 今日余款
	
	private Integer totalCustomers = 0; // 总客户
	private Integer todayCustomers = 0; // 今日客户
	
	private Integer totalUsers = 0; // 总用户
	private Integer todayUsers = 0; // 今日用户

	public Integer getTotalProjects() {
		return totalProjects;
	}

	public void setTotalProjects(Integer totalProjects) {
		this.totalProjects = totalProjects;
	}

	public Integer getTodayProjects() {
		return todayProjects;
	}

	public void setTodayProjects(Integer todayProjects) {
		this.todayProjects = todayProjects;
	}

	public Double getTotalBudgets() {
		return totalBudgets;
	}

	public void setTotalBudgets(Double totalBudgets) {
		this.totalBudgets = totalBudgets;
	}

	public Double getTodayBudgets() {
		return todayBudgets;
	}

	public void setTodayBudgets(Double todayBudgets) {
		this.todayBudgets = todayBudgets;
	}

	public Double getTotalCosts() {
		return totalCosts;
	}

	public void setTotalCosts(Double totalCosts) {
		this.totalCosts = totalCosts;
	}

	public Double getTodayCosts() {
		return todayCosts;
	}

	public void setTodayCosts(Double todayCosts) {
		this.todayCosts = todayCosts;
	}

	public Double getTotalIncomes() {
		return totalIncomes;
	}

	public void setTotalIncomes(Double totalIncomes) {
		this.totalIncomes = totalIncomes;
	}

	public Double getTodayIncomes() {
		return todayIncomes;
	}

	public void setTodayIncomes(Double todayIncomes) {
		this.todayIncomes = todayIncomes;
	}

	public Double getTotalInQuotas() {
		return totalInQuotas;
	}

	public void setTotalInQuotas(Double totalInQuotas) {
		this.totalInQuotas = totalInQuotas;
	}

	public Double getTodayInQuotas() {
		return todayInQuotas;
	}

	public void setTodayInQuotas(Double todayInQuotas) {
		this.todayInQuotas = todayInQuotas;
	}

	public Double getTotalUnQuotas() {
		return totalUnQuotas;
	}

	public void setTotalUnQuotas(Double totalUnQuotas) {
		this.totalUnQuotas = totalUnQuotas;
	}

	public Double getTodayUnQuotas() {
		return todayUnQuotas;
	}

	public void setTodayUnQuotas(Double todayUnQuotas) {
		this.todayUnQuotas = todayUnQuotas;
	}

	public Integer getTotalCustomers() {
		return totalCustomers;
	}

	public void setTotalCustomers(Integer totalCustomers) {
		this.totalCustomers = totalCustomers;
	}

	public Integer getTodayCustomers() {
		return todayCustomers;
	}

	public void setTodayCustomers(Integer todayCustomers) {
		this.todayCustomers = todayCustomers;
	}

	public Integer getTotalUsers() {
		return totalUsers;
	}

	public void setTotalUsers(Integer totalUsers) {
		this.totalUsers = totalUsers;
	}

	public Integer getTodayUsers() {
		return todayUsers;
	}

	public void setTodayUsers(Integer todayUsers) {
		this.todayUsers = todayUsers;
	}

	@Override
	public String toString() {
		return "TotalBean{" +
				"totalProjects=" + totalProjects +
				", todayProjects=" + todayProjects +
				", totalBudgets=" + totalBudgets +
				", todayBudgets=" + todayBudgets +
				", totalCosts=" + totalCosts +
				", todayCosts=" + todayCosts +
				", totalIncomes=" + totalIncomes +
				", todayIncomes=" + todayIncomes +
				", totalInQuotas=" + totalInQuotas +
				", todayInQuotas=" + todayInQuotas +
				", totalUnQuotas=" + totalUnQuotas +
				", todayUnQuotas=" + todayUnQuotas +
				", totalCustomers=" + totalCustomers +
				", todayCustomers=" + todayCustomers +
				", totalUsers=" + totalUsers +
				", todayUsers=" + todayUsers +
				'}';
	}
}
