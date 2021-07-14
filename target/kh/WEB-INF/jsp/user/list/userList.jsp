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
			<span class="c-gray en">&gt;</span> 用户管理 
			<span class="c-gray en">&gt;</span> 用户列表
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);">
				<i class="Hui-iconfont">&#xe68f;</i>
			</a>
		</nav>
		<%@include file="../../other/seach.html" %>
		<div id="bjnrEdit" style="display: none;">
			<%@include file="../../other/pops/edit/user.html" %>
		</div>
	</div>
	<%@include file="../../other/tools.html" %>
	<%@include file="../../other/cols/userTableCols.html" %>
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		// 密码隐藏显示
		function MD5(obj) {
			return obj.replace(/[a-zA-Z0-9_|.,;!?<>()+=@#&$%]/g, "*");//隐藏
		}
		// lay加载
		layui.use(['form', 'table', 'laydate'], function () {
			var table = layui.table;
			var form = layui.form;
			let laydate = layui.laydate;
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
			// 初始化表格
			table.render({
				elem: '#LAY_table_user' // 指定表格
				, id: 'userReload'
				, url: '${pageContext.request.contextPath }/user/searchList' //数据请求路径
				, method: 'post'
				, contentType: "application/json;charset=UTF-8"
				, where: {}
				, even: true // 开启隔行换色
				//, height: 'full-180' // 最大化适应表格高度
				, size: 'lg' //sm小尺寸的表格 lg大尺寸
				//,cellMinWidth: 150 // 表格单元格最小宽度
				, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
				, cols: [[
					{type: 'radio'}
					, {
					    field: 'id',
						unresize: true,
						width: 80,
						title: 'ID',
						align: 'center',
						templet: '#idTpl'
					}
					, {
						field: 'nickName',
						unresize: true,
						minWidth: 110,
						title: '昵称',
						align: 'center',
						toolbar: "#nickNameTpl"
					}
					, {field: 'password', unresize: true, title: '密码', align: 'center', templet: '#passwordTpl'}
					, {
						field: 'userName',
						unresize: true,
						minWidth: 110,
						title: '姓名',
						align: 'center',
						templet: "#userNameTpl"
					}
					, {
					    field: 'role.roleName',
						unresize: true,
						minWidth: 110,
						title: '角色',
						align: 'center',
						templet: "#roleNameTpl"
					}
					, {
						field: 'createDate',
						unresize: true,
						minWidth:240,
						title: '创建日期',
						align: 'center',
						templet: "#createDateTpl"
					}
					, {
						field: 'remarkDescription',
						unresize: true,
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
					case 'create':
						DelReadonly("nickName",1,'');
						//弹出框开始
						var _funbtnxs = {
							yesxs1: function (index, layero) {
								var nickName = $("#nickName").val().trim();
								if (nickName == "") {
									layer.msg('请输入昵称', {icon: 0, time: 1000, anim: 6});
									return;
								}
								if (nickName.length < 6) {
									layer.msg('昵称长度>=6', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var password = $("#password").val().trim();
								if (password == "") {
									layer.msg('请输入密码', {icon: 0, time: 1000, anim: 6});
									return;
								}
								if (password.length < 6) {
									layer.msg('密码长度>=6', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var userName = $("#userName").val().trim();
								if (userName == "") {
									layer.msg('请输入姓名', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var roleID = $("#roleID").val().trim();
								if (roleID == "") {
									layer.msg('请选择角色', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var createDate = new Date();
								var remarkDescription = $("#remarkDescription").val().trim();
								$.ajax({
									type: 'post',
									url: "${pageContext.request.contextPath }/user/add",
									data: JSON.stringify({
										roleID: roleID,
										nickName: nickName,
										password: password,
										userName: userName,
										createDate:createDate,
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
											layer.msg('账户已存在!', {icon: 5, time: 1000, anim: 6});
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
								$("#roleID").val('');
								$("#nickName").val("");
								$("#userName").val("");
								$("#password").val("123456");
								$("#remarkDescription").val('');
								form.render('select');
							}
						}
						tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe604;</i> 新增用户</div>', ['80%', '80%'], 'userbj', $("#bjnrEdit"), ['确定','关闭'], _funbtnxs);
						break;
					case 'update':
						var dataRow = checkStatus.data;  //获取选中行数据
						if (dataRow.length == 0) {
							layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
							return;
						}
						SetReadonly("nickName",1,'');
						//弹出框开始
						var _funbtnxs = {
							yesxs1: function (index, layero) {
								//单击提交的回调
								var id = dataRow[0].id;
								var nickName = $("#nickName").val().trim();
								var password = $("#password").val().trim();
								if (password == "") {
									layer.msg('请输入密码', {icon: 0, time: 1000, anim: 6});
									return;
								}
								if (password.length < 6) {
									layer.msg('密码长度>=6', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var userName = $("#userName").val().trim();
								if (userName == "") {
									layer.msg('请输入姓名', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var roleID = $("#roleID").val().trim();
								if (roleID == "") {
									layer.msg('请选择角色', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var remarkDescription = $("#remarkDescription").val().trim();
								$.ajax({
									type: 'post',
									url: "${pageContext.request.contextPath }/user/update",
									data: JSON.stringify({
										id: id,
										nickName:nickName,
										roleID: roleID == dataRow[0].roleID ? null : roleID,
										password: password == dataRow[0].password ? null : password,
										userName: userName == dataRow[0].userName ? null : userName,
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
								$("#roleID").val(dataRow[0].roleID);
								$("#nickName").val(dataRow[0].nickName);
								$("#password").val(dataRow[0].password);
								$("#userName").val(dataRow[0].userName);
								$("#remarkDescription").val(dataRow[0].remarkDescription);
								form.render('select');
							}
						}
						tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe72a;</i> 用户详情<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+dataRow[0].nickName+'</div>', ['80%', '80%'], 'userbj', $("#bjnrEdit"), ['确定','关闭'], _funbtnxs);
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
								url: '${pageContext.request.contextPath }/user/delete',
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
				};
			});
			// 搜索
			let $ = layui.$, active = {
				reload: function () {
					//执行重载
					table.reload('userReload', {
						url: '${pageContext.request.contextPath }/user/searchList',
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
					permission('${sessionScope.CurrentUser.roleID}','用户列表');
				}
			};
			// 刷新
			$('.demoTable .layui-btn').on('click', function () {
				let type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});
			// 角色
			$.ajax({
				url: '${pageContext.request.contextPath }/role/getList',
				method: 'post',
				data: JSON.stringify({ }),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					$('#roleID').empty();
					$('#roleID').append(new Option("请选择", ""));
					$.each(data, function (index, item) {
						$('#roleID').append(new Option(item.roleName, item.id));
					});
					form.render("select");
				}, error: function (data) {
					$('#roleID').empty();
					$('#roleID').append(new Option("请选择", ""));
					form.render("select");
				}
			});
			permission('${sessionScope.CurrentUser.roleID}','用户列表');
        });
   </script>
</body>
</html>