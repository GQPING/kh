package com.zyjd.kh.model;

public class Totals {

    private Integer projects = 0; // 项目

    private Double budgets = 0.0; // 预算

    private Double costs = 0.0;   // 成本

    private Double incomes = 0.0; // 收入

    private Double inQuotas = 0.0; // 回款

    private Double unQuotas = 0.0; // 余款

    private Double delayPays = 0.0; // 滞纳

    public Integer getProjects() {
        return projects;
    }

    public void setProjects(Integer projects) {
        this.projects = projects;
    }

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

    public Double getDelayPays() {
        return delayPays;
    }

    public void setDelayPays(Double delayPays) {
        this.delayPays = delayPays;
    }

    @Override
    public String toString() {
        return "Totals{" +
                "projects=" + projects +
                ", budgets=" + budgets +
                ", costs=" + costs +
                ", incomes=" + incomes +
                ", inQuotas=" + inQuotas +
                ", unQuotas=" + unQuotas +
                ", delayPays=" + delayPays +
                '}';
    }
}
