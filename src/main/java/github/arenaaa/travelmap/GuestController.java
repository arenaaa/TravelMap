package github.arenaaa.travelmap;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.parser.Parser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import github.arenaaa.travelmap.dao.GhDao;
import github.arenaaa.travelmap.vo.GuestHouse;
import github.arenaaa.travelmap.vo.UserVO;

@Controller
public class GuestController {

	private static Logger logger = LoggerFactory.getLogger(GuestController.class);
	
	@Autowired
	private GhDao ghDao ; // 어찌어찌 - Reflection!
	/*
	 * GuestController c = new GuestController();
	 * 
	 */

	@RequestMapping(value="/ghdata.json", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> /*List<GuestHouse>*/ GuestHouseList( HttpServletResponse res ){
		/*
		 *  HTTP 1.1 OK 200
		 *  header
		 *  header
		 *  header
		 *  
		 * {"msg": "OK"}
		 * 
		 * { 
		 *   success : true,
		 *   data : [{}, {], {}]
		 * }
		 * 
		 * 실제로는 이 응답을 처리해주는 라이브러리가 뒷단(스프링 프레임워크 저기 어딘가)에 있습니다.
		 */
		List<GuestHouse> ghList = ghDao.finalAll();
		
		Map<String, Object> resp = new HashMap<String, Object>();
		resp.put("success", true);
		resp.put("data", ghList);
		
		return resp;
//		return "{\"msg\": \"OK\"}";
	}
	
	@RequestMapping(value="/mygh", method=RequestMethod.GET)
	public String mygh(HttpServletRequest req, HttpSession session) {
		/*
		 *   /travelmap/mygh
		 */
		UserVO user = (UserVO) session.getAttribute("loginUser");
		List<GuestHouse> ghList = ghDao.findFavoriteGH(user);
		req.setAttribute("ghList", ghList); // myghpage.jsp 에서 el 태그로 쓸 수 있게됨!
		
		return "myghpage";
		
	}
	
	@RequestMapping(value="/addgh", method=RequestMethod.POST)
	public @ResponseBody String addgh( HttpServletRequest req, HttpSession session ) {
		// 1. /addgh?geha=14
		// 2. /adgh/14 
		String ghId = req.getParameter ( "geha");
		UserVO user = (UserVO) session.getAttribute("loginUser");
		Integer uid = user.getSeq(); // 
		ghDao.addFavoriteGH(ghId, uid);
		System.out.println("geha : " + ghId);
		
		return "{\"success\":true}";
		
	}
	
	@RequestMapping(value="/delgh", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	public  @ResponseBody String delgh( HttpServletRequest req, HttpSession session ){
		String ghSeq = req.getParameter("geha");
		UserVO user = (UserVO) session.getAttribute("loginUser");
		Integer uid = user.getSeq();
		ghDao.delFavoriteGH(ghSeq, uid);

		return "{\"success\":true}";
	}
	
	// map 으로 반환
	@RequestMapping(value="/viewgh", method=RequestMethod.GET, produces="application/json;charset=utf-8")
	public @ResponseBody String viewgh( HttpServletRequest req, HttpSession session ) {
		String ghSeq = req.getParameter("gh");
		UserVO user = (UserVO) session.getAttribute("loginUser");
		Integer uid = user.getSeq();
		GuestHouse gh = ghDao.findGhBySeq(ghSeq);
		/*
		 *  { "success" : true, "gh" : { "lat" : 23.233, "lng" : 322.3233, "name": "gdkdkdk" } }
		 */
		return "";
		
	}
	
	@Autowired
	private SearchService ghService ; // = new SearchService();
	
	@RequestMapping(value="/searchGH", method=RequestMethod.GET, produces="text/xml;charset=utf-8")
	public @ResponseBody String searchGH( @RequestParam(value="ghname") String ghName, @RequestParam Integer pagenum ) {
//	public String searchGH( HttpServletRequest req ) {
//		String ghName = req.getParameter("ghname");
		System.out.println("gh: " + ghName);
		System.out.println("page: " + pagenum);
		
		String xml = ghService.searchGH(ghName, pagenum);
		return xml ;
	}
	
	@RequestMapping(value="/registergh", method=RequestMethod.GET)
	public String registergh( HttpServletRequest req, HttpSession session ) {
		return "registergh";
	}
	
//	@RequestMapping(value="/autocomplete.json", method=RequestMethod.POST)
//	public @ResponseBody Map<String, Object> autocomplete ( HttpServletRequest req) {
//		String searchValue=req.getParameter("searchValue");
//		JSONArray arrayObj = new JSONArray();
//		JSONObject jsonobj = null;
//		
//		
//		ArrayList<String> dblist = new ArrayList<String>();
//		dblist = ghDao.getGhName();
//	}
	
	@RequestMapping(value="/search.json", method=RequestMethod.GET, produces="application/json;charset=utf-8")
	public @ResponseBody Map<String, Object> search( @RequestParam(value="k") String searchWord ) {
		
		Map<String, Object> map = new HashMap<String, Object>();

		if ( searchWord == null || searchWord.trim().length() == 0 ){
			map.put("success", false);
			map.put("cause", "EMPTY_QUERY");
		} else {
			logger.info("keyworad: " + searchWord);
			List<GuestHouse> results = ghDao.findByName(searchWord.trim());
			
			map.put("success", true);
			map.put("data", results);
			
		}
		
		return map;
	}
	
	@RequestMapping(value="enroll", method=RequestMethod.GET)
    public String pageEnrollbyAdmin ( ) {
        return "enroll";
    }

	
	
	
    @RequestMapping(value="placeurl", method=RequestMethod.GET, produces="application/json;charset=utf-8")
    public @ResponseBody String parseGhUrl ( @RequestParam  String dmapPlaceUrl ) {

        try {

            Connection con  = Jsoup.connect(dmapPlaceUrl) ;
            con.timeout(60 * 1000);
            Document doc = con.get();
            String url = doc.select("#daumContent #homepageTooltip a.f_l").attr("href").trim();
            System.out.println("URL: " + dmapPlaceUrl + " => " + url);
            if ( url.length() == 0  ) {
                return "{\"success\" : false , \"cause\": \"{0}\" }".replace("{0}", "NO_URL");                
            } else {
                return "{\"success\" : true , \"url\": \"{0}\" }".replace("{0}", url);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "{\"success\" : false , \"cause\": \"{0}\" }".replace("{0}", e.getMessage());
        }
    }
}

