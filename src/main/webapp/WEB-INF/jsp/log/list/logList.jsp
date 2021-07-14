<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../other/meta.html" %>
    <%@include file="../../other/style.html" %>
</head>
<body>
<div>
    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span> 系统管理
        <span class="c-gray en">&gt;</span> 系统日志
        <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);">
            <i class="Hui-iconfont">&#xe68f;</i>
        </a>
    </nav>
    <%@include file="../../other/seach.html" %>
</div>
<%@include file="../../other/tools.html" %>
<%@include file="../../other/cols/logTableCols.html" %>
<%@include file="../../other/conjs.html" %>
<script type="text/javascript">
    // lay加载
    layui.use(['form', 'table', 'laydate'], function () {
        let table = layui.table;
        let form = layui.form;
        let laydate = layui.laydate;
        //执行一个laydate实例
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
                // 作为 结束选择 的 开始时间
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
        // 初始化表格
        table.render({
            elem: '#LAY_table_user' // 指定表格
            , id: 'logReload'
            , url: '${pageContext.request.contextPath }/log/searchList' //数据请求路径
            , method: 'post'
            , contentType: "application/json;charset=UTF-8"
            , where: {}
            , even: true // 开启隔行换色
            //, height: 'full-180' // 最大化适应表格高度
            , size: 'lg' //sm小尺寸的表格 lg大尺寸
            //, cellMinWidth: 150 // 表格单元格最小宽度
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , cols: [[
                {type: 'checkbox'}
                , {
                    field: 'id',
                    unresize: true,
                    sort: true,
                    width: 80,
                    title: 'ID',
                    align: 'center',
                    templet: '#idTpl'
                }
                , {
                    field: 'nickName',
                    unresize: true,
                    title: '用户昵称',
                    align: 'center',
                    templet: '#nickNameTpl'
                }
                , {
                    field: 'userName',
                    unresize: true,
                    title: '用户姓名',
                    align: 'center',
                    templet: '#userNameTpl'
                }
                , {
                    field: 'roleName',
                    unresize: true,
                    title: '角色名称',
                    align: 'center',
                    templet: '#roleNameTpl'
                }
                , {
                    field: 'operateType',
                    unresize: true,
                    title: '操作类型',
                    align: 'center',
                    templet: '#operateTypeTpl'
                }
                , {
                    field: 'operateDetail',
                    unresize: true,
                    title: '操作明细',
                    align: 'center',
                    templet: '#operateDetailTpl'
                }
                , {
                    field: 'logsIpAddress',
                    unresize: true,
                    title: 'IP地址',
                    align: 'center',
                    templet: '#logsIpAddressTpl'
                }
                , {
                    field: 'createDate',
                    unresize: true,
                    title: '创建日期',
                    align: 'center',
                    templet: "#createDateTpl"
                }
            ]]
            , page: true  //开启分页
            , limit: 10   //默认十条数据一页
            , limits: [5, 10, 50, 100, 300] //数据分页条
            , response: {
                statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
            }
        });
        // 头工具栏事件
        table.on('toolbar(user)', function (obj) {
            let checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
            switch (obj.event) {
                case 'delete':
                    let dataRow = checkStatus.data;  //获取选中行数据
                    if (dataRow.length == 0) {
                        layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
                        return;
                    }
                    layer.confirm('确认要删除所选' + dataRow.length + '条记录吗？', function (index) {
                        let fail_count = 0;
                        let success_count = 0;
                        // 遍历所有选中数据
                        for (let i = 0; i < dataRow.length; i++) {
                            let id = dataRow[i].id;
                            $.ajax({
                                type: 'post',
                                url: '${pageContext.request.contextPath }/log/delete',
                                data: {id: id},
                                success: function (data) {
                                    if (data == '1') {
                                        success_count++;
                                    } else {
                                        fail_count++;
                                    }
                                    if (success_count + fail_count == dataRow.length) {
                                        layer.msg('共选中' + dataRow.length + '个记录；删除成功:' + success_count + "个,删除失败：" + fail_count + "个！", {
                                            icon: 1, time: 2000, end: function () {
                                                location.reload();
                                            }
                                        });
                                    }
                                },
                                error: function (data) {
                                    fail_count++;
                                }
                            });
                        }
                    });
                    break;
            }
            ;
        });
        // 搜索重载
        let $ = layui.$, active = {
            reload: function () {
                table.reload('logReload', {
                    url: '${pageContext.request.contextPath }/log/searchList',
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
                permission('${sessionScope.CurrentUser.roleID}', '系统日志');
            }
        };
        // 刷新
        $('.demoTable .layui-btn').on('click', function () {
            let type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        permission('${sessionScope.CurrentUser.roleID}', '系统日志');
    });
</script>
</body>
</html>