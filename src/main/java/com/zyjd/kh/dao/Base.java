package com.zyjd.kh.dao;

import java.util.List;

/**
 * 基础数据接口
 * @param <T>
 */
public interface Base <T>{
    int add(T obj);// 添加

    int update(T obj);// 修改

    int delete(int id);// 删除

    List<T> findAll();// 查询全部

    T findById(int id);// 查询指定

    List<T> findByCondition(T obj);// 模糊查询

    List<T> findByConditions(T obj);// 条件查询

    List<T> findByConditionPage(T obj);// 分页模糊查询
}
