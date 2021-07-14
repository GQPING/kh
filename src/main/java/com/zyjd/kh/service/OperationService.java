package com.zyjd.kh.service;

import com.zyjd.kh.dao.OperationDao;
import com.zyjd.kh.model.Operation;

public interface OperationService extends OperationDao{
    Operation findByName(String operationName);
}
