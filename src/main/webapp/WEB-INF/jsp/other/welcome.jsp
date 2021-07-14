<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
	<%@include file="meta.html"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui/css/H-ui.min2.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/business/css/style.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/lib/Hui-iconfont/1.0.9/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-feature-carousel/css/feature-carousel.css"/>
</head>
<body>
<div class="wap-container">
		<article class="Hui-admin-content clearfix">
			<div class="row-24 clearfix" style="margin-left: -12px; margin-right: -12px;">
				<div class="col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6" style="padding-left: 12px; padding-right: 12px; margin-bottom: 24px;">
					<div class="panel">
						<div class="panel-header" style="padding:15px 24px;font-weight: 400;color:#999;">总项目数：</div>
						<div class="panel-body" style="padding:0 0px;">
							<div class="c-primary" style="font-size: 30px;line-height: 38px;padding:12px 24px;">
								${bean.totalProjects} 个
							</div>
							<div class="f-14" style="padding: 10px 24px;border-top:solid 1px #eee"><span class="c-999">今日新增项目</span> <span>${bean.todayProjects} 个</span></div>
						</div>
					</div>
				</div>
				<div class="col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6" style="padding-left: 12px; padding-right: 12px; margin-bottom: 24px;">
					<div class="panel">
						<div class="panel-header" style="padding:15px 24px;font-weight: 400;color:#999;">总应收款项：</div>
						<div class="panel-body" style="padding:0 0px;">
							<div class="c-primary" style="font-size: 30px;line-height: 38px;padding:12px 24px;">
								<f:formatNumber type="currency" value="${bean.totalBudgets}" maxFractionDigits="2"/>
							</div>
							<div class="f-14" style="padding: 10px 24px;border-top:solid 1px #eee"><span class="c-999">今日新增应收款项</span> <span><f:formatNumber type="currency" value="${bean.todayBudgets}" maxFractionDigits="2"/></span></div>
						</div>
					</div>
				</div>
				<div class="col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6" style="padding-left: 12px; padding-right: 12px; margin-bottom: 24px;">
					<div class="panel">
						<div class="panel-header" style="padding:15px 24px;font-weight: 400;color:#999;">总预算：</div>
						<div class="panel-body" style="padding:0 0px;">
							<div class="c-danger" style="font-size: 30px;line-height: 38px;padding:12px 24px;">
								<f:formatNumber type="currency" value="${bean.totalCosts}" maxFractionDigits="2"/>
							</div>
							<div class="f-14" style="padding: 10px 24px;border-top:solid 1px #eee"><span class="c-999">今日新增预算</span> <span><f:formatNumber type="currency" value="${bean.todayCosts}" maxFractionDigits="2"/></span></div>
						</div>
					</div>
				</div>
				<div class="col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6" style="padding-left: 12px; padding-right: 12px; margin-bottom: 24px;">
					<div class="panel">
						<div class="panel-header" style="padding:15px 24px;font-weight: 400;color:#999;">总收入：</div>
						<div class="panel-body" style="padding:0 0px;">
							<div class="c-success" style="font-size: 30px;line-height: 38px;padding:12px 24px;">
								<f:formatNumber type="currency" value="${bean.totalIncomes}" maxFractionDigits="2"/>
							</div>
							<div class="f-14" style="padding: 10px 24px;border-top:solid 1px #eee"><span class="c-999">今日新增收入</span> <span><f:formatNumber type="currency" value="${bean.todayIncomes}" maxFractionDigits="2"/></span></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row-24 clearfix" style="margin-left: -12px; margin-right: -12px;">
				<div class="col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6" style="padding-left: 12px; padding-right: 12px; margin-bottom: 24px;">
					<div class="panel">
						<div class="panel-header" style="padding:15px 24px;font-weight: 400;color:#999;">总回款：</div>
						<div class="panel-body" style="padding:0 0px;">
							<div class="c-success" style="font-size: 30px;line-height: 38px;padding:12px 24px;">
								<f:formatNumber type="currency" value="${bean.totalInQuotas}" maxFractionDigits="2"/>
							</div>
							<div class="f-14" style="padding: 10px 24px;border-top:solid 1px #eee"><span class="c-999">今日新增回款</span> <span><f:formatNumber type="currency" value="${bean.todayInQuotas}" maxFractionDigits="2"/></span></div>
						</div>
					</div>
				</div>
				<div class="col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6" style="padding-left: 12px; padding-right: 12px; margin-bottom: 24px;">
					<div class="panel">
						<div class="panel-header" style="padding:15px 24px;font-weight: 400;color:#999;">总余款：</div>
						<div class="panel-body" style="padding:0 0px;">
							<div class="c-danger" style="font-size: 30px;line-height: 38px;padding:12px 24px;">
								<f:formatNumber type="currency" value="${bean.totalUnQuotas}" maxFractionDigits="2"/>
							</div>
							<div class="f-14" style="padding: 10px 24px;border-top:solid 1px #eee"><span class="c-999">今日新增余款</span> <span><f:formatNumber type="currency" value="${bean.todayUnQuotas}" maxFractionDigits="2"/></span></div>
						</div>
					</div>
				</div>
				<div class="col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6" style="padding-left: 12px; padding-right: 12px; margin-bottom: 24px;">
					<div class="panel">
						<div class="panel-header" style="padding:15px 24px;font-weight: 400;color:#999;">总客户：</div>
						<div class="panel-body" style="padding:0 0px;">
							<div class="c-primary" style="font-size: 30px;line-height: 38px;padding:12px 24px;">
								${bean.totalCustomers} 人
							</div>
							<div class="f-14" style="padding: 10px 24px;border-top:solid 1px #eee"><span class="c-999">今日新增客户</span> <span>${bean.todayCustomers} 人</span></div>
						</div>
					</div>
				</div>
				<div class="col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6" style="padding-left: 12px; padding-right: 12px; margin-bottom: 24px;">
					<div class="panel">
						<div class="panel-header" style="padding:15px 24px;font-weight: 400;color:#999;">总用户：</div>
						<div class="panel-body" style="padding:0 0px;">
							<div class="c-primary" style="font-size: 30px;line-height: 38px;padding:12px 24px;">
								${bean.totalUsers} 人
							</div>
							<div class="f-14" style="padding: 10px 24px;border-top:solid 1px #eee"><span class="c-999">今日新增用户</span> <span>${bean.todayUsers} 人</span></div>
						</div>
					</div>
				</div>
			</div>
			<div class="panel">
				<div class="panel-body">
					<div class="carousel-container">
						<div id="carousel">
							<div class="carousel-feature">
								<img class="carousel-image" alt="QT300SA" src="${ctx}/static/jquery-feature-carousel/images/sample1.jpg">
								<div class="carousel-caption">
									<p>QT300SA.</p>
								</div>
							</div>
							<div class="carousel-feature">
								<img class="carousel-image" alt="QT800C" src="${ctx}/static/jquery-feature-carousel/images/sample2.jpg">
								<div class="carousel-caption">
									<p>QT800C.</p>
								</div>
							</div>
							<div class="carousel-feature">
								<img class="carousel-image" alt="QT1000C" src="${ctx}/static/jquery-feature-carousel/images/sample3.jpg">
								<div class="carousel-caption">
									<p>QT1000C.</p>
								</div>
							</div>
							<div class="carousel-feature">
								<img class="carousel-image" alt="QT1000PA" src="${ctx}/static/jquery-feature-carousel/images/sample4.jpg">
								<div class="carousel-caption">
									<p>QT1000PA.</p>
								</div>
							</div>
							<div class="carousel-feature">
								<img class="carousel-image" alt="QT1265D" src="${ctx}/static/jquery-feature-carousel/images/sample5.jpg">
								<div class="carousel-caption">
									<p>QT1265D.</p>
								</div>
							</div>
						</div>
						<div id="carousel-left">
							<img src="${ctx}/static/jquery-feature-carousel/images/arrow-left.jpg" />
						</div>
						<div id="carousel-right">
							<img src="${ctx}/static/jquery-feature-carousel/images/arrow-right.jpg" />
						</div>
					</div>
				</div>
			</div>
		</article>
		<footer class="footer Hui-admin-footer">
			Copyright &copy;2020 清晨雨清洁设备有限公司 tuodiche.cts v1.0 All Rights Reserved.<br> 本后台系统由<a href="http://www.h-ui.net/" target="_blank" title="H-ui前端框架">H-ui前端框架</a>提供前端技术支持</p>
		</footer>
	</div>
    <script type="text/javascript" src="${ctx}/static/jquery-feature-carousel/js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/jquery-feature-carousel/js/jquery.featureCarousel.min.js"></script>
    <script type="text/javascript">
		$(document).ready(function () {
			let carousel = $("#carousel").featureCarousel({});
		});
	</script>
</body>
</html>