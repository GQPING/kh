package com.zyjd.kh.dao;

import com.zyjd.kh.model.Project;
import com.zyjd.kh.model.Totals;

/**
 * 项目数据接口
 */
public interface ProjectDao extends Base<Project>{
	Totals findTotalByCondition(Project project);//条件汇总查询
}
