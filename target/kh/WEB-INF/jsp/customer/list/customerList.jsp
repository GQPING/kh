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
		<nav class="breadcrumb">
			<i class="Hui-iconfont">&#xe67f;</i> 首页 
			<span class="c-gray en">&gt;</span> 客户管理 
			<span class="c-gray en">&gt;</span> 客户信息列表
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);">
				<i class="Hui-iconfont">&#xe68f;</i>
			</a>
		</nav>
		<%@include file="../../other/seach.html" %>
		<div id="bjnrEdit" style="display: none;">
			<%@include file="../../other/pops/edit/customer.html" %>
		</div>
	</div>
	<%@include file="../../other/tools.html" %>
	<%@include file="../../other/cols/customerTableCols.html" %>
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		// lay加载
		layui.use(['form', 'table', 'laydate'], function () {
			let table = layui.table;
			let form = layui.form;
			let laydate = layui.laydate;
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
			// 执行一个table实例
			table.render({
				elem: '#LAY_table_user' // 指定表格
				, id: 'customerReload'
				, url: '${pageContext.request.contextPath }/customer/searchList' //数据请求路径
				, method: 'post'
				, contentType: "application/json;charset=UTF-8"
				, where: { }
				, even: true // 开启隔行换色
				//, height: 'full-180' // 最大化适应表格高度
				, size: 'lg' //sm小尺寸的表格 lg大尺寸
				, cellMinWidth: 150 // 表格单元格最小宽度
				, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
				, cols: [[
					{type: 'radio'}
					, {
					    field: 'customerName',
						unresize:true,
						minWidth:240,
						title: '客户名称',
						align: 'center',
						templet: '#customerNameTpl'
					}
					, {
						field: 'customerPerson',
					    title: '联系人',
						unresize:true,
						align: 'center',
						templet: "#customerPersonTpl"
					}
					, {
						field: 'customerPhone',
						title: '联系电话',
						unresize:true,
						align: 'center',
						templet: "#customerPhoneTpl"
					}
					, {
						field: 'customerAddress',
					    title: '联系地址',
						minWidth:300,
						unresize:true,
						align: 'center',
						templet: "#customerAddressTpl"
					}
					, {
						field: 'customerLevel',
						title: '信用星级',
						unresize:true,
						align: 'center',
						templet: "#customerLevelTpl"
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
						minWidth:300,
						title: '备注',
						align: 'center',
						templet: "remarkDescriptionTpl"
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
					case 'create':
						//弹出框开始
						var _funbtnxs = {
							yesxs1: function (index, layero) {
								var customerName = $("#customerName").val().trim();
								if (customerName == "") {
									layer.msg('请输入客户名称', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var customerPerson = $("#customerPerson").val().trim();
								var customerPhone = $("#customerPhone").val().trim();
								// 手机号合法规则
								/*var reg = /(^$)|^1\d{10}$/;
								if (customerPhone != "" && !reg.test(customerPhone)) {
									layer.msg('请输入正确的手机号', {icon: 0, time: 1000, anim: 6});
									return;
								}*/
								var customerAddress = $("#customerAddress").val().trim();
								var customerLevel = $("#customerLevel").val().trim();
								var remarkDescription = $("#remarkDescription").val().trim();
								$.ajax({
									type: 'post',
									url: "${pageContext.request.contextPath }/customer/add",
									data: JSON.stringify({
										createDate:new Date(),
										customerName: customerName,
										customerPhone:customerPhone,
										customerLevel:customerLevel,
										customerPerson:customerPerson,
										customerAddress:customerAddress,
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
											layer.msg('此客户已存在，请更换客户名称!', {icon: 5, time: 1000, anim: 6});
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
								$("#customerName").val('');
								$("#customerPerson").val('');
								$("#customerPhone").val('');
								$("#customerLevel").val(5);
								$("#customerAddress").val('');
								$("#remarkDescription").val('');
								form.render('select');
							}
						}
						tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe604;</i> 新增客户</div>', ['80%', '80%'], 'userbj', $("#bjnrEdit"), ['确定','关闭'], _funbtnxs);
						break;
					case 'update':
						var dataRow = checkStatus.data;  //获取选中行数据
						if (dataRow.length == 0) {
							layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
							return;
						}
						//弹出框开始
						var _funbtnxs = {
							yesxs1: function (index, layero) {
								//单击提交的回调
								var id = dataRow[0].id;
								var customerName = $("#customerName").val().trim();
								if (customerName == "") {
									layer.msg('请输入客户名称', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var customerPerson = $("#customerPerson").val().trim();
								var customerPhone = $("#customerPhone").val().trim();
								// 手机号合法规则
								/*var reg = /(^$)|^1\d{10}$/;
								if (customerPhone != "" && !reg.test(customerPhone)) {
									layer.msg('请输入正确的手机号', {icon: 0, time: 1000, anim: 6});
									return;
								}*/
								var customerAddress = $("#customerAddress").val().trim();
								var customerLevel = $("#customerLevel").val().trim();
								var remarkDescription = $("#remarkDescription").val().trim();
								$.ajax({
									type: 'post',
									url: "${pageContext.request.contextPath }/customer/update",
									data: JSON.stringify({
										id: id,
										customerLevel:customerLevel,
										customerName: customerName == dataRow[0].customerName ? null : customerName,
										customerPhone:customerPhone == dataRow[0].customerPhone ? null : customerPhone,
										customerPerson:customerPerson == dataRow[0].customerPerson ? null : customerPerson,
										customerAddress:customerAddress == dataRow[0].customerAddress ? null : customerAddress,
										remarkDescription: remarkDescription == dataRow[0].remarkDescription ? null : remarkDescription
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
											layer.msg('此客户已存在，请更换客户名称!', {icon: 5, time: 1000, anim: 6});
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
								$("#customerName").val(dataRow[0].customerName);
								$("#customerPhone").val(dataRow[0].customerPhone);
								$("#customerLevel").val(dataRow[0].customerLevel);
								$("#customerPerson").val(dataRow[0].customerPerson);
								$("#customerAddress").val(dataRow[0].customerAddress);
								$("#remarkDescription").val(dataRow[0].remarkDescription);
								form.render('select');
							}
						}
						tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe72a;</i> 客户详情<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+dataRow[0].customerName+'</div>', ['80%', '80%'], 'userbj', $("#bjnrEdit"), ['确定','关闭'], _funbtnxs);
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
								url: '${pageContext.request.contextPath }/customer/delete',
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
				};
			});
			// 搜索
			var $ = layui.$, active = {
				reload: function () {
					//执行重载
					table.reload('customerReload', {
						url: '${pageContext.request.contextPath }/customer/searchList',
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
					permission('${sessionScope.CurrentUser.roleID}','客户信息列表');
				}
			};
			// 刷新
			$('.demoTable .layui-btn').on('click', function () {
				var type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});
			permission('${sessionScope.CurrentUser.roleID}','客户信息列表');
		});
   </script>
</body>
</html>