package com.zyjd.kh.dao;

import java.util.List;
import com.zyjd.kh.model.Customer;

/**
 * 客户数据接口
 */
public interface CustomerDao extends Base<Customer>{
	Integer findCountByCondition(Customer customer);// 条件数量查询
}
