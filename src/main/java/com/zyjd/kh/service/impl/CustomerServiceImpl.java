package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.CustomerDao;
import com.zyjd.kh.model.Customer;
import com.zyjd.kh.service.CustomerService;

@Service
@Transactional
public class CustomerServiceImpl implements CustomerService {
	
	@Resource
	private CustomerDao customerDao;

	@Override
	public int add(Customer customer) {
		return customerDao.add(customer);
	}

	@Override
	public int delete(int id) {
		return customerDao.delete(id);
	}
	
	@Override
	public int update(Customer customer) {
		return customerDao.update(customer);
	}
	
	@Override
	public Customer findById(int id) {
		return customerDao.findById(id);
	}

	@Override
	public List<Customer> findAll() {
		return customerDao.findAll();
	}

	@Override
	public List<Customer> findByCondition(Customer customer) {
		return customerDao.findByCondition(customer);
	}

	@Override
	public List<Customer> findByConditions(Customer obj) { return customerDao.findByConditions(obj); }

	@Override
	public List<Customer> findByConditionPage(Customer customer) {
		return customerDao.findByConditionPage(customer);
	}

	@Override
	public Integer findCountByCondition(Customer customer) { return customerDao.findCountByCondition(customer); }

	@Override
	public Customer findByName(String customerName) {
		Customer customer = new Customer();
		customer.setCustomerName(customerName);
		List<Customer> customers = customerDao.findByConditions(customer);
		if(customers!=null && !customers.isEmpty() && customers.size()==1){
			return customers.get(0);
		}
		return  null;
	}
}
