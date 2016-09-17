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


<title>맹지현</title>
<jsp:include page="/WEB-INF/views/common.jsp"></jsp:include>
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

#rating {
	padding : 0 10px;
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
	padding: 0;
}

.tab-content {
	padding: 0px
}

h3.gh-title {
	margin : 0;
	padding : 10px;
	font-size: 1.3em;
}
.card {
	background: #FFF none repeat scroll 0% 0%;
	box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.3);
	margin-bottom: 30px;
}
#gh-content {
	padding : 0 10px;
}

/*
.fixed_img_row ul{margin:0;padding:0;font-size:12px;font-family:Tahoma, Geneva, sans-serif;list-style:none}
.fixed_img_row li{position:relative;margin:0 0 -1px 0;padding:15px 0 15px 135px;border:1px solid #eee;border-left:0;border-right:0;vertical-align:top;*zoom:1}
.fixed_img_row li:after{display:block;clear:both;content:""}
.fixed_img_row a{text-decoration:none;cursor:pointer}
.fixed_img_row a strong{display:inline-block;margin:0 0 4px 0;color:#333}
.fixed_img_row .thumb{display:inline;overflow:hidden;float:left;position:relative;width:120px;margin:0 15px 0 -135px;background:#eee;color:#666;line-height:80px;text-align:center;-moz-box-shadow:0 0 5px #666;-webkit-box-shadow:0 0 5px #666}
.fixed_img_row .thumb img{display:block;border:0}
.fixed_img_row .thumb em{visibility:hidden;position:absolute;top:50%;left:0;width:1px;height:1px;margin:-90px 0 0 0;background:#000;font-weight:bold;font-style:normal;color:#fff;text-align:center;opacity:.6;filter:alpha(opacity=60)}
.fixed_img_row .thumb em{_visibility:visible;_top:0;_width:100%;_height:auto;_margin:0;_line-height:20px}
.fixed_img_row p{margin:0;color:#767676;line-height:1.4}
.fixed_img_row a:hover strong,
.fixed_img_row a:active strong,
.fixed_img_row a:focus strong{text-decoration:underline}
.fixed_img_row a:hover .thumb,
.fixed_img_row a:active .thumb,
.fixed_img_row a:focus .thumb{margin:-3px -3px -3px -138px;border:3px solid #eee;-moz-box-shadow:0 0 5px #666;-webkit-box-shadow:0 0 5px #666}
.fixed_img_row a:hover .thumb em,
.fixed_img_row a:active .thumb em,
.fixed_img_row a:focus .thumb em{visibility:visible;width:100%;height:auto;line-height:180px}
*/
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
			  
			 var li = '<blockquote><a href="{l}" target="blank">{t}</a></blockquote>';
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
	
	$('#search-input').on('keyup', function(evt) {
		if ( evt.keyCode == 13 ) {
			var searchWord =  $(evt.target).val();
			// /tmp/search.json?k=tdkdk
			$.get(ctxpath + '/search.json', {k : searchWord}, function(resp){
				console.log('검색', resp);
				if ( resp.success ) {
					var ghList = resp.data;
					console.log ( ghList );
					$('#search-tbl').empty();
					var template = '<tr><td><a href="#" class="gh-name" data-gh="{id}" data-lat="{lat}" data-lng="{lng}">{name}</a></td></tr>';
					for (var j = 0; j < ghList.length; j++) {
						// <tr><td><a href="#" class="gh-name" data-gh="{id}" data-lat="{lat}" data-lng="{lng}">{name}</a></td></tr>
						var tr = template.replace("{id}", ghList[j].id)
						                 .replace("{name}", ghList[j].name)
						                 .replace("{lat}", ghList[j].lat)
						                 .replace("{lng}", ghList[j].lng);
						
						$('#search-tbl').append ( tr );
					}// end-for
					
				} else {
					
				}
				
				
				
			});
			$(evt.target).blur();
			// new google.maps.event.trigger ( markers[1], 'click');
		}
	});
	
	$('#search-tbl').on('click', function(e){
		
		var ghId = $(e.target).data('gh');
		/**
		markerCluster.resetViewport();
		*/
		for ( var i = 0; i < markers.length; i++) {
			if( markers[i].gh.id == ghId ) {
				// new google.maps.event.trigger( markers[i], 'click');
				showInfowindow ( map, markers[i], markers[i].gh );
			}
		}
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
									<h3 class="gh-title">
										<span id="gh-name"></span> [ <a id="gh-link" href="#">LINK</a> ]
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
									<div id="gh-content">
										<div id="gh-address">제주시 어디 어디 어디 어디</div>
										<div id="gh-phone"><a href="tel:01062786793">010-4444-4444</a></div>
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
										<!-- UI Object -->
    <ul>
    <li>
   	검색중
    </li>
    </ul>
</div>
<!-- //UI Object -->
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 끝 -->
		<div id="gh-search" class="input-group input-group-hg input-group-rounded">
		  <span class="input-group-btn">
	  		  <button type="submit" class="btn"><span class="fui-search"></span></button>
	 	 </span>
	  		<input type="text" class="form-control" placeholder="Search" id="search-input">
		</div>
			<!--  <input type="text" id="search-input" class="form-control"> -->
			  <!-- Table -->
			<!-- <tr><td><a href="#" class="gh-name" data-gh="{id}" data-lat="{lat}" data-lng="{lng}">{name}</a></td></tr> -->
            <table class="table" id="search-tbl">
            </table>
			
			

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
	var infowindow;
	var markerCluster ;

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

	// DB에서 데이터 받아오는 함수
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
	
	function getCurrentLocation(cbSuccess, cbFail) {
		
		
	    if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(cbSuccess, cbFail);
	    } else {
	        console.log ( "Geolocation is not supported by this browser.") ;
	        cbFail ( 'fail' );
	    }
	}
	
	function installControlls ( map ) {
		var searchCtrl = document.createElement('div');
	    $(searchCtrl).css('margin' , '10px');
	    
		var btn = $('<div style="-webkit-user-select: none; box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; border-radius: 2px; cursor: pointer; width: 28px; height: 28px; background-color: rgb(255, 255, 255);text-align:center"><i class="fa fa-search fa-2x" aria-hidden="true" style="margin-top:3px;"></i></div>');
		searchCtrl.appendChild ( btn[0] );
		
		btn.on ( 'click', function(){
			$('#gh-info').hide();
			$('#gh-search').show();
		
		});
		
		map.controls[google.maps.ControlPosition.TOP_RIGHT].push(searchCtrl);
		
		var myposition =$('<div style="-webkit-user-select: none; box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; border-radius: 2px; cursor: pointer; width: 28px; height: 28px; background-color: rgb(255, 255, 255);text-align:center"><i class="fa fa-location-arrow fa-2x" aria-hidden="true" style="margin-top:3px;"></i></div>')
		searchCtrl.appendChild ( myposition[0] );
		
		myposition.on ( 'click', function(){
			getCurrentLocation(function(position) {
				var lat = position.coords.latitude;
				var lng = position.coords.longitude;
				var myLatLng = { lat:lat, lng:lng };
				map.setCenter(myLatLng);
				/*
				var marker = new google.maps.Marker({
				    position: myLatLng,
				    map: map,
				    title: '나의 위치'
				});
			 	markers.push(marker);
				*/
				
			}, function( error ) {
				console.log(error );
			});
		
		});
		
	}

	function initMap() {

		map = new google.maps.Map(document.getElementById('map'), {
			center : curCenter,
			zoom : 14

		});
		installControlls ( map );
		infowindow = new google.maps.InfoWindow({
			content : 'no content'
		});

			
		//guesthouses 배열의 값을 마커로 출력
		for (var i = 0; i < guesthouses.length; i++) {
			var marker = new google.maps.Marker({
				position : {
					lat : guesthouses[i].lat,
					lng : guesthouses[i].lng
				},
				icon : {
					fillColor : 'yellow' ,
					fillOpacity : 0.5,
					path : 'M-5,0a5,5 0 1,0 10,0a5,5 0 1,0 -10,0'
				} ,
				map : map,
				title : guesthouses[i].name,
				gh : guesthouses[i]
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
		/*
		for ( var k = 0 ; k < markers.length ; k++ ) {
			markers[k].setMap ( null );
		}
		*/
		
		var options = {
		 	imagePath: ctxpath + '/resources/images/m'
		 };

		markerCluster = new MarkerClusterer(map, markers, options);
		
	}

	function updateGhInfo(gh) {
		$('#gh-info').css('display', 'block');
		$('#gh-name').html(gh.name)
		$('#gh-link').attr("href", gh.url);
		$('#gh-address').html(gh.address);
		$('#gh-phone a').html(gh.phone);
		$('#gh-phone a').attr('href', 'tel:' + gh.phone);
		activeGh = gh;
	}
	
	function showInfowindow(map, marker, gh) {
		var template = '<a href={0}><i>{1}</i></a><br><c:if test="${not empty loginUser }">'
				+ '<button type="button" id="{id}" class="btn btn-success btn-xs">추가</button></c:if>    ';

		var content = template.replace("{0}", gh.url).replace("{1}",
				gh.name).replace("{id}", 'gh' + gh.id); // id="btn"
		if(map.getZoom() <= 17) {
			map.setZoom ( 17 );				
		} 
		map.setCenter(marker.getPosition());
		infowindow.setContent(content);
		infowindow.open(map, marker);
	}

	function addClickListener(infowin, map, marker, gh) {


		marker.addListener('click', function() {
			/*
			var content = template.replace("{0}", gh.url).replace("{1}",
					gh.name).replace("{id}", 'gh' + gh.id); // id="btn"
			infowin.setContent(content);
			infowin.open(map, marker);
			*/
			showInfowindow(map, marker, gh);
			$("#gh-search").hide();
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
				alert(gh.name+"가 추가되었습니다.");
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