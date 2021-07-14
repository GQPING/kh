package com.zyjd.kh.vo;

import com.zyjd.kh.model.Customer;

/**
 * 销售额Bean
 */
public class SalesBean {

    // 金额变量
    private Double budgets = 0.0;   // 预算
	private Double costs = 0.0;     // 成本
    private Double incomes = 0.0;   // 收入
	private Double delays = 0.0;    // 滞纳
	private Double inQuotas = 0.0;  // 回款
    private Double unQuotas = 0.0;  // 余款
    private Double inPayEnds = 0.0; // 到期已收(回款)
    private Double unPayEnds = 0.0; // 到期未收(余款)
    private Customer customer = new Customer();// 关联客户

    public Double getBudgets() {
        return budgets;
    }

    public void setBudgets(Double budgets) {
        this.budgets = budgets;
    }

    public Double getCosts() {
        return costs;
    }

    public void setCosts(Double costs) {
        this.costs = costs;
    }

    public Double getIncomes() {
        return incomes;
    }

    public void setIncomes(Double incomes) {
        this.incomes = incomes;
    }

    public Double getDelays() {
        return delays;
    }

    public void setDelays(Double delays) {
        this.delays = delays;
    }

    public Double getInQuotas() {
        return inQuotas;
    }

    public void setInQuotas(Double inQuotas) {
        this.inQuotas = inQuotas;
    }

    public Double getUnQuotas() {
        return unQuotas;
    }

    public void setUnQuotas(Double unQuotas) {
        this.unQuotas = unQuotas;
    }

    public Double getInPayEnds() {
        return inPayEnds;
    }

    public void setInPayEnds(Double inPayEnds) {
        this.inPayEnds = inPayEnds;
    }

    public Double getUnPayEnds() {
        return unPayEnds;
    }

    public void setUnPayEnds(Double unPayEnds) {
        this.unPayEnds = unPayEnds;
    }

    public Customer getCustomer() { return customer; }

    public void setCustomer(Customer customer) { this.customer = customer; }

    @Override
    public String toString() {
        return "SalesBean{" +
                "budgets=" + budgets +
                ", costs=" + costs +
                ", incomes=" + incomes +
                ", delays=" + delays +
                ", inQuotas=" + inQuotas +
                ", unQuotas=" + unQuotas +
                ", inPayEnds=" + inPayEnds +
                ", unPayEnds=" + unPayEnds +
                ", customer=" + customer +
                '}';
    }
}
