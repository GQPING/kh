package com.zyjd.kh.util;

import org.joda.time.DateTime;
import org.joda.time.LocalDate;

import java.util.Date;

/**
 * 日志格式转化工具类
 */
public class DateUtils {
    // 年月日比较器
    public static boolean sameDate(Date dt1 , Date dt2 ) {
        if(dt1==null || dt2==null) {
            return false;
        }else{
            LocalDate ld1 = new LocalDate(new DateTime(dt1));
            LocalDate ld2 = new LocalDate(new DateTime(dt2));
            return ld1.equals(ld2)?false:true;
        }
    }
    // 年月日时分秒比较器
    public static boolean sameDateTime(Date dt1 , Date dt2 ) {
        if(dt1==null || dt2==null) {
            return false;
        }else {
            long ld1 = dt1.getTime();
            long ld2 = dt2.getTime();
            return ld1 == ld2?false:true;
        }
    }
}
