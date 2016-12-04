<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판</title>
<jsp:include page="/WEB-INF/views/common.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
<h4> 자유 게시판 </h4>
<table class="table table-hover">
  <tr>
		<td>글번호</td>
		<td>글제목</td>
		<td>작성일</td>
		<td>조회수</td>
		<td>추천수</td>
		<td>작성자</td>
  </tr>
  <c:forEach items="${requestScope.xxx }" var="p">
	<tr>
		<td>${p.seq }</td> <!-- p.getSeq() -->
		<td><a href='<%=application.getContextPath() %>/posting?id=${p.seq}'>${p.title }</a></td><!-- p.getTitle() -->
		<td>${p.ctime }</td>
		<td>${p.viewcount}</td>
		<td>${p.recocount}</td>
		<c:if test="${not empty user }">
		<td><a href='<%=application.getContextPath() %>/message?receiver=${p.writer.seq}'>${p.writer.userId}</a></td><!-- p.getWriter().getUserId() -->
		</c:if>
		<c:if test="${empty user }">
		<td>${p.writer.userId}</td><!-- p.getWriter().getUserId() -->
		</c:if>
	</tr>
</c:forEach>
</table>
</body>
</html>