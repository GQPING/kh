package com.zyjd.kh.service;

import com.zyjd.kh.dao.ProjectDao;
import com.zyjd.kh.model.Project;

public interface ProjectService extends ProjectDao {
    Project findByName(String projectNumber);
}
