package github.arenaaa.travelmap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BoardController {

	@RequestMapping(value="/board", method = RequestMethod.GET)
	public String join_ok( HttpServletRequest req ){
		req.setAttribute ( "msg", "WELCOME!");
		return "board"; //
	}
}
