/* 这里面是整个系统业务相关的js代码 */
function runDatetimePicker(){
  $("#search-datetime-start").datetimepicker({
    language:  'zh-cn',
    format: 'yyyy-mm-dd',
    minView: "month",
    todayBtn:  1,
    autoclose: 1,
    endDate : new Date(),
  }).on('changeDate', function(event) {
    event.preventDefault();
    event.stopPropagation();
    var startTime = event.date;
    $('#search-datetime-end').datetimepicker('setStartDate',startTime);
  });
  $("#search-datetime-end").datetimepicker({
    language:  'zh-cn',
    format: 'yyyy-mm-dd',
    minView: "month",
    todayBtn:  1,
    autoclose: 1,
    endDate : new Date(),
  }).on('changeDate', function(event) {
    event.preventDefault();
    event.stopPropagation();
    var endTime = event.date;
    $("#search-datetime-start").datetimepicker('setEndDate',endTime);
  });
}

// 提取URL中参数为对象
function parseQueryString(url){
  var str = url.split('?')[1];
  var result = {};
  var temp = (str || '').split('&');
  for(var i=0; i<temp.length; i++){
    var temp2 = (temp[i] || '').split('=');
    result[temp2[0]] = temp2[1];
  }
  return result;
}