package github.arenaaa.travelmap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import github.arenaaa.travelmap.dao.GhDao;
import github.arenaaa.travelmap.dao.UserDao;
import github.arenaaa.travelmap.service.UserService;
import github.arenaaa.travelmap.vo.GuestHouse;
import github.arenaaa.travelmap.vo.UserVO;

@Controller
public class UserController {

	@Autowired
	private UserDao userDao ; //userDao 생성해줌
	
	@Autowired
	UserService userService ;
	
	public String pageLogin() {
		return "login";
	}
	
	@RequestMapping(value="/join", method = RequestMethod.GET)
	public String join_ok( HttpServletRequest req ){
		req.setAttribute ( "msg", "WELCOME!");
		return "join-ok"; // forwarding
	}
	
	@RequestMapping(value="/doJoin", method = RequestMethod.POST)
		/*
		 * 브라우저가 회원가입 정보를 보내왔음.
		 * dao를 이용해셔 정보를 넣고
		 * 어딘가로? 리다이렉트를 해줘야 함!
		 */
		
		
	public String setMember (HttpServletRequest req, HttpServletResponse res){
		   // model과 view를 동시에 지정 가능한 객체 선언
		ModelAndView mav = new ModelAndView();
//		mav.setView("travelmap/do-join);
		/*
		 * 1. 검증긴으이 없음. (짜증나는 부분)(손도 많이 가고 자동화해야함!)
		 * 
		 */
		String userid = req.getParameter("uid");
		String email = req.getParameter("email");
		String password = req.getParameter("pw");
		UserVO uservo = new UserVO();
		uservo.setUserid(userid);
		uservo.setEmail(email);
		uservo.setPassword(password);
		// 데이터를 추가하는 메소드 호출
		
		UserDao udao = new UserDao();
		udao.insertUser(uservo);
		
		return "welcome"; // return "redirect:/success";
	}
	/*
	@RequestMapping(value="/welcome", method=RequestMethod.GET)
	public String pageWelcom () {
		return "welcome";
	}
	*/
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public @ResponseBody String login_ok( HttpServletRequest req, HttpSession session ){
		req.setAttribute ( "msg", "WELCOME!");
		String userid = req.getParameter("uid");
		String password = req.getParameter("pw");

		UserVO loginUser = userDao.Login( userid, password );
			
		String jsonString = "";
		if ( loginUser != null ) {
			System.out.println("OK");
			session.setAttribute("loginUser", loginUser);
			jsonString = "{\"success\": true}";
		} else {
			System.out.println("Fail");
			jsonString = "{\"success\": false}";
		}
		return jsonString; // @ResponseBody {}.jsp(x),  
	}
	
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public @ResponseBody String join_ok( HttpServletRequest req, HttpSession session ){
		req.setAttribute ( "msg", "WELCOME!");
		String userid = req.getParameter("uid");
		String password = req.getParameter("pw");
		String email = req.getParameter("email");

		UserVO joinUser = new UserVO(userid, password, email);
		userDao.Join( joinUser );
			
		String jsonString = "";
		if ( joinUser != null ) {
			System.out.println("OK");
			jsonString = "{\"success\": true}";
		} else {
			System.out.println("Fail");
			jsonString = "{\"success\": false}";
		}
		return jsonString; // @ResponseBody {}.jsp(x),  
	}
	
	@RequestMapping(value="/doLogin", method = RequestMethod.POST)
	public String doLogin( HttpServletRequest req, HttpSession session ) {
		String userid = req.getParameter("uid");
		String password = req.getParameter("pw");

		UserVO loginUser = userDao.Login( userid, password );
		if ( loginUser != null ){
			// header.jsp에서 로그인 여부를 판별할때 아래의 loginUser를 el태그에서 사용하게 됩니다.
			session.setAttribute("loginUser", loginUser );
			return "redirect:/";
		} else {
			return "/login";
		}
		
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(HttpSession session ) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/update", method = RequestMethod.GET)
	public String update(HttpServletRequest req, HttpSession session) {
		return "/update";
	}
	
	@RequestMapping(value="forgotpw", method=RequestMethod.GET)
	public String forgotpw() {
		return "forgotpw";
	}
	
	@RequestMapping(value="doresetpw", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object>  doresetpw( @RequestParam(value="email") String email ) {
		Map<String, Object> json = new HashMap<>();
		
		List<Integer> seq = userDao.findByEmail(email);
		
		if( !seq.isEmpty() ) {
			
			
			userService.resetPw( seq.get(0), email, 60 );
			json.put("success", true);
			json.put("email", email);
			
			return json;
		} else {
			json.put("success", false);
			json.put("cause", "NO_SUCH_EMAIL");
			
			return json;
			
		}
	}
	
	/*
	// /around/36.44344,126.2333
	 * /around?lat
	 *
	@RequestMapping(value="/around/{lat},{lng}" )
	public List<GuestHouse> findAround( @PathParam(value="lat") String lat, String lng, double radium ) {
		return nulll;
	}
	*/
	
	@RequestMapping(value="resetpw/{path}", method=RequestMethod.GET)
	public String updatepwpage(@PathVariable(value = "path") String path, HttpSession session) {
		System.out.println("[" + path + "]");
		UserVO user = userDao.findUserByPath ( path, "n" );
		if ( user == null ) {
			session.invalidate();
			return "expired";
		}
		
		session.setAttribute("user", user); // Session 생성 시 user 라는 이름으로 넣어줌
		return "updatepw"; //xxxx.jsp
	}
	/* 클라이언트                           서버
	 * 
	 * 1. 이메일 입력   --------------->  1.1 ppth 생성
	 *                                 1.2 db에 path와 이메일을 넣어둠.
	 *                                 1.3 이메일 전송
	 *                                 
	 * 2. 이메일 로그인을 함.
	 *    링크를 클릭( /doupdoupdate/dekdk3d...) ---> 2.1 {path}를 잡아냄
	 *                                             2.2 path로 이메일(사용자)를 찾아냄
	 *                                             2.3 
	 *                        
	 */
	@RequestMapping(value="doupdatepw", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> doupdatepw (@RequestParam (value="InputPw") String password, HttpSession session) {
		
		UserVO user = (UserVO) session.getAttribute("user"); //Session 에서 생성한 user 이름으로 받아옴
		Integer userseq = user.getSeq();
		user.setPassword(password);
		userDao.update(user);
		userDao.closedPath(userseq);
		session.invalidate();
		
		Map<String, Object> resp = new HashMap<>();
		resp.put("success", true);
		
		return resp;
	}
	
}
