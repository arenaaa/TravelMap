package github.arenaaa.travelmap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import github.arenaaa.travelmap.dao.PathDao;

@Controller
public class RouteController {

	@Autowired
	private PathDao pathdao;
	
	@RequestMapping(value="/olleh/{path}" , method = RequestMethod.GET,  produces="application/json;charset=utf-8")
	public @ResponseBody Map<String, Object> edit(@PathVariable(value = "path") String path) {
		String pathstring = pathdao.getPath(path);
		String[] values = pathstring.split("\n");
		String[] latlng = null;
		
		StringBuilder sb = new StringBuilder();
		List<LatLng> routes = new ArrayList<>();
		
		for( int i=0; i<values.length; i++) {
			latlng = values[i].split(",");
			routes.add( new LatLng(Double.parseDouble(latlng[1]), Double.parseDouble(latlng[0])));
		}
		
		/*
		 * "{lat:37.55,23.44},{lat:37.55,23.44},{lat:37.55,23.44},{lat:37.55,23.44},{lat:37.55,23.44}
		 */
		System.out.println("points : " + sb.toString());
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", true);
		map.put("routes", routes);
//		map.put("routes","["+ sb.toString()+"]");
		
		return map;
		
//		return "{\"success\": true, \"routes\": [" + sb.toString() + "]}";
		
	}
	
	public static class LatLng {
		private Double lat;
		private Double lng ;
		public LatLng(Double lat, Double lng) {
			super();
			this.lat = lat;
			this.lng = lng;
		}
		public Double getLat() {
			return lat;
		}
		public Double getLng() {
			return lng;
		}
	}
	
}
