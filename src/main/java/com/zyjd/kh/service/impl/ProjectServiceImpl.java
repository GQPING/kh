package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import com.zyjd.kh.model.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.ProjectDao;
import com.zyjd.kh.service.ProjectService;

@Service
@Transactional
public class ProjectServiceImpl implements ProjectService {

	@Resource
	private ProjectDao projectDao;
	
	@Override
	public int add(Project project) {
		return projectDao.add(project);
	}

	@Override
	public int delete(int id) {
		return projectDao.delete(id);
	}

	@Override
	public int update(Project project) {
		return projectDao.update(project);
	}

	@Override
	public Project findById(int id) {
		return projectDao.findById(id);
	}

	@Override
	public List<Project> findAll() {
		return projectDao.findAll();
	}

	@Override
	public List<Project> findByCondition(Project project) { return projectDao.findByCondition(project); }

	@Override
	public List<Project> findByConditions(Project obj) { return projectDao.findByConditions(obj); }

	@Override
	public List<Project> findByConditionPage(Project project) { return projectDao.findByConditionPage(project); }

	@Override
	public Totals findTotalByCondition(Project project) { return projectDao.findTotalByCondition(project); }

	@Override
	public Project findByName(String projectNumber) {
		Project project = new Project();
		project.setProjectNumber(projectNumber);
		List<Project> projects = projectDao.findByConditions(project);
		if(projects!=null && !projects.isEmpty() && projects.size()==1){
			return projects.get(0);
		}
		return  null;
	}
}
