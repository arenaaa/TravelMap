<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
}

#gh-info {
    display: none;
}


</style>
<!-- jQuery -->
<script
    src="<%=request.getContextPath()%>/resources/js/jquery-1.11.3.js"></script>

<!-- Bootstrap Core JavaScript -->
<script
    src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script
    src="<%=request.getContextPath()%>/resources/js/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="<%=request.getContextPath()%>/resources/js/sb-admin-2.js"></script>

<script type="text/javascript">
var ctxpath = '<%=request.getContextPath()%>';
function viewGh ( ghid ) { // [1]tntkdgkskdkd
	var is = ghid.indexOf('[') + 1;
	var ie = ghid.indexOf(']') ;
	var ghSeq = ghid.substring(is, ie); 
	var formData = { gh : ghSeq}; // req.getParameter("gh");
	$.get ( ctxpath + '/viewgh', formData, function(resp){
		console.log ( resp );
	});
}
$(document).ready ( function() {
	$('a.gh-name').click(function(e){
		viewGh ( $(this).text() );
		e.preventDefault(); //
		
		
	});
	//});
	
	$('.btn-del-gh').click(function(){
		var ghSeq = $(this).attr ( 'id').substring(3); //del12
		var formData = { geha : ghSeq };
		$.post ( ctxpath + '/delgh', formData, function(resp){
			console.log( resp );
			if ( resp.success ) {
				location.reload();
			}
		})
	});
	
});

var map;
var infowindow;
var markers = [];

function getCurrentLocation(cbSuccess, cbFail) {
	/*
	function showPosition(position) {
	    alert ("Latitude: " + position.coords.latitude + 
	    "Longitude: " + position.coords.longitude ); 
	}
	*/
	
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(cbSuccess, cbFail);
    } else {
        console.log ( "Geolocation is not supported by this browser.") ;
        cbFail ( 'fail' );
    }
}


function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center: {lat: -34.397, lng: 150.644},
		zoom: 8
	});
	
	infowindow = new google.maps.InfoWindow({
        content: 'no content'
    });
	// 
	$('.gh-name').each ( function(i, gh) {
		var $gh = $(gh);
		var lat = $gh.data('lat');
		var lng = $gh.data('lng'); 
		var myLatLng = { lat:lat, lng:lng} ;
	 	var marker = new google.maps.Marker({
		    position: myLatLng,
		    map: map,
		    title: 'Hello World!'
		});
	 		markers.push(marker);
	});
	
	var bnd = new google.maps.LatLngBounds();
	// 각각의마커들마다 위치정보를 얻어와서 bnd.extend(..)로 점들을 등록하면 알아서 크기를 설정합니다.
	for(var i=0; i <markers.length; i++){
	    var pos = markers[i].getPosition();
	    bnd.extend(pos);
	}
	map.fitBounds(bnd);
	
	getCurrentLocation(function(position) {
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		var myLatLng = { lat:lat, lng:lng };
		var marker = new google.maps.Marker({
		    position: myLatLng,
		    map: map,
		    title: '나의 위치'
		});
	 		markers.push(marker);
		
	}, function( error ) {
		console.log(error );
	});
	
}

</script>


<body>
<div id="wrapper">
    <!-- Navigation -->
    <jsp:include page="/WEB-INF/header.jsp"></jsp:include>

    <div id="ghList">
        <div class="panel panel-default">
            <!-- Default panel contents -->
            <div class="panel-heading">관심 게스트하우스</div>

            <!-- Table -->
            <table class="table">
                <c:forEach items="${requestScope.ghList }" var="gh">
                <tr>
                    <!-- el태그 안에는 GuestHouse의 getter를 참고 -->
                    <td><a href="#" class="gh-name" data-gh="${gh.id}" data-lat="${gh.lat}" data-lng="${gh.lng}">[${gh.id}]${gh.name}</a></td> <!-- onclick="viewGh(${gh.id}); return false" --> 
                    <td align="right"><button id="del${gh.id}" class="btn btn-default btn-xs btn-del-gh" ><i class="fa fa-times" aria-hidden="true"></i></button></td>
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
        <div>
        </div>
    </div>
    <div id="map" style="height:300px"></div>

    <!-- /.container-fluid -->
</div>
<!-- /#wrapper -->
</body>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCy1X-f36fp4thbEIZSJWpCU7GCKMve2uA&callback=initMap" async defer></script>
</head>
</html>