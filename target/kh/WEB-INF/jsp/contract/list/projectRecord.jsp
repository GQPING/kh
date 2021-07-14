<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../other/meta.html"%>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui/css/H-ui.min2.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/business/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/lib/Hui-iconfont/1.0.9/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-feature-carousel/css/feature-carousel.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/lib/layui/css/layui.css" media="all">
</head>
<body>
<div class="wap-container">
    <nav class="breadcrumb" style="background-color:#f5f5f5;padding-left: 24px;padding-right: 24px;">
        <i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span> 项目管理
        <span class="c-gray en">&gt;</span> 项目档案列表
        <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px"
           href="javascript:location.replace(location.href);">
            <i class="Hui-iconfont">&#xe68f;</i>
        </a>
    </nav>
    <div class="page-container">
        <div class="mt" style="padding:12px 24px 0px 24px;">
            <div class="demoTable layui-form">
                <div class="layui-inline" style="width: 100%;">
                    <div class="layui-inline" style="width: 20%;position:relative;min-width: 330px;padding: 12px 12px 12px 0px;">
                        <div style="position:absolute;right:2px;top:10px;cursor:pointer;display: none;padding: 12px 12px 12px 0px;" class="input_clear">
                            <button type="button" class="clear" style="border: 0px;background-color:white;">
                                <i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
                            </button>
                        </div>
                        <input class="layui-input" oninput="showClear(this)" id="searchString" autocomplete="off" placeholder="请输入名称查询">
                    </div>
                    <div class="layui-inline" style="width: 10%;min-width: 110px;padding: 12px 0px 12px 0px;">
                        <input class="layui-input" id="timeStart" autocomplete="off" placeholder="开始日期">
                    </div>
                    <span style="color:#555;font-weight: bold;font-size:16px;padding: 12px 0px 12px 0px;">-</span>
                    <div class="layui-inline" style="width: 10%;min-width: 110px;padding: 12px 12px 12px 0px;">
                        <input class="layui-input" id="timeFinal" autocomplete="off" placeholder="结束日期">
                    </div>
                    <button class="layui-btn" data-type="reload" style="margin:0px 0px 0px 0px;padding: 0px 12px 0px 12px;">
                        <i class="Hui-iconfont">&#xe665;</i>
                    </button>
                </div>
            </div>
        </div>
        <div style="max-height:708px;overflow:auto;margin-top: -12px;">
            <article class="Hui-admin-content clearfix" id="flow">
                <div class="row-24 clearfix flow-default" style="margin-left: -12px; margin-right: -12px;" id="LAY_demo1"></div>
            </article>
        </div>
    </div>
</div>
<%@include file="../../other/tools.html" %>
<%@include file="../../other/cols/projectRecordTableCols.html" %>
<%@include file="../../other/conjs.html" %>
<script type="text/javascript">
    var layer;// 全局变量
    // 初始数据
    $(function () {
        lay();// 首次流加载函数
        $(".layui-btn").click(function(){
            $("#LAY_demo1").remove();// 移除容器元素
            $(document).unbind();//把容器的事件解除绑定
            $('#flow').append('<div class="row-24 clearfix flow-default" style="margin-left: -12px; margin-right: -12px;" id="LAY_demo1"></div>');
            lay();//重新执行流加载函数
        });
    });
    // lay 加载
    function lay() {
        var timeStart = $('#timeStart').val();
        var timeFinal = $('#timeFinal').val();
        var searchString = $('#searchString').val().trim();
        layui.use(['flow', 'util', 'laydate', 'layer', 'element'], function () {
            let flow = layui.flow, util = layui.util,
                $ = layui.jquery, element = layui.element;
                laydate = layui.laydate, layer=layui.layer;
            //执行一个laydate实例
            let dateEntryStart = laydate.render({
                elem: '#timeStart',
                //theme: '#0079c4',
                trigger: 'click',
                //btns: ['clear', 'confirm'],
                // showBottom: false,
                done: function (value, date) {
                    dateEntryEnd.config.min = {
                        year: date.year,
                        month: date.month - 1,
                        date: date.date,
                        hours: date.hours,
                        minutes: date.minutes,
                        seconds: date.seconds
                    };
                    // 作为 结束选择 的 开始时间
                    dateEntryEnd.config.value = value;
                }
            });
            let dateEntryEnd = laydate.render({
                elem: '#timeFinal',
                //theme: '#0079c4',
                trigger: 'click',//  触发方式
                //btns: ['clear', 'confirm'],// 底部按钮
                // showBottom: false,
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
            // 流加载
            flow.load({
                elem: '#LAY_demo1', //流加载容器
                scrollElem: '#LAY_demo1', //滚动条所在元素，一般不用填
                isAuto: false,
                isLazyimg: true,
                done: function (page, next) { //执行下一页的回调
                    //模拟数据插入
                    setTimeout(function () {
                        let lis = [];
                        //数据请求地址，page，第几页，默认page是从2开始返回
                        $.post('${pageContext.request.contextPath }/project/getRecord', {
                            page: page,
                            timeStart: timeStart,
                            timeFinal: timeFinal,
                            searchString: searchString
                        }, function (res) {
                            layui.each(res.data, function (index, item) {
                                //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                                // 加载数据
                                lis.push("<div onclick='detail("+JSON.stringify(item)+")' class='col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6' style='padding-left: 12px; padding-right: 12px; margin-bottom: 24px;'>"
                                    + "<div class='panel'>"
                                    + "<div class='panel-body' style='padding:0 0px;'>"
                                    + "<div class='panel-header' style='text-align:center;padding:15px 24px;font-weight: 400;color:#999;'>" + item.projectName + "</div>"
                                    + "<div class='c-success' style='text-align:center;font-size: 30px;line-height: 38px;padding:12px 24px;'>"
                                    + item.projectBudget
                                    + "元</div>"
                                    + "<div class='f-14' style='text-align:center;padding: 10px 24px;border-top:solid 1px #eee'><span class='c-999'>" + util.toDateString(item.signDate, 'yyyy-MM-dd') + "</span></div>"
                                    + "</div>"
                                    + "</div>"
                                    + "</div>");
                            });
                            //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                            next(lis.join(''), page < res.pages);
                        });
                    }, 500);
                }
            });
        });
    }
    // 档案详细
    function detail(obj){
        //弹出框开始
        var _funbtnxs = {
            yesxs1: function (index, layero) {
                layer.close(index);
            }, xs2: function (index, layero) {

                layer.close(index);
            }, success: function (layero) {
                $("#customerIDLabel").text(obj.customer.customerName);
                $("#signDateLabel").text(layui.util.toDateString(obj.signDate, 'yyyy-MM-dd'));
                $("#projectNumberLabel").text(obj.projectNumber);
                $("#projectTypeLabel").text(obj.projectType);
                $("#projectNameLabel").text(obj.projectName);
                $("#projectNameTitle").text(obj.projectName);
                $("#projectAddressLabel").text(obj.projectAddress);
                $("#projectDescriptionLabel").text(obj.projectDescription);
                $("#projectPersonLabel").text(obj.projectPerson);
                $("#projectStartDateLabel").text(layui.util.toDateString(obj.projectStartDate, 'yyyy-MM-dd'));
                $("#projectFinalDateLabel").text(layui.util.toDateString(obj.projectFinalDate, 'yyyy-MM-dd'));
                $("#projectCycleLabel").text(obj.projectCycle+"天");
                $("#projectPriceLabel").text(obj.projectPrice+"元");
                $("#projectAreaLabel").text(obj.projectArea+"m²");
                $("#projectBudgetLabel").text(obj.projectBudget+"元");
                $("#projectCostLabel").text(obj.projectCost+"元");
                $("#projectIncomeLabel").text(obj.projectIncome+"元");
                $("#projectInQuotaLabel").text(obj.projectInQuota+"元");
                $("#projectBadQuotaLabel").text(obj.projectBadQuota+"元");
                $("#projectUnQuotaLabel").text(obj.projectUnQuota+"元");
                $("#deadLineDateLabel").text(layui.util.toDateString(obj.deadLineDate, 'yyyy-MM-dd'));
                $("#projectDelayLabel").text(obj.projectDelay+"元");
                $("#projectPayStateLabel").text(obj.projectPayState);
                $("#remarkDescriptionLabel").text(obj.remarkDescription);
                $("#projectRemindDaysLabel").text(obj.projectRemindDays+"天到期提醒");
                $("#hasBillLabel").text(obj.hasBill==1?'已开票':'未开票');
                $.ajax({
                    url: '${pageContext.request.contextPath }/contact/search',
                    method: 'post',
                    data: JSON.stringify({projectID :obj.id}),
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
                layui.use('element', function () {
                    var element = layui.element;
                    var i = 6;  // 默认切换收款记录
                    element.tabChange('recordTab', i);
                    inittable1('LAY_table_user'+i, 'user'+i, obj.id);
                    // 监听Tab切换状态
                    element.on('tab(recordTab)', function(){
                        i = this.getAttribute('lay-id');
                        if(i==6){
                            inittable1('LAY_table_user'+i, 'user'+i, obj.id);
                        }else if(i==7){
                            inittable2('LAY_table_user'+i, 'user'+i, obj.id);
                        }else if(i==8){
                            inittable3('LAY_table_user'+i, 'user'+i, obj.id);
                        }
                    });
                });
            }
        }
        tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe695;</i> 项目详情<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+obj.projectName+'</div>', ['80%', '80%'], 'userbj', $("#bjnrRecord"), ['关闭'], _funbtnxs);
    }
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
<%@include file="../../other/pops/read/projectRecord.html" %>
</body>
</html>
