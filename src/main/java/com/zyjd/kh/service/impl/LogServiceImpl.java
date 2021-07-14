package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.LogDao;
import com.zyjd.kh.model.Log;
import com.zyjd.kh.service.LogService;

@Service
@Transactional
public class LogServiceImpl implements LogService {

	@Resource
	private LogDao logDao;
	
	@Override
	public int add(Log log) {
		return logDao.add(log);
	}

	@Override
	public int update(Log obj) { return 0; }

	@Override
	public int delete(int id) {
		return logDao.delete(id);
	}

	@Override
	public Log findById(int id) {
		return logDao.findById(id);
	}

	@Override
	public List<Log> findAll() {
		return logDao.findAll();
	}

	@Override
	public List<Log> findByCondition(Log log) {
		return logDao.findByCondition(log);
	}

	@Override
	public List<Log> findByConditions(Log obj) { return logDao.findByConditions(obj); }

	@Override
	public List<Log> findByConditionPage(Log log) {
		return logDao.findByConditionPage(log);
	}
}
