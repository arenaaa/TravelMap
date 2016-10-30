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
	$('#ghlist').on('change', function(e){
		
		//var ghid = $(this).data('ghid');
		var ghid = $("#ghlist option:selected").val();
		if ( ghid.legnth == 0 ) {
			return ;
		}
		$('#gh-form').css ( 'display', 'block');
		$.get( ctxpath + '/ghdetail/' + ghid, function(resp){
			console.log ( resp );
			$('#gh-name').text ( "게스트하우스 이름 넣음");
			$('#gh-id').val ( resp.id );
			if( resp.womanOnly ){
				$('#wmonly').prop("checked", true);
			}
			if ( resp.foodOutsideOnly ){
				$('#nofood').prop("checked", true);
			}
			if ( resp.bbq ) {
				$('#bbq').prop("checked", true);
				$('#bbq-memo').val(resp.bbqMemo);
			}
			if ( resp.checkin ) {
				$('#check-in').val(resp.checkin.substring(0,5));
			}
			if ( resp.checkout ) {
				$('#check-out').val(resp.checkout.substring(0,5));
			}
			if ( resp.breakfastStart ) {
				$('#bf-start').val(resp.breakfastStart.substring(0,5));
			}
			if ( resp.breakfastEnd ) {
				$('#bf-end').val(resp.breakfastEnd.substring(0,5));
			}
			if ( resp.limitTime) {
				$('#limit-time').val(resp.limitTime.substring(0,5));
			}
			if( resp.parkingLot ) {
				$('#parking-lot').val(resp.parkingLot);
			}
			var ghdetail = resp;
		} );
		
		$('#submit').click ( function() {
			// 시간 필드 값들에서 HH:mm:00
			$('#check-in').val ( $('#check-in').val().concat(":00") );
			$('#check-out').val ( $('#check-out').val().concat(":00") );
			$('#bf-start').val ( $('#bf-start').val().concat(":00") );
			$('#bf-end').val ( $('#bf-end').val().concat(":00") );
			$('#limit-time').val ( $('#limit-time').val().concat(":00") );
			var data = $('#frm-gh').serialize(); // key=value&key=value
			$.post ( ctxpath + '/ghdetail/edit', data, function(resp){
				console.log ( 'ok!');
			});
		});
	});
	
	
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
 
    <div class="container">
       <div class="row">
    </div>
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
      		<h3 id="gh-name"></h3>
	      	<form id="frm-gh">
	      		<input type="hidden" id="gh-id" name="id" value="">
	      		  <div class="form-check">
				    <label class="form-check-label">
				      <input id="wmonly" name="womanOnly" type="checkbox" class="form-check-input"> 여성전용
				    </label>
				  </div>
	      		  <div class="form-check">
				    <label class="form-check-label">
				      <input id="nofood" name="foodOutsideOnly" type="checkbox" class="form-check-input"> 실내 취사 금지
				    </label>
				  </div>
	      		  <div class="form-check">
				    <label class="form-check-label">
				      <input id="bbq" name="bbq" type="checkbox" class="form-check-input"> 바베큐
				    </label>
				    <textarea id="bbq-memo" name="bbqMemo" class="form-control"></textarea>
				  </div>
	      		  <div class="form-group">
				    <label for="wmonly">체크인 체크아웃</label>
				    <input id="check-in" name="checkin" type="text" value="" placeholder="체크인"> ~ <input type="text" id="check-out" name="checkout" value="" placeholder="체크아웃">
				  </div>
	      		  <div class="form-group">
				    <label for="wmonly">조식 제공시간</label>
				    <input type="text" name="breakfastStart" id="bf-start" value="" placeholder="시작시간"> ~ <input type="text" id="bf-end" name="breakfastEnd" value="" placeholder="종료시간">
				  </div>
	      		  <div class="form-group">
				    <label for="wmonly">통금 시간</label>
				    <input type="text" id="limit-time" name="limitTime" value="" placeholder="시작시간"> 이후
				  </div>
	      		  <div class="form-group">
				    <label for="wmonly">주차 가능</label>
				    <input type="text" id="parking-lot" name="parkingLot" value="" placeholder="시작시간"> 
				  </div>
				  
				  <button type="button" id="submit">편집 완료</button>
				  <button type="button" id="submit">새로 등록</button>
	      	</form>
      		</div>
      	</div>
      	<!-- 
      	<div class="col-xs-12"><input type="checkbox" > 여성전용</div>
      	<div class="col-xs-12"></div>
      	<div class="col-xs-12"><input type="text" ></div>
      	 -->
      </div>
    </div><!-- /.container -->

  
</body>
</html>