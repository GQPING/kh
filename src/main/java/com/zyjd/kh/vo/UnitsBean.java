package com.zyjd.kh.vo;

/**
 * 数量Bean
 */
public class UnitsBean {

	// 数量变量
	private Integer projects = 0;  // 项目
	private Integer inEnds = 0;    // 到期
	private Integer unEnds = 0;    // 未到期
	private Integer inPayEnds = 0; // 到期已结清
	private Integer unPayEnds = 0;  // 到期未结清

	public Integer getProjects() {
		return projects;
	}

	public void setProjects(Integer projects) {
		this.projects = projects;
	}

	public Integer getInEnds() {
		return inEnds;
	}

	public void setInEnds(Integer inEnds) {
		this.inEnds = inEnds;
	}

	public Integer getUnEnds() {
		return unEnds;
	}

	public void setUnEnds(Integer unEnds) {
		this.unEnds = unEnds;
	}

	public Integer getInPayEnds() {
		return inPayEnds;
	}

	public void setInPayEnds(Integer inPayEnds) {
		this.inPayEnds = inPayEnds;
	}

	public Integer getUnPayEnds() {
		return unPayEnds;
	}

	public void setUnPayEnds(Integer unPayEnds) {
		this.unPayEnds = unPayEnds;
	}

	@Override
	public String toString() {
		return "UnitsBean{" +
				"projects=" + projects +
				", inEnds=" + inEnds +
				", unEnds=" + unEnds +
				", inPayEnds=" + inPayEnds +
				", unPayEnds=" + unPayEnds +
				'}';
	}
}
