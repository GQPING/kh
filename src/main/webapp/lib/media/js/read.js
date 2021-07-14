// 设置只读
function SetReadonly(obj,type,form) {
    if(type=='1'){
        $('#'+obj).attr("disabled", "disabled");
        $('#'+obj+':first').addClass("layui-btn-disabled");
    }else if(type=='2'){
        $('#'+obj).attr("disabled", "disabled");
        form.render('select',obj);
    }else {

    }
}
// 取消只读
function DelReadonly(obj,type,form) {
    if(type=='1'){
        $('#'+obj).removeAttr("disabled", "disabled");
        $('#'+obj+':first').removeClass("layui-btn-disabled");
    }else if(type=='2'){
        $('#'+obj).removeAttr("disabled", "disabled");
        form.render('select',obj);
    }else {

    }
}