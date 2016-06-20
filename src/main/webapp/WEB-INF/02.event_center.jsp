<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>CENTER의 위도 경도 출력</title>
    <meta name="viewport" content="initial-scale=1.0">
    <meta charset="utf-8">
    <link href="<%=application.getContextPath() %>/resources/css/bootstrap.min.css" rel="stylesheet">
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }
    </style>
    <script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/jquery-1.11.3.js"></script>
    <script type="text/javascript">
    var guesthouses = [];
    var ctxpath = '<%=application.getContextPath() %>';
    $(document).ready( function() {
/*     	
    	$.get( ctxpath + '/ghdata.json' , function( resp ) {
    		// {"data":[{"lng":126.91695973428261,"name":"시드게스트하우스","id":1,"lat":33.468129861052574,"url":"http:\/\/localhost:8080\/gh\/39393","info":"제주도 위치1"},{"lng":126.90262399765027,"name":"수상한소금밭","id":2,"lat":33.490385445453654,"url":"http:\/\/localhost:8080\/gh\/233","info":"제주도 위치2"}],"success":true}
    		
    		if ( resp.success ) {
    			guesthouses = resp.data;
    			
    		}
    		
    	}); */
    });
    </script>
  </head>
  <body>
    <div id="map"></div>
    <script>
    // /ghdata.json ? 
var map;
var curCenter = {
 lat : 33.504644819360955, 
 lng : 126.4942775800781
};
/*
var guesthouses = [
{
 name : '산방산게스트하우스',
 lat : 33.23255758504589,
 lng : 126.30854687662057,
 url : 'http://localhost:8080/gh/43443'
},
{
 name : '사계게스트하우스',
 lat : 33.231812165087895,
 lng : 126.29858749927214,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '네모커패앤게스트하우스',
 lat : 33.290099836998685,
 lng : 126.16577122511637,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '늘푸른게스트하우스',
 lat : 33.2141844129521,
 lng : 126.25917310835055,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '뿌리게스트하우스',
 lat : 33.32058546441496,
 lng : 126.17781032027972,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '와하하게스트하우스',
 lat : 33.3099207979367,
 lng : 126.83087390067351,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '소낭게스트하우스',
 lat : 33.55204387553987,
 lng : 126.79098911734593,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : 'B게스트 하우스',
 lat : 33.4852474057651,
 lng : 126.45196305065916,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '꿈꾸는물고기게스트하우스',
 lat : 33.4902864623745,
 lng : 126.90053824486506,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '수상한소금밭',
 lat : 33.490385445453654,
 lng : 126.90262399765027,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '시드게스트하우스',
 lat : 33.468129861052574, 
 lng : 126.91695973428261,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '해와바다게스트하우스',
 lat : 33.468991286258834,
 lng : 126.92047611030114,
 url : 'http://localhost:8080/gh/39393'
},
{
 name : '포도게스트하우스',
 lat : 33.466051217966225,
 lng : 126.93498417886269,
 url : 'http://localhost:8080/gh/39393'
}];
*/
// http://www.w3schools.com/html/html5_geolocation.asp

function loadGoogleMap () {
	
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
   
   
 }
  
  
  /*
  var pos = curCenter;
  // here
  var contentString = '<div id="Tom N Toms"><b>T and T</b>AHAHAHAHAHA</div>';
  var infowindow = new google.maps.InfoWindow({
    content: contentString
  });
  var marker = new google.maps.Marker({
     position: pos,
     map: map,
     title: 'Tom N Toms'
  });
  
  marker.addListener('click', markerClicked);
  */
  
}
/*
 * "비동기 방식으로 콜백을 등록합니다" 메소드를 등록하는 시점과 실행되는 시점에 서로 다름
 * 이래서 엄청 헷갈림.
 */
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
	});
 
 console.log("콜백 등록했음.");
}
function markerClicked () {
 console.log();
}
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCy1X-f36fp4thbEIZSJWpCU7GCKMve2uA&callback=loadGoogleMap"
        async defer></script>
  </body>
</html> 