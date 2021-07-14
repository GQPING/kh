<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<span class="c-gray en">&gt;</span> 项目管理
			<span class="c-gray en">&gt;</span> 项目开票列表
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);">
				<i class="Hui-iconfont">&#xe68f;</i>
			</a>
		</nav>
		<%@include file="../../other/seach.html" %>
		<div id="bjnrEdit" style="display: none;">
			<%@include file="../../other/pops/edit/bill.html" %>
		</div>
	</div>
	<%@include file="../../other/tools.html" %>
	<%@include file="../../other/cols/billTableCols.html" %>
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		// lay加载
		layui.use(['form', 'table', 'laydate'], function () {
			let table = layui.table;
			let form = layui.form;
			let laydate = layui.laydate;
			laydate.render({
				elem: '#billDate'
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
			// 初始化表格
			table.render({
				elem: '#LAY_table_user' // 指定表格
				, id: 'billReload'
				, url: '${pageContext.request.contextPath }/bill/searchList' //数据请求路径
				, method: 'post'
				, contentType: "application/json;charset=UTF-8"
				, where: { }
				, even: true // 开启隔行换色
				//, height: 'full-180' // 最大化适应表格高度
				, size: 'lg' //sm小尺寸的表格 lg大尺寸
				, cellMinWidth: 150 // 表格单元格最小宽度
				, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
				, totalRow: true // 开启合计行
				, cols: [[
					{type: 'radio', totalRowText: '合计'}
					, {
						field: 'projectName',
						unresize:true,
						title: '项目名称',
						align: 'center',
						templet: '#projectNameTpl'
					}
					, {
						field: 'projectAddress',
						unresize:true,
						minWidth:300,
						title: '项目地址',
						align: 'center',
						templet: '#projectAddressTpl'
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
					    field: 'remarkDescription',
						unresize:true,
						minWidth:300,
						title: '备注',
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
			// 头工具栏事件
			table.on('toolbar(user)', function (obj) {
				var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
				switch (obj.event) {
					case 'update':
						var dataRow = checkStatus.data;  //获取选中行数据
						if (dataRow.length == 0) {
							layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
							return;
						}
						SetReadonly("projectID",2,form);
						//弹出框开始
						var _funbtnxs = {
							yesxs1: function (index, layero) {
								var id = dataRow[0].id;
								var projectID = $("#projectID").val().trim();
								var billType = $("#billType").val().trim();
								if (billType == "") {
									layer.msg('请选择开票类型', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var billQuota = $("#billQuota").val().trim();
								if (billQuota == "") {
									layer.msg('请输入开票金额', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var billDate = $("#billDate").val().trim();
								if (billDate == "") {
									layer.msg('请选择开票日期', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var remarkDescription = $("#remarkDescription").val().trim();
								$.ajax({
									type: 'post',
									url: "${pageContext.request.contextPath }/bill/update",
									data: JSON.stringify({
										id: id,
										projectID:projectID,
										billType: billType==dataRow[0].billType ? null : billType,
										billQuota: billQuota==dataRow[0].billQuota ? null : billQuota,
										remarkDescription: remarkDescription==dataRow[0].remarkDescription ? null : remarkDescription,
										billDate: billDate==layui.util.toDateString(dataRow[0].billDate, 'yyyy-MM-dd')? null : billDate
									}),
									contentType: "application/json;charset=UTF-8",
									dataType: "json",
									success: function (data) {
										if (data == "1") {
											layer.msg('修改成功!', {
												icon: 1, time: 1000, end: function () {
													location.reload();
												}
											});
										} else {
											layer.msg('修改失败!', {icon: 5, time: 1000, anim: 6});
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
								$("#billType").val(dataRow[0].billType);
								$("#projectID").val(dataRow[0].projectID);
								$("#billQuota").val(dataRow[0].billQuota);
								$("#remarkDescription").val(dataRow[0].remarkDescription);
								$("#billDate").val(layui.util.toDateString(dataRow[0].billDate, 'yyyy-MM-dd'));
								form.render('select');
							}
						}
						tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe72a;</i> 开票详情<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+dataRow[0].project.projectName+'</div>', ['80%', '80%'], 'userbj', $("#bjnrEdit"), ['确定','关闭'], _funbtnxs);
						break;
					case 'delete':
						var dataRow = checkStatus.data;  //获取选中行数据
						if (dataRow.length == 0) {
							layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
							return;
						}
						var id = dataRow[0].id;
						layer.confirm('确认要删除吗？', function (index) {
							$.ajax({
								type: 'post',
								url: '${pageContext.request.contextPath }/bill/delete',
								data: {id: id},
								success: function (data) {
									if (data == '1') {
										layer.msg('删除成功!', {
											icon: 1, time: 1000, end: function () {
												location.reload();
											}
										});
									} else {
										layer.msg('删除失败!', {icon: 5, time: 1000, anim: 6});
									}
								},
								error: function (data) {
									layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
								},
							});
						});
						break;
				}
				;
			});
			// 重载
			var $ = layui.$, active = {
				reload: function () {
					table.reload('billReload', {
						url: '${pageContext.request.contextPath }/bill/searchList',
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
					permission('${sessionScope.CurrentUser.roleID}','项目开票列表');
				}
			};
			// 刷新
			$('.demoTable .layui-btn').on('click', function () {
				var type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});
			// 项目
			$.ajax({
				url: '${pageContext.request.contextPath }/project/getList',
				method: 'post',
				data: JSON.stringify({ }),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					$('#projectID').empty();
					$('#projectID').append('<option value="">请选择</option>');
					$.each(data, function (index, item) {
						$('#projectID').append('<option value=' + item.id + '>' + item.projectName + '</option>');
					});
					form.render("select");
				}, error: function (data) {
					$('#projectID').empty();
					$('#projectID').append('<option value="">请选择</option>');
					form.render("select",);
				}
			});
			permission('${sessionScope.CurrentUser.roleID}','项目开票列表');
		});
   </script>
</body>
</html>