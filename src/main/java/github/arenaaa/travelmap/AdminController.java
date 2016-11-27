package github.arenaaa.travelmap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import github.arenaaa.travelmap.dao.AdminDao;
import github.arenaaa.travelmap.dao.PathDao;
import github.arenaaa.travelmap.service.AdminService;
import github.arenaaa.travelmap.vo.DetailVO;
import github.arenaaa.travelmap.vo.GuestHouse;
import github.arenaaa.travelmap.vo.UserVO;

@Controller 
public class AdminController {

	@Autowired
	private PathDao pathDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private AdminService adminService ;
	
	@RequestMapping(value="/route-editor" , method = RequestMethod.GET)
	public String edit() {
		return "editor";
	}
	
	private List<String> times = new ArrayList<String>();
	{
		String t = "xx:00:00";
		for(int i=0; i<24; i++){
			times.add(t.replace("xx", String.format("%02d", i)) );
		}
	}
	
	private List<String> limitTimes = new ArrayList<String>();
	{
		limitTimes.add("22:00:00");
		limitTimes.add("23:00:00");
		limitTimes.add("24:00:00");
	}
	
	private List<Integer> parkinglot = new ArrayList<Integer>();
	{
		for(int i=0; i<=100; i++){
			parkinglot.add(i);
		}
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
		model.addAttribute("times", times);
		model.addAttribute("limitTimes", limitTimes);
		model.addAttribute("parkinglot", parkinglot);
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
	public @ResponseBody Map<String, Object> ghdetail(@PathVariable(value = "ghid") String ghid) {
		
		Map<String, Object> resp = new HashMap<>();
		DetailVO detail = adminDao.findDetail(ghid);
		if ( detail == null ){
			resp.put("success", Boolean.FALSE);
			resp.put("cause", "NO_DETAIL");
		} else {
			resp.put("success", Boolean.TRUE);
			resp.put("detail", detail);
		}
		/*
		 * { success : true, gh : { ... } }
		 */
		return resp;
		
	}
	
	@RequestMapping(value="/ghdetail/edit" , method = RequestMethod.POST)
	public @ResponseBody String updateGHDetail ( @ModelAttribute DetailVO detail, BindingResult result ) {
		System.out.println( detail );
		if ( result.hasErrors() ) {
			System.out.println("바인딩 에러 발생! ");
		}
		
//		adminDao.updateghDetail(detail);
		adminService.updateGhDetail(detail);
		
//		DetailVO detail = adminDao.findDetail(ghid);
		return "{}";
		
	}
	
	
	
}
