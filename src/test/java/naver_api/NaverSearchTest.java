package naver_api;

import static org.junit.Assert.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.junit.Test;

public class NaverSearchTest {

	@Test
	public void test_parsing_html() throws IOException {
		/*
		 * http://blog.saltfactory.net/html5/using-html5-custom-data-attributes.
		 * html
		 */
		Document doc = Jsoup.connect("http://blog.saltfactory.net/html5/using-html5-custom-data-attributes.html").get();

		Elements images = doc.select("img");
		for (Element img : images) {

			System.out.println("URL: " + img.attr("src"));
		}
	}

	@Test
	public void test_parsing_xml() throws IOException {
		Connection con = Jsoup.connect(
				"https://openapi.naver.com/v1/search/blog.xml?query=" + keyword("소낭게스트하우스") + "&start=1&display=10");
		Parser parser = org.jsoup.parser.Parser.xmlParser();
		con.parser(parser);
		con.header("X-Naver-Client-Id", "74d0w2qyx1FrOv8NYiu4");
		con.header("X-Naver-Client-Secret", "TVVzDouamH");

		Document xml = con.get();

		Elements links = xml.select("rss channel item  link");
		// System.out.println(xml.toString());
		for (Element link : links) {
			System.out.println(link.text());
		}

	}

	private String keyword(String keyword) throws UnsupportedEncodingException {
		return URLEncoder.encode(keyword, "UTF-8");
	}

}
