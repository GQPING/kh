package com.zyjd.kh.util;

import java.util.HashMap;
import java.util.List;

/**
 * Layui工具类
 */
@SuppressWarnings("serial")
public class Layui extends HashMap<String, Object> {
    public static Layui data(Integer count,List<?> data){
        Layui r = new Layui();
        r.put("code", 200);// 状态量
        r.put("msg", "");// 回调消息
        r.put("count", count);// 数量合计
        r.put("data", data);// 数据
        return r;
    }   
}
