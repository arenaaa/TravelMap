<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<title>Registration Form Design</title>
        <meta name="keywords" content="form,design,registration form, signup form, style, unqie, design" />
		<meta name="description" content="Registration Form Design: Using CSS3 and HTML5" />
		<meta name="author" content="Codeconvey" />
		<link rel="stylesheet" type="text/css" href="<%=application.getContextPath() %>/resources/css/style.css" />
	</head>
	<body>
		
        <div class="container">
			<!-- Top Navigation -->
			<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
			<div class="codeconveyTop clearfix">
				<ul>
				<li><a href="<%=request.getContextPath()%>"><span>Main</span></a></li>
                </ul>
			</div>
		</div>
        
		<div class="container">
          <div class="SignUp">
              <div class="heading">
                <h1>회원가입</h1>
                <img class="portrait" src="">
                <svg class="slant" viewBox="0 0 1 1" preserveAspectRatio="none">
                  <polygon points="0,1 1,1 1,0">
                </svg>
              </div>
              
              <form action = "<%=request.getContextPath()%>/doJoin" method = "post">
              	<input type="text" placeholder="your name" name="uid">
                <input type="email" placeholder="email" name="email">
                <input type="password" placeholder="password" name="pw">
                <button type="submit" class="form-control">Create Account</button>
              </form>
              
              
          </div>
        </div>

        
        
	</body>
</html>