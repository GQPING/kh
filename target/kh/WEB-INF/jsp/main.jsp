<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
  <%@include file="./other/meta.html"%>
  <link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui/css/H-ui.min.css"/>
  <link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui.admin.pro.iframe/css/h-ui.admin.pro.iframe.min.css"/>
  <link rel="stylesheet" type="text/css" href="${ctx}/lib/Hui-iconfont/1.0.9/iconfont.css"/>
  <link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui.admin.pro.iframe/skin/default/skin.css" id="skin"/>
  <link rel="stylesheet" type="text/css" href="${ctx}/static/business/css/style.css"/>
  <style type="text/css">
    .Hui-admin-aside-wrapper .Hui-admin-menu-dropdown .Hui-menu>.Hui-menu-item .Hui-menu>.Hui-menu-title {
      padding-left: 50px;
    }
  </style>
</head>
<body>
  <aside class="Hui-admin-aside-wrapper">
    <div class="Hui-admin-logo-wrapper">
      <a class="logo navbar-logo" href="#" target="_self">
        <i class="va-m iconpic global-logo" style="background-image: url(${ctx}/favicon.ico);"></i>
        <span class="va-m">清晨雨开荒跟踪系统</span>
      </a>
    </div>
    <div class="Hui-admin-menu-dropdown bk_2">
      <!-- 项目管理 -->
      <dl id="menu-contract" class="Hui-menu" style="display: none;">
        <dt class="Hui-menu-title"><i class="Hui-iconfont">&#xe639;</i> 项目管理<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
        <dd class="Hui-menu-item">
          <ul>
            <li id="contractset" style="display: none;"><a data-href="${ctx}/project/admin" data-title="开荒项目管理" href="javascript:void(0)">开荒项目管理</a></li>
            <li id="contractlist" style="display: none;"><a data-href="${ctx}/project/list" data-title="开荒项目列表" href="javascript:void(0)">开荒项目列表</a></li>
            <li id="contactlist" style="display: none;"><a data-href="${ctx}/contact/list" data-title="项目联系列表" href="javascript:void(0)">项目联系列表</a></li>
            <li id="cashinglist" style="display: none;"><a data-href="${ctx}/cashing/list" data-title="项目收款列表" href="javascript:void(0)">项目收款列表</a></li>
            <li id="billlist" style="display: none;"><a data-href="${ctx}/bill/list" data-title="项目开票列表" href="javascript:void(0)">项目开票列表</a></li>
            <li id="projectRecord" style="display: none;"><a data-href="${ctx}/project/record" data-title="项目档案列表" href="javascript:void(0)">项目档案列表</a></li>
            <li id="menu-summary" style="display: none;">
              <dl class="Hui-menu">
                <dt class="Hui-menu-title">项目数据汇总<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
                <dd class="Hui-menu-item">
                  <ul>
                    <li id="summary0" style="display: none;"><a data-href="${ctx}/project/summary0" data-title="项目数量明细" href="javascript:void(0)">项目数量明细</a></li>
                    <li id="summary1" style="display: none;"><a data-href="${ctx}/project/summary1" data-title="项目收支明细" href="javascript:void(0)">项目收支明细</a></li>
                    <li id="summary2" style="display: none;"><a data-href="${ctx}/project/summary2" data-title="项目回款明细" href="javascript:void(0)">项目回款明细</a></li>
                    <li id="summary3" style="display: none;"><a data-href="${ctx}/project/summary3" data-title="客户交易明细" href="javascript:void(0)">客户交易明细</a></li>
                  </ul>
                </dd>
              </dl>
            </li>
          </ul>
        </dd>
      </dl>
      <!-- 客户管理 -->
      <dl id="menu-customer" class="Hui-menu" style="display: none;">
        <dt class="Hui-menu-title"><i class="Hui-iconfont">&#xe60d;</i> 客户管理<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
        <dd class="Hui-menu-item">
          <ul>
            <li id="customerlist" style="display: none;"><a data-href="${ctx}/customer/list" data-title="客户信息列表" href="javascript:void(0)">客户信息列表</a></li>
            <li id="customerRecord" style="display: none;"><a data-href="${ctx}/customer/record" data-title="客户档案列表" href="javascript:void(0)">客户档案列表</a></li>
          </ul>
        </dd>
      </dl>
      <!-- 用户管理 -->
      <dl id="menu-user" class="Hui-menu" style="display: none;">
        <dt class="Hui-menu-title"><i class="Hui-iconfont">&#xe62c;</i> 用户管理<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
        <dd class="Hui-menu-item">
          <ul>
            <li id="userlist" style="display: none;"><a data-href="${ctx}/user/list" data-title="用户列表" href="javascript:void(0)">用户列表</a></li>
            <li id="updatepwd" style="display: none;"><a data-href="${ctx}/user/password" data-title="修改密码" href="javascript:void(0)">修改密码</a></li>
          </ul>
        </dd>
      </dl>
      <!-- 系统管理 -->
      <dl id="menu-system" class="Hui-menu" style="display: none;">
        <dt class="Hui-menu-title"><i class="Hui-iconfont">&#xe62e;</i> 系统管理<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
        <dd class="Hui-menu-item">
          <ul>
            <li id="rolelist" style="display: none;"><a data-href="${ctx}/role/list" data-title="角色列表" href="javascript:void(0)">角色列表</a></li>
            <li id="permissionlist" style="display: none;"><a data-href="${ctx}/permission/list" data-title="权限列表" href="javascript:void(0)">权限列表</a></li>
            <li id="menulist" style="display: none;"><a data-href="${ctx}/menu/list" data-title="菜单列表" href="javascript:void(0)">菜单列表</a></li>
            <li id="operationlist" style="display: none;"><a data-href="${ctx}/operation/list" data-title="操作列表" href="javascript:void(0)">操作列表</a></li>
            <li id="loglist" style="display: none;"><a data-href="${ctx}/log/list" data-title="系统日志" href="javascript:void(0)">系统日志</a></li>
          </ul>
        </dd>
      </dl>
    </div>
  </aside>
  <div class="Hui-admin-aside-mask"></div>
  <div class="Hui-admin-dislpayArrow">
    <a href="javascript:void(0);" onClick="displaynavbar(this)">
      <i class="Hui-iconfont Hui-iconfont-left">&#xe6d4;</i>
      <i class="Hui-iconfont Hui-iconfont-right">&#xe6d7;</i>
    </a>
  </div>
  <c:set var="pop" value="false"/>
  <c:forEach items="${sessionScope.CurrentUser.permissions}" var="item">
    <c:choose>
      <c:when test="${item.menu.menuName eq '项目提醒弹窗' && item.operation.operateName eq '查看'}"><c:set var="pop" value="true"/></c:when>
    </c:choose>
  </c:forEach>
  <section class="Hui-admin-article-wrapper">
    <header class="Hui-navbar">
      <div class="navbar">
        <div class="container-fluid clearfix">
          <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar" style="text-align: right;">
            <ul class="clearfix">
              <li>${sessionScope.CurrentUser.role.roleName} : </li>
              <li class="dropDown dropDown_hover">
                <a href="#" class="dropDown_A">${sessionScope.CurrentUser.userName}<i class="Hui-iconfont">&#xe6d5;</i></a>
                <ul class="dropDown-menu menu radius box-shadow" style="background-color:rgba(255,255,255,0.5);">
                  <li><a data-href="${ctx}/user/password" data-title="修改密码" onClick="Hui_admin_tab(this)" href="javascript:;">修改密码</a></li>
                  <li><a data-href="#" href="javascript:;" onClick="exit()" title="退出" >退出</a></li>
                </ul>
              </li>
              <c:choose>
                <c:when test="${pop == false}">
                  <li id="Hui-msg" class="dropDown dropDown_hover right">
                    <a href="javascript:;">
                      <span class="badge"></span>
                      <i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i>
                    </a>
                  </li>
                </c:when>
                <c:when test="${pop == true && data == 0}">
                  <li id="Hui-msg" class="dropDown dropDown_hover right">
                    <a href="javascript:;">
                      <span class="badge"></span>
                      <i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i>
                    </a>
                  </li>
                </c:when>
                <c:when test="${pop == true && data == 1}">
                  <li id="Hui-msg" class="dropDown dropDown_hover right">
                    <c:set var="remind" value="1"></c:set>
                    <a class="dropDown_A" title="消息" href="javascript:;">
                      <span class="badge badge-danger">1</span>
                      <i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i>
                    </a>
                    <ul class="dropDown-menu menu radius box-shadow" style="background-color:rgba(255,255,255,0.5);">
                      <li class=""><a data-href="#" href="javascript:;" onClick="remind()">回款提醒</a></li>
                    </ul>
                  </li>
                </c:when>
              </c:choose>
            </ul>
          </nav>
        </div>
      </div>
    </header>
    <div id="Hui-admin-tabNav" class="Hui-admin-tabNav">
      <div class="Hui-admin-tabNav-wp">
        <ul id="min_title_list" class="acrossTab clearfix" style="width: 241px; left: 0px;">
          <li class="active"><span title="我的桌面" data-href="${ctx}/welcome">我的桌面</span><em></em></li>
        </ul>
      </div>
      <div class="Hui-admin-tabNav-more btn-group" style="display: none;">
        <a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a>
        <a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a>
      </div>
    </div>
    <div id="iframe_box" class="Hui-admin-article">
      <div class="show_iframe">
        <iframe id="iframe-welcome" data-scrolltop="0" scrolling="yes" frameborder="0" src="${ctx}/welcome"></iframe>
      </div>
    </div>
  </section>
  <div class="contextMenu" id="Huiadminmenu">
    <ul>
      <li id="closethis">关闭当前 </li>
      <li id="closeother">关闭其他 </li>
      <li id="closeall">关闭全部 </li>
    </ul>
  </div>
  <script type="text/javascript" src="${ctx}/lib/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript" src="${ctx}/lib/media/js/control.js"></script>
  <script type="text/javascript" src="${ctx}/lib/layer/3.1.1/layer.js"></script>
  <script type="text/javascript" src="${ctx}/static/h-ui/js/H-ui.min.js"></script>
  <script type="text/javascript" src="${ctx}/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
  <script type="text/javascript" src="${ctx}/static/h-ui.admin.pro.iframe/js/h-ui.admin.pro.iframe.min.js"></script>
  <script>
    // 关闭或刷新前，不访问服务器
    /*window.addEventListener("beforeunload", function(e) {
       e = e || window.event;
       // 兼容IE8和Firefox 4之前的版本
       if (e) {
         e.returnValue = '关闭提示';
       }
       // Chrome, Safari, Firefox 4+, Opera 12+ , IE 9+
       return '关闭提示';
    });

    // 关闭或刷新，访问服务器
    window.addEventListener("unload", function (event) {
       var a_n = window.event.screenX - window.screenLeft;
       var a_b = a_n > document.documentElement.scrollWidth-20;
       if(a_b && window.event.clientY< 0 || window.event.altKey){
          location.href="${pageContext.request.contextPath }/close";
       }else{
          //alert('跳转或者刷新页面行为');
       }
    });*/
    // 初始化
    $(function () {
        // 权限控制
        menuPermission('${sessionScope.CurrentUser.roleID}');
        let remind = "${remind}";
        if (remind == '1') {
            layer_show('项目回款提醒', '${ctx}/remind');
        }
    });
    // 提醒
    function remind() {
        layer_show('项目回款提醒', '${ctx}/remind');
    }
    // 退出
    function exit(){
		layer.confirm('确认要退出吗？',function(index){
			location.href = "${pageContext.request.contextPath }/exit";
		});
	}
    // 弹窗
    function layer_show(title,url){
    	if (title == null || title == '') {
    		title=false;
    	};
    	if (url == null || url == '') {
    		url="404.html";
    	};
    	var index = layer.open({
    		type: 2,
    		area: ['100%', '600px'],
    		fix: false, // 固定
    		maxmin: false,// 最大最小化
    		shade:0.4,
    		title: title,
    		content: url,
    		success: function(layero,index){
              //layero.find('.layui-layer-max').remove();// 不开放最小化
              //layero.find('.layui-layer-min').remove();// 不开放最小化
              //layer.iframeAuto(index);// 弹窗高度自适应
            }
    	});
        parent.layer.full(index);
    }
    // 权限控制
    function menuPermission(roleID) {
      // 获取权限
      $.ajax({
        url: '${pageContext.request.contextPath }/rolePermission/search',
        method: 'post',
        data: JSON.stringify({id: roleID}),
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
        success: function (data) {
          menuControl(data);
        }, error: function (data) {
          layer.msg('权限获取异常!', {icon: 5, time: 1000, anim: 6});
        }
      });
    }
  </script>
</body>
</html>