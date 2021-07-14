package com.zyjd.kh.dao;

import com.zyjd.kh.model.Cashing;

/**
 * 收款数据接口
 */
public interface CashingDao extends Base<Cashing>{
	Double findCashByCondition(Cashing cashing);// 条件查询收款额
}
