//弹出框 _title抬头标题,_area_arr弹出框宽高数组,_id唯一性,_content弹出框内容,_btn_arr按钮数组,_funbtnxs点击按钮对象函数
function tk(_title, _area_arr, _id, _content, _btn_arr, _funbtnxs) {
	layer.open({
		type : 1,
		closeBtn : 1,
		title : _title,//标题
		area : _area_arr,//['600px', '450px']
		shade : 0.1,
		id : _id, //设定一个id，防止重复弹出'LAY_layuipro'
		btn : _btn_arr,//['确定', '取消']
		btnAlign : 'r',
		moveType : 1, //拖拽模式，0或者1
		content : _content, //html内容
		yes : _funbtnxs.yesxs1,
		btn2 : _funbtnxs.xs2,
		success : _funbtnxs.success
	});
}