// 控制操作权限
function operateControl(data) {
    let obj = eval(data);
    $(obj).each(function (index) {
        let item = obj[index];
        switch (item.operation.operateName) {
            case "创建":
                document.getElementById("createbtn").style.display = "";
                break;
            case "修改":
                document.getElementById("updatebtn").style.display = "";
                break;
            case "删除":
                document.getElementById("deletebtn").style.display = "";
                break;
            case "分配":
                document.getElementById("assignbtn").style.display = "";
                break;
            case "收款":
                document.getElementById("cashbtn").style.display = "";
                break;
            case "开票":
                document.getElementById("billbtn").style.display = "";
                break;
            case "刷新":
                document.getElementById("flushbtn").style.display = "";
                break;
            case "联系人":
                document.getElementById("contactbtn").style.display = "";
                break;
            case "申请开票":
                document.getElementById("applybtn").style.display = "";
                break;
        }
    });
}

// 控制菜单权限
function menuControl(data) {
    let obj = eval(data);
    $(obj).each(function (index) {
        let item = obj[index];
        switch (item.menu.menuName) {
            case "项目管理":
                document.getElementById("menu-contract").style.display = "";
                break;
            case "开荒项目管理":
                document.getElementById("contractset").style.display = "";
                break;
            case "开荒项目列表":
                document.getElementById("contractlist").style.display = "";
                break;
            case "项目联系列表":
                document.getElementById("contactlist").style.display = "";
                break;
            case "项目收款列表":
                document.getElementById("cashinglist").style.display = "";
                break;
            case "项目开票列表":
                document.getElementById("billlist").style.display = "";
                break;
            case "项目数据汇总":
                document.getElementById("menu-summary").style.display = "";
                break;
            case "项目数量明细":
                document.getElementById("summary0").style.display = "";
                break;
            case "项目收支明细":
                document.getElementById("summary1").style.display = "";
                break;
            case "项目回款明细":
                document.getElementById("summary2").style.display = "";
                break;
            case "客户交易明细":
                document.getElementById("summary3").style.display = "";
                break;
            case "项目档案列表":
                document.getElementById("projectRecord").style.display = "";
                break;
            case "客户管理":
                document.getElementById("menu-customer").style.display = "";
                break;
            case "客户信息列表":
                document.getElementById("customerlist").style.display = "";
                break;
            case "客户档案列表":
                document.getElementById("customerRecord").style.display = "";
                break;
            case "用户管理":
                document.getElementById("menu-user").style.display = "";
                break;
            case "用户列表":
                document.getElementById("userlist").style.display = "";
                break;
            case "修改密码":
                document.getElementById("updatepwd").style.display = "";
                break;
            case "系统管理":
                document.getElementById("menu-system").style.display = "";
                break;
            case "角色列表":
                document.getElementById("rolelist").style.display = "";
                break;
            case "权限列表":
                document.getElementById("permissionlist").style.display = "";
                break;
            case "菜单列表":
                document.getElementById("menulist").style.display = "";
                break;
            case "操作列表":
                document.getElementById("operationlist").style.display = "";
                break;
            case "系统日志":
                document.getElementById("loglist").style.display = "";
                break;
            case "项目提醒弹窗":
                //document.getElementById("contractRemindPop").style.display = "";
                break;
        }
    });
}