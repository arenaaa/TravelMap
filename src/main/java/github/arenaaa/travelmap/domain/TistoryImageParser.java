package github.arenaaa.travelmap.domain;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class TistoryImageParser implements ImageUrlParser {

	@Override
	public boolean isAcceptableUrl(String url) {
		// http://*.tistory.com
		return url.contains(".tistory.com");
	}

	@Override
	public List<String> parseImageUrls(String blogUrl) {
		
//		return  new ArrayList<>();
		return Collections.emptyList();
	}

}
