/**
 * pagenation suppprt
 * 
 * 24
 * 
 * 5
 * 5
 * 5
 * 5
 * 4
 * 
 * var pgn = Pagenation(total, 10, 5).getPagenation( 112);
 * 
 * pgn.start; // 11
 * pgn.end ;  // 15
 * pgn.curPage ; // 112
 */

function Pagenation ( total, display, groupSize ) {
	/*
	 * total : 231
	 * display : 10
	 * groupSize : 5
	 * 
	 * 112 : 11, 16
	 * 
	 * [1, 2, 3, 4, 5]
	 * 
	 * [6, 7, 8, 9, 10]
	 */
	//var pagesize = total / display 
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
	
	console.log ( 'P : ' , P);
	console.log ( 'GC :', GC);
	
	
	return {
		getPagination : function ( curPage ) {
			
			var GI = curPage - 1 ; //  0, 1, 2, 3, 4 = > start: 0, end:4 prev=-1, next=5 
			
			var offset = parseInt(GI / groupSize) ;
			
			var start = offset * groupSize ;
			var end = Math.min(start + groupSize, P);
			
			var prev = -1 ;
			if( start > 0 ) {
				prev = GI   ;
			}
			
			var next = -1;
			if ( end < P ) {
				next = start + groupSize // (start+groupSize) * display + 1 ;
			}
			return {
				curPage : curPage ,
				start : start ,
				end :   end,
				
				prev : start - 1,
				next : end + 1 
			}
		}
	}
}