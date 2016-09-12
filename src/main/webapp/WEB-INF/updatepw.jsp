<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 변경</title>
<jsp:include page="/WEB-INF/views/common.jsp"></jsp:include>
<style type="text/css">
.email-block {
	margin-bottom : 15px;
}
</style>

<script type="text/javascript">
var ctxpath = '<%=request.getContextPath()%>';
$(document).ready ( function() {
	$("#pw-update").on("click", function(){
	//	var origPw = $('#origPw').val();
		var InputPw = $('#InputPw').val();
		var InputPwAgain = $('#InputPwAgain').val();
		
		if ( InputPw == InputPwAgain ) {
		$.post(ctxpath + '/doupdatepw', {InputPw:InputPw }, function(json) {
			if (json.success) {
				alert( '비밀번호가 변경되었습니다.');
			} else {
				$(".error").css("display", "block");
			}
		});
			
		}
	});
});

</script>
</head>
<body>
	<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
	
	<div class="panel panel-default">
	  	<div class="panel-body">
		    <label for="exampleInputEmail1">비밀번호 변경</label>
		    <!-- 
		    <input type="password" class="form-control email-block" id="origPw" placeholder="현재 비밀번호 입력">
		     -->
	   		 <input type="password" class="form-control email-block" id="InputPw" placeholder="비밀번호 입력">
	   		 <input type="password" class="form-control email-block" id="InputPwAgain" placeholder="비밀번호 재입력">
	   		 <button type="button" class="btn btn-primary btn-block" id="pw-update">변경</button>
	   </div>
  	</div>

</body>
</html>