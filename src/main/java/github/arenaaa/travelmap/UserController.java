package github.arenaaa.travelmap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import github.arenaaa.travelmap.dao.UserDao;
import github.arenaaa.travelmap.vo.UserVO;

@Controller
public class UserController {

	private UserDao userDao ;
	
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
		
		return "welcome";
	}
	/*
	@RequestMapping(value="/welcome", method=RequestMethod.GET)
	public String pageWelcom () {
		return "welcome";
	}
	*/
}
