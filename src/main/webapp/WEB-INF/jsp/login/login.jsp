<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../other/meta.html"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui/css/H-ui.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/lib/Hui-iconfont/1.0.9/iconfont.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui.ucenter/css/H-ui.ucenter.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/lib/layui/css/layui.css" media="all">
	<style type="text/css">
		#nickName-error {
			margin-top: 1px;
			line-height:25px;
		}
		#password-error {
			margin-top: 1px;
			line-height:25px;
		}
		#login-box {
			position: absolute;
			left: 60%;
			top: 45%;
			transform: translateX(-50%) translateY(-50%);
		}
		#slider {
			background-color: #f0f0f0;
			border-color: #f0f0f0;
			border-radius: 5px;
		}
		.slider-bg {
			border-color: #f0f0f0;
			border-radius: 5px;
		}
		.slider-item {
			background-color: #f0f0f0;
			border-color: #f0f0f0;
			border-radius: 5px;
		}
		.slider-btn {
			border-color: #f0f0f0;
			border-radius: 5px;
		}
	</style>
</head>
<body onload="loadTopWindow()">
	<div class="login-wraper">
		<div class="login-form radius box-shadow" id="login-box">
			<div class="clearfix pt-20">
				<i class="iconpic iconpic-logo" style="background-image: url(${ctx}/lib/media/image/logo.png);"></i>
			</div>
			<div class="row clearfix form-title">清晨雨开荒跟踪系统</div>
			<form class="form form-horizontal" id="form-admin-login" autocomplete="off">
				<div class="row clearfix" style="position:relative;">
					<div style="position:absolute;right:2px;top:11px;cursor:pointer;display: none;" class="input_clear">
						<button type="button" class="clear" style="border: 0px;background-color:#f0f0f0;">
							<i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
						</button>
					</div>
					<input type="text" oninput="showClear(this)" class="input-text radius size-L" value="" name="nickName" id="nickName" placeholder="昵称">
				</div>
				<div class="row clearfix">
					<input type="password" class="input-text radius size-L" value="" name="password" id="password" placeholder="密码">
				</div>
				<div class="row clearfix">
					<div class="input-text radius size-L" id="slider"></div>
				</div>
				<div class="row clearfix">
					<!--class="btn btn-primary btn-block radius size-L"-->
					<button class="layui-btn btn-block radius size-L">登录</button>
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript" src="${ctx}/lib/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/lib/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
	<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/validate-methods.js"></script>
	<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/messages_zh.js"></script>
	<script type="text/javascript">
		let slider;// 全局配置
		let layer;// 全局配置
		layui.config({
			base: '${ctx}/lib/sliderVerify/'
		}).extend({
			sliderVerify: 'sliderVerify'
		}).use(['sliderVerify','layer','jquery'], function() {
			let sliderVerify = layui.sliderVerify,
			$ = layui.jquery;
			layer = layui.layer;
			slider = sliderVerify.render({
				elem: '#slider',
				onOk: function(){//当验证通过回调
					layer.msg("滑块验证通过",{time : 1000});
					/*$.ajax({
						type:'POST',
						url: "${pageContext.request.contextPath}/login.action",
						data:JSON.stringify({
							nickName:$('#nickName').val(),
							password:$('#password').val()
						}),
						contentType:"application/json;charset=UTF-8",
						dataType : "json",
						success : function(data){
							if(data == "1"){
								layer.msg('登录成功!',{
									icon:1,
									time:1000,
									end:function(){
										location.href="${pageContext.request.contextPath}/main";
									}}
								);
							}else if(data == "2"){
								layer.msg('账号不存在!', {
									icon : 2,
									time : 1000,
									anim: 6,
									end:function(){
										$('#nickName').val('');
										$('#nickName').addClass('layui-form-danger').focus();
									}
								});
								slider.reset();
							}else if(data == "3"){
								layer.msg('密码错误!', {
									icon : 2,
									time : 1000,
									anim: 6,
									end:function(){
										$('#password').val('')
										$('#password').addClass('layui-form-danger').focus();
									}
								});
								slider.reset();
							}else{
								layer.msg('服务器发生异常，请稍后尝试!', {
									icon : 5,
									time : 1000,
									anim: 6
								});
								slider.reset();
							}
						},
						error:function(data){
							layer.msg('服务器发生异常，请稍后尝试!', {
								icon : 5,
								time : 1000,
								anim: 6
							});
							slider.reset();
						}
					});*/
				}
			});
		});
		$(function() {
			// 表单验证，提交
			$("#form-admin-login").validate({
				rules : {
					nickName : {
						required : true,
					},
					password : {
						required : true,
						rangelength : [ 6, 16 ]
					}
				},
				messages : {
					nickName : {
						required : "账户不能为空"
					},
					password : {
						required : "密码不能为空",
						rangelength : "密码长度6到16个字符,区分大小写"
					},
				},
				onkeyup : false,
				focusCleanup : false,
				submitHandler : function(form) {
					if(slider.isOk()) {//获取当前实例是否已经滑动成功
						// js出错会触发form提交(假象：POST请求变成GET请求，实际ajax提交已终止，触发form.submit();)
						// var nickName = $("#nickName").val() 或 form.nickName.value;// 错误：nickName.value
						$.ajax({
							type:'POST',
							url: "${pageContext.request.contextPath}/user/login",
							data:JSON.stringify({
								nickName:form.nickName.value,
								password:form.password.value
							}),
							contentType:"application/json;charset=UTF-8",
							dataType : "json",
							success : function(data){
								if(data == "1"){
									layer.msg('登录成功!',{
										icon:1,
										time:1000,
										end:function(){
											location.href="${pageContext.request.contextPath}/main";
										}}
									);
								}else if(data == "2"){
									layer.msg('账号不存在!', {
										icon : 2,
										time : 1000,
										anim: 6,
										end:function(){
											form.nickName.value="";
											form.nickName.focus();
											//$('#nickName').addClass('layui-form-danger').focus();
										}
									});
									slider.reset();
								}else if(data == "3"){
									layer.msg('密码错误!', {
										icon : 2,
										time : 1000,
										anim: 6,
										end:function(){
											form.password.value="";
											form.password.focus();
											//$('#password').addClass('layui-form-danger').focus();
										}
									});
									slider.reset();
								}else{
									layer.msg('服务器发生异常，请稍后尝试!', {
										icon : 5,
										time : 1000,
										anim: 6
									});
									slider.reset();
								}
							},
							error:function(data){
								layer.msg('服务器发生异常，请稍后尝试!', {
									icon : 5,
									time : 1000,
									anim: 6
								});
								slider.reset();
							}
						});
					}else{
						layer.msg("请先通过滑块验证", {icon: 5, time : 1000, anim: 6});
					}
					return false; // 阻止表单自动提交事件
				}
			});
		});
		// 会话失效退出iframe
		function loadTopWindow() {
			if (window.top != null && window.top.document.URL != document.URL) {
				window.top.location = document.URL;
			}
		}
		// input清除
		function showClear (obj) {
			if ($(obj).val() == '') {
				$(obj).parent().children(".input_clear").hide();
			}else{
				$(obj).parent().children(".input_clear").show();
			}
		}
		$("input").blur(function() {
			if ($(this).val() == '') {
				$(this).parent().children(".input_clear").hide();
			}
		});
		$(".input_clear").click(function() {
			$(this).parent().find('input').val('');
			$(this).hide();
		});
	</script>
</body>
</html>