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
			<span class="c-gray en">&gt;</span> 开荒项目列表
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href='${ctx}/project/list');">
				<i class="Hui-iconfont">&#xe68f;</i>
			</a>
		</nav>
		<div class="page-container">
			<div class="layui-tab" lay-filter="projectTab">
				<ul class="layui-tab-title">
					<li class="layui-this" lay-id="1">所有开荒的项目</li>
					<li lay-id="2">已申请开票项目</li>
					<li lay-id="3">未申请开票项目</li>
					<li lay-id="4">已申请且未开票项目</li>
					<li lay-id="5">已申请且已开票项目</li>
				</ul>
				<div class="layui-tab-content">
					<div class="layui-tab-item layui-show">
						<div class="mt" style="padding:-12px 0px 0px 0px;">
							<div class="demoTable layui-form">
								<div class="layui-inline" style="width: 100%;">
									<div class="layui-inline" style="width: 20%;position:relative;min-width: 330px;padding: 6px 12px 12px 0px;">
										<div style="position:absolute;right:2px;top:10px;cursor:pointer;display: none;padding: 6px 12px 12px 0px;" class="input_clear">
											<button type="button" class="clear" style="border: 0px;background-color:white;">
												<i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
											</button>
										</div>
										<input class="layui-input" oninput="showClear(this)" id="searchString1" autocomplete="off" placeholder="请输入内容查询">
									</div>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 0px 12px 0px;">
										<input class="layui-input" id="timeStart1" autocomplete="off" placeholder="开始日期">
									</div>
									<span style="color:#555;font-weight: bold;font-size:16px;padding: 12px 0px 12px 0px;">-</span>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 12px 12px 0px;">
										<input class="layui-input" id="timeFinal1" autocomplete="off" placeholder="结束日期">
									</div>
									<button class="layui-btn" data-type="reload" style="margin:-6px 0px 0px 0px;padding: 0px 12px 0px 12px;">
										<i class="Hui-iconfont">&#xe665;</i>
									</button>
								</div>
							</div>
						</div>
						<table class="layui-hide" id="LAY_table_user1" lay-filter="user1"></table>
					</div>
					<div class="layui-tab-item">
						<div class="mt" style="padding:-12px 0px 0px 0px;">
							<div class="demoTable layui-form">
								<div class="layui-inline" style="width: 100%;">
									<div class="layui-inline" style="width: 20%;position:relative;min-width: 330px;padding: 6px 12px 12px 0px;">
										<div style="position:absolute;right:2px;top:10px;cursor:pointer;display: none;padding: 6px 12px 12px 0px;" class="input_clear">
											<button type="button" class="clear" style="border: 0px;background-color:white;">
												<i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
											</button>
										</div>
										<input class="layui-input" oninput="showClear(this)" id="searchString2" autocomplete="off" placeholder="请输入内容查询">
									</div>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 0px 12px 0px;">
										<input class="layui-input" id="timeStart2" autocomplete="off" placeholder="开始日期">
									</div>
									<span style="color:#555;font-weight: bold;font-size:16px;padding: 12px 0px 12px 0px;">-</span>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 12px 12px 0px;">
										<input class="layui-input" id="timeFinal2" autocomplete="off" placeholder="结束日期">
									</div>
									<button class="layui-btn" data-type="reload" style="margin:-6px 0px 0px 0px;padding: 0px 12px 0px 12px;">
										<i class="Hui-iconfont">&#xe665;</i>
									</button>
								</div>
							</div>
						</div>
						<table class="layui-hide" id="LAY_table_user2" lay-filter="user2"></table>
					</div>
					<div class="layui-tab-item">
						<div class="mt" style="padding:-12px 0px 0px 0px;">
							<div class="demoTable layui-form">
								<div class="layui-inline" style="width: 100%;">
									<div class="layui-inline" style="width: 20%;position:relative;min-width: 330px;padding: 6px 12px 12px 0px;">
										<div style="position:absolute;right:2px;top:10px;cursor:pointer;display: none;padding: 6px 12px 12px 0px;" class="input_clear">
											<button type="button" class="clear" style="border: 0px;background-color:white;">
												<i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
											</button>
										</div>
										<input class="layui-input" oninput="showClear(this)" id="searchString3" autocomplete="off" placeholder="请输入内容查询">
									</div>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 0px 12px 0px;">
										<input class="layui-input" id="timeStart3" autocomplete="off" placeholder="开始日期">
									</div>
									<span style="color:#555;font-weight: bold;font-size:16px;padding: 12px 0px 12px 0px;">-</span>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 12px 12px 0px;">
										<input class="layui-input" id="timeFinal3" autocomplete="off" placeholder="结束日期">
									</div>
									<button class="layui-btn" data-type="reload" style="margin:-6px 0px 0px 0px;padding: 0px 12px 0px 12px;">
										<i class="Hui-iconfont">&#xe665;</i>
									</button>
								</div>
							</div>
						</div>
						<table class="layui-hide" id="LAY_table_user3" lay-filter="user3"></table>
					</div>
					<div class="layui-tab-item">
						<div class="mt" style="padding:-12px 0px 0px 0px;">
							<div class="demoTable layui-form">
								<div class="layui-inline" style="width: 100%;">
									<div class="layui-inline" style="width: 20%;position:relative;min-width: 330px;padding: 6px 12px 12px 0px;">
										<div style="position:absolute;right:2px;top:10px;cursor:pointer;display: none;padding: 6px 12px 12px 0px;" class="input_clear">
											<button type="button" class="clear" style="border: 0px;background-color:white;">
												<i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
											</button>
										</div>
										<input class="layui-input" oninput="showClear(this)" id="searchString4" autocomplete="off" placeholder="请输入内容查询">
									</div>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 0px 12px 0px;">
										<input class="layui-input" id="timeStart4" autocomplete="off" placeholder="开始日期">
									</div>
									<span style="color:#555;font-weight: bold;font-size:16px;padding: 12px 0px 12px 0px;">-</span>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 12px 12px 0px;">
										<input class="layui-input" id="timeFinal4" autocomplete="off" placeholder="结束日期">
									</div>
									<button class="layui-btn" data-type="reload" style="margin:-6px 0px 0px 0px;padding: 0px 12px 0px 12px;">
										<i class="Hui-iconfont">&#xe665;</i>
									</button>
								</div>
							</div>
						</div>
						<table class="layui-hide" id="LAY_table_user4" lay-filter="user4"></table>
					</div>
					<div class="layui-tab-item">
						<div class="mt" style="padding:-12px 0px 0px 0px;">
							<div class="demoTable layui-form">
								<div class="layui-inline" style="width: 100%;">
									<div class="layui-inline" style="width: 20%;position:relative;min-width: 330px;padding: 6px 12px 12px 0px;">
										<div style="position:absolute;right:2px;top:10px;cursor:pointer;display: none;padding: 6px 12px 12px 0px;" class="input_clear">
											<button type="button" class="clear" style="border: 0px;background-color:white;">
												<i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
											</button>
										</div>
										<input class="layui-input" oninput="showClear(this)" id="searchString5" autocomplete="off" placeholder="请输入内容查询">
									</div>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 0px 12px 0px;">
										<input class="layui-input" id="timeStart5" autocomplete="off" placeholder="开始日期">
									</div>
									<span style="color:#555;font-weight: bold;font-size:16px;padding: 12px 0px 12px 0px;">-</span>
									<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 12px 12px 0px;">
										<input class="layui-input" id="timeFinal5" autocomplete="off" placeholder="结束日期">
									</div>
									<button class="layui-btn" data-type="reload" style="margin:-6px 0px 0px 0px;padding: 0px 12px 0px 12px;">
										<i class="Hui-iconfont">&#xe665;</i>
									</button>
								</div>
							</div>
						</div>
						<table class="layui-hide" id="LAY_table_user5" lay-filter="user5"></table>
					</div>
				</div>
			</div>
		</div>
		<%@include file="../../other/pops/edit/project.html" %>
		<%@include file="../../other/pops/read/projectRecord.html" %>
	</div>
	<%@include file="../../other/toolss.html" %>
	<%@include file="../../other/cols/projectTableCols.html" %>
	<%@include file="../../other/cols/projectRecordTableCols.html" %>
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		// lay加载
		layui.use(['laydate', 'element'], function () {
			let element = layui.element, laydate = layui.laydate;
			laydate.render({
				elem: '#billDate' //指定元素
			});
			laydate.render({
				elem: '#payDate' //指定元素
			});
			let dateEntryStart1 = laydate.render({
				elem: '#timeStart1',
				//theme: '#0079c4',
				trigger: 'click',
				//btns: ['clear', 'confirm'],
				// showBottom: false,
				done: function (value, date) {
					dateEntryEnd1.config.min = {
						year: date.year,
						month: date.month - 1,
						date: date.date,
						hours: date.hours,
						minutes: date.minutes,
						seconds: date.seconds
					};
					// 作为 结束选择 的 开始时间
					dateEntryEnd1.config.value = value;
				}
			});
			let dateEntryEnd1 = laydate.render({
				elem: '#timeFinal1',
				//theme: '#0079c4',
				trigger: 'click',//  触发方式
				//btns: ['clear', 'confirm'],// 底部按钮
				// showBottom: false,
				done: function (value, date) {// 选择完成回调
					dateEntryStart1.config.max = {
						year: date.year,
						month: date.month - 1,
						date: date.date,
						hours: date.hours,
						minutes: date.minutes,
						seconds: date.seconds
					};
					dateEntryStart1.config.value = value;
				}
			});
			let dateEntryStart2 = laydate.render({
				elem: '#timeStart2',
				//theme: '#0079c4',
				trigger: 'click',
				//btns: ['clear', 'confirm'],
				// showBottom: false,
				done: function (value, date) {
					dateEntryEnd2.config.min = {
						year: date.year,
						month: date.month - 1,
						date: date.date,
						hours: date.hours,
						minutes: date.minutes,
						seconds: date.seconds
					};
					// 作为 结束选择 的 开始时间
					dateEntryEnd2.config.value = value;
				}
			});
			let dateEntryEnd2 = laydate.render({
				elem: '#timeFinal2',
				//theme: '#0079c4',
				trigger: 'click',//  触发方式
				//btns: ['clear', 'confirm'],// 底部按钮
				// showBottom: false,
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
				}
			});
			let dateEntryStart3 = laydate.render({
				elem: '#timeStart3',
				//theme: '#0079c4',
				trigger: 'click',
				//btns: ['clear', 'confirm'],
				// showBottom: false,
				done: function (value, date) {
					dateEntryEnd3.config.min = {
						year: date.year,
						month: date.month - 1,
						date: date.date,
						hours: date.hours,
						minutes: date.minutes,
						seconds: date.seconds
					};
					// 作为 结束选择 的 开始时间
					dateEntryEnd3.config.value = value;
				}
			});
			let dateEntryEnd3 = laydate.render({
				elem: '#timeFinal3',
				//theme: '#0079c4',
				trigger: 'click',//  触发方式
				//btns: ['clear', 'confirm'],// 底部按钮
				// showBottom: false,
				done: function (value, date) {// 选择完成回调
					dateEntryStart3.config.max = {
						year: date.year,
						month: date.month - 1,
						date: date.date,
						hours: date.hours,
						minutes: date.minutes,
						seconds: date.seconds
					};
					dateEntryStart3.config.value = value;
				}
			});
			let dateEntryStart4 = laydate.render({
				elem: '#timeStart4',
				//theme: '#0079c4',
				trigger: 'click',
				//btns: ['clear', 'confirm'],
				// showBottom: false,
				done: function (value, date) {
					dateEntryEnd4.config.min = {
						year: date.year,
						month: date.month - 1,
						date: date.date,
						hours: date.hours,
						minutes: date.minutes,
						seconds: date.seconds
					};
					// 作为 结束选择 的 开始时间
					dateEntryEnd4.config.value = value;
				}
			});
			let dateEntryEnd4 = laydate.render({
				elem: '#timeFinal4',
				//theme: '#0079c4',
				trigger: 'click',//  触发方式
				//btns: ['clear', 'confirm'],// 底部按钮
				// showBottom: false,
				done: function (value, date) {// 选择完成回调
					dateEntryStart4.config.max = {
						year: date.year,
						month: date.month - 1,
						date: date.date,
						hours: date.hours,
						minutes: date.minutes,
						seconds: date.seconds
					};
					dateEntryStart4.config.value = value;
				}
			});
			let dateEntryStart5 = laydate.render({
				elem: '#timeStart5',
				//theme: '#0079c4',
				trigger: 'click',
				//btns: ['clear', 'confirm'],
				// showBottom: false,
				done: function (value, date) {
					dateEntryEnd5.config.min = {
						year: date.year,
						month: date.month - 1,
						date: date.date,
						hours: date.hours,
						minutes: date.minutes,
						seconds: date.seconds
					};
					// 作为 结束选择 的 开始时间
					dateEntryEnd5.config.value = value;
				}
			});
			let dateEntryEnd5 = laydate.render({
				elem: '#timeFinal5',
				//theme: '#0079c4',
				trigger: 'click',//  触发方式
				//btns: ['clear', 'confirm'],// 底部按钮
				// showBottom: false,
				done: function (value, date) {// 选择完成回调
					dateEntryStart5.config.max = {
						year: date.year,
						month: date.month - 1,
						date: date.date,
						hours: date.hours,
						minutes: date.minutes,
						seconds: date.seconds
					};
					dateEntryStart5.config.value = value;
				}
			});
			var i = 1;  // 默认切换
			element.tabChange('projectTab', i);
			inittable('LAY_table_user' + i, 'user' + i,i,null,null);
			// 监听Tab切换状态
			element.on('tab(projectTab)', function () {
				i = this.getAttribute('lay-id');
				if (i == 1) {
					inittable('LAY_table_user' + i, 'user' + i, i,null,null);
				} else if (i == 2) {
					inittable('LAY_table_user' + i, 'user' + i, i, 1, null);
				} else if (i == 3) {
					inittable('LAY_table_user' + i, 'user' + i, i, 0, null);
				}else if (i == 4) {
					inittable('LAY_table_user' + i, 'user' + i, i, 1, 0);
				}else if (i == 5) {
					inittable('LAY_table_user' + i, 'user' + i, i, 1, 1);
				}
			});
		});
		// 项目表格
		function inittable(elem,id,param0,param1,param2){
			// lay加载
			layui.use(['form','table','element'], function () {
				var form = layui.form;
				var table = layui.table;
				var element = layui.element;
				// 初始化表格
				table.render({
					elem: '#' + elem  // 指定表格
					, id: id
					, url: '${pageContext.request.contextPath}/project/searchList' //数据请求路径
					, method: 'post'
					, contentType: "application/json;charset=UTF-8"
					, where: {
						hasBill:param2,
						hasApplyBill:param1
					}// 默认显示已申请开票还未开票的记录
					, even: true // 开启隔行换色
					//, height: 'full-40' // 最大化适应表格高度
					, size: 'lg' //sm小尺寸的表格 lg大尺寸
					, cellMinWidth: 150 // 表格单元格最小宽度
					, toolbar: '#toolbarDemo'+param0 //开启头部工具栏，并为其绑定左侧模板
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
				table.on('tool('+id+')', function(obj){
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
				table.on('toolbar('+id+')', function (obj) {
					var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
					var isType = true;// 按平方类型，还是全包类型
					switch (obj.event) {
						case 'cashing':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return;
							}
							//弹出框开始
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var projectID = dataRow[0].id;// 选中项目id
									var payType = $("#payType").val();
									if (payType == "") {
										layer.msg('请选择收款类型', {icon: 0, time: 1000, anim: 6});
										return;
									}
									var payPerson = $("#payPerson").val();
									if (payPerson == "") {
										layer.msg('请输入收款人', {icon: 0, time: 1000, anim: 6});
										return;
									}
									var payQuota = $("#payQuota").val();
									if (payQuota == "") {
										layer.msg('请输入收款金额', {icon: 0, time: 1000, anim: 6});
										return;
									}
									var payDate = $("#payDate").val();
									if (payDate == "") {
										layer.msg('请选择收款日期', {icon: 0, time: 1000, anim: 6});
										return;
									}
									var remarkDescription = $("#cash_remarkDescription").val();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/cashing/add",
										data: JSON.stringify({
											payType: payType,
											payDate: payDate,
											payQuota: payQuota,
											projectID: projectID,
											payPerson: payPerson,
											remarkDescription: remarkDescription,
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
												layer.msg('添加失败!', {icon: 5, time: 1000, anim: 6});
											}
										}, error: function (data) {
											layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
								, xs2: function (index, layero) {
									layer.close(index);
								}, success: function (layero) {
									$("#cash_projectName").val(dataRow[0].projectName);
								}
							}
							tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe604;</i> 新增收款<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+dataRow[0].projectName+'</div>', ['80%', '80%'], 'userbj', $("#bjnrCash"), ['确定','关闭'], _funbtnxs);
							break;
						case 'billing':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return;
							}
							//弹出框开始
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var projectID = dataRow[0].id;// 选中项目id
									var billType = $("#billType").val();
									if (billType == "") {
										layer.msg('请选择开票类型', {icon: 0, time: 1000, anim: 6});
										return;
									}
									var billQuota = $("#billQuota").val();
									if (billQuota == "") {
										layer.msg('请输入开票金额', {icon: 0, time: 1000, anim: 6});
										return;
									}
									var billDate = $("#billDate").val();
									if (billDate == "") {
										layer.msg('请选择开票日期', {icon: 0, time: 1000, anim: 6});
										return;
									}
									var remarkDescription = $("#bill_remarkDescription").val();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/bill/add",
										data: JSON.stringify({
											billDate: billDate,
											billType: billType,
											billQuota: billQuota,
											projectID: projectID,
											remarkDescription: remarkDescription,
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
									$("#bill_projectName").val(dataRow[0].projectName);
								}
							}
							tk('<div><i class="Hui-iconfont" style="font-size: 18px;">&#xe604;</i> 新增开票<i class="Hui-iconfont" style="font-size: 10px;"> &#xe63d; </i>'+dataRow[0].projectName+'</div>', ['80%', '80%'], 'userbj', $("#bjnrBill"), ['确定','关闭'], _funbtnxs);
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
					};
				});
				// 重载
				var $ = layui.$, active = {
					reload: function () {
						//执行重载
						table.reload(id, {
							url: '${pageContext.request.contextPath}/project/searchList',
							method: 'post',
							contentType: "application/json;charset=UTF-8",
							page: {
								curr: 1 //重新从第 1 页开始
							}, where: {
								timeStart: $('#timeStart'+param0).val() == "" ? null : $('#timeStart'+param0).val(),
								timeFinal: $('#timeFinal'+param0).val() == "" ? null : $('#timeFinal'+param0).val(),
								searchString: $('#searchString'+param0).val().trim() == "" ? null : $('#searchString'+param0).val().trim()
							}
						}, 'data');
						permissions('${sessionScope.CurrentUser.roleID}','开荒项目列表',param0);
					}
				};
				// 刷新
				$('.demoTable .layui-btn').on('click', function () {
					var type = $(this).data('type');
					active[type] ? active[type].call(this) : '';
				});
				permissions('${sessionScope.CurrentUser.roleID}','开荒项目列表',param0);
			});
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
		// 权限控制
		function permissions(roleID,menuName,id){
			// 权限
			$.ajax({
				url: '${pageContext.request.contextPath }/rolePermission/search',
				method: 'post',
				data: JSON.stringify({id:roleID,searchString:menuName}),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					operateControls(data,id);
				}, error: function (data) {
					layer.msg('权限获取异常!', {icon: 5, time: 1000, anim: 6});
				}
			});
		}
		// 控制操作权限
		function operateControls(data,id) {
			let obj = eval(data);
			$(obj).each(function (index) {
				let item = obj[index];
				switch (item.operation.operateName) {
					case "收款":
						document.getElementById("cashbtn"+id).style.display = "";
						break;
					case "开票":
						document.getElementById("billbtn"+id).style.display = "";
						break;
					case "刷新":
						document.getElementById("flushbtn"+id).style.display = "";
						break;
				}
			});
		}
   </script>
</body>
</html>