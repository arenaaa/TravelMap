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
<title>비밀번호 재설정</title>
<jsp:include page="/WEB-INF/views/common.jsp"></jsp:include>
<style type="text/css">
.email-block {
	margin-bottom : 15px;
}
</style>

<script type="text/javascript">
var ctxpath = '<%=request.getContextPath()%>';
$(document).ready ( function() {
	$("#fg-submit").on("click", function(){
		var email = $('#InputEmail').val();
		$.post(ctxpath + '/doresetpw', {email: email}, function(json) {
			if (json.success) {
				alert( json.email + '로 비밀번호 재설정 메일을 보냈습니다.');
			} else {
				$(".error").css("display", "block");
			}
		});
	});
});

</script>
</head>
<body>
	<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
	
	<div class="panel panel-default">
	  	<div class="panel-body">
		    <label for="exampleInputEmail1">가입한 이메일 주소 입력(비밀번호 링크를 보내드립니다)</label>
	   		 <input type="email" class="form-control email-block" id="InputEmail" placeholder="Email">
	   		 <button type="button" class="btn btn-primary btn-block" id="fg-submit">전송</button>
	   </div>
  	</div>

</body>
</html>