package com.zyjd.kh.util;

/**
 * 字符串工具类
 */
public class StringUtils {
    // 字符串比较器
    public static boolean ComparerString(String a,String b){
        if(a==null || b==null){
            return false;
        }else{
            return a.trim().equals(b.trim())?false:true;
        }
    }
}
