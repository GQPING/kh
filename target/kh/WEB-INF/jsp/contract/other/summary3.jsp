<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../other/meta.html"%>
	<%@include file="../../other/style.html" %>
</head>
<body>
<nav class="breadcrumb">
	<i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 项目管理
	<span class="c-gray en">&gt;</span> 项目数据汇总
	<span class="c-gray en">&gt;</span> 客户交易明细
	<a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);">
		<i class="Hui-iconfont">&#xe68f;</i>
	</a>
</nav>
<div class="page-container">
	<div class="mt">
		<div class="demoTable layui-form">
			<div class="layui-inline" style="width:100%;">
				<label><b>客户交易查询:</b></label>
				<div class="layui-input-inline">
					<select class="layui-input" id="customerID" lay-filter="customerID" lay-search placeholder="请指定客户">
						<option value="">请选择客户</option>
					</select>
				</div>
				<label class="layui-inline" id="worldlable" style="width: 190px;">
					<input id="worldId" style="width: 220px;" placeholder="请选择时间"
						   type="text" class="layui-input laydate-test" autocomplete="off">
				</label>
			</div>
		</div>
		<table class="layui-hide" id="LAY_table_user" lay-filter="user"></table>
	</div>
</div>
<script type="text/html" id="xuhao">
	{{d.LAY_TABLE_INDEX+1}}月
</script>
<script type="text/html" id="budgetsTpl">
	<span data-d="{{parseFloat(d.budgets).toFixed(2)}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{parseFloat(d.budgets).toFixed(2)}}元</span>
</script>
<script type="text/html" id="inQuotasTpl">
	<span data-d="{{parseFloat(d.inQuotas).toFixed(2)}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" style="color: #009688;" class="layui-table-label">{{parseFloat(d.inQuotas).toFixed(2)}}元</span>
</script>
<script type="text/html" id="unQuotasTpl">
	{{#  if(d.unQuotas === 0){ }}
	<span data-d="{{parseFloat(d.unQuotas).toFixed(2)}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()"class="layui-table-label">{{parseFloat(d.unQuotas).toFixed(2)}}元</span>
	{{#  } else { }}
	<span data-d="{{parseFloat(d.unQuotas).toFixed(2)}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" style="color: #FF5722;"  class="layui-table-label">{{parseFloat(d.unQuotas).toFixed(2)}}元</span>
	{{#  } }}
</script>
<script type="text/html" id="inPayEndsTpl">
	<span data-d="{{parseFloat(d.inPayEnds).toFixed(2)}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" style="color: #009688;" class="layui-table-label">{{parseFloat(d.inPayEnds).toFixed(2)}}元</span>
</script>
<script type="text/html" id="unPayEndsTpl">
	{{#  if(d.unPayEnds === 0){ }}
	<span data-d="{{parseFloat(d.unPayEnds).toFixed(2)}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{parseFloat(d.unPayEnds).toFixed(2)}}元</span>
	{{#  } else { }}
	<span data-d="{{parseFloat(d.unPayEnds).toFixed(2)}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" style="color: #FF5722;" class="layui-table-label">{{parseFloat(d.unPayEnds).toFixed(2)}}元</span>
	{{#  } }}
</script>
<script type="text/html" id="customerNameTpl">
	{{# var fn = function(){
	        if(d.customer!=null){
	           return d.customer.customerName;
	        }else{
	           return '---';
	        }
	    };
	}}
	<span data-d="{{fn()}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{fn()}}</span>
</script>
<%@include file="../../other/conjs.html" %>
<script type="text/javascript" src="${ctx}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${ctx}/lib/echarts/4.1.0.rc2/echarts.min.js"></script>
<script type="text/javascript">
	layui.use(['form', 'laydate', 'table'], function () {
		let form = layui.form;
		let table = layui.table;
		let laydate = layui.laydate;
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
				form.render("select");
			}, error: function (data) {
				$('#customerID').empty();
				$('#customerID').append('<option value="">请选择</option>');
				form.render("select");
			}
		});

		// 初始化表格
		table.render({
			elem: '#LAY_table_user' // 指定表格
			, id: 'summaryReload'
			, url: '${pageContext.request.contextPath }/project/searchSummary3' //数据请求路径
			, method: 'post'
			, where: {id:null,time:''}
			, even: true // 开启隔行换色
			, height: 'full-125' // 最大化适应表格高度
			, size: 'lg' //sm小尺寸的表格 lg大尺寸
			, cellMinWidth: 150 // 表格单元格最小宽度
			, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
			, cols: [[{
				   field: 'months',
				   title: '月份',
				   fixed: 'left',
				   align: 'center',
				   width:80,
				   unresize: true,
				   templet: '#xuhao'
			    }
				, {
					field: 'customerName',
					unresize:true,
					title: '客户名称',
					align: 'center',
					templet: '#customerNameTpl'
				}
				, {
					field: 'budgets',
					unresize: true,
					title: '应收',
					align: 'center',
					templet: '#budgetsTpl'
				}
				, {
					field: 'inQuotas',
					unresize: true,
					title: '回款',
					align: 'center',
					templet: '#inQuotasTpl'
				}
				, {
					field: 'unQuotas',
					unresize: true,
					title: '余款',
					align: 'center',
					templet: '#unQuotasTpl'
				}
				, {
					field: 'inPayEnds',
					unresize: true,
					title: '到期已收',
					align: 'center',
					templet: "#inPayEndsTpl"
				}
				, {
					field: 'unPayEnds',
					unresize: true,
					title: '到期未收',
					align: 'center',
					templet: '#unPayEndsTpl'
				}
			]]
			, page: false  //开启分页
			, response: {
				statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
			}
		});

		// 默认"年"条件
		laydate.render({
			elem: '#worldId',
			type: 'year',
			max: genTime('day'),
			//value: genTime('year'),
			showBottom: false,// 不会显示控件的底部栏区域
			//btns: ['clear', 'confirm'],
			change: function (value, date) {
				$("#worldId").val(value);
				if (value != "" && value.length > 0) {
					var time = value;
					var id = $("#customerID").val();
					table.reload('summaryReload', {
						url: '${pageContext.request.contextPath }/project/searchSummary3',
						method: 'post',
						where: {
							id:id,
							time: time
						}
					}, 'data');
				}
			},
			ready: function (date) {
				// 选择后关闭
				$(".layui-laydate").off('click').on('click', '.layui-laydate-list li', function () {
					$(".layui-laydate").remove();
				});
			}
		});

		// 客户下拉框值改变动态设置样式
		form.on('select(customerID)', function (data) {
			var id = data.value;
			var time = $("#worldId").val();
			table.reload('summaryReload', {
				url: '${pageContext.request.contextPath }/project/searchSummary3',
				method: 'post',
				where: {
					id: id == '' ? null : id,
					time: time
				}
			}, 'data');
		});
	});

	// 时间
	function genTime(opt) {
		let now = new Date();
		let year = now.getFullYear();
		let mth = now.getMonth();
		let day = now.getDate();
		let month = mth + 1;
		if (month < 10) {
			month = '0' + month
		}
		if (day < 10) {
			day = '0' + day
		}
		let str;
		if (opt == 'day') {
			str = year + '-' + month + '-' + day;
		} else if (opt == 'month') {
			str = year + '-' + month;
		}
		return str;
	}
	// 初始数据
	$(function () {
		let time = (new Date()).getFullYear();
		$('#worldId').val(time);
	});
</script>
</body>
</html>