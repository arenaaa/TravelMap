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

	public String searchGH ( String ghName ) {
		Connection con;
		try {
			con = Jsoup.connect(
					"https://openapi.naver.com/v1/search/blog.xml?query=" + keyword(ghName) + "&start=1&display=10");
			
			Parser parser = org.jsoup.parser.Parser.xmlParser();
			con.parser(parser);
			con.header("X-Naver-Client-Id", "74d0w2qyx1FrOv8NYiu4");
			con.header("X-Naver-Client-Secret", "TVVzDouamH");
			
			Document xml = con.get();
			
			StringBuilder sb = new StringBuilder("<search>");
			Elements items = xml.select("rss channel item");
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
			sb.append("</search>");
			
			return sb.toString();
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException( e );
		} catch (IOException e) {
			throw new RuntimeException( e );
		}
		
		
	}
	
	private String keyword(String keyword) throws UnsupportedEncodingException {
		return URLEncoder.encode(keyword, "UTF-8");
	}
}
