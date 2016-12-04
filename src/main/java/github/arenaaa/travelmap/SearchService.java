package github.arenaaa.travelmap;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

@Service
public class SearchService {

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
