function Pagenation ( total, display, groupSize ) {

    var itemsInGroup = display * groupSize ; 
    var P = parseInt(total / display) ; // 전체 페이지 갯수
    if ( total % display == 0){
        P = P + 0;
    } else {
        P = P + 1;
    }

    var GC = parseInt(P/groupSize);
    if( P%groupSize != 0 ){
        GC = GC + 1;
    }
    console.log ( 'T  : ', total );
    console.log ( 'P  : ', P);
    console.log ( 'GC : ', GC);


    return {
        getPagination : function ( curPage ) {

            var pageIndex = curPage - 1 ; //  0, 1, 2, 3, 4 = > start: 0, end:4 prev=-1, next=5 

            var groupIndex = parseInt(pageIndex / groupSize) ;

            var start = groupIndex * groupSize ;
            var end = Math.min(start + groupSize, P);

            var prev = -1 ;
            if( start > 0 ) {
                prev = start - 1   ;
            }

            var next = -1;
            if ( end < P ) {
                next = start + groupSize // (start+groupSize) * display + 1 ;
            }
            return {
                curPage : curPage ,
                start : start ,
                end :   end - 1 ,

                prev : prev,
                next : next 
            }
        }
    }
}