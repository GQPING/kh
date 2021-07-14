package com.zyjd.kh.service;

import com.zyjd.kh.dao.CustomerDao;
import com.zyjd.kh.model.Customer;

public interface CustomerService extends CustomerDao {
    Customer findByName(String customerName);
}
