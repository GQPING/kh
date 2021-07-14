package com.zyjd.kh.model;

import java.util.Date;
import com.zyjd.kh.util.QcyConstants;

/*
 import java.sql.Timestamp;
1、Date()转timestamp：
    Timestamp t = new Timestamp((new Date()).getTime())
2、timestamp转Date()：
    Timestamp t = new Timestamp(System.currentTimeMillis());
    Date d = new Date(t.getTime());
*/

/**
 * 基础数据模型
 */
public class Base {

    // 搜索查询
    protected Integer searchInteger;// 搜索数值

    protected String searchString;// 搜索字符串

    // 区间查询
    protected Date timeStart;// 时间开始

    protected Date timeFinal;// 时间结束

    // 分页显示
    protected Integer page = QcyConstants.PAGE_DEFAULT_PAGE; // 当前页码

    protected Integer limit = QcyConstants.PAGE_DEFAULT_SIZE; // 每页数量

    protected Integer start = QcyConstants.PAGE_DEFAULT_START;// 开始地址

    // 特定条件
    protected Integer isYear;// 是否按年份查询

    protected Integer isMonth;// 是否按月份查询

    protected Integer isToday;// 是否按今日查询

    protected Integer isPayEnd;// 是否项目已付清区分：!='已付清' 或 == '已付清'

    protected Integer isDeadLine;// 是否项目到期查询

    protected Integer isFinished;// 是否项目已完工查询

    protected Integer isOrderDesc = 1;// 是否升序降序排序,默认为降序

    public Integer getSearchInteger() { return searchInteger; }

    public void setSearchInteger(Integer searchInteger) {
        this.searchInteger = searchInteger;
    }

    public String getSearchString() {
        return searchString;
    }

    public void setSearchString(String searchString) {
        this.searchString = searchString;
    }

    public Date getTimeStart() {
        return timeStart;
    }

    public void setTimeStart(Date timeStart) {
        this.timeStart = timeStart;
    }

    public Date getTimeFinal() {
        return timeFinal;
    }

    public void setTimeFinal(Date timeFinal) {
        this.timeFinal = timeFinal;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getIsToday() { return isToday; }

    public void setIsToday(Integer isToday) { this.isToday = isToday; }

    public Integer getIsMonth() { return isMonth; }

    public void setIsMonth(Integer isMonth) { this.isMonth = isMonth; }

    public Integer getIsPayEnd() { return isPayEnd; }

    public void setIsPayEnd(Integer isPayEnd) { this.isPayEnd = isPayEnd; }

    public Integer getIsDeadLine() { return isDeadLine; }

    public void setIsDeadLine(Integer isDeadLine) { this.isDeadLine = isDeadLine; }

    public Integer getIsYear() { return isYear; }

    public void setIsYear(Integer isYear) { this.isYear = isYear; }

    public Integer getIsFinished() { return isFinished; }

    public void setIsFinished(Integer isFinished) { this.isFinished = isFinished; }

    public Integer getIsOrderDesc() { return isOrderDesc; }

    public void setIsOrderDesc(Integer isOrderDesc) { this.isOrderDesc = isOrderDesc; }

    @Override
    public String toString() {
        return "Base{" +
                "searchInteger=" + searchInteger +
                ", searchString='" + searchString + '\'' +
                ", timeStart=" + timeStart +
                ", timeFinal=" + timeFinal +
                ", page=" + page +
                ", limit=" + limit +
                ", start=" + start +
                ", isYear=" + isYear +
                ", isMonth=" + isMonth +
                ", isToday=" + isToday +
                ", isPayEnd=" + isPayEnd +
                ", isDeadLine=" + isDeadLine +
                ", isFinished=" + isFinished +
                ", isOrderDesc=" + isOrderDesc +
                '}';
    }
}
