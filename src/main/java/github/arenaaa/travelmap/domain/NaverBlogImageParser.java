package github.arenaaa.travelmap.domain;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class NaverBlogImageParser implements ImageUrlParser {

	@Override
	public boolean isAcceptableUrl ( String url ) {
		// http://blog.naver.com/xxxx/sdldkslkdjfkdjf
		// http://itstory.com/xlskdk
		return url.contains("blog.naver.com");
	}
	
	@Override
	public List<String> parseImageUrls(String blogUrl) {
		/*
		 * TODO blog url 을 보고 그에 맞는 파서를 사용해야 합니다.
		 */
		Connection con ;
		
		con = Jsoup.connect ( blogUrl );
		
		try {
			Document doc = con.get();
			
//			System.out.println(doc.toString());
			
			/*
			 * 
			 */
			String mainLink = doc.select("#mainFrame").attr("src");
			String mainUrl = "http://blog.naver.com" + mainLink;
			System.out.println(mainUrl);
			
			con = Jsoup.connect( mainUrl );
			
			doc = con.get();
			Elements elems = doc.select("td.bcc img[src*=postfiles]"); //태그.클래스이름 자식중img태그 찾음
			List<String> imgs = new ArrayList<String>();
			for ( Element img : elems ) {
				imgs.add(img.attr("src"));
			}
			
			return imgs;
			
		} catch (IOException e) {
			throw new RuntimeException( e );
		}
	}

}
