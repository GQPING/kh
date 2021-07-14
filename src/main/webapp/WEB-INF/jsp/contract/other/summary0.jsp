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
        <span class="c-gray en">&gt;</span> 项目数量明细
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
        // 默认合计
        let total = 0;
        let jsonArr = new Array();
        // 刷新默认
        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath }/project/searchSummary0",
            data:{time : time},
            async: false,
            success: function (data) {
                var obj = eval(data);
                $(obj).each(function (index) {
                    var val = obj[index];
                    jsonArr[index] = val;
                    total = total + val.projects;// 总项目数
                });
            },
            error: function (data) { }
        });
        if (total != 0) {
            document.getElementById('container').style.display = 'block';
            let echarts1 = echarts.init(document.getElementById('container'));
            let echarts1_option = {
                title : {
                    text: time+'年项目数量统计（个）',
                    textStyle:{
                        color:"#595959",
                        fontSize: 18,
                        fontWeight:"bold"
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
                            res+='<p>'+params[i].seriesName+'：'+params[i].data+' 个</p>'
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
                    data: ['项目合计', '未到期数', '到期个数', '到期已结清', '到期未结清'],
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
                        return param.name + '：' + param.value + ' 台';
                    }*/
                },
                series: [{
                    name: '项目合计',
                    data: [jsonArr[0].projects,
                        jsonArr[1].projects,
                        jsonArr[2].projects,
                        jsonArr[3].projects,
                        jsonArr[4].projects,
                        jsonArr[5].projects,
                        jsonArr[6].projects,
                        jsonArr[7].projects,
                        jsonArr[8].projects,
                        jsonArr[9].projects,
                        jsonArr[10].projects,
                        jsonArr[11].projects],
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
                            color: "#a52a2a"
                        },
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    },
                    barWidth: 15,
                }, {
                    name: '未到期数',
                    data: [jsonArr[0].unEnds,
                        jsonArr[1].unEnds,
                        jsonArr[2].unEnds,
                        jsonArr[3].unEnds,
                        jsonArr[4].unEnds,
                        jsonArr[5].unEnds,
                        jsonArr[6].unEnds,
                        jsonArr[7].unEnds,
                        jsonArr[8].unEnds,
                        jsonArr[9].unEnds,
                        jsonArr[10].unEnds,
                        jsonArr[11].unEnds],
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
                    name: '到期个数',
                    data: [jsonArr[0].inEnds,
                        jsonArr[1].inEnds,
                        jsonArr[2].inEnds,
                        jsonArr[3].inEnds,
                        jsonArr[4].inEnds,
                        jsonArr[5].inEnds,
                        jsonArr[6].inEnds,
                        jsonArr[7].inEnds,
                        jsonArr[8].inEnds,
                        jsonArr[9].inEnds,
                        jsonArr[10].inEnds,
                        jsonArr[11].inEnds],
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
                            color: "#90ed7d"
                        },
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    },
                    barWidth: 15,
                }, {
                    name: '到期已结清',
                    data: [jsonArr[0].inPayEnds,
                        jsonArr[1].inPayEnds,
                        jsonArr[2].inPayEnds,
                        jsonArr[3].inPayEnds,
                        jsonArr[4].inPayEnds,
                        jsonArr[5].inPayEnds,
                        jsonArr[6].inPayEnds,
                        jsonArr[7].inPayEnds,
                        jsonArr[8].inPayEnds,
                        jsonArr[9].inPayEnds,
                        jsonArr[10].inPayEnds,
                        jsonArr[11].inPayEnds],
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
                            color: "#f7a35c"
                        },
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    },
                    barWidth: 15,
                }, {
                    name: '到期未结清',
                    data: [jsonArr[0].unPayEnds,
                        jsonArr[1].unPayEnds,
                        jsonArr[2].unPayEnds,
                        jsonArr[3].unPayEnds,
                        jsonArr[4].unPayEnds,
                        jsonArr[5].unPayEnds,
                        jsonArr[6].unPayEnds,
                        jsonArr[7].unPayEnds,
                        jsonArr[8].unPayEnds,
                        jsonArr[9].unPayEnds,
                        jsonArr[10].unPayEnds,
                        jsonArr[11].unPayEnds],
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
                            color: "#c2c2c2"
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