package com.zyjd.kh.model;

/**
 * 操作数据模型
 */
public class Operation extends Base{

	private Integer id;// 主键，编号

	private String operateName;// 操作名称

	private String remarkDescription;// 操作备注

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOperateName() {
		return operateName;
	}

	public void setOperateName(String operateName) {
		this.operateName = operateName;
	}

	public String getRemarkDescription() {
		return remarkDescription;
	}

	public void setRemarkDescription(String remarkDescription) {
		this.remarkDescription = remarkDescription;
	}

	@Override
	public String toString() {
		return "Operation{" +
				"id=" + id +
				", operateName='" + operateName + '\'' +
				", remarkDescription='" + remarkDescription + '\'' +
				'}';
	}
}
