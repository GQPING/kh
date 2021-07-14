package com.zyjd.kh.controller;

import com.zyjd.kh.model.Customer;
import com.zyjd.kh.util.FlowloadUtils;
import com.zyjd.kh.model.Log;
import com.zyjd.kh.util.Layui;
import com.zyjd.kh.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 日志控制器
 * 处理日志相关操作
 */
@Controller
@RequestMapping("/log")
public class LogController {

    @Autowired
    private LogService logService;

    // 列表界面
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String List() {
        return "log/list/logList";
    }

    // 列表查询(分页)
    @RequestMapping(value = "/searchList", method = RequestMethod.POST)
    @ResponseBody
    public Layui SearchList(@RequestBody Log log) {
        // 设置地址
        log.setStart((log.getPage() - 1) * log.getLimit());
        // 查询记录
        List<Log> alls = logService.findByCondition(log);
        // 当页记录
        List<Log> logs = logService.findByConditionPage(log);
        if (logs != null && !logs.isEmpty()) {
            return Layui.data(alls.size(), logs);
        }
        return Layui.data(0, null);
    }

    // 列表查询(不分页)
    @RequestMapping(value = "/searchAll", method = RequestMethod.POST)
    @ResponseBody
    public Layui SearchAll(@RequestBody Log log) {
        List<Log> alls = logService.findByCondition(log);
        if (alls != null && !alls.isEmpty()) {
            return Layui.data(alls.size(), alls);
        }
        return Layui.data(0, null);
    }

    // 获取列表
    @RequestMapping(value = "/getList", method = RequestMethod.POST)
    @ResponseBody
    public List<Log> GetList(@RequestBody Log log) {
        return logService.findByConditions(log);
    }

    // 删除操作
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public String Delete(@RequestParam(value = "id") Integer id) {
        try {
            if (logService.delete(id) > 0) {
                return "1";// 成功删除
            } else {
                return "0";// 语法异常
            }
        } catch (Exception e) {
            return "0";// 服务器异常
        }
    }
}
