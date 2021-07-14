
/** 该部分已集成到 layui module form.js*/
// 显示提示
var tips;
function show_shopm(t){
    var row=$(t).attr('data-d'); //获取显示内容
    if(row!=null && row!="") {
        //小tips
        tips = layer.tips("<span style='color:#000;'>" + row + "</span>", t, {
            tips: [1, '#F5DEB3'],
            time: 2000,
            area: 'auto'
        })
    }else{
        tips=null;
    }
}

// 关闭提示
function exit_shopm(){
    if(tips!=null) {
        layer.close(tips);
    }
}