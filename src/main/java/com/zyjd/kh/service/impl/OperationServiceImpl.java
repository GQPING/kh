package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.OperationDao;
import com.zyjd.kh.model.Operation;
import com.zyjd.kh.service.OperationService;

@Service
@Transactional
public class OperationServiceImpl implements OperationService {

	@Resource
	private OperationDao operationDao;
	
	@Override
	public int add(Operation operation) {
		return operationDao.add(operation);
	}

	@Override
	public int delete(int id) {
		return operationDao.delete(id);
	}

	@Override
	public int update(Operation operation) {
		return operationDao.update(operation);
	}

	@Override
	public Operation findById(int id) {
		return operationDao.findById(id);
	}

	@Override
	public List<Operation> findAll() {
		return operationDao.findAll();
	}

	@Override
	public List<Operation> findByCondition(Operation operation) {
		return operationDao.findByCondition(operation);
	}

	@Override
	public List<Operation> findByConditions(Operation obj) { return operationDao.findByConditions(obj); }

	@Override
	public List<Operation> findByConditionPage(Operation operation) {
		return operationDao.findByConditionPage(operation);
	}

	@Override
	public Operation findByName(String operationName) {
		Operation operation = new Operation();
		operation.setOperateName(operationName);
		List<Operation> operations = operationDao.findByConditions(operation);
		if(operations!=null && !operations.isEmpty() && operations.size()==1){
			return operations.get(0);
		}
		return  null;
	}
}
