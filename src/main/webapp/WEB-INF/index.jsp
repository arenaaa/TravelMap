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

<link rel="shortcut icon"
	href="<%=request.getContextPath()%>/resources/images/favicon.ico"
	type="image/x-icon" />
<link rel="icon"
	href="<%=request.getContextPath()%>/resources/images/favicon.ico"
	type="image/x-icon" />
<title>맹뜌</title>

<!-- Bootstrap Core CSS -->
<link
	href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="<%=request.getContextPath()%>/resources/fonts/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- jQuery -->
<script
	src="<%=request.getContextPath()%>/resources/js/jquery-1.11.3.js"></script>

<!-- Bootstrap Core JavaScript -->
<script
	src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script
	src="<%=request.getContextPath()%>/resources/js/metisMenu.min.js"></script>

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
	position: fixed;
	width: 100%;
	overflow: scroll;
	background-color: #fff;
	display: none;
}

.nav-elem {
	float: right;
}

#rating .star_rating {
	font-size: 0;
	letter-spacing: -4px;
}

#rating .star_rating a {
	font-size: 22px;
	letter-spacing: 0;
	display: inline-block;
	margin-left: 5px;
	color: rgba(160, 160, 160, 0.44);
	text-decoration: none;
}

#rating .star_rating a:first-child {
	margin-left: 0;
}

#rating .star_rating a.on {
	color: #d0f510;
}

.nav-tabs {
	border-bottom: 2px solid #DDD;
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover
	{
	border-width: 0;
}

.nav-tabs>li>a {
	border: none;
	color: #666;
}

.nav-tabs>li.active>a, .nav-tabs>li>a:hover {
	border: none;
	color: #4285F4 !important;
	background: transparent;
}

.nav-tabs>li>a::after {
	content: "";
	background: #4285F4;
	height: 2px;
	position: absolute;
	width: 100%;
	left: 0px;
	bottom: -1px;
	transition: all 250ms ease 0s;
	transform: scale(0);
}

.nav-tabs>li.active>a::after, .nav-tabs>li:hover>a::after {
	transform: scale(1);
}

.tab-nav>li>a::after {
	background: #21527d none repeat scroll 0% 0%;
	color: #fff;
}

.tab-pane {
	padding: 15px 0;
}

.tab-content {
	padding: 20px
}

.card {
	background: #FFF none repeat scroll 0% 0%;
	box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.3);
	margin-bottom: 30px;
}
</style>

<style type="text/css">
.auth-form-body {
	padding: 20px;
	font-size: 14px;
	background-color: #fff;
	border: 1px solid #d8dee2;
	border-top: 0;
	border-radius: 0 0 3px 3px;
}

.auth-form-body .input-block {
	margin-top: 5px;
	margin-bottom: 15px;
}

.auth-form-body .error {
	margin-top: 5px;
	margin-bottom: 15px;
	display: none;
}
</style>
<script type="text/javascript">
var ctxpath = '<%=request.getContextPath()%>';
function enableRating() {
    $('#gh-info').css('display', 'block');
    $( '#rating .star_rating a' ).click(function() {
        $(this).parent().children('a').removeClass('on');

        $(this).addClass('on').prevAll('a').addClass('on');
        return false;
    });    
    $('#gh-info').css('display', 'none');
}

$(document).ready ( function() {
	$('a[href="#messages"]').on('shown.bs.tab', function (e) {
		 /*
		  * <ul>
		      <li><a href="#">{title}</a>
		      <li><a href="#">{title}</a>
		    </ul>
		  */
		  var ghname = activeGh.name;
		  $.get (ctxpath + '/searchGH?ghname=' + ghname, function( resp ) {
			  // console.log ( resp );
			  var search = resp.childNodes[0];
			  var items = search.childNodes; // array
			  var searchHtml = '<ul>';
			  var li = '<li><a href="{l}" target="blank">{t}</a></li>';
			  for ( var i = 0 ; i < items.length; i ++ ) {
				  var item = items[i]; // each item
				  var title = item.childNodes[0].childNodes[0].textContent;
				  var link  = item.childNodes[1].childNodes[0].textContent;
				  var desc  = item.childNodes[2].childNodes[0].textContent;
				  // console.log ( title, link, desc );
				  searchHtml += li.replace('{l}', link).replace('{t}', title);
			  }
			  searchHtml += '</ul>';
			  $('#searchview').empty().append( searchHtml );
		  });
	});
});
</script>
</head>

<body>
	<!-- Navigation -->
	<jsp:include page="/WEB-INF/header.jsp"></jsp:include>

	<!-- Page Content -->
	<div id="wrapper">

		<div id="map">
			<div id="map-core"></div>
		</div>
		<div id="gh-info">
			<!-- tap menu 시작 -->
			<div class="container">
				<div class="row">
					<div>
						<!-- Nav tabs -->
						<div class="card"> <!-- $('#home').tab('show') -->
							<ul class="nav nav-tabs" role="tablist" id="ghTab">
								<li role="presentation" class="active"><a href="#home"
									aria-controls="home" role="tab" data-toggle="tab">게스트하우스</a></li>
								<li role="presentation"><a href="#profile"
									aria-controls="profile" role="tab" data-toggle="tab">상세정보</a></li>
								<li role="presentation"><a href="#messages"
									aria-controls="messages" role="tab" data-toggle="tab">검색결과</a></li>
							</ul>

							<!-- Tab panes -->
							<div class="tab-content">
								<div role="tabpanel" class="tab-pane active" id="home">
									<h3>
										<span id="gh-name"></span> [ <a id="gh-link" href="#">LINK</a>
										]
										<c:if test="${not empty loginUser }">
											<i class="fa fa-plus-square" aria-hidden="true"></i>
										</c:if>
									</h3>
									<div id="rating">
										<p class="star_rating">
											<a href="#" class="on fa fa-star fw"></a> <a href="#"
												class="on fa fa-star fw"></a> <a href="#"
												class="on fa fa-star fw"></a> <a href="#"
												class="on fa fa-star fw"></a> <a href="#"
												class="on fa fa-star fw"></a>
										</p>
									</div>
								</div>

								<div role="tabpanel" class="tab-pane" id="profile">
									<ul>
										<li>010-3333-2233</li>
										<li>addr@naver.com</li>
										<li>제주시 어디 어디 300-34</li>
										<li>게스트하우스 소개 내용이 여기 출력됩니다.</li>
									</ul>
								</div>
								<div role="tabpanel" class="tab-pane" id="messages">
									<div id="searchview">
										<ul>
											<li>검색결과1
											<li>검색결과1
											<li>검색결과1
											<li>검색결과1
											<li>검색결과1
											<li>검색결과1
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 끝 -->
			<div id="overview"></div>

		</div>
	</div>
</body>
<!-- Custom Theme JavaScript -->

<script type="text/javascript">
    var star = {
            path: 'M 0,0 20,0 20,20 0,20 0,0 z',
            fillColor: 'yellow',
            fillOpacity: 0.6,
            scale: 1,
            strokeColor: 'gold',
            strokeWeight: 3
          };
    var guesthouses = [];
    var ctxpath = '<%=application.getContextPath()%>';
	var map;
	var markers = [];
	var activeGh ;

	var curCenter = {
		lat : 33.504644819360955,
		lng : 126.4942775800781
	};

	function adjustSize(ratio) {
		var $win = $(window);
		var $menu = $('#nav-menu');
		var $map = $('#map');
		var info = $('#gh-info');

		var H = $win.height(); // device height
		$map.css('height', H * ratio + 'px');

		var infoT = $menu.height() + $map.height();
		var infoH = $win.height() - (infoT);

		info.css('height', infoH + 'px');
		//info.css('top', infoT + 'px');
	}

	function adjustInfoSize(ratio) {
		var win = $(window);
		var menu = $('#nav-menu');
		var map = $('#map');

	}

	function loadGoogleMap() {

		adjustSize(0.5);
		$.get(ctxpath + '/ghdata.json', function(resp) {
			// {"data":[{"lng":126.91695973428261,"name":"시드게스트하우스","id":1,"lat":33.468129861052574,"url":"http:\/\/localhost:8080\/gh\/39393","info":"제주도 위치1"},{"lng":126.90262399765027,"name":"수상한소금밭","id":2,"lat":33.490385445453654,"url":"http:\/\/localhost:8080\/gh\/233","info":"제주도 위치2"}],"success":true}

			if (resp.success) {
				guesthouses = resp.data;
			} else {
				guesthouses = [];
			}
			initMap();
		});
	}

	function initMap() {

		map = new google.maps.Map(document.getElementById('map'), {
			center : curCenter,
			zoom : 14

		});
		var infowindow = new google.maps.InfoWindow({
			content : 'no content'
		});

		//guesthouses 배열의 값을 마커로 출력
		for (var i = 0; i < guesthouses.length; i++) {
			var marker = new google.maps.Marker({
				position : {
					lat : guesthouses[i].lat,
					lng : guesthouses[i].lng
				},
				map : map,
				title : guesthouses[i].name
			});

			markers.push(marker);
			addClickListener(infowindow, map, marker, guesthouses[i]);
		}// end-for

		var bnd = new google.maps.LatLngBounds();
		// 각각의마커들마다 위치정보를 얻어와서 bnd.extend(..)로 점들을 등록하면 알아서 크기를 설정합니다.

		for (var i = 0; i < markers.length; i++) {
			var pos = markers[i].getPosition();
			bnd.extend(pos);
		}

		map.fitBounds(bnd);
		enableRating();
	}

	function updateGhInfo(gh) {
		$('#gh-info').css('display', 'block');
		$('#gh-name').html(gh.name)
		$('#gh-link').attr("href", gh.url);
		activeGh = gh;
	}

	function addClickListener(infowin, map, marker, gh) {

		var template = '<a href={0}><i>{1}</i></a><br><c:if test="${not empty loginUser }">'
				+ '<button type="button" id="{id}" class="btn btn-success btn-xs">추가</button></c:if>    ';

		marker.addListener('click', function() {
			var content = template.replace("{0}", gh.url).replace("{1}",
					gh.name).replace("{id}", 'gh' + gh.id); // id="btn"
			infowin.setContent(content);
			infowin.open(map, marker);
			var pos = marker.getPosition();
			//map.panTo ( pos );
			console.log("콜백 실행됐음");
			
			$('#gh' + gh.id).on('click', function(evt) {
				var ghId = $(evt.target).attr('id').substring(2);
				var formData = {
					geha : ghId
				}; // new HashMap();
				/* var obj = new Object();
				obj.geha = ghId; */
				// /tarvelmap/addgh?geha=14
				$.post(ctxpath + '/addgh', formData, function(resp) {
					console.log(resp);
				});
			});
			updateGhInfo(gh);
			$('#ghTab a:first').tab('show'); // tab 초기화
		});

		console.log("콜백 등록했음.");
	}
	function markerClicked() {
		console.log();
	}
</script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCy1X-f36fp4thbEIZSJWpCU7GCKMve2uA&callback=loadGoogleMap"
	async defer></script>

</html>