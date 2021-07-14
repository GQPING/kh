package com.zyjd.kh.util;

/**
 * 数字格式转化工具类
 */
public class DigitUtils {
    // 整数比较器
    public static boolean ComparerInteger(Integer a,Integer b){
        if(a==null || b==null){
            return false;
        }else{
            return a.equals(b)?false:true;
        }
    }
    // 浮点数比较器
    public static boolean ComparerDouble(Double a,Double b){
        if(a==null || b==null){
            return false;
        }else{
            return Double.doubleToLongBits(a) == Double.doubleToLongBits(b)?false:true;
        }
    }
}
