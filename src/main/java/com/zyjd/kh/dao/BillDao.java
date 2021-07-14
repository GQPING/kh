package com.zyjd.kh.dao;

import com.zyjd.kh.model.Bill;

/**
 * 开票数据接口
 */
public interface BillDao extends Base<Bill>{
	Double findBillByCondition(Bill bill);// 条件查询开票额
}
