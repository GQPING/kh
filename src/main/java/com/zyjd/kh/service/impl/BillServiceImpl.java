package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.BillDao;
import com.zyjd.kh.model.Bill;
import com.zyjd.kh.service.BillService;

@Service
@Transactional
public class BillServiceImpl implements BillService {

	@Resource
	private BillDao billDao;
	
	@Override
	public int add(Bill bill) {
		return billDao.add(bill);
	}

	@Override
	public int delete(int id) {
		return billDao.delete(id);
	}

	@Override
	public int update(Bill bill) {
		return billDao.update(bill);
	}

	@Override
	public Bill findById(int id) {
		return billDao.findById(id);
	}

	@Override
	public List<Bill> findAll() {
		return billDao.findAll();
	}

	@Override
	public List<Bill> findByCondition(Bill bill) {
		return billDao.findByCondition(bill);
	}

	@Override
	public List<Bill> findByConditions(Bill obj) { return billDao.findByConditions(obj); }

	@Override
	public List<Bill> findByConditionPage(Bill bill) {
		return billDao.findByConditionPage(bill);
	}

	@Override
	public Double findBillByCondition(Bill bill) {
		return billDao.findBillByCondition(bill);
	}
}
