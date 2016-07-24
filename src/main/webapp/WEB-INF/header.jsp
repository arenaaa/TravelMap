<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav id="nav-menu" class="navbar navbar-default navbar-fixed-top" role="navigation" style="margin-bottom: 0">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                data-target="#nav-elem">
                <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
                <span class="icon-bar"></span> <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<%=request.getContextPath()%>/">Travel Map</a>
        </div>
        <div class="collapse navbar-collapse" id="nav-elem">
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${empty loginUser }"><li><a href="<%= request.getContextPath()%>/join"><i class="fa fa-user fa-fw"></i>가입</a></li></c:if>
                <c:if test="${ empty loginUser }">
                        <li><a href="<%=request.getContextPath()%>/login" data-toggle="modal"><i class="fa fa-sign-in fa-fw"> </i> 로그인</a>
                    </c:if>
                    <c:if test="${not empty loginUser }">
                        <li><a href="<%=request.getContextPath()%>/mygh"><i class="fa fa-cubes"></i> 관심 게하</a></li>
                        <li><a href="<%=request.getContextPath()%>/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                    </c:if>
                <!-- 
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>
                        <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                    <c:if test="${ empty loginUser }">
                        <li><a href="<%=request.getContextPath()%>/login"><i class="fa fa-sign-in fa-fw"></i> Login</a>
                    </c:if>
                    <c:if test="${not empty loginUser }">
                        <li><a href="<%=request.getContextPath()%>/mygh"><i class="fa fa-user fa-fw"></i>관심 게스트하우스</a></li>
                        <li><a href="<%=request.getContextPath()%>/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                    </c:if>
                    </ul>
                </li>
                 -->    
            </ul>
        </div>
    </div>
</nav>
<div id="header-padding" style="height:50px"></div>
<div class="modal fade">
	<div class="modal-dialog">
		<div class="modal-header">
			<p>로그인</p>
		</div>
	
	</div>
</div>