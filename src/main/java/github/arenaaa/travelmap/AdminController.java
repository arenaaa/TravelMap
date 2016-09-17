package github.arenaaa.travelmap;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import github.arenaaa.travelmap.dao.PathDao;
import github.arenaaa.travelmap.vo.UserVO;

@Controller 
public class AdminController {

	@Autowired
	private PathDao pathDao;
	
	@RequestMapping(value="/route-editor" , method = RequestMethod.GET)
	public String edit() {
		return "editor";
	}
	
	@RequestMapping(value="/pathdata/{path}" , method = RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> edit(@PathVariable(value = "path") String path) {
		String pathstring = pathDao.getPath(path);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", true);
		map.put("data", pathstring.trim());
		
		return map;
		
	}
}
