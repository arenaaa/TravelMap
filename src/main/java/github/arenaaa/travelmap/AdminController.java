package github.arenaaa.travelmap;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import github.arenaaa.travelmap.dao.AdminDao;
import github.arenaaa.travelmap.dao.PathDao;
import github.arenaaa.travelmap.vo.DetailVO;
import github.arenaaa.travelmap.vo.GuestHouse;
import github.arenaaa.travelmap.vo.UserVO;

@Controller 
public class AdminController {

	@Autowired
	private PathDao pathDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@RequestMapping(value="/route-editor" , method = RequestMethod.GET)
	public String edit() {
		return "editor";
	}
	
	@RequestMapping(value="/admin" , method = RequestMethod.GET)
	public String adminedit(HttpSession session, Model model ) {
		
		if ( session.getAttribute("loginUser") == null ) {
			return "redirect:/";
		}
		UserVO user = (UserVO) session.getAttribute("loginUser");
		Integer seq = user.getSeq();
		List<GuestHouse> gh = adminDao.findGHbyowner(seq);
		
		model.addAttribute("gh", gh);
		System.out.println("gh목록 : " + gh);
		return "admin";
	}
	
	@RequestMapping(value="/pathdata/{path}" , method = RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> edit(@PathVariable(value = "path") String path) {
		String pathstring = pathDao.getPath(path);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", true);
		map.put("data", pathstring.trim());
		
		return map;
		
	}
	
	@RequestMapping(value="/updatepath" , method = RequestMethod.POST)
	public @ResponseBody String updatepath (HttpServletRequest req) {
		String updatepathstr = req.getParameter("path");
		String pathid = req.getParameter("pathid");
		
		pathDao.updatePath(updatepathstr, pathid);
		
		return "{\"success\":true}";
		
	}
	
	@RequestMapping(value="/ghdetail/{ghid}" , method = RequestMethod.GET)
	public @ResponseBody DetailVO ghdetail(@PathVariable(value = "ghid") String ghid) {
		
		DetailVO detail = adminDao.findDetail(ghid);
		return detail;
		
	}
}
