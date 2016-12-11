package github.arenaaa.travelmap.domain;

import java.util.List;

public interface ImageUrlParser {
	/**
	 * 주어진 url을 검색할 수 있는지 나타냅니다.
	 * @param url
	 * @return
	 */
	boolean isAcceptableUrl(String url);

	/**
	 * 주어진 사이트에서 이미지 링크를 반환합니다. 
	 * @param blogUrl
	 * @return
	 */
	public List<String> parseImageUrls ( String blogUrl ) ;

}
