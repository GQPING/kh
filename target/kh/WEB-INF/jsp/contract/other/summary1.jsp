<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
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
		<span class="c-gray en">&gt;</span> 项目数据汇总
		<span class="c-gray en">&gt;</span> 项目收支明细
		<a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);">
			<i class="Hui-iconfont">&#xe68f;</i>
		</a>
	</nav>
	<div class="page-container">
		<div class="layui-form" style="height: 31px;">
			<label><b>汇总条件:</b></label>
			<div class="layui-input-inline">
				<select name="type" id="selectedOption" lay-filter="college">
					<option value="year" selected="selected">按年统计</option>
				</select>
			</div>
			<label class="layui-inline" id="worldlable" style="width: 190px;">
				<input id="worldId" style="width: 220px;" placeholder="请点击选择时间" type="text" class="layui-input laydate-test">
			</label>
		</div>
		<div id="container" style="margin-top:30px;min-width:800px;height:600px"></div>
	</div>
</div>
<%@include file="../../other/conjs.html" %>
<script type="text/javascript" src="${ctx}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${ctx}/lib/echarts/4.1.0.rc2/echarts.min.js"></script>
<script type="text/javascript">
	layui.use(['form', 'laydate'], function () {
		let form = layui.form;
		let laydate = layui.laydate;
		// 默认"年"条件
		laydate.render({
			elem: '#worldId',
			type: 'year',
			max: genTime('day'),
			showBottom: false,
			change: function (value, date) {
				$("#worldId").val(value);
				if (value != "" && value.length > 0) {
					submitAction(value);
				}
			},
			ready: function (date) {
				// 选择后关闭
				$(".layui-laydate").off('click').on('click', '.layui-laydate-list li', function () {
					$(".layui-laydate").remove();
				});
			}
		});
		form.on('select(college)', function (data) {
			let opt = $("#selectedOption").val();
			let ele = $("#selectedOption");
			$("#worldId").remove();
			$("#worldlable").html('<input id="worldId" style="width:220px;" placeholder="请点击选择时间" type="text" class="layui-input laydate-test">');
			// 年
			laydate.render({
				elem: '#worldId',
				type: 'year',
				max: genTime('day'),
				showBottom: false,
				change: function (value, date) {
					$("#worldId").val(value);
					if (value != "" && value.length > 0) {
						submitAction(value);
					}
				},
				ready: function (date) {
					$(".layui-laydate").off('click').on('click', '.layui-laydate-list li', function () {
						$(".layui-laydate").remove();
					});
				}
			});
		});
	});

	// 获取时间
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

	// 提交条件查询
	function submitAction(time){
		// 默认预算
		let total = 0.0;
		let jsonArr = new Array();
		// 刷新默认
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath }/project/searchSummary1",
			data:{time : time, type:""},
			async: false,
			success: function (data) {
				var obj = eval(data);
				$(obj).each(function (index) {
					var val = obj[index];
					jsonArr[index] = val;
					total = total + val.budgets;
				});
			},
			error: function (data) { }
		});
		if (total != 0.0) {
			document.getElementById('container').style.display = 'block';
			/*let total = jsonArr[0].budgets +
					jsonArr[1].budgets +
					jsonArr[2].budgets +
					jsonArr[3].budgets +
					jsonArr[4].budgets +
					jsonArr[5].budgets +
					jsonArr[6].budgets +
					jsonArr[7].budgets +
					jsonArr[8].budgets +
					jsonArr[9].budgets +
					jsonArr[10].budgets +
					jsonArr[11].budgets;*/
			let echarts1 = echarts.init(document.getElementById('container'));
			let echarts1_option = {
				title : {
					text:time+'年项目收支统计（元）',
					//subtext:'总计:'+total+"元",
					textStyle:{
						color:"#595959",
						fontSize: 18,
						fontWeight:"bold"
					},
					subtextStyle:{
						fontSize: 14,
					},
					left: 'center'
				},
				color: '#1890ff',
				tooltip : {
					trigger: 'axis',
					axisPointer : {            // 坐标轴指示器，坐标轴触发有效
						type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
					},
					formatter: function (params) {
						var res='<div><p>时间：'+ time + '年' +params[0].name+'</p></div>'
						for(var i=0;i<params.length;i++){
							res+='<p>'+params[i].seriesName+'：'+params[i].data+' 元</p>'
						}
						return res;
					}
				},
				toolbox: {
					show: true,
					feature: {
						dataView: {show: true, readOnly: false},
						magicType: {show: true, type: ['line', 'bar']},
						restore: {show: true},
						saveAsImage: {show: true}
					},
					padding:[0,30,30,0] //可设定图例[距上方距离，距右方距离，距下方距离，距左方距离]
				},
				legend: {
					data: ['合计', '预算', '收入'],
					orient: 'vertical',
					left: 'center',
					bottom:'bottom',
					padding:[30,0,0,0] //可设定图例[距上方距离，距右方距离，距下方距离，距左方距离]
				},
				calculable: true,
				xAxis: {
					type: 'category',
					data: ['1月', '2月', '3月', '4月','5月','6月','7月','8月','9月','10月', '11月', '12月']
				},
				yAxis: {
					type: 'value'
				},
				label: {
					fontSize: 14,
					color: '#666'/*,
					formatter: function (param) {
						return param.name + '：' + param.value + ' 元';
					}*/
				},
				series: [{
					name: '合计',
					data: [jsonArr[0].budgets,
						jsonArr[1].budgets,
						jsonArr[2].budgets,
						jsonArr[3].budgets,
						jsonArr[4].budgets,
						jsonArr[5].budgets,
						jsonArr[6].budgets,
						jsonArr[7].budgets,
						jsonArr[8].budgets,
						jsonArr[9].budgets,
						jsonArr[10].budgets,
						jsonArr[11].budgets],
					type: 'bar',
					/*markPoint: {
						data: [
							{type: 'max', name: '最大值'},
							{type: 'min', name: '最小值'}
						]
					},
					markLine: {
						data: [
							{type: 'average', name: '平均值'}
						]
					},*/
					itemStyle: {
						normal: {
							color: "#48d0df"
						},
						emphasis: {
							shadowBlur: 10,
							shadowOffsetX: 0,
							shadowColor: 'rgba(0, 0, 0, 0.5)'
						}
					},
					barWidth: 15,
				},{
					name: '预算',
					data: [jsonArr[0].costs,
						jsonArr[1].costs,
						jsonArr[2].costs,
						jsonArr[3].costs,
						jsonArr[4].costs,
						jsonArr[5].costs,
						jsonArr[6].costs,
						jsonArr[7].costs,
						jsonArr[8].costs,
						jsonArr[9].costs,
						jsonArr[10].costs,
						jsonArr[11].costs],
					type: 'bar',
					/*markPoint: {
						data: [
							{type: 'max', name: '最大值'},
							{type: 'min', name: '最小值'}
						]
					},
					markLine: {
						data: [
							{type: 'average', name: '平均值'}
						]
					},*/
					itemStyle: {
						normal: {
							color: "#1890ff"
						},
						emphasis: {
							shadowBlur: 10,
							shadowOffsetX: 0,
							shadowColor: 'rgba(0, 0, 0, 0.5)'
						}
					},
					barWidth: 15,
				}, {
					name: '收入',
					data: [jsonArr[0].incomes,
						jsonArr[1].incomes,
						jsonArr[2].incomes,
						jsonArr[3].incomes,
						jsonArr[4].incomes,
						jsonArr[5].incomes,
						jsonArr[6].incomes,
						jsonArr[7].incomes,
						jsonArr[8].incomes,
						jsonArr[9].incomes,
						jsonArr[10].incomes,
						jsonArr[11].incomes],
					type: 'bar',
					/*markPoint: {
						data: [
							{type: 'max', name: '最大值'},
							{type: 'min', name: '最小值'}
						]
					},
					markLine: {
						data: [
							{type: 'average', name: '平均值'}
						]
					},*/
					itemStyle: {
						normal: {
							color: "#ff5722"
						},
						emphasis: {
							shadowBlur: 10,
							shadowOffsetX: 0,
							shadowColor: 'rgba(0, 0, 0, 0.5)'
						}
					},
					barWidth: 15,
				}]
			}
			// 初始化统计图
			echarts1.setOption(echarts1_option);
		} else {
			document.getElementById('container').style.display = 'none';
			layer.msg('无数据!', {time : 1000, anim: 6});
		}
	}
	// 初始数据
	$(function () {
		let time = (new Date()).getFullYear();
		submitAction(time);
		$('#worldId').val(time);
	});
</script>
</body>
</html>