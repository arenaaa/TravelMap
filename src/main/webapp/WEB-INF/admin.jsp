<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 페이지</title>
<jsp:include page="/WEB-INF/views/common.jsp"></jsp:include>
<script type="text/javascript">
var ctxpath = "<%= request.getContextPath() %>";
$(document).ready( function(){
	$('.btnGh').on('click', function(e){
		
		var ghid = $(this).data('ghid');
		$.get( ctxpath + '/ghdetail/' + ghid, function(resp){
			console.log ( resp );
		} );
	});
})
</script>
</head>
<body>
<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
<h3>관리 게스트하우스 목록</h3>
<c:forEach items="${gh }" var="g">
	<button class="btnGh btn btn-primary" data-ghid="${g.id}">${g.name}</button>
</c:forEach>

<!-- 
<button class="btnGh btn btn-primary" data-path="2322">마마게하</button>
<button class="btnGh btn btn-primary" data-path="3222">aA게하</button>
 -->
<!-- 
<table class="table">
<tr>
	<td><a href="<%=request.getContextPath() %>/ghedital/1257">테스트게하</a></td>
</tr>
<tr>
	<td><a href="#">A게하</a></td>
</tr>
</table>
 -->
</body>
</html>