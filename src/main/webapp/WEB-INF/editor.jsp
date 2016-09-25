<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css"rel="stylesheet">

<style type="text/css">
#cross {
    position : absolute;
    top : 50%;
    left : 50%;
    width : 1px;
    height : 1px;

    z-index: 1000;
}
#cross #w {
    position: absolute;
    top : 0px;
    left : -10px;
    width : 20px;
    height : 1px;
    background-color: #f00;
}
#cross #h {
    position: absolute;
    top : -10px;
    left : 0px;
    width : 1px;
    height :20px;
    background-color: #f00;
}
#map-info {
    position : absolute;
    top : 0px;
    left : 0px;
    width : 400px;
    height : 34px;
    z-index: 1000;
    opacity : 0.7;
}
#placesList {
    max-height : 100px;
    overflow: auto;
}
#placesList li .title {
    font-size: 1.5em;
    font-weight: bold;
}
#placesList li .addr {
    color : #3c3;
}
</style>
<script src="<%=request.getContextPath()%>/resources/js/jquery-1.11.3.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
<script type="text/javascript">
var apikey = '6960b8f8bc93e9fd96bc91dff9cb3497';

var route01 = [];

$(document).ready ( function (){
	/*
    $('#keyword').on('keyup', function(e) {
        if ( e.keyCode == 13) {
            doSearch ( $(this).val() );
        }
    });

    $('#placesList').on('mouseover', function(e){
        $(e.target).closest('li').css('background-color', '#ffc').css('cursor', 'pointer');

    }).on('mouseout', function(e){
        $(e.target).closest('li').css('background-color', '#fff    ') ;
    }).on('click', function(e){
        var $li = $(e.target).closest('li');
        var lat = $li.data('lat');
        var lng = $li.data('lng');
        console.log ( lat , lng);
        map.panTo ( new daum.maps.LatLng ( parseFloat(lat), parseFloat(lng)));
        showMapInfo ( map );
        displayDetail ( $li.data('id'));
    });

    $('#search_wrap .pagination').on('click', function (e ) {
        var pagenum = parseInt( $(e.target).data ( 'pg') );
        result.pgn.gotoPage ( pagenum );
    });

    $('#use-bnd').on('click', function(){
        var checked = $(this).prop('checked') ;
        repaint( checked );

    });

    $('#query').on('click', function() {
        $(this)[0].select();
    });

    $('#btnClear').on('click', function(){
        $('#query').val('');
    });
	*/
});
</script>

<title>게스트하우스 올레길 경로 입력 도구</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
    </div>
    <div class="row">
        <div class="col-xs-8">
            
	        <div style="position: relative">
	            <div id="map" style="width:100%;height:600px;"></div>
	            <div id="cross"><div id="w"></div><div id="h"></div></div>
	            <div id="map-info"><input type="text" id="latlng" placeholder="위도 경도 출력 위치" class="form-control"></div>
	        </div>
        </div>
        <div class="col-xs-4">
            <textarea rows="30" class="form-control" id="path"></textarea>
            <button id="commit" onclick="updatepath()">올레길 갱신하기</button>
            <button id="clear" onclick="clearpathString()">모두 지우기</button>
            
        </div>
    </div>
    

</div>
<div class="map_wrap">
    <div id="drawingMap"></div>
    <p class="modes">
    	<div class="col-xs-8">
            
    	<select id="route" onchange="showPath()" >
		  <option>[코스선택]</option>
		  <option value="1" >올레길1코스</option>
		  <option value="2">올레길2코스</option>
		  <option value="3">올레길3코스</option>
		  <option value="4">올레길4코스</option>
		</select>
	    <button onclick="selectOverlay('MARKER')">마커</button>
	    <button onclick="selectOverlay('POLYLINE')">선</button>
	    <button onclick="printlatlng()">가져오기</button>
	    <button onclick="removeline()">지우기</button>
	    
	    
	    <p class="edit">
		<button id="undo" class="disabled" onclick="undo()" disabled>UNDO</button>
	    <button id="redo" class="disabled" onclick="redo()" disabled>REDO</button>
	</p>
	</div>
</div>
</body>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=6960b8f8bc93e9fd96bc91dff9cb3497&libraries=services,drawing"></script>
<script type="text/javascript">
var ctxpath = '<%=request.getContextPath()%>';
var margin =5 * 1000; // meters

var mapContainer = document.getElementById('map'), 
    mapOption = { 
        center: new daum.maps.LatLng(33.450701, 126.570667),
        level: 8
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
map.addControl ( new daum.maps.ZoomControl(), daum.maps.ControlPosition.RIGHT);

var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
    map: map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
    drawingMode: [ // Drawing Manager로 제공할 그리기 요소 모드입니다
        daum.maps.Drawing.OverlayType.MARKER,
        daum.maps.Drawing.OverlayType.POLYLINE
    ],
    
    // 사용자에게 제공할 그리기 가이드 툴팁입니다
    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
    guideTooltip: [], 
    markerOptions: { // 마커 옵션입니다 
        draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
        removable: true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다  
    },
    polylineOptions: { // 선 옵션입니다
        draggable: false, // 그린 후 드래그가 가능하도록 설정합니다
        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
        editable: true, // 그린 후 수정할 수 있도록 설정합니다 
        strokeColor: '#39f', // 선 색
        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
        hintStrokeOpacity: 0.5  // 그리중 마우스를 따라다니는 보조선의 투명도
    },
   
};

// 위에 작성한 옵션으로 Drawing Manager를 생성합니다
var manager = new daum.maps.Drawing.DrawingManager(options);

// undo, redo 버튼의 disabled 속성을 설정하기 위해 엘리먼트를 변수에 설정합니다
var undoBtn = document.getElementById('undo');
var redoBtn = document.getElementById('redo');

// Drawing Manager 객체에 state_changed 이벤트를 등록합니다
// state_changed 이벤트는 그리기 요소의 생성/수정/이동/삭제 동작 
// 또는 Drawing Manager의 undo, redo 메소드가 실행됐을 때 발생합니다
manager.addListener('state_changed', function() {

	// 되돌릴 수 있다면 undo 버튼을 활성화 시킵니다 
	if (manager.undoable()) {
		undoBtn.disabled = false;
		undoBtn.className = "";
	} else { // 아니면 undo 버튼을 비활성화 시킵니다 
		undoBtn.disabled = true;
		undoBtn.className = "disabled";
	}

	// 취소할 수 있다면 redo 버튼을 활성화 시킵니다 
	if (manager.redoable()) {
		redoBtn.disabled = false;
		redoBtn.className = "";
	} else { // 아니면 redo 버튼을 비활성화 시킵니다 
		redoBtn.disabled = true;
		redoBtn.className = "disabled";
	}

});

// 버튼 클릭 시 호출되는 핸들러 입니다
function selectOverlay(type) {
    // 그리기 중이면 그리기를 취소합니다
    manager.cancel();

    // 클릭한 그리기 요소 타입을 선택합니다
    manager.select(daum.maps.Drawing.OverlayType[type]);
}

function printlatlng() {
	var data = manager.getData();

    // 지도에 가져온 데이터로 도형들을 그립니다
    var lines = data[daum.maps.Drawing.OverlayType.POLYLINE];
    
    var len = lines.length, i = 0;

    if ( len == 0 ) {
    	return;
    }
    var str = '126.444,38.566';
    var points = lines[0].points;
    var something = getpath( points );
    console.log( points );	
    /*
    for (; i < len; i++) {
        var path = lines[i].points
        
        console.log(i + 'th: ', path);
    }
    */
    $('#path').val ( something );
}
function removeline() {
	removeOverlays();
}

function updatepath() {
	var sel = $('#route')[0];
	var path = $('#path').val();
	var id =  sel.item ( sel.selectedIndex ).value ;
	var formData = {
		pathid : id,
		path : path
	};
	$.post(ctxpath + '/updatepath', formData, function(resp) {
		console.log(resp);
		alert('갱신하였습니다.');
	});
}

function getpath(points) {
	var lat, lng;
	var str = '';
	for ( var i = 0; i < points.length; i++) {
		lat = points[i].x;
		lng = points[i].y;
		str = str + lat + ',' + lng + '\n';
	}
	return str;
}

function showPath() {
	var sel = $('#route')[0];
	// console.log ( sel.selectedIndex );
	
	if ( sel.selectedIndex != 0 ) {
		var pathId = sel.item ( sel.selectedIndex ).value ;
		$.get(ctxpath + '/pathdata/'+ pathId, function(resp){
			if(resp.success) {
				console.log(resp.data);
				var path= [];
				var lines = resp.data.split('\n');
				for ( var i = 0; i < lines.length; i++){
					var xy = lines[i].split(','); // xy[0] , xy[1] // 
					var lng = parseFloat(xy[0]);
					var lat = parseFloat(xy[1]);
					var latlng = new daum.maps.LatLng(lat, lng);
			        path.push(latlng); 
				}
				manager.put(daum.maps.Drawing.OverlayType.POLYLINE, path);
			}
		} );
	}
	
}
// undo 버튼 클릭시 호출되는 함수입니다.
function undo() {
	// 그리기 요소를 이전 상태로 되돌립니다
	manager.undo();
}

// redo 버튼 클릭시 호출되는 함수입니다.
function redo() {
	// 이전 상태로 되돌린 상태를 취소합니다
	manager.redo();
}

var markers = [];
/*
daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng;
    route01.push(latlng);
    
 // 지도에 표시할 선을 생성합니다
    var polyline = new daum.maps.Polyline({
        path: route01, // 선을 구성하는 좌표배열 입니다
        strokeWeight: 5, // 선의 두께 입니다
        strokeColor: '#FFAE00', // 선의 색깔입니다
        strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
        strokeStyle: 'solid' // 선의 스타일입니다
    });

    // 지도에 선을 표시합니다 
    polyline.setMap(map); 
    
    ///route01.push(latlng.getLat(), latlng.getLng());
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    console.log ( message );
    
});
*/

daum.maps.event.addListener(map, 'mousemove', function( e ) {
	// var target = mouseEvent.target;
	// console.log ( e );
});

var searchService = new daum.maps.services.Places();
var result = {keyword : '', places : {}, pgn : null }
function updateHistory( keyword, places, pagination ) {
    result.keyword = keyword;
    for ( var i = 0 ; i < places.length ; i++ ) {
        var p = places[i] ;
        result.places[ p.id ] = places[i];
    }
    result.pgn = pagination ;
}

function displayDetail( ghId ) {

    var place = result.places[ghId];
    var gh = $('#gh-detail');
    $('.gh-name', gh).text ( place.title );
    $('.gh-info', gh).text ( place.title);
    $('.gh-lat', gh).text ( place.latitude);
    $('.gh-lng', gh).text ( place.longitude);

    $('.gh-url', gh).text ( 'PARSING...' );


    $.get ( ctxpath + '/placeurl', {dmapPlaceUrl : place.placeUrl }, function ( resp ){
        var tpl = '<a target="_blank" href="{}">{}</a>';
        var h = '' ;

        if ( resp.success) {
            h = tpl.replace('{}', resp.url).replace('{}', resp.url);
        } else {
            h = 'error : ' + resp.cause ;
        }    

        $('.gh-url', gh).html ( h  );

        var q = "INSERT IGNORE INTO guesthouses ( name, info, lat, lng, url ) values ( '{n}', '{i}', {lat}, {lng}, '{url}');\n";
        var query = q.replace('{n}', place.title)
                     .replace('{i}', place.title + '입니다')
                     .replace('{lat}', place.latitude)
                     .replace('{lng}', place.longitude)
                     .replace('{url}', resp.success ? resp.url : '#');
        // $('#query').text ( query );
    });

function clearpathString(){
	$('#path').value;
}

}

function flushQuery(append, places ) {
    console.log ( 'flusing query :' , places.length);
    var qholder = $('#query');
    if ( !append) {
        qholder.val('');
    }
    var q = "INSERT IGNORE INTO guesthouses ( name, info, lat, lng, url,address, phone ) values ( '{n}', '{i}', {lat}, {lng}, '{url}', '{addr}', '{phone}' );\n";

    for ( var i = 0 ; i < places.length; i ++ ) {
        (function(place ) {
            $.get ( ctxpath + '/placeurl', {dmapPlaceUrl : place.placeUrl }, function ( resp ){
                if ( resp.success || resp.cause == 'NO_URL' ) {
                    var query = q.replace('{n}', place.title)
                                 .replace('{i}', place.title + '입니다')
                                 .replace('{lat}', place.latitude)
                                 .replace('{lng}', place.longitude)
                                 .replace('{addr}', place.address)
                                 .replace('{phone}', place.phone)
                                 .replace('{url}', resp.success ? resp.url : '#');
                    qholder.val ( qholder.val() + query );
                } else {
                    //h = 'error : ' + resp.cause ;
                    console.log ( 'error' , place.title, resp.cause );
                }    

            });

        })(places[i]);
    }
}

function installListener () {

}
function repaint(useBnd) {
    useBoundary = useBnd ;

    if ( useBoundary ) {
        area.setMap ( map );
    } else {
        area.setMap ( null );
    }
    map.relayout();
}
installListener();
</script>
</html>