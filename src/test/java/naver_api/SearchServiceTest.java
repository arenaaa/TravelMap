package naver_api;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;

import github.arenaaa.travelmap.SearchService;

public class SearchServiceTest {

	@Test
	public void test() {
		SearchService service = new SearchService();
		
		String xml = service.searchGH("와흘리게스트하우스", 1);
		System.out.println(xml);
	}
	
	@Test
	public void test_get_image_links () {
		SearchService service = new SearchService();
		List<String> links = service.parseBlogImages("http://blog.naver.com/dmsdms0516?Redirect=Log&logNo=220782738132");
		System.out.println(links.size() + " images");
		System.out.println(links);
	}

}
