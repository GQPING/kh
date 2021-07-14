<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../other/meta.html" %>
    <%@include file="../../other/style.html" %>
    <style type="text/css">
        em.error {
            font-size: 8px;
            color: red;
        }
    </style>
</head>
<body>
<div>
    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span> 项目管理
        <span class="c-gray en">&gt;</span> 开荒项目管理
        <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);">
            <i class="Hui-iconfont">&#xe68f;</i>
        </a>
    </nav>
    <%@include file="../../other/seach.html" %>
    <%@include file="../../other/pops/edit/projectAdmin.html" %>
    <%@include file="../../other/pops/read/projectRecord.html" %>
</div>
<%@include file="../../other/tools.html" %>
<%@include file="../../other/cols/projectTableCols.html" %>
<%@include file="../../other/cols/projectRecordTableCols.html" %>
<%@include file="../../other/conjs.html" %>
<script type="text/javascript">
    // 面积、单价变化
    function PriceChange(){
        var projectType = $('#projectType').val();
        if(projectType=='全包'){
            // 与面积、单价没有关系
        } else {
            // 与面积、单价有关系
            var projectArea = $('#projectArea').val()==''?0.0:parseFloat($('#projectArea').val());// 面积
            var projectPrice = $('#projectPrice').val()==''?0.0:parseFloat($('#projectPrice').val());// 单价
            var projectDelay = $('#projectDelay').val()==''?0.0:parseFloat($('#projectDelay').val());// 滞纳金
            var projectCost = $('#projectCost').val()==''?0.0:parseFloat($('#projectCost').val());// 预算
            var projectInQuota = $('#projectInQuota').val()==''?0.0:parseFloat($('#projectInQuota').val());// 回款
            var projectBadQuota = $('#projectBadQuota').val()==''?0.0:parseFloat($('#projectBadQuota').val());// 坏账
            if(projectArea!='' && projectPrice!='') {
                var total = projectArea * projectPrice + projectDelay;// 应收 = 面积*单价 + 滞纳金
                var unQuota = total - projectInQuota - projectBadQuota;// 余款 = 应收 - 回款 - 坏账
                var income = total - projectCost - projectBadQuota;// 收入 = 应收 - 预算 -坏账
                // 应收
                $("#projectBudget").val(total);
                // 收入
                $("#projectIncome").val(income);
                // 余款
                $("#projectUnQuota").val(unQuota);
                // 状态
                if(unQuota <= 0) {
                    $("#projectPayState").val('已付清');
                } else {
                    var date = $("#deadLineDate").val();
                    if(date!=""){
                        var cur = new Date(Date.parse(layui.util.toDateString(new Date(), 'yyyy-MM-dd')));
                        //var end = new Date(Date.parse(layui.util.toDateString(date, 'yyyy-MM-dd')));
                        var end = new Date(Date.parse(date));
                        var t1 = cur.getTime();
                        var t2 = end.getTime();
                        if(t2 < t1){// 截止日期小于当前日期，拖欠中
                            $("#projectPayState").val('拖欠中');
                        }else{
                            $("#projectPayState").val('未付清');
                        }
                    }else{
                        $("#projectPayState").val('未付清');
                    }
                }
            }else{
                $("#projectBudget").val(0);// 应收
                $("#projectIncome").val(0);// 收入
                $("#projectUnQuota").val(0);// 余款
                $("#projectPayState").val('未付清');// 状态
            }
        }
    }
    // 滞纳变化
    function DelayChange(){
        var projectDelay = $('#projectDelay').val()==''?0.0:parseFloat($('#projectDelay').val());// 滞纳金
        var projectArea = $('#projectArea').val()==''?0.0:parseFloat($('#projectArea').val());// 面积
        var projectPrice = $('#projectPrice').val()==''?0.0:parseFloat($('#projectPrice').val());// 单价
        var projectBudget = $('#projectBudget').val()==''?0.0:parseFloat($('#projectBudget').val());// 应收
        var projectCost = $('#projectCost').val()==''?0.0:parseFloat($('#projectCost').val());// 预算
        var projectInQuota = $('#projectInQuota').val()==''?0.0:parseFloat($('#projectInQuota').val());// 回款
        var projectBadQuota = $('#projectBadQuota').val()==''?0.0:parseFloat($('#projectBadQuota').val());// 坏账
        // 同步数据
        var total = projectArea * projectPrice + projectDelay;// 应收 = 面积*单价 + 滞纳金
        var unQuota = total - projectInQuota - projectBadQuota;// 余款 = 应收 - 回款 - 坏账
        var income = total - projectCost - projectBadQuota;// 收入 = 应收 - 预算 -坏账
        // 应收
        $("#projectBudget").val(total);
        // 收入
        $("#projectIncome").val(income);
        // 余款
        $("#projectUnQuota").val(unQuota);
        // 状态
        if (unQuota <= 0) {
            $("#projectPayState").val('已付清');
        } else {
            var date = $("#deadLineDate").val();
            if (date != "") {
                var cur = new Date(Date.parse(layui.util.toDateString(new Date(), 'yyyy-MM-dd')));
                //var end = new Date(Date.parse(layui.util.toDateString(date, 'yyyy-MM-dd')));
                var end = new Date(Date.parse(date));
                var t1 = cur.getTime();
                var t2 = end.getTime();
                if(t2 < t1){// 截止日期小于当前日期，拖欠中
                    $("#projectPayState").val('拖欠中');
                }else{
                    $("#projectPayState").val('未付清');
                }
            } else {
                $("#projectPayState").val('未付清');
            }
        }
    }
    // 应收变化
    function BudgetChange(){
        var projectBudget = $('#projectBudget').val()==''?0.0:parseFloat($('#projectBudget').val());// 应收
        var projectDelay = $('#projectDelay').val()==''?0.0:parseFloat($('#projectDelay').val());// 滞纳金
        var projectCost = $('#projectCost').val()==''?0.0:parseFloat($('#projectCost').val());// 预算
        var projectInQuota = $('#projectInQuota').val()==''?0.0:parseFloat($('#projectInQuota').val());// 回款
        var projectBadQuota = $('#projectBadQuota').val()==''?0.0:parseFloat($('#projectBadQuota').val());// 坏账
        // 同步数据
        var unQuota = projectBudget - projectInQuota - projectBadQuota;// 余款 = 应收 - 回款 - 坏账
        var income = projectBudget - projectCost - projectBadQuota;// 收入 = 应收 - 预算 -坏账
        // 收入
        $("#projectIncome").val(income);
        // 余款
        $("#projectUnQuota").val(unQuota);
        // 状态
        if (unQuota <= 0) {//原先此处==0，扩大范围，<=0
            $("#projectPayState").val('已付清');
        } else {
            var date = $("#deadLineDate").val();
            if (date != "") {
                var cur = new Date(Date.parse(layui.util.toDateString(new Date(), 'yyyy-MM-dd')));
                //var end = new Date(Date.parse(layui.util.toDateString(date, 'yyyy-MM-dd')));
                var end = new Date(Date.parse(date));
                var t1 = cur.getTime();
                var t2 = end.getTime();
                if(t2 < t1){// 截止日期小于当前日期，拖欠中
                    $("#projectPayState").val('拖欠中');
                }else{
                    $("#projectPayState").val('未付清');
                }
            } else {
                $("#projectPayState").val('未付清');
            }
        }
    }
    // 预算变化
    function CostChange(){
        var projectCost = $('#projectCost').val()==''?0.0:parseFloat($('#projectCost').val());// 预算
        var projectDelay = $('#projectDelay').val()==''?0.0:parseFloat($('#projectDelay').val());// 滞纳金
        var projectBudget = $('#projectBudget').val()==''?0.0:parseFloat($('#projectBudget').val());// 应收
        var projectBadQuota = $('#projectBadQuota').val()==''?0.0:parseFloat($('#projectBadQuota').val());// 坏账
        // 同步数据
        var income = projectBudget - projectCost - projectBadQuota;// 收入 = 应收 - 预算 -坏账
        // 收入
        $("#projectIncome").val(income);
    }
    // 坏账变化
    function BadQuotaChange(){
        var projectBadQuota = $('#projectBadQuota').val()==''?0.0:parseFloat($('#projectBadQuota').val());// 坏账
        var projectArea = $('#projectArea').val()==''?0.0:parseFloat($('#projectArea').val());// 面积
        var projectPrice = $('#projectPrice').val()==''?0.0:parseFloat($('#projectPrice').val());// 单价
        var projectDelay = $('#projectDelay').val()==''?0.0:parseFloat($('#projectDelay').val());// 滞纳金
        var projectBudget = $('#projectBudget').val()==''?0.0:parseFloat($('#projectBudget').val());// 应收
        var projectCost = $('#projectCost').val()==''?0.0:parseFloat($('#projectCost').val());// 预算
        var projectInQuota = $('#projectInQuota').val()==''?0.0:parseFloat($('#projectInQuota').val());// 回款
        // 同步数据
        var total = projectArea * projectPrice + projectDelay;// 应收 = 面积*单价 + 滞纳金
        var unQuota = total - projectInQuota - projectBadQuota;// 余款 = 应收 - 回款 - 坏账
        var income = total - projectCost - projectBadQuota;// 收入 = 应收 - 预算 -坏账
        // 应收
        $("#projectBudget").val(total);
        // 收入
        $("#projectIncome").val(income);
        // 余款
        $("#projectUnQuota").val(unQuota);
        // 状态
        if (unQuota <= 0) {
            $("#projectPayState").val('已付清');
        } else {
            var date = $("#deadLineDate").val();
            if (date != "") {
                var cur = new Date(Date.parse(layui.util.toDateString(new Date(), 'yyyy-MM-dd')));
                //var end = new Date(Date.parse(layui.util.toDateString(date, 'yyyy-MM-dd')));
                var end = new Date(Date.parse(date));
                var t1 = cur.getTime();
                var t2 = end.getTime();
                if(t2 < t1){// 截止日期小于当前日期，拖欠中
                    $("#projectPayState").val('拖欠中');
                }else{
                    $("#projectPayState").val('未付清');
                }
            } else {
                $("#projectPayState").val('未付清');
            }
        }
    }
    // lay加载
    layui.use(['form', 'table', 'laydate','element'], function () {
        let form = layui.form;
        let table = layui.table;
        let laydate = layui.laydate;
        let element = layui.element;
        laydate.render({
            elem: '#billDate' //指定元素
        });
        laydate.render({
            elem: '#payDate' //指定元素
        });
        laydate.render({
            elem: '#signDate',
            done: function (value, date) {
                let time2 = new Date(Date.parse(value));
                let deadLineDate = $("#deadLineDate").val();
                if(deadLineDate!=""){
                    let time1 = new Date(Date.parse(deadLineDate));
                    if(time1<time2){
                        layer.msg('截止日期不正确！', {icon: 5, time: 1000, anim: 6});
                        $("#deadLineDate").val('');
                    }
                }
            }
        });
        laydate.render({
            elem: '#deadLineDate',
            done: function (value, date) {
                let time1 = new Date(Date.parse(value));
                let signDate = $("#signDate").val();
                if(signDate!=""){
                    let time2 = new Date(Date.parse(signDate));
                    if(time1<time2){
                        layer.msg('截止日期不正确！', {icon: 5, time: 1000, anim: 6});
                        $("#deadLineDate").val('');
                    }
                }
                let startDate = $("#projectStartDate").val();
                if(startDate!=''){
                    let time2 = new Date(Date.parse(startDate));
                    if(time1<time2){
                        layer.msg('截止日期不正确！', {icon: 5, time: 1000, anim: 6});
                        $("#deadLineDate").val('');
                    }
                }
                let finalDate = $("#deadLineDate").val();
                if(finalDate!=''){
                    let time2 = new Date(Date.parse(finalDate));
                    if(time1<time2){
                        layer.msg('截止日期不正确！', {icon: 5, time: 1000, anim: 6});
                        $("#deadLineDate").val('');
                    }
                }
                if($("#deadLineDate").val()!='') {
                    var bk = $("#projectUnQuota").val();
                    var state = $("#projectPayState").val();
                    if(parseFloat(bk)<=0){
                        state = '已付清';
                    }else{
                        var cur = new Date(Date.parse(layui.util.toDateString(new Date(), 'yyyy-MM-dd')));
                        var end = new Date(Date.parse($("#deadLineDate").val()));
                        var t1 = cur.getTime();
                        var t2 = end.getTime();
                        if(t2 < t1){// 截止日期小于当前日期，拖欠中
                            state = '拖欠中';
                        }else{
                            state = '未付清';
                        }
                    }
                    $("#projectPayState").val(state);
                }
            }
        });
        let dateEntryStart = laydate.render({
            elem: '#timeStart',
            trigger: 'click',
            done: function (value, date) {
                dateEntryEnd.config.min = {
                    year: date.year,
                    month: date.month - 1,
                    date: date.date,
                    hours: date.hours,
                    minutes: date.minutes,
                    seconds: date.seconds
                };
                dateEntryEnd.config.value = value;
            }
        });
        let dateEntryEnd = laydate.render({
            elem: '#timeFinal',
            trigger: 'click',//  触发方式
            done: function (value, date) {// 选择完成回调
                dateEntryStart.config.max = {
                    year: date.year,
                    month: date.month - 1,
                    date: date.date,
                    hours: date.hours,
                    minutes: date.minutes,
                    seconds: date.seconds
                };
                dateEntryStart.config.value = value;
            }
        });
        let dateEntryStart2 = laydate.render({
            elem: '#projectStartDate',
            trigger: 'click',
            done: function (value, date) {
                dateEntryEnd2.config.min = {
                    year: date.year,
                    month: date.month - 1,
                    date: date.date,
                    hours: date.hours,
                    minutes: date.minutes,
                    seconds: date.seconds
                };
                dateEntryEnd2.config.value = value;
                let finalDate = $("#projectFinalDate").val();
                let startDate = $("#projectStartDate").val();
                if(finalDate!='' && startDate!=''){
                    let time1 = new Date(Date.parse(startDate));
                    let time2 = new Date(Date.parse(finalDate));
                    let t1 = time1.getTime();
                    let t2 = time2.getTime();
                    let datetime=1000*60*60*24;
                    let minusDays = Math.floor(((t2-t1)/datetime));
                    document.getElementById("projectCycle").value=minusDays;
                }else{
                    document.getElementById("projectCycle").value = 0;
                }
                let time2 = new Date(Date.parse(value));
                let deadLineDate = $("#deadLineDate").val();
                if(deadLineDate!=""){
                    let time1 = new Date(Date.parse(deadLineDate));
                    if(time1<time2){
                        layer.msg('截止日期不正确！', {icon: 5, time: 1000, anim: 6});
                        $("#deadLineDate").val('');
                    }
                }
            }
        });
        let dateEntryEnd2 = laydate.render({
            elem: '#projectFinalDate',
            trigger: 'click',//  触发方式
            done: function (value, date) {// 选择完成回调
                dateEntryStart2.config.max = {
                    year: date.year,
                    month: date.month - 1,
                    date: date.date,
                    hours: date.hours,
                    minutes: date.minutes,
                    seconds: date.seconds
                };
                dateEntryStart2.config.value = value;
                let finalDate = $("#projectFinalDate").val();
                let startDate = $("#projectStartDate").val();
                if(finalDate!='' && startDate!=''){
                    let time1 = new Date(Date.parse(startDate));
                    let time2 = new Date(Date.parse(finalDate));
                    let t1 = time1.getTime();
                    let t2 = time2.getTime();
                    let datetime=1000*60*60*24;
                    let minusDays = Math.floor(((t2-t1)/datetime));
                    document.getElementById("projectCycle").value=minusDays;
                }else{
                    document.getElementById("projectCycle").value = 0;
                }
                let time2 = new Date(Date.parse(value));
                let deadLineDate = $("#deadLineDate").val();
                if(deadLineDate!=""){
                    let time1 = new Date(Date.parse(deadLineDate));
                    if(time1<time2){
                        layer.msg('截止日期不正确！', {icon: 5, time: 1000, anim: 6});
                        $("#deadLineDate").val('');
                    }
                }
            }
        });
        // 初始化表格
        table.render({
            elem: '#LAY_table_user' // 指定表格
            , id: 'projectAdminReload'
            , url: '${pageContext.request.contextPath}/project/searchAdmin' //数据请求路径
            , method: 'post'
            , contentType: "application/json;charset=UTF-8"
            , where: {}
            , even: true // 开启隔行换色
            //, height: 'full-180' // 最大化适应表格高度
            , size: 'lg' //sm小尺寸的表格 lg大尺寸
            , cellMinWidth: 150 // 表格单元格最小宽度
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , totalRow: true // 开启合计行
            , cols: [[
                {type: 'radio', totalRowText: '合计'}
                , {
                    field: 'signDate',
                    unresize:true,
                    width: 110,
                    title: '签订日期',
                    hide:true,
                    sort: true,
                    align: 'center',
                    templet: "#signDateTpl"
                }
                , {
                    field: 'projectNumber',
                    unresize:true,
                    title: '项目编号',
                    hide:true,
                    align: 'center',
                    templet: '#projectNumberTpl'
                }
                , {
                    field: 'customerName',
                    unresize:true,
                    title: '项目客户',
                    hide:true,
                    align: 'center',
                    templet: '#customerNameTpl'
                }
                , {
                    field: 'projectName',
                    unresize:true,
                    title: '项目名称',
                    align: 'center',
                    toolbar: '#projectNameTpl'
                }
                , {
                    field: 'projectType',
                    unresize:true,
                    width: 90,
                    hide: true,
                    title: '项目类型',
                    align: 'center',
                    templet: '#projectTypeTpl'
                }
                , {
                    field: 'projectAddress',
                    unresize:true,
                    minWidth: 200,
                    title: '项目地址',
                    align: 'center',
                    templet: "#projectAddressTpl"
                }
                , {
                    field: 'projectDescription',
                    unresize:true,
                    minWidth: 300,
                    title: '项目概况',
                    hide:true,
                    align: 'center',
                    templet: "#projectDescriptionTpl"
                }
                , {
                    field: 'projectPerson',
                    unresize:true,
                    width: 120,
                    title: '项目负责人',
                    hide:true,
                    align: 'center',
                    templet: '#projectPersonTpl'
                }
                , {
                    field: 'projectDate',
                    unresize:true,
                    width: 210,
                    title: '项目日期',
                    align: 'center',
                    templet: "#projectDateTpl"
                }
                , {
                    field: 'projectCycle',
                    unresize:true,
                    width: 110,
                    title: '项目周期',
                    hide:true,
                    align: 'center',
                    templet: "#projectCycleTpl"
                }
                , {
                    field: 'projectPrice',
                    unresize:true,
                    width: 90,
                    title: '单价',
                    align: 'center',
                    templet: "#projectPriceTpl"
                }
                , {
                    field: 'projectArea',
                    unresize:true,
                    width: 110,
                    title: '面积',
                    align: 'center',
                    templet: "#projectAreaTpl"
                }
                , {
                    field: 'projectDelay',
                    unresize:true,
                    width: 110,
                    title: '滞纳金',
                    hide:true,
                    align: 'center',
                    templet: "#projectDelayTpl",
                    totalRow: true
                }
                , {
                    field: 'projectBudget',
                    unresize:true,
                    width: 110,
                    title: '应收款项',
                    align: 'center',
                    templet: '#projectBudgetTpl',
                    totalRow: true
                }
                , {
                    field: 'projectCost',
                    unresize:true,
                    width: 110,
                    title: '预算',
                    hide:true,
                    align: 'center',
                    templet: "#projectCostTpl",
                    totalRow: true
                }
                , {
                    field: 'projectIncome',
                    unresize:true,
                    width: 110,
                    title: '收入',
                    hide:true,
                    align: 'center',
                    templet: "#projectIncomeTpl",
                    totalRow: true
                }
                , {
                    field: 'projectInQuota',
                    unresize:true,
                    width: 110,
                    title: '回款',
                    align: 'center',
                    templet: "#projectInQuotaTpl",
                    totalRow: true
                }
                , {
                    field: 'projectBadQuota',
                    unresize:true,
                    width: 110,
                    title: '坏账',
                    align: 'center',
                    templet: "#projectBadQuotaTpl",
                    totalRow: true
                }
                , {
                    field: 'projectUnQuota',
                    unresize:true,
                    width: 110,
                    title: '余款',
                    align: 'center',
                    templet: "#projectUnQuotaTpl",
                    totalRow: true
                }
                , {
                    field: 'projectPayState',
                    unresize:true,
                    width: 90,
                    title: '回款状态',
                    align: 'center',
                    templet: '#projectPayStateTpl'
                }
                , {
                    field: 'deadLineDate',
                    unresize:true,
                    width: 110,
                    title: '截止日期',
                    align: 'center',
                    templet: "#deadLineDateTpl"
                }
                , {
                    field: 'projectState',
                    unresize:true,
                    width: 130,
                    title: '截止状态',
                    align: 'center',
                    templet: '#projectStateTpl'
                }
                , {
                    field: 'hasBill',
                    unresize:true,
                    width: 110,
                    title: '是否开票',
                    align: 'center',
                    templet: '#hasBillTpl'
                }
                , {
                    field: 'remarkDescription',
                    unresize:true,
                    title: '备注',
                    hide:true,
                    align: 'center',
                    templet: '#remarkDescriptionTpl'
                }
            ]]
            , page: true  //开启分页
            , limit: 10   //默认十条数据一页
            , limits: [5, 10, 15, 20, 25, 30] //数据分页条
            , response: {
                statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
            }
        });
        //监听行工具事件
        table.on('tool(user)', function(obj){
            var dataRow = obj.data;
            switch (obj.event) {
                case "prlook":
                    //弹出框开始
                    var _funbtnxs = {
                        yesxs1: function (index, layero) {
                            layer.close(index);
                        }, xs2: function (index, layero) {
                            layer.close(index);
                        }, success: function (layero) {
                            $("#customerIDLabel").text(dataRow.customer.customerName);
                            $("#signDateLabel").text(layui.util.toDateString(dataRow.signDate, 'yyyy-MM-dd'));
                            $("#projectNumberLabel").text(dataRow.projectNumber);
                            $("#projectTypeLabel").text(dataRow.projectType);
                            $("#projectNameLabel").text(dataRow.projectName);
                            $("#projectNameTitle").text(dataRow.projectName);
                            $("#projectAddressLabel").text(dataRow.projectAddress);
                            $("#projectDescriptionLabel").text(dataRow.projectDescription);
                            $("#projectPersonLabel").text(dataRow.projectPerson);
                            $("#projectStartDateLabel").text(layui.util.toDateString(dataRow.projectStartDate, 'yyyy-MM-dd'));
                            $("#projectFinalDateLabel").text(layui.util.toDateString(dataRow.projectFinalDate, 'yyyy-MM-dd'));
                            $("#projectCycleLabel").text(dataRow.projectCycle+"天");
                            $("#projectPriceLabel").text(dataRow.projectPrice+"元");
                            $("#projectAreaLabel").text(dataRow.projectArea+"m²");
                            $("#projectBudgetLabel").text(dataRow.projectBudget+"元");
                            $("#projectCostLabel").text(dataRow.projectCost+"元");
                            $("#projectIncomeLabel").text(dataRow.projectIncome+"元");
                            $("#projectInQuotaLabel").text(dataRow.projectInQuota+"元");
                            $("#projectBadQuotaLabel").text(dataRow.projectBadQuota+"元");
                            $("#projectUnQuotaLabel").text(dataRow.projectUnQuota+"元");
                            $("#deadLineDateLabel").text(layui.util.toDateString(dataRow.deadLineDate, 'yyyy-MM-dd'));
                            $("#projectDelayLabel").text(dataRow.projectDelay+"元");
                            $("#projectPayStateLabel").text(dataRow.projectPayState);
                            $("#remarkDescriptionLabel").text(dataRow.remarkDescription);
                            $("#projectRemindDaysLabel").text(dataRow.projectRemindDays+"天到期提醒");
                            $("#hasBillLabel").text(dataRow.hasBill==1?'已开票':'未开票');
                            $.ajax({
                                url: '${pageContext.request.contextPath }/contact/search',
                                method: 'post',
                                data: JSON.stringify({projectID:dataRow.id}),
                                contentType: "application/json;charset=UTF-8",
                                dataType: "json",
                                success: function (data) {
                                    var oj = eval(data);
                                    $("#contactNameLabel").text(oj.contactName);
                                    $("#contactPhoneLabel").text(oj.contactPhone);
                                }, error: function (data) {
                                    $("#contactNameLabel").text('');
                                    $("#contactPhoneLabel").text('');
                                }
                            });
                            var i = 6;  // 默认切换收款记录
                            element.tabChange('recordTab', i);
                            inittable1('LAY_table_user' + i, 'user' + i, dataRow.id);
                            // 监听Tab切换状态
                            element.on('tab(recordTab)', function () {
                                i = this.getAttribute('lay-id');
                                if (i == 6) {
                                    inittable1('LAY_table_user' + i, 'user' + i, dataRow.id);
                                } else if (i == 7) {
                                    inittable2('LAY_table_user' + i, 'user' + i, dataRow.id);
                                } else if (i == 8) {
                                    inittable3('LAY_table_user' + i, 'user' + i, dataRow.id);
                                }
                            });
                        }
                    }
                    tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe695;</i> 项目详情<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+dataRow.projectName+'</div>', ['80%', '80%'], 'userbj', $("#bjnrRecord"), ['关闭'], _funbtnxs);
                    break;
            }
        });
        // 头工具栏事件
        table.on('toolbar(user)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
            var isType = true;// 按平方类型，还是全包类型
            switch (obj.event) {
                // 新增
                case 'create':
                    DelReadonly("contactName",'1','');
                    SetReadonly("projectCycle",'1','');
                    SetReadonly("projectBudget",'1','');
                    SetReadonly("projectIncome",'1','');
                    SetReadonly("projectInQuota",'1','');
                    SetReadonly("projectUnQuota",'1','');
                    SetReadonly("projectPayState",'1','');
                    //弹出框开始
                    var _funbtnxs = {
                        yesxs1: function (index, layero) {
                            var projectNumber = $("#projectNumber").val().trim();
                            if (projectNumber == "") {
                                layer.msg('请输入项目编号', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            //编号规则验证
                            var reg = /^[a-zA-Z]([a-zA-Z0-9]{6,16})$/;
                            if (!reg.test(projectNumber)) {
                                layer.msg('项目编号只能由字母和数字组成,且以字母开头,6<=长度<=16', {icon: 5, time: 3000, anim: 6});
                                return;
                            }
                            var projectName = $("#projectName").val().trim();
                            if (projectName == "") {
                                layer.msg('请输入项目名称', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectAddress = $("#projectAddress").val().trim();
                            if (projectAddress == "") {
                                layer.msg('请输入项目地址', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var signDate = $("#signDate").val().trim();
                            if (signDate == "") {
                                layer.msg('请选择签订日期', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectType = $("#projectType").val().trim();
                            if (projectType == "") {
                                layer.msg('请选择项目类型', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var customerID = $("#customerID").val().trim();
                            if (customerID == "") {
                                layer.msg('请选择项目客户', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var contactName = $("#contactName").val().trim();
                            /*if (contactName == "") {
                                layer.msg('请输入项目联系人', {icon: 0, time: 1000, anim: 6});
                                return;
                            }*/
                            var contactPhone = $("#contactPhone").val().trim();
                            /*if (contactPhone == "") {
                                layer.msg('请输入联系方式', {icon: 0, time: 1000, anim: 6});
                                return;
                            }*/
                            var projectPerson = $("#projectPerson").val().trim();
                            /*if (projectPerson == "") {
                                layer.msg('请输入项目负责人', {icon: 0, time: 1000, anim: 6});
                                return;
                            }*/
                            var projectDescription = $("#projectDescription").val().trim();
                            var projectStartDate = $("#projectStartDate").val().trim();
                            if (projectStartDate == "") {
                                layer.msg('请选择进场日期', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectFinalDate = $("#projectFinalDate").val().trim();
                            if (projectFinalDate == "") {
                                layer.msg('请选择完工日期', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectCycle = $("#projectCycle").val().trim();
                            var deadLineDate = $("#deadLineDate").val().trim();
                            if (deadLineDate == "") {
                                layer.msg('请选择付款截止日期', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectRemindDays = $("#projectRemindDays").val().trim();
                            if (projectRemindDays == "") {
                                layer.msg('请选择到期提醒天数', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectArea = $("#projectArea").val().trim();
                            var projectPrice = $("#projectPrice").val().trim();
                            var projectBudget = $("#projectBudget").val().trim();
                            if (isType) {// 按平方
                                if (projectArea == "") {
                                    layer.msg('请输入开荒面积', {icon: 0, time: 1000, anim: 6});
                                    return;
                                }
                                if (projectPrice == "") {
                                    layer.msg('请输入单价', {icon: 0, time: 1000, anim: 6});
                                    return;
                                }
                            } else {// 全包
                                projectArea = projectArea==""?0:projectArea;
                                projectPrice = projectPrice==""?0:projectPrice;
                                if (projectBudget == "") {
                                    layer.msg('请输入应收款项', {icon: 0, time: 1000, anim: 6});
                                    return;
                                }
                            }
                            var projectCost = $("#projectCost").val().trim().trim();
                            if (projectCost == "") {
                                layer.msg('请输入预算', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectDelay = $("#projectDelay").val().trim();
                            if (projectDelay == "") {
                                layer.msg('请输入滞纳金', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectIncome = $("#projectIncome").val().trim();
                            var projectInQuota = $("#projectInQuota").val().trim();
                            var projectBadQuota = $("#projectBadQuota").val().trim();
                            if (projectBadQuota == "") {
                                layer.msg('请输入坏账', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectUnQuota = $("#projectUnQuota").val().trim();
                            var projectPayState = $("#projectPayState").val().trim();
                            var remarkDescription = $("#remarkDescription").val().trim();
                            // 提交
                            $.ajax({
                                type: 'post',
                                url: '${pageContext.request.contextPath}/project/add?contactName='+contactName+'&contactPhone='+contactPhone,
                                data: JSON.stringify({
                                    projectNumber: projectNumber.toUpperCase(),
                                    projectName:projectName,
                                    projectAddress: projectAddress,
                                    signDate: signDate,
                                    projectType:projectType,
                                    customerID: customerID,
                                    projectPerson: projectPerson,
                                    projectDescription: projectDescription,
                                    projectStartDate: projectStartDate,
                                    projectFinalDate: projectFinalDate,
                                    projectCycle:projectCycle,
                                    deadLineDate:deadLineDate,
                                    projectRemindDays:projectRemindDays,
                                    projectArea:projectArea,
                                    projectPrice: projectPrice,
                                    projectBudget:projectBudget,
                                    projectCost: projectCost,
                                    projectDelay:projectDelay,
                                    projectIncome:projectIncome,
                                    projectBadQuota:projectBadQuota,
                                    projectInQuota:projectInQuota,
                                    projectUnQuota:projectUnQuota,
                                    projectPayState:projectPayState,
                                    remarkDescription: remarkDescription
                                }),
                                contentType: "application/json;charset=UTF-8",
                                dataType: "json",
                                success: function (data) {
                                    if (data == "1") {
                                        layer.msg('添加成功!', {icon: 1, time: 1000});
                                    } else {
                                        layer.msg('添加失败!', {icon: 5, time: 1000, anim: 6});
                                    }
                                },
                                error: function (data) {
                                    layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
                                }
                            });
                        }
                        , xs2: function (index, layero) {
                            layer.close(index);
                        }, success: function (layero) {
                            $("#customerID").val('');
                            $("#signDate").val('');
                            $("#projectNumber").val('');
                            $("#projectType").val('按平方');
                            $("#projectName").val('');
                            $("#projectAddress").val('');
                            $("#projectDescription").val('');
                            $("#projectPerson").val('');
                            $("#projectStartDate").val('');
                            $("#projectFinalDate").val('');
                            $("#projectCycle").val(0);
                            $("#projectPrice").val(0);
                            $("#projectArea").val(0);
                            $("#projectBudget").val(0);
                            $("#projectCost").val(0);
                            $("#projectIncome").val(0);
                            $("#projectInQuota").val(0);
                            $("#projectBadQuota").val(0);
                            $("#projectUnQuota").val(0);
                            $("#deadLineDate").val('');
                            $("#projectDelay").val(0);
                            $("#projectPayState").val('');
                            $("#remarkDescription").val('');
                            $("#projectRemindDays").val(7);
                            $("#contactName").val('');
                            $("#contactPhone").val('');
                            form.render('select');
                        }
                    }
                    tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe604;</i> 新增项目</div>', ['100%', '100%'], 'userbj', $("#bjnrEdit"), ['确定','关闭'], _funbtnxs);
                    // 项目类型下拉框值改变动态设置样式
                    form.on('select(projectType)', function (data) {
                        var text = $("#projectType option:selected").text();
                        if (text.indexOf("全包") >= 0) {
                            DelReadonly("projectBudget",'1','');
                            isType = false;
                        } else {
                            SetReadonly("projectBudget",'1','');
                            isType = true;
                        }
                        form.render('select','projectType');
                    });
                    break;
                // 修改车辆
                case 'update':
                    var dataRow = checkStatus.data;  //获取选中行数据
                    if (dataRow.length == 0) {
                        layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
                        return;
                    }
                    SetReadonly("contactName",'1','');
                    if(dataRow[0].projectType=="全包"){
                        DelReadonly("projectBudget",'1','');// 可编辑
                    } else if(dataRow[0].projectType=="按平方"){
                        SetReadonly("projectBudget",'1','');// 不可编辑
                    }
                    SetReadonly("projectCycle",'1','');
                    SetReadonly("projectIncome",'1','');
                    SetReadonly("projectInQuota",'1','');
                    SetReadonly("projectUnQuota",'1','');
                    SetReadonly("projectPayState",'1','');
                    //弹出框开始
                    var _funbtnxs = {
                        yesxs1: function (index, layero) {
                            var id = dataRow[0].id;// 选中项目id
                            var projectNumber = $("#projectNumber").val().trim();
                            if (projectNumber == "") {
                                layer.msg('请输入项目编号', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            //编号规则验证
                            var reg = /^[a-zA-Z]([a-zA-Z0-9]{6,16})$/;
                            if (!reg.test(projectNumber)) {
                                layer.msg('项目编号只能由字母和数字组成,且以字母开头,6<=长度<=16', {icon: 5, time: 3000, anim: 6});
                                return;
                            }
                            var projectName = $("#projectName").val().trim().trim();
                            if (projectName == "") {
                                layer.msg('请输入项目名称', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectAddress = $("#projectAddress").val().trim();
                            if (projectAddress == "") {
                                layer.msg('请输入项目地址', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var signDate = $("#signDate").val().trim();
                            if (signDate == "") {
                                layer.msg('请选择签订日期', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectType = $("#projectType").val().trim();
                            if (projectType == "") {
                                layer.msg('请选择项目类型', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var customerID = $("#customerID").val().trim();
                            if (customerID == "") {
                                layer.msg('请选择项目客户', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var contactName = $("#contactName").val().trim();
                            /*if (contactName == "") {
                                layer.msg('请输入项目联系人', {icon: 0, time: 1000, anim: 6});
                                return;
                            }*/
                            var contactPhone = $("#contactPhone").val().trim();
                            /*if (contactPhone == "") {
                                layer.msg('请输入联系方式', {icon: 0, time: 1000, anim: 6});
                                return;
                            }*/
                            var projectPerson = $("#projectPerson").val().trim();
                            /*if (projectPerson == "") {
                                layer.msg('请输入项目负责人', {icon: 0, time: 1000, anim: 6});
                                return;
                            }*/
                            var projectDescription = $("#projectDescription").val().trim();
                            var projectStartDate = $("#projectStartDate").val().trim();
                            if (projectStartDate == "") {
                                layer.msg('请选择进场日期', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectFinalDate = $("#projectFinalDate").val().trim();
                            if (projectFinalDate == "") {
                                layer.msg('请选择完工日期', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectCycle = $("#projectCycle").val().trim();
                            var deadLineDate = $("#deadLineDate").val().trim();
                            if (deadLineDate == "") {
                                layer.msg('请选择付款截止日期', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectRemindDays = $("#projectRemindDays").val().trim();
                            if (projectRemindDays == "") {
                                layer.msg('请选择到期提醒天数', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectArea = $("#projectArea").val().trim();
                            var projectPrice = $("#projectPrice").val().trim();
                            var projectBudget = $("#projectBudget").val().trim();
                            if (isType) {// 按平方
                                if (projectArea == "") {
                                    layer.msg('请输入开荒面积', {icon: 0, time: 1000, anim: 6});
                                    return;
                                }
                                if (projectPrice == "") {
                                    layer.msg('请输入单价', {icon: 0, time: 1000, anim: 6});
                                    return;
                                }
                            } else {// 全包
                                projectArea = projectArea==""?0:projectArea;
                                projectPrice = projectPrice==""?0:projectPrice;
                                if (projectBudget == "") {
                                    layer.msg('请输入应收款项', {icon: 0, time: 1000, anim: 6});
                                    return;
                                }
                            }
                            var projectCost = $("#projectCost").val().trim();
                            if (projectCost == "") {
                                layer.msg('请输入预算', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectDelay = $("#projectDelay").val().trim();
                            if (projectDelay == "") {
                                layer.msg('请输入滞纳金', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectIncome = $("#projectIncome").val().trim();
                            var projectInQuota = $("#projectInQuota").val().trim();
                            var projectBadQuota = $("#projectBadQuota").val().trim();
                            if (projectBadQuota == "") {
                                layer.msg('请输入坏账', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var projectUnQuota = $("#projectUnQuota").val().trim();
                            var projectPayState = $("#projectPayState").val().trim();
                            if(parseFloat(projectUnQuota)==0){
                                projectPayState = '已付清';
                            }else{
                                var cur = new Date();
                                var t1 = cur.getTime();
                                var t2 = dataRow[0].deadLineDate;// 默认时间格式long型数值
                                if(t2 < t1){// 截止日期小于当前日期，拖欠中
                                    projectPayState = '拖欠中';
                                }else{
                                    projectPayState = '未付清';
                                }
                            }
                            var remarkDescription = $("#remarkDescription").val().trim();
                            // 提交
                            $.ajax({
                                type: 'post',
                                url: '${pageContext.request.contextPath}/project/update?contactName='+contactName+'&contactPhone='+contactPhone,
                                data: JSON.stringify({
                                    id: id,
                                    projectNumber: projectNumber.toUpperCase(),
                                    projectName:projectName==dataRow[0].projectName ? null : projectName,
                                    projectAddress: projectAddress==dataRow[0].projectAddress ? null : projectAddress,
                                    signDate: signDate==layui.util.toDateString(dataRow[0].signDate, 'yyyy-MM-dd')? null : signDate,
                                    projectType:projectType==dataRow[0].projectType ? null : projectType,
                                    customerID: customerID==dataRow[0].customerID ? null : customerID,
                                    projectPerson: projectPerson==dataRow[0].projectPerson ? null : projectPerson,
                                    projectDescription: projectDescription==dataRow[0].projectDescription ? null : projectDescription,
                                    projectStartDate: projectStartDate==layui.util.toDateString(dataRow[0].projectStartDate, 'yyyy-MM-dd')? null : projectStartDate,
                                    projectFinalDate: projectFinalDate==layui.util.toDateString(dataRow[0].projectFinalDate, 'yyyy-MM-dd')? null : projectFinalDate,
                                    projectCycle:projectCycle==dataRow[0].projectCycle ? null : projectCycle,
                                    deadLineDate:deadLineDate==layui.util.toDateString(dataRow[0].deadLineDate, 'yyyy-MM-dd')? null : deadLineDate,
                                    projectRemindDays:projectRemindDays==dataRow[0].projectRemindDays ? null : projectRemindDays,
                                    projectArea:projectArea==dataRow[0].projectArea ? null : projectArea,
                                    projectPrice: projectPrice==dataRow[0].projectPrice ? null : projectPrice,
                                    projectBudget:projectBudget==dataRow[0].projectBudget ? null : projectBudget,
                                    projectCost: projectCost==dataRow[0].projectCost ? null : projectCost,
                                    projectDelay:projectDelay==dataRow[0].projectDelay ? null : projectDelay,
                                    projectIncome:projectIncome==dataRow[0].projectIncome ? null : projectIncome,
                                    projectInQuota:projectInQuota==dataRow[0].projectInQuota ? null : projectInQuota,
                                    projectBadQuota:projectBadQuota==dataRow[0].projectBadQuota ? null : projectBadQuota,
                                    projectUnQuota:projectUnQuota==dataRow[0].projectUnQuota ? null : projectUnQuota,
                                    projectPayState:projectPayState==dataRow[0].projectPayState ? null : projectPayState,
                                    remarkDescription: remarkDescription==dataRow[0].remarkDescription ? null : remarkDescription
                                }),
                                contentType: "application/json;charset=UTF-8",
                                dataType: "json",
                                success: function (data) {
                                    if (data == '1') {
                                        layer.msg('修改成功!', {
                                            icon: 1, time: 1000, end: function () {
                                                location.reload();
                                            }
                                        });
                                    } else {
                                        layer.msg('修改失败!', {icon: 5, time: 1000, anim: 6});
                                    }
                                }, error: function (data) {
                                    layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
                                }
                            });
                        }, xs2: function (index, layero) {
                            layer.close(index);
                        }, success: function (layero) {
                            $("#customerID").val(dataRow[0].customerID);
                            $("#signDate").val(layui.util.toDateString(dataRow[0].signDate, 'yyyy-MM-dd'));
                            $("#projectNumber").val(dataRow[0].projectNumber);
                            $("#projectType").val(dataRow[0].projectType);
                            $("#projectName").val(dataRow[0].projectName);
                            $("#projectAddress").val(dataRow[0].projectAddress);
                            $("#projectDescription").val(dataRow[0].projectDescription);
                            $("#projectPerson").val(dataRow[0].projectPerson);
                            $("#projectStartDate").val(layui.util.toDateString(dataRow[0].projectStartDate, 'yyyy-MM-dd'));
                            $("#projectFinalDate").val(layui.util.toDateString(dataRow[0].projectFinalDate, 'yyyy-MM-dd'));
                            $("#projectCycle").val(dataRow[0].projectCycle);
                            $("#projectPrice").val(dataRow[0].projectPrice);
                            $("#projectArea").val(dataRow[0].projectArea);
                            $("#projectBudget").val(dataRow[0].projectBudget);
                            $("#projectCost").val(dataRow[0].projectCost);
                            $("#projectIncome").val(dataRow[0].projectIncome);
                            $("#projectInQuota").val(dataRow[0].projectInQuota);
                            $("#projectBadQuota").val(dataRow[0].projectBadQuota);
                            $("#projectUnQuota").val(dataRow[0].projectUnQuota);
                            $("#deadLineDate").val(layui.util.toDateString(dataRow[0].deadLineDate, 'yyyy-MM-dd'));
                            $("#projectDelay").val(dataRow[0].projectDelay);
                            $("#projectPayState").val(dataRow[0].projectPayState);
                            $("#remarkDescription").val(dataRow[0].remarkDescription);
                            $("#projectRemindDays").val(dataRow[0].projectRemindDays);
                            $.ajax({
                                url: '${pageContext.request.contextPath }/contact/search',
                                method: 'post',
                                data: JSON.stringify({projectID:dataRow[0].id}),
                                contentType: "application/json;charset=UTF-8",
                                dataType: "json",
                                success: function (data) {
                                    var oj = eval(data);
                                    $("#contactName").val(oj.contactName);
                                    $("#contactPhone").val(oj.contactPhone);
                                }, error: function (data) {
                                    $("#contactName").val('');
                                    $("#contactPhone").val('');
                                }
                            });
                            form.render('select');
                        }
                    }
                    tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe72a;</i> 项目详情<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+dataRow[0].projectName+'</div>', ['100%', '100%'], 'userbj', $("#bjnrEdit"), ['确定','关闭'], _funbtnxs);
                    // 项目类型下拉框值改变动态设置样式
                    form.on('select(projectType)', function (data) {
                        var text = $("#projectType option:selected").text();
                        if (text.indexOf("全包") >= 0) {
                            DelReadonly("projectBudget",'1','');
                            isType = false;
                        } else {
                            SetReadonly("projectBudget",'1','');
                            isType = true;
                        }
                        form.render('select','projectType');
                    });
                    break;
                case 'flush':
                    var dataRow = checkStatus.data;  //获取选中行数据
                    if (dataRow.length == 0) {
                        layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
                        return;
                    }
                    var id = dataRow[0].id;// 选中项目id
                    var projectUnQuota = dataRow[0].projectUnQuota;
                    var projectPayState = dataRow[0].projectPayState;
                    if(parseFloat(projectUnQuota)==0){
                        projectPayState = '已付清';
                    }else{
                        var cur = new Date();
                        var t1 = cur.getTime();
                        var t2 = dataRow[0].deadLineDate;// 默认时间格式long型数值
                        if(t2 < t1){// 截止日期小于当前日期，拖欠中
                            projectPayState = '拖欠中';
                        }else{
                            projectPayState = '未付清';
                        }
                    }
                    // 提交
                    $.ajax({
                        type: 'post',
                        url: '${pageContext.request.contextPath}/project/flush',
                        data: JSON.stringify({
                            id: id,
                            projectPayState:projectPayState
                        }),
                        contentType: "application/json;charset=UTF-8",
                        dataType: "json",
                        success: function (data) {
                            if (data == '1') {
                                layer.msg('刷新成功!', {
                                    icon: 1, time: 1000, end: function () {
                                        location.reload();
                                    }
                                });
                            } else {
                                layer.msg('刷新失败!', {icon: 5, time: 1000, anim: 6});
                            }
                        }, error: function (data) {
                            layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
                        }
                    });
                    break;
                case 'apply':
                    var dataRow = checkStatus.data;  //获取选中行数据
                    if (dataRow.length == 0) {
                        layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
                        return;
                    }
                    if(dataRow[0].hasApplyBill == 1){
                        if(dataRow[0].hasBill==1){
                            layer.msg('已经申请且已开票', {icon: 0, time: 1000, anim: 6});
                        }else{
                            layer.msg('已经申请还未开票', {icon: 0, time: 1000, anim: 6});
                        }
                        return;
                    }
                    var id = dataRow[0].id;// 选中项目id
                    // 提交
                    $.ajax({
                        type: 'post',
                        url: '${pageContext.request.contextPath}/project/flush',
                        data: JSON.stringify({
                            id: id,
                            hasApplyBill:1
                        }),
                        contentType: "application/json;charset=UTF-8",
                        dataType: "json",
                        success: function (data) {
                            if (data == '1') {
                                layer.msg('申请成功!', {
                                    icon: 1, time: 1000, end: function () {
                                        //location.reload();
                                    }
                                });
                            } else {
                                layer.msg('申请失败!', {icon: 5, time: 1000, anim: 6});
                            }
                        }, error: function (data) {
                            layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
                        }
                    });
                    break;
                // 删除
                case 'delete':
                    var dataRow = checkStatus.data;  //获取选中行数据
                    if (dataRow.length == 0) {
                        layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
                        return;
                    }
                    if(dataRow[0].projectPayState == "已付清"){
                        layer.msg('已付清，无法删除', {icon: 5, time: 1000, anim: 6});
                        return;
                    }
                    var id = dataRow[0].id;// 选中项目id
                    layer.confirm('确认要删除吗？', function (index) {
                        $.ajax({
                            type: 'post',
                            url: '${pageContext.request.contextPath}/project/delete',
                            data: {id: id},
                            success: function (data) {
                                if (data == '1') {
                                    layer.msg('删除成功!', {
                                        icon: 1, time: 1000, end: function () {
                                            location.reload();
                                        }
                                    });
                                } else {
                                    layer.msg('删除失败!', {icon: 2, time: 1000, anim: 6});
                                }
                            },
                            error: function (data) {
                                layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
                            },
                        });
                    });
                    break;
                case 'contact':
                    var dataRow = checkStatus.data;  //获取选中行数据
                    if (dataRow.length == 0) {
                        layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
                        return;
                    }
                    //弹出框开始
                    var _funbtnxs = {
                        yesxs1: function (index, layero) {
                            //单击提交的回调
                            var projectID = dataRow[0].id;// 选中项目id
                            var contactName = $("#contact_contactName").val().trim();
                            if (contactName == "") {
                                layer.msg('请输入联系人', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var contactPhone = $("#contact_contactPhone").val().trim();
                            if (contactPhone == "") {
                                layer.msg('请输入联系方式', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            // 手机号合法规则
                            var reg = /(^$)|^1\d{10}$/;
                            if (!reg.test(contactPhone)) {
                                layer.msg('请输入正确的手机号', {icon: 0, time: 1000, anim: 6});
                                return;
                            }
                            var createDate = new Date();
                            var remarkDescription = $("#contact_remarkDescription").val().trim();
                            $.ajax({
                                type: 'post',
                                url: "${pageContext.request.contextPath }/contact/add",
                                data: JSON.stringify({
                                    projectID: projectID,
                                    createDate:createDate,
                                    contactName: contactName,
                                    contactPhone: contactPhone,
                                    remarkDescription: remarkDescription
                                }),
                                contentType: "application/json;charset=UTF-8",
                                dataType: "json",
                                success: function (data) {
                                    if (data == "1") {
                                        layer.msg('添加成功!', {
                                            icon: 1, time: 1000, end: function () {
                                                location.reload();
                                            }
                                        });
                                    } else {
                                        layer.msg('此联系人已存在，请更换联系人!', {icon: 5, time: 1000, anim: 6});
                                    }
                                },
                                error: function (data) {
                                    layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
                                }
                            });
                        }
                        , xs2: function (index, layero) {
                            layer.close(index);
                        }, success: function (layero) {
                            $("#contact_projectName").val(dataRow[0].projectName);
                        }
                    }
                    tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe604;</i> 新增联系人<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+dataRow[0].projectName+'</div>', ['80%', '80%'], 'userbj', $("#bjnrContact"), ['确定','关闭'], _funbtnxs);
                    break;
            };
        });
        // 重载
        var $ = layui.$, active = {
            reload: function () {
                //执行重载
                table.reload('projectAdminReload', {
                    url: '${pageContext.request.contextPath}/project/searchAdmin',
                    method: 'post',
                    contentType: "application/json;charset=UTF-8",
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }, where: {
                        timeStart: $('#timeStart').val() == "" ? null : $('#timeStart').val(),
                        timeFinal: $('#timeFinal').val() == "" ? null : $('#timeFinal').val(),
                        searchString: $('#searchString').val().trim() == "" ? null : $('#searchString').val().trim()
                    }
                }, 'data');
                permission('${sessionScope.CurrentUser.roleID}','开荒项目管理');
            }
        };
        // 刷新
        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        // 客户
        $.ajax({
            url: '${pageContext.request.contextPath }/customer/getList',
            method: 'post',
            data: JSON.stringify({ }),
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            success: function (data) {
                $('#customerID').empty();
                $('#customerID').append('<option value="">请选择</option>');
                $.each(data, function (index, item) {
                    $('#customerID').append('<option value='+item.id+'>'+item.customerName+'</option>');
                });
                form.render("select",'customerID');
            }, error: function (data) {
                $('#customerID').empty();
                $('#customerID').append('<option value="">请选择</option>');
                form.render("select",'customerID');
            }
        });
        permission('${sessionScope.CurrentUser.roleID}','开荒项目管理');
    });
    // 项目收款
    function inittable1(elem,id,projectID){
        layui.use(['table'], function () {
            let table = layui.table;
            table.render({
                elem: '#' + elem // 指定表格
                , id: id // 表格唯一ID
                , url: '${pageContext.request.contextPath }/cashing/searchAll' //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {
                    projectID:projectID
                }
                , even: true // 开启隔行换色
                //, height: 'full-192' // 最大化适应表格高度
                , size: 'lg' //sm小尺寸的表格 lg大尺寸
                , cellMinWidth: 150 // 表格单元格最小宽度
                //, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , totalRow: true // 开启合计行
                , cols: [[
                    {type: 'radio', totalRowText: '合计'}
                    , {
                        field: 'payDate',
                        unresize:true,
                        minWidth:110,
                        title: '收款日期',
                        align: 'center',
                        templet: "#payDateTpl"
                    }
                    , {
                        field: 'payType',
                        unresize:true,
                        minWidth:110,
                        title: '收款类型',
                        align: 'center',
                        templet: "#payTypeTpl"
                    }
                    , {
                        field: 'payPerson',
                        unresize:true,
                        minWidth:110,
                        title: '收款人',
                        align: 'center',
                        templet: "#payPersonTpl"
                    }
                    , {
                        field: 'payQuota',
                        unresize:true,
                        minWidth:110,
                        title: '收款金额',
                        align: 'center',
                        templet: "#payQuotaTpl",
                        totalRow: true
                    }
                    , {
                        field: 'remarkDescription',
                        unresize:true,
                        title: '备注',
                        align: 'center',
                        templet: '#remarkDescriptionTpl'
                    }
                ]]
                , page: false  //开启分页
                , limit: 5   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
                , response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
        });
    }
    // 项目开票
    function inittable2(elem,id,projectID){
        layui.use(['table'], function () {
            let table = layui.table;
            table.render({
                elem: '#' + elem // 指定表格
                , id: id // 表格唯一ID
                , url: '${pageContext.request.contextPath }/bill/searchAll' //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {
                    projectID:projectID
                }
                , even: true // 开启隔行换色
                //, height: 'full-192' // 最大化适应表格高度
                , size: 'lg' //sm小尺寸的表格 lg大尺寸
                , cellMinWidth: 150 // 表格单元格最小宽度
                //, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , totalRow: true // 开启合计行
                , cols: [[
                    {type: 'radio', totalRowText: '合计'}
                    , {
                        field: 'billDate',
                        unresize:true,
                        minWidth:110,
                        title: '开票日期',
                        align: 'center',
                        templet: "#billDateTpl"
                    }
                    , {
                        field: 'billType',
                        unresize:true,
                        title: '开票类型',
                        minWidth:110,
                        align: 'center',
                        templet: '#billTypeTpl'
                    }
                    , {
                        field: 'billQuota',
                        unresize:true,
                        minWidth:110,
                        title: '开票金额',
                        align: 'center',
                        templet: "#billQuotaTpl",
                        totalRow: true
                    }
                    , {
                        field: 'remarkDescription',
                        unresize:true,
                        title: '备注',
                        align: 'center',
                        templet: '#remarkDescriptionTpl'
                    }
                ]]
                , page: false  //开启分页
                , limit: 5   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
                , response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
        });
    }
    // 项目联系人
    function inittable3(elem,id,projectID){
        layui.use(['table'], function () {
            let table = layui.table;
            table.render({
                elem: '#' + elem // 指定表格
                , id: id // 表格唯一ID
                , url: '${pageContext.request.contextPath }/contact/searchList' //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {
                    projectID:projectID
                }
                , even: true // 开启隔行换色
                //, height: 'full-192' // 最大化适应表格高度
                , size: 'lg' //sm小尺寸的表格 lg大尺寸
                , cellMinWidth: 150 // 表格单元格最小宽度
                //, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , cols: [[
                    {type: 'radio'}
                    , {
                        field: 'contactName',
                        unresize:true,
                        title: '联系人',
                        align: 'center',
                        templet: "#contactNameTpl"
                    }
                    , {
                        field: 'contactPhone',
                        unresize:true,
                        title: '联系电话',
                        align: 'center',
                        templet: "#contactPhoneTpl"
                    }
                    , {
                        field: 'createDate',
                        unresize:true,
                        minWidth:240,
                        title: '创建日期',
                        align: 'center',
                        templet: "#createDateTpl"
                    }
                    , {
                        field: 'remarkDescription',
                        unresize:true,
                        minWidth:400,
                        title: '备注',
                        align: 'center',
                        templet: "remarkDescriptionTpl"
                    }
                ]]
                , page: false  //开启分页
                , limit: 5   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
                , response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
        });
    }
</script>
</body>
</html>