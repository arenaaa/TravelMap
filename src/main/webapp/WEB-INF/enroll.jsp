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

$(document).ready ( function (){

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

});
</script>

<title>게스트하우스 위경도 검색</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div style="position: relative">
            <div id="map" style="width:100%;height:300px;"></div>
            <div id="cross"><div id="w"></div><div id="h"></div></div>
            <div id="map-info"><input type="text" id="latlng" placeholder="위도 경도 출력 위치" class="form-control"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <h3>게스트하우스</h3>
            <form id="frm-search"onsubmit="return false;">
                <input type="checkbox" checked="checked" id="use-bnd">반경 10KM 이내 검색
                  <input type="text" id="keyword" placeholder="게스트하우스검색 + 엔터" class="form-control" value="게스트하우스">
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-6">
            <div id="search_wrap">
                <ul id="placesList" class="list-group">
                    <!-- 
                    <li class="list-group-item" data-lat="33.50819890827951" data-lng="126.51527912315979"><span class="title">미르 게스트하우스</span>-<span class="addr">제주시 어디어디</span>
                    <li class="list-group-item" data-lat="33.520101495632694" data-lng="126.53450182074451">미르 게스트하우스-제주시 어디어디
                     -->
                </ul>
                <nav>
                    <ul class="pagination">
                        <li class="disabled"><a href="#" aria-label="Previous" data-target="{pg}"><span aria-hidden="true">&laquo;</span></a></li>
                        <li class="active"><a href="#" data-pg="{pg}">1</a></li>
                        <li><a href="#" data-pg="{pg}">2</a></li>
                        <li class="disabled"><a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="col-xs-6">
            <div id="gh-detail">
                <div>NAME : <span class="gh-name"></span></div>
                <div>INFO : <span class="gh-info"></span></div>
                <div>POS : <span class="gh-lat"></span>, <span class="gh-lng"></span></div>
                <div>URL : <span class="gh-url"></span></div>
                <div>ADDR : <span class="gh-addr"></span></div>
            </div>
            <div>
                <textarea id="query" class="form-control" rows="5"></textarea>
                <input type="button" id="btnClear" value="CLEAR">
            </div>
        </div>
    </div>

</div>
</body>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=6960b8f8bc93e9fd96bc91dff9cb3497&libraries=services"></script>
<script>
var ctxpath = '<%=request.getContextPath()%>';
var margin =5 * 1000; // meters

var mapContainer = document.getElementById('map'), 
    mapOption = { 
        center: new daum.maps.LatLng(33.450701, 126.570667),
        level: 8
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
map.addControl ( new daum.maps.ZoomControl(), daum.maps.ControlPosition.RIGHT);

var markers = [];

var area = new daum.maps.Circle ({
    center : map.getCenter(),
    radius : margin,
    strokeColor : '#57C',
    strokeStyle : 'dashed'
});
area.setMap ( map );

var useBoundary = true;

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

function doSearch ( keyword, pagenum ) {

    var trimmed = keyword.replace(/^\s+|\s+$/g, '');
    if ( !trimmed ) {
        alert('키워드를 입력해주세요!');
        return;
    }

    var options = { page : pagenum ? parseInt ( pagenum ) : 1 };

    if ( useBoundary ) {
        options.location = map.getCenter() ;
        options.radius = margin;
    }

    searchService.keywordSearch ( trimmed, function (status, resp, pagination){
        if ( status === daum.maps.services.Status.OK ) {
            console.log ( resp );
            console.log( pagination);
            displayPlaces ( resp.places );
            displayPagination ( pagination);
            updateHistory( trimmed, resp.places, pagination );

            flushQuery( true, resp.places);

        } else if (status === daum.maps.services.Status.ZERO_RESULT) {

            alert('검색 결과가 존재하지 않습니다.');
            return;

        } else if (status === daum.maps.services.Status.ERROR) {

            alert('검색 결과 중 오류가 발생했습니다.');
            return;

        }
    }, options );
}

function displayPlaces ( places ) {
    var $ul = $('#placesList');
    $ul.empty();
    var bounds = new daum.maps.LatLngBounds();
    var liTemplate = '<li class="list-group-item" data-lat="{lat}" data-id="{id}" data-lng="{lng}"><span class="title">{name}</span>-<span class="addr">{addr}</span></li>';
    for ( var i = 0 ; i < places.length ; i++ ) {
        var lat = places[i].latitude;
        var lng = places[i].longitude;
        var liHtml = liTemplate.replace ( '{lat}', lat)
                               .replace ( '{lng}', lng)
                               .replace ( '{id}', places[i].id)
                               .replace ('{name}', places[i].title)
                               .replace ('{addr}', places[i].newAddress);

        $ul.append ( liHtml );
    }

    // markers
    $.each ( markers, function ( i, mkr){
        mkr.setMap ( null );
    });
    markers = [];
    for ( i = 0 ; i < places.length ; i++ ) {
        lat = places[i].latitude;
        lng = places[i].longitude;
        var marker = new daum.maps.Marker ({map : map , position : new daum.maps.LatLng ( lat, lng )});
        markers.push ( marker );
    }
}

function displayPagination( pgn ) {
    var prevTpl = '<li class="{disabled}"><a href="#" aria-label="Previous" data-pg="{pg}"><span aria-hidden="true">&laquo;</span></a></li>';
    var eachTpl = '<li class="{a}"><a href="#" data-pg="{pg}">{pg}</a></li>';
    var nextTpl = '<li class="{disabled}"><a href="#" aria-label="Next" data-pg={pg}><span aria-hidden="true">&raquo;</span></a></li>';

    var $UL = $('#search_wrap .pagination');
    $UL.empty();

    for ( var i = pgn.first ; i <= pgn.last ; i ++ ) {
        var each = eachTpl.replace ( '{pg}', i).replace('{pg}', i );
        if ( i == pgn.current ) {
            each = each.replace('{a}', 'active');
        } else {
            each = each.replace('{a}', '');
        }
        $UL.append ( each );
    }
}

function displayDetail( ghId ) {
    /*
            <div id="gh-detail">
                <div>NAME : <span class="gh-name"></span></div>
                <div>INFO : <span class="gh-info"></span></div>
                <div>POS : <span class="gh-lat"></span>, <span class="gh-lng"></span></div>
                <div>URL : <span class="gh-url"></span></div>
                <div>ADDR : <span class="gh-addr"></span></div>
            </div>
    */
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
function showMapInfo ( map ){
    var pos = map.getCenter();
    $('#latlng').val ( pos.getLat() + ', ' + pos.getLng());
    area.setPosition ( pos );
}
function installListener () {
    daum.maps.event.addListener(map, 'dragend', function() {
        showMapInfo ( map );
    });
    /*
    daum.maps.event.addListener(map, 'center_changed', function() {
        showMapInfo ( map );
    });
    */
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