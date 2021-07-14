<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../other/meta.html"%>
    <%@include file="../../other/style.html" %>
</head>
<body>
	<div>
        <%@include file="../../other/seachp.html" %>
        <%@include file="../../other/pops/read/projectRecord.html" %>
	</div>
    <%@include file="../../other/cols/projectTableCols.html" %>
    <%@include file="../../other/cols/projectRecordTableCols.html" %>
    <%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
        layui.use(['form', 'table','element'], function () {
            let form = layui.form;
            let table = layui.table;
            let element = layui.element;
            // 初始化表格
            table.render({
                elem: '#LAY_table_user' // 指定表格
                , id: 'remindReload'
                , url: '${pageContext.request.contextPath }/remindList' //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: { }
                , even: true // 开启隔行换色
                //, height: 'full-120' // 最大化适应表格高度
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
                , page: false  //开启分页
                , limit: 10   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
                , response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
            // 弹出前赋值
            function InitValue(obj) {
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
            }
            //监听行工具事件
            table.on('tool(user)', function(obj){
                let dataRow = obj.data;
                switch (obj.event) {
                    case "prlook":
                        var _funbtnxs = {
                            yesxs1: function (index, layero) {
                                layer.close(index);
                            }, xs2: function (index, layero) {
                                layer.close(index);
                            }, success: function (layero) {
                                InitValue(dataRow);
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
            // 客户列表
            $.ajax({
                url: '${pageContext.request.contextPath }/customer/getList',
                method: 'post',
                data: JSON.stringify({ }),
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (data) {
                    $('#customerIDFilter').empty();
                    $('#customerIDFilter').append('<option value="">请选择</option>');
                    $.each(data, function (index, item) {
                        $('#customerIDFilter').append('<option value='+item.id+'>'+item.customerName+'</option>');
                    });
                    form.render("select");
                }, error: function (data) {
                    $('#customerIDFilter').empty();
                    $('#customerIDFilter').append('<option value="">请选择</option>');
                    form.render("select");
                }
            });
            // 项目列表
            $.ajax({
                url: '${pageContext.request.contextPath }/project/getList',
                method: 'post',
                data: JSON.stringify({
                    isPayEnd:1,
                    isDeadLine:1,
                    customerID:null,
                    projectPayState:'已付清'
                }),
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (data) {
                    $('#projectIDFilter').empty();
                    $('#projectIDFilter').append(new Option("请选择", ""));
                    $.each(data, function (index, item) {
                        $('#projectIDFilter').append(new Option(item.projectName, item.id));
                    });
                    form.render("select");
                }, error: function (data) {
                    $('#projectIDFilter').empty();
                    $('#projectIDFilter').append(new Option("请选择", ""));
                    form.render("select");
                }
            });
            // 一级级联
            form.on('select(customerIDFilter)', function (data) {
                table.reload('remindReload', {
                    url: '${pageContext.request.contextPath }/remindList',
                    method: 'post',
                    contentType: "application/json;charset=UTF-8",
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }, where: {
                        id: $('#projectIDFilter').val() == "" ? null : $('#projectIDFilter').val(),
                        customerID: $('#customerIDFilter').val() == "" ? null : $('#customerIDFilter').val()
                    }
                }, 'data');
                // 级联查询
                if(data.value==""){
                    $.ajax({
                        url: '${pageContext.request.contextPath }/project/getList',
                        method:'post',
                        data:JSON.stringify({
                            isPayEnd:1,
                            isDeadLine:1,
                            customerID:null,
                            projectPayState:'已付清'
                        }),
                        contentType:"application/json;charset=UTF-8",
                        dataType : "json",
                        success: function (data) {
                            $('#projectIDFilter').empty();
                            $('#projectIDFilter').append(new Option("请选择", ""));
                            $.each(data, function (index, item) {
                                $('#projectIDFilter').append(new Option(item.projectName, item.id));
                            });
                            form.render("select");
                            /*if(data.length==0){
                                document.getElementById("projectList").style.display="none";
                            }else{
                                document.getElementById("projectList").style.display="";
                            }*/
                        },error:function(data){
                            $('#projectIDFilter').empty();
                            $('#projectIDFilter').append(new Option("请选择", ""));
                            form.render("select");
                            //document.getElementById("projectList").style.display="none";
                        }
                    });
                }else{
                    $.ajax({
                        url: '${pageContext.request.contextPath }/project/getList',
                        method:'post',
                        data:JSON.stringify({
                            isPayEnd:1,
                            isDeadLine:1,
                            customerID:data.value,
                            projectPayState:'已付清'
                        }),
                        contentType:"application/json;charset=UTF-8",
                        dataType : "json",
                        success: function (data) {
                            $('#projectIDFilter').empty();
                            $('#projectIDFilter').append(new Option("请选择", ""));
                            $.each(data, function (index, item) {
                                $('#projectIDFilter').append(new Option(item.projectName, item.id));
                            });
                            form.render("select");
                            /*if(data.length==0){
                                document.getElementById("projectList").style.display="none";
                            }else{
                                document.getElementById("projectList").style.display="";
                            }*/
                        },error:function(data){
                            $('#projectIDFilter').empty();
                            $('#projectIDFilter').append(new Option("请选择", ""));
                            form.render("select");
                            //document.getElementById("projectList").style.display="none";
                        }
                    });
                }
            });
            // 二级级联
            form.on('select(projectIDFilter)', function (data) {
                table.reload('remindReload', {
                    url: '${pageContext.request.contextPath }/remindList',
                    method: 'post',
                    contentType: "application/json;charset=UTF-8",
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }, where: {
                        id: $('#projectIDFilter').val() == "" ? null : $('#projectIDFilter').val(),
                        customerID: $('#customerIDFilter').val() == "" ? null : $('#customerIDFilter').val()
                    }
                }, 'data');
            });
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