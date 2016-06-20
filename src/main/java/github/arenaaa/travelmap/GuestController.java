package github.arenaaa.travelmap;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import github.arenaaa.travelmap.dao.GhDao;
import github.arenaaa.travelmap.vo.GuestHouse;

@Controller
public class GuestController {

	@Autowired
	private GhDao ghDao ; // 어찌어찌 - Reflection!
	/*
	 * GuestController c = new GuestController();
	 * 
	 */

	@RequestMapping(value="/ghdata.json", method=RequestMethod.GET)
	public @ResponseBody List<GuestHouse> GuestHouseList( HttpServletResponse res ){
		/*
		 *  HTTP 1.1 OK 200
		 *  header
		 *  header
		 *  header
		 *  
		 * {"msg": "OK"}
		 * 
		 * 실제로는 이 응답을 처리해주는 라이브러리가 뒷단(스프링 프레임워크 저기 어딘가)에 있습니다.
		 */
		List<GuestHouse> ghList = ghDao.finalAll();
		return ghList;
//		return "{\"msg\": \"OK\"}";
	}
}
