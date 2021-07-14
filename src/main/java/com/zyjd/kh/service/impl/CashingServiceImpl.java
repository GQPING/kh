package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.CashingDao;
import com.zyjd.kh.model.Cashing;
import com.zyjd.kh.service.CashingService;

@Service
@Transactional
public class CashingServiceImpl implements CashingService {

	@Resource
	private CashingDao cashingDao;

	@Override
	public int add(Cashing cashing) {
		return cashingDao.add(cashing);
	}

	@Override
	public int delete(int id) {
		return cashingDao.delete(id);
	}

	@Override
	public int update(Cashing cashing) {
		return cashingDao.update(cashing);
	}

	@Override
	public Cashing findById(int id) {
		return cashingDao.findById(id);
	}

	@Override
	public List<Cashing> findAll() {
		return cashingDao.findAll();
	}

	@Override
	public List<Cashing> findByCondition(Cashing cashing) {
		return cashingDao.findByCondition(cashing);
	}

	@Override
	public List<Cashing> findByConditions(Cashing obj) { return cashingDao.findByConditions(obj); }

	@Override
	public List<Cashing> findByConditionPage(Cashing cashing) {
		return cashingDao.findByConditionPage(cashing);
	}

	@Override
	public Double findCashByCondition(Cashing cashing) {
		return cashingDao.findCashByCondition(cashing);
	}
}
