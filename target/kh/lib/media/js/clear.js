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