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
<title>관리자 페이지</title>
<jsp:include page="/WEB-INF/views/common.jsp"></jsp:include>
<style type="text/css">
.select-for-time {
	min-width: 100px !important;
}
</style>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/flat-ui.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/application.js"></script>
<script type="text/javascript">
var ctxpath = "<%= request.getContextPath() %>";
$(document).ready( function(){
	$('#ghlist').on('change', function(e){
		
		//var ghid = $(this).data('ghid');
		var ghid = $("#ghlist option:selected").val();
		if ( ghid.length == 0 ) {
			$('#gh-form').css ( 'display', 'none');
			return ;
		}
		//$('#gh-id').val ( ghid );
		$('#gh-form').css ( 'display', 'block');
		$.get( ctxpath + '/ghdetail/' + ghid, function(resp){
			console.log ( resp );
			if ( resp.success ) {
				// 편집
			} else {
				// 신규 작성
			}
			// $('#gh-name').text ( "게스트하우스 이름 넣음");
			$('#gh-id').val ( resp.detail.id );
			if( resp.detail.womanOnly ){
				$('#wmonly').prop("checked", true);
			}
			if ( resp.detail.foodOutsideOnly ){
				$('#nofood').prop("checked", true);
			}
			if ( resp.detail.bbq ) {
				$('#bbq').prop("checked", true);
				$('#bbq-memo').val(resp.detail.bbqMemo);
				$('#bbq-memo').show();
			} else {
				$('#bbq').prop("checked", false);
				$('#bbq-memo').hide();
			}
			// here
			if ( resp.detail.checkin ) {
				// 15:00:00.000000
				var hhmmss = resp.detail.checkin.substring(0,8);
				$('#check-in').val ( hhmmss ).select2();
			}
			if ( resp.detail.checkout ) {
				var hhmmss = resp.detail.checkout.substring(0,8);
				$('#check-out').val( hhmmss).select2();
			}
			if ( resp.detail.breakfastStart ) {
				var hhmmss = resp.detail.breakfastStart.substring(0,8);
				$('#bf-start').val(hhmmss).select2();
			}
			if ( resp.detail.breakfastEnd ) {
				var hhmmss = resp.detail.breakfastEnd.substring(0,8);
				$('#bf-end').val(hhmmss).select2();
			}
			if ( resp.detail.limitTime ) {
				var hhmmss = resp.detail.limitTime.substring(0,8);
				$('#limit-time').val(hhmmss).select2();
			} else {
				$('#limit-time').val("null").select2();
			}
			if( resp.detail.parkingLot ) {
				var number = resp.detail.parkingLot
				$('#parking-lot').val(number).select2();
			}
		} );
		
		$('#submit').click ( function() {
			// 시간 필드 값들에서 HH:mm:00
			/*
			$('#check-in').val ( );
			console.log($('#check-in').val ( ));
			$('#check-out').val ( );
			$('#bf-start').val ( );
			$('#bf-end').val ( );
			$('#limit-time').val ( );
			*/
			var data = $('#frm-gh').serialize(); // key=value&key=value
			console.log ( data );
			$.post ( ctxpath + '/ghdetail/edit', data, function(resp){
				console.log ( 'ok!');
			});
		});
	});
	
	// $(':checkbox').radiocheck();
	$('#bbq').on('change.radiocheck', function() {
		if ( $(this).is(':checked') ) {
			$('#bbq-memo').show();
		} else {
			$('#bbq-memo').hide();
		}
	}) ;
	
});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/header.jsp"></jsp:include>

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
 <!-- 
 <form class="form-horizontal">
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
    <div class="col-sm-10">
      <input type="email" class="form-control" id="inputEmail3" placeholder="Email">
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <div class="checkbox">
        <label>
          <input type="checkbox"> Remember me
        </label>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-default">Sign in</button>
    </div>
  </div>
</form>
  -->
    <div class="container">
       
      <div class="row">
        <div class="col-sm-6 col-md-4">
          <div class="todo">
            <div class="todo-search">
              <input class="todo-search-field" value="게스트하우스 리스트"/>
            </div>
            <select id="ghlist" class="form-control">
            	<option value="" >게스트하우스 선택</option>
	            <c:forEach items="${gh }" var="g">
            	<option value="${g.id }"> ${g.name}</option>
				</c:forEach>
            </select>
            <!-- 
            <ul>
            <c:forEach items="${gh }" var="g">
				 <li class="todo-done" data-ghid="${g.id}">
                <div class="todo-icon fui-list"></div>
                <div class="todo-content">
                  <h4 class="todo-name">
					<strong>${g.name }</strong>
                  </h4>
                   ${g.address }
                </div>
              </li>
			</c:forEach>
            </ul>
             -->
          </div><!-- /.todo -->
        </div><!-- /.col-md-4 -->
      </div><!-- /.row -->
      
      <div class="row">
      	<div class="col-xs-12">
      		<div id="gh-form" style="display:none">
      		<div class="form-group">
      		<!-- <h3 id="gh-name"></h3> -->
	      	<form id="frm-gh" class="form-horizontal">
	      		<input type="hidden" id="gh-id" name="id" value="">
			    <label class="checkbox" for="wmonly" >
			      <!-- <input id="wmonly" name="womanOnly" type="checkbox" class="custom-checkbox"> 여성전용 -->
			      <input id="wmonly" class="custom-checkbox" name="womanOnly" type="checkbox" data-toggle="checkbox">
				  <!-- <span class="icons"><span class="icon-unchecked"></span><span class="icon-checked"></span></span> -->
			      여성전용
			    </label>
			    <label class="checkbox" for="nofood" >
			      <input id="nofood" class="custom-checkbox" name="foodOutsideOnly" type="checkbox" data-toggle="checkbox">
			      <!-- <span class="icons"><span class="icon-unchecked"></span><span class="icon-checked"></span></span> -->
			      실내 취사 금지
			    </label>
			    <label class="checkbox" for="bbq">
			      <input id="bbq" class="custom-checkbox" name="bbq" type="checkbox" data-toggle="checkbox"> 
			      <!-- <span class="icons"><span class="icon-unchecked"></span><span class="icon-checked"></span></span> -->
			      바베큐
			    </label>
				<textarea id="bbq-memo" name="bbqMemo" class="form-control"></textarea>
				<div class="row">
					<div class="col-md-12"></div>
				</div>
	      		<div class="form-group">
					<label class="col-xs-12 col-md-2">체크인/체크아웃</label>
			    	<div class="col-xs-6 col-md-5"  style="padding-right: 5px;">
			    	<select data-toggle="select" id="check-in" name="checkin" class="form-control select select-default select-lg select-for-time">
				        <c:forEach var="t" items="${times}">
				        <option value="${t}">${fn:substring(t, 0, 5)}</option>
	      		 		</c:forEach>
			    	</select>
			    	</div>
			    	<div class="col-xs-6 col-md-5" style="padding-left: 5px;">
			    	<select data-toggle="select" id="check-out" name="checkout" class="form-control select select-default select-lg  select-for-time">
				        <c:forEach var="t" items="${times}">
				        <option value="${t}">${fn:substring(t, 0, 5)}</option>
	      		 		</c:forEach>
			    	</select>
			    	</div>
				</div>
	      		  <div class="form-group">
	      		 	<label class="col-xs-12 col-md-2">조식 제공시간</label>
	      		 	<div class="col-xs-6 col-md-5"  style="padding-right: 5px;">
	      		 	<select data-toggle="select" class="form-control select select-default select-lg select-for-time" name="breakfastStart" id="bf-start">
	      		 		<c:forEach var="t" items="${times}">
				        <option value="${t}">${fn:substring(t, 0, 5)}</option>
	      		 		</c:forEach>
			    	</select>
	      		 	</div>
	      		 	<div class="col-xs-6 col-md-5"  style="padding-left: 5px;">
	      		 	<select data-toggle="select" class="form-control select select-default select-lg select-for-time" id="bf-end" name="breakfastEnd">
				        <c:forEach var="t" items="${times}">
				        <option value="${t}">${fn:substring(t, 0, 5)}</option>
	      		 		</c:forEach>
	      		 		
			    	</select>
	      		 	</div>
				    <!-- <input type="text" name="breakfastStart" id="bf-start" value="" placeholder="시작시간"> ~ <input type="text" id="bf-end" name="breakfastEnd" value="" placeholder="종료시간"> -->
				  </div>
	      		  <div class="form-group">
				    <label class="col-xs-12 col-md-2">통금 시간</label>
				    <div class="col-xs-6 col-md-5"  style="padding-right: 5px;">
				    <select data-toggle="select" class="form-control select select-default select-lg select-for-time" id="limit-time" name="limitTime">
	      		 		<c:forEach var="t" items="${limitTimes}">
				        <option value="${t}">${fn:substring(t, 0, 5)}</option>
	      		 		</c:forEach>
	      		 		<option value="null"> 제한없음</option>
			    	</select>
				    </div>
				    <div class="col-xs-6 col-md-5"  style="padding-left: 5px;">
				    </div>
				    <!--  
				    <input type="text" id="limit-time" name="limitTime" value="" placeholder="시작시간"> 이후
				    -->
				  </div>
	      		  <div class="form-group">
				    <label class="col-xs-12 col-md-2">주차 가능</label>
				     <div class="col-xs-10 col-md-10"  style="padding-right: 5px;">
				     <select data-toggle="select" class="form-control select select-default select-lg select-for-time" name="parkingLot">
	      		 		<c:forEach var="park" items="${parkinglot}">
				        <option value="${park}">${park}대</option>
	      		 		</c:forEach>
	      		 		
			    	</select>
				    <!-- <input type="text" id="parking-lot" name="parkingLot" value="" placeholder="시작시간"> --> 
				    </div>
				  </div>
				  <div class="row">
				  <div class="col-xs-12 col-md-2">
				  <button type="button" class="btn btn-primary" id="submit">수정 완료</button>
				  </div>
				  </div>
	      	</form>
      		</div>
      	</div>
      	<!-- 
      	<div class="col-xs-12"><input type="checkbox" > 여성전용</div>
      	<div class="col-xs-12"></div>
      	<div class="col-xs-12"><input type="text" ></div>
      	 -->
      </div>
   </div>
</div><!-- /.container -->

  
</body>
</html>