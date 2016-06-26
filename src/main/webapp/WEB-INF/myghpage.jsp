<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>맹뜌</title>

    <!-- Bootstrap Core CSS -->
    <link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="<%=request.getContextPath()%>/resources/css/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="<%=request.getContextPath()%>/resources/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<%=request.getContextPath()%>/resources/fonts/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<style type="text/css">
      #ghList {
      margin-top : 100px;
      }
      #gh-info {
      display : none;
      }
      </style>
          <!-- jQuery -->
    <script src="<%=request.getContextPath()%>/resources/js/jquery-1.11.3.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="<%=request.getContextPath()%>/resources/js/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="<%=request.getContextPath()%>/resources/js/sb-admin-2.js"></script>

<script type="text/javascript">
function viewGh ( ghid ) {
	alert ( ghid );
}
</script>
</head>

<body>
    <div id="wrapper">
        <!-- Navigation -->
        <jsp:include page="/WEB-INF/header.jsp"></jsp:include>

        <!-- Page Content -->
        <div id="page-wrapper">
                <div id="ghList">
                	<div class="panel panel-default">
					  <!-- Default panel contents -->
					  <div class="panel-heading">관심 게스트하우스</div>
					
					  <!-- Table -->
					  <table class="table">
					  <c:forEach items="${requestScope.ghList }" var="gh">
					  <tr>
					  		<!-- el태그 안에는 GuestHouse의 getter를 참고 -->
					    	<td><a href="#" onclick="viewGh(${gh.id}); return false">${gh.name}</a></td>
					    	<td><button type="button" class="btn btn-default btn-xs">제거</button></td>
					    </tr>
					  </c:forEach>
					  <!-- 
					    <tr>
					    	<td><a href="#">소낭게스트하우스</a></td>
					    	<td><button type="button" class="btn btn-default btn-xs">제거</button></td>
					    </tr>
					    <tr>
					    	<td><a href="#">소낭게스트하우스</a></td>
						    	<td><button type="button" class="btn btn-default btn-xs">제거</button></td>
					    </tr>
					    <tr>
					    	<td><a href="#">소낭게스트하우스</a></td>
					    	<td><button type="button" class="btn btn-default btn-xs">제거</button></td>
					    </tr>
					   -->
					  </table>
					</div>
                </div>
                <div id="gh-info">
                	<div id="overview">
	                	<h3><span id="gh-name"></span> [ <a id="gh-link" href="#">LINK</a> ] 
	                	<c:if test="${not empty loginUser }"><button type="button" class="btn btn-default btn-xs">제거</button></c:if>
	                	</h3>
	                	
	                	<ul>
		                	<li>010-3333-2233</li>
		                	<li>addr@naver.com</li>
		                	<li>제주시 어디 어디 300-34</li>
		                	<li>게스트하우스 소개 내용이 여기 출력됩니다.</li>
	                	</ul>
                	</div>
                	<div id="searchview">
                		<ul>
                			<li>검색결과1
                			<li>검색결과1
                			<li>검색결과1
                			<li>검색결과1
                		</ul>
                	</div>
                	
                </div>
   				             
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->
</body>


</html>
