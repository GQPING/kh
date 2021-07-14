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
			<span class="c-gray en">&gt;</span> 项目管理 
			<span class="c-gray en">&gt;</span> 项目联系表
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);">
				<i class="Hui-iconfont">&#xe68f;</i>
			</a>
		</nav>
		<%@include file="../../other/seach.html" %>
		<div id="bjnrEdit" style="display: none;">
			<%@include file="../../other/pops/edit/contact.html" %>
		</div>
	</div>
	<%@include file="../../other/tools.html" %>
	<%@include file="../../other/cols/contactTableCols.html" %>
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		// lay加载
		layui.use(['form', 'table', 'laydate'], function () {
			let form = layui.form;
			let table = layui.table;
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
				, id: 'contactReload'
				, url: '${pageContext.request.contextPath }/contact/searchList' //数据请求路径
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
					    field: 'contactName',
						unresize:true,
						minWidth:110,
						title: '联系人',
						align: 'center',
						templet: "#contactNameTpl"
					}
					, {
					    field: 'contactPhone',
						unresize:true,
						minWidth:110,
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
								//单击提交的回调
								var id = dataRow[0].id;
								var projectID = $("#projectID").val().trim();
								var contactName = $("#contactName").val().trim();
								if (contactName == "") {
									layer.msg('请输入联系人', {icon: 0, time: 1000, anim: 6});
									return;
								}
								var contactPhone = $("#contactPhone").val().trim();
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
								var remarkDescription = $("#remarkDescription").val().trim();
								$.ajax({
									type: 'post',
									url: "${pageContext.request.contextPath }/contact/update",
									data: JSON.stringify({
										id: id,
										projectID: projectID,
										contactName: contactName == dataRow[0].contactName ? null : contactName,
										contactPhone: contactPhone == dataRow[0].contactPhone ? null : contactPhone,
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
								$("#projectID").val(dataRow[0].projectID);
								$("#contactName").val(dataRow[0].contactName);
								$("#contactPhone").val(dataRow[0].contactPhone);
								$("#remarkDescription").val(dataRow[0].remarkDescription);
								form.render('select');
							}
						}
						tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe72a;</i> 联系人详情<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+dataRow[0].project.projectName+'</div>', ['80%', '80%'], 'userbj', $("#bjnrEdit"), ['确定','关闭'], _funbtnxs);
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
								url: '${pageContext.request.contextPath }/contact/delete',
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
			// 搜索
			var $ = layui.$, active = {
				reload: function () {
					//执行重载
					table.reload('contactReload', {
						url: '${pageContext.request.contextPath }/contact/searchList',
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
					permission('${sessionScope.CurrentUser.roleID}','项目联系列表');
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
					form.render("select");
				}
			});
			permission('${sessionScope.CurrentUser.roleID}','项目联系列表');
		});
   </script>
</body>
</html>