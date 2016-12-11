package github.arenaaa.travelmap;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.log4j.spi.LoggerFactory;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.springframework.stereotype.Service;

import github.arenaaa.travelmap.domain.ImageUrlParser;
import github.arenaaa.travelmap.domain.NaverBlogImageParser;
import github.arenaaa.travelmap.domain.TistoryImageParser;

@Service
public class SearchService {

	private static Logger logger = org.slf4j.LoggerFactory.getLogger(SearchService.class);
	
//	private List<ImageUrlParser> imageUrlParsers = 
//			Arrays.<ImageUrlParser>asList(new NaverBlogImageParser());
	private List<ImageUrlParser> imageUrlParsers = new ArrayList<>();
	{
		imageUrlParsers.add(new NaverBlogImageParser());
		imageUrlParsers.add(new TistoryImageParser());
		
	}
	
	/**
	 * 주어진 네이버 블로그 포스팅에 들어있는 이미지 링크를 수집합니다.
	 * @param blogUrl 네이버 블로그 포스팅 url 
	 * @return 포스팅 안에 포함된 이미지 링크들
	 */
	public List<String> parseBlogImages ( String blogUrl ) {
		
		for( int i = 0 ; i < imageUrlParsers.size(); i ++ ) {
			ImageUrlParser parser = imageUrlParsers.get(i);
			if ( parser.isAcceptableUrl(blogUrl) ) {
				return parser.parseImageUrls(blogUrl);
			}
		}
		
		logger.warn("[UNKNOWN BLOG URL ] " + blogUrl);
		
		return Arrays.asList();
	}
	/**
	 * 
	 * @param ghName 검색할 게스트하우스 이름
	 * @param pageNum 검색 페이지
	 * @return
	 */
	public String searchGH ( String ghName, int pageNum ) {
		String url = "https://openapi.naver.com/v1/search/blog.xml?query={0}&start={1}&display=10";
		Connection con;
		try {
			url = url.replace("{0}", keyword(ghName));
			int start = 10 * (pageNum - 1) + 1;
			url = url.replace("{1}", "" + start);
			
			Parser parser = org.jsoup.parser.Parser.xmlParser();
			con = Jsoup.connect(url);
			con.parser(parser);
			con.header("X-Naver-Client-Id", "74d0w2qyx1FrOv8NYiu4");
			con.header("X-Naver-Client-Secret", "TVVzDouamH");
			
			Document xml = con.get();
			
			StringBuilder sb = new StringBuilder("<search>");
			String total = xml.select("rss channel total").text();
			String pageElem = "<page cur=\"{0}\" total=\"{1}\"/>";
			pageElem = pageElem.replace("{0}", ""+pageNum);
			pageElem = pageElem.replace("{1}", total);
			sb.append(pageElem);
			
			Elements items = xml.select("rss channel item");
			sb.append("<items>");
			for (Element item : items) {
				String title = item.select("title").text();
				String link = item.select("link").text();
				String desc = item.select("description").text();
				// <![CDATA[]]>
				
				sb.append("<item>");
				sb.append("<title><![CDATA[" + title + "]]></title>");
				sb.append("<link><![CDATA[" + link + "]]></link>");
				sb.append("<desc><![CDATA[" + desc + "]]></desc>");
				/* */
				List<String> imgs = parseBlogImages( link ); 
				
				sb.append("<images>");
				for ( int i=0; i<imgs.size(); i++){
					sb.append("<img>");
					sb.append(imgs.get(i));
					sb.append("</img>");
				}
				sb.append("</images>");
				/* */
				sb.append("</item>");
			}
			sb.append("</items>");
			sb.append("</search>");
			
			return sb.toString();
			
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException( e );
		} catch (IOException e) {
			throw new RuntimeException( e );
		}
	}
	/**
	 * 1페이지조회
	 * @param ghName
	 * @return
	 */
	public String searchGH ( String ghName ) {
		return searchGH(ghName, 1);
	}
	
	private String keyword(String keyword) throws UnsupportedEncodingException {
		return URLEncoder.encode(keyword, "UTF-8");
	}
}
