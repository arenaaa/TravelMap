<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav id="nav-menu" class="navbar navbar-default navbar-fixed-top"
	role="navigation" style="margin-bottom: 0">
	

	
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#nav-elem">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="<%=request.getContextPath()%>/">Travel
				Map</a>
		</div>
		<div class="collapse navbar-collapse" id="nav-elem">
			<ul class="nav navbar-nav navbar-right">
				<c:if test="${empty loginUser }">
					<li><a href="#" data-toggle="modal" data-target="#joinModal">
					<i
							class="fa fa-user fa-fw"></i>회원가입</a></li>
				</c:if>
				<c:if test="${ empty loginUser }">
					<li><a href="#" data-toggle="modal" data-target="#myModal"><i
							class="fa fa-sign-in fa-fw"> </i> 로그인</a>
				</c:if>
				<c:if test="${not empty loginUser }">
					<li class="dropdown">
              			<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 메뉴 <b class="caret"></b></a>
              				<ul class="dropdown-menu">
                	<li><a href="<%=request.getContextPath()%>/mygh"><i class="fa fa-cubes"></i> 관심 게하</a></li>
                	<li><a href="<%=request.getContextPath()%>/registergh">
						<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
						글쓰기</a></li>
               		 <li><a href="<%=request.getContextPath()%>/updatepw">비밀번호 변경</a></li>
                	<li class="divider"></li>
                	<li><a href="<%=request.getContextPath()%>/admin">관리자 도구</a></li>
              </ul>
            </li>
					
					<li><a href="<%=request.getContextPath()%>/logout"><i
							class="fa fa-sign-out fa-fw"></i> Logout</a></li>
							
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
<div id="header-padding" style="height: 50px"></div>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
		<div class="modal-header">
		<i class="fa fa-hand-o-right" aria-hidden="true"></i>
		Login  
		</div>
			<div class="auth-form-body">

				<div class="error">
					<span class="label label-danger">	ERROR!</span>
				</div>
				<label> ID:tom, PW:1111 입력 </label><p>
				<input autocapitalize="off" autocorrect="off" autofocus="autofocus" class="form-control input-block" placeholder="아이디" id="id" name="login" tabindex="1"
					type="text">  
				<input
					class="form-control form-control input-block"  placeholder="비밀번호" id="password"
					name="password" tabindex="2" type="password"> <input
					id="btnLogin" class="btn btn-primary btn-block"
					data-disable-with="Signing in…" name="commit" tabindex="3"
					type="button" value="로그인">
					<class="btn btn-info"><a href="<%=request.getContextPath()%>/forgotpw">비밀번호 재설정</a></div>
					<%-- <button type="button"  id="fgpw-btn"><a href="<%=request.getContextPath()%>/forgotpw">비밀번호 재설정</a></button> --%>
			</div>
		</div>
	</div>
</div>



<!-- 회원 가입 모달 -->
<div class="modal fade" id="joinModal" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
		<div class="modal-header">
		회원가입
		</div>
			<div class="auth-form-body">

				<div class="error">
					<span class="label label-danger">ERROR!</span>
				</div>
				<input autocapitalize="off" autocorrect="off" autofocus="autofocus" class="form-control input-block"  placeholder="아이디" id="uid" name="name" tabindex="1"
					type="text"> 
				<input autocapitalize="off" autocorrect="off" autofocus="autofocus" class="form-control input-block"  placeholder="이메일" id="email" name="email" tabindex="1"
					type="text"> 
				<input class="form-control form-control input-block"  placeholder="비밀번호" id="upass"
					name="password" tabindex="1" type="password"> 
					<input class="form-control form-control input-block"  placeholder="비밀번호 확인" id="password-chk"
					name="password-chk" tabindex="2" type="password"> 
					<input
					id="btnJoin" class="btn btn-primary btn-block"
					data-disable-with="Signing in…" name="commit" tabindex="3"
					type="button" value="가입">
			</div>
		</div>
	</div>
</div>
<script>
	$("#btnLogin").click(function() {
		var uid = $("#id").val();
		var pass = $("#password").val();
		var formData = {
			uid : uid,
			pw : pass
		};
		$.post(ctxpath + '/login', formData, function(resp) {
			console.log('응답1', resp);
			var json = JSON.parse(resp);
			console.log('응답2', json);
			if (json.success) {
				location.reload();
			} else {
				$(".error").css("display", "block");
			}
		});
	});
	
	$("#btnJoin").click(function() {
		var uid = $("#uid").val();
		var email = $("#email").val(); 
		var pass = $("#upass").val();
		var passchx = $('#password-chk').val();
		
		if ( pass != passchx ) {
			alert('비밀번호가 다릅니다.');
			$('#upass').focus().select();
			return ;
		}
		
		var formData = {
			uid : uid,
			pw : pass,
			email : email
		};
		
		$.post(ctxpath + '/join', formData, function(resp) {
			console.log('응답1', resp);
			var json = JSON.parse(resp);
			console.log('응답2', json);
			if (json.success) {
				location.reload();
			} 
		});
	});
</script>