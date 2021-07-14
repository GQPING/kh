package com.zyjd.kh.util;

import java.util.HashMap;
import java.util.List;

/**
 * 流加载工具类
 */
public class FlowloadUtils {
    public static HashMap<String, Object> buildResult(Integer pages,List<?> data) {
        HashMap<String, Object> result=new HashMap<>();
        result.put("code", 0);// 状态量
        result.put("msg","");// 回调消息
        result.put("pages", pages);// 页量
        result.put("data",data);// 数据
        return result;
    }
}
