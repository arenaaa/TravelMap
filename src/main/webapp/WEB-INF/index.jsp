<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	#map {
        height: 400px;
      }
      #gh-info {
      position : fixed;
      width :100%;
      overflow: scroll;
      background-color: #fff;
      margin-left : 15px;
      display : none
      
      }
      </style>
</head>

<body>
    <div id="wrapper">
        <!-- Navigation -->
        <jsp:include page="/WEB-INF/header.jsp"></jsp:include>

        <!-- Page Content -->
        <div id="page-wrapper">
                <div id="map"></div> 
                <div id="gh-info">
                	<div id="overview">
	                	<h3><span id="gh-name"></span> [ <a id="gh-link" href="#">LINK</a> ] </h3>
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
    <!-- jQuery -->
    <script src="<%=request.getContextPath()%>/resources/js/jquery-1.11.3.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="<%=request.getContextPath()%>/resources/js/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="<%=request.getContextPath()%>/resources/js/sb-admin-2.js"></script>
    
    <script type="text/javascript">
    var guesthouses = [];
    var ctxpath = '<%=application.getContextPath() %>';
    var map;
    var markers = [];
    
    var curCenter = {
     lat : 33.504644819360955, 
     lng : 126.4942775800781
    };
    
    function adjustSize(ratio ) {
    	var $win = $(window);
    	var $menu = $('#nav-menu');
    	var $map = $('#map');
    	$map.css('top', '100px');
    	
    	var H = $win.height(); // device height
    	$map.css('height' , H *ratio + 'px');
    }
    
    function adjustInfoSize(ratio) {
    	var win = $(window);
    	var menu = $('#nav-menu');
    	var map = $('#map');
    	var info = $('#gh-info');
    	
    	var infoT = 100 + map.height();
    	var infoH = win.height() - ( infoT );
    	
		info.css('height', infoH  + 'px');
		info.css('top', infoT + 'px');
    }
    
    function loadGoogleMap () {
    	
    	adjustSize(0.4);
    	adjustInfoSize();
    	$.get( ctxpath + '/ghdata.json' , function( resp ) {
    		// {"data":[{"lng":126.91695973428261,"name":"시드게스트하우스","id":1,"lat":33.468129861052574,"url":"http:\/\/localhost:8080\/gh\/39393","info":"제주도 위치1"},{"lng":126.90262399765027,"name":"수상한소금밭","id":2,"lat":33.490385445453654,"url":"http:\/\/localhost:8080\/gh\/233","info":"제주도 위치2"}],"success":true}
    		
    		if ( resp.success ) {
    			guesthouses = resp.data;
    		} else {
    			guesthouses = [];
    		}
    		initMap();
    	});
    }
    
    function initMap() {
    	
    	  map = new google.maps.Map(document.getElementById('map'), {
    	    center: curCenter,
    	    zoom: 14
    	    
    	  });
    	   var infowindow = new google.maps.InfoWindow({
    	    content: 'no content'
    	   });
    	  
    	  //guesthouses 배열의 값을 마커로 출력
    	  for(var i=0; i < guesthouses.length; i++){
    	   var marker = new google.maps.Marker({
    	    position: { lat : guesthouses[i].lat, lng : guesthouses[i].lng} ,
    	    map : map ,
    	    title : guesthouses[i].name
    	   });
    	   
    	   markers.push ( marker );
    	   /*
    	    * javascript 클로저???? - 함수를 나와도 함수안에 사용한 변수 사용 가능 
    	    * marker(71번째)는 57번째 라인의 변수가 참조하는 마커를 가리킵니다. 
    	    */
    	   /*
    	   marker.addListener('click', function ( ){
    	    infowindow.open ( map, marker );
    	   });
    	   */
    	    
    	   addClickListener ( infowindow, map, marker, guesthouses[i] );
   	  }// end-for
   	  
   	 var bnd = new google.maps.LatLngBounds();
	 // 각각의마커들마다 위치정보를 얻어와서 bnd.extend(..)로 점들을 등록하면 알아서 크기를 설정합니다.
	 
	 for(var i=0; i <markers.length; i++){
		 var pos = markers[i].getPosition();
		 bnd.extend(pos);
	 }
	 
	 map.fitBounds(bnd);
	 
   	  
    }
    
    function updateGhInfo (gh) {
    	$('#gh-info').css('display', 'block');
    	$('#gh-name').html(gh.name)
    	$('#gh-link').attr("href", gh.url);
    }
    
    function addClickListener ( infowin, map, marker, gh) {
     	
    	var template = '<a href={0}>{1}</a>';
    	
    	marker.addListener('click', function ( ){
    		var content = template.replace("{0}", gh.url)
    		                      .replace("{1}", gh.name);
    		infowin.setContent(content);
    	    infowin.open ( map, marker );
    	    var pos = marker.getPosition();
    	    map.panTo ( pos );
    	    console.log("콜백 실행됐음");
    	    
    	    updateGhInfo ( gh );
    	});
     
     console.log("콜백 등록했음.");
    }
    function markerClicked () {
     console.log();
    }
    </script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCy1X-f36fp4thbEIZSJWpCU7GCKMve2uA&callback=loadGoogleMap"
        async defer></script>


</html>
