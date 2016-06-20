package github.arenaaa.travelmap;

import java.lang.reflect.Method;

import github.arenaaa.travelmap.dao.GhDao;

public class AboutReflection {
	public static void main(String[] args) throws ClassNotFoundException, InstantiationException, IllegalAccessException {
		/*
		 * 1. 생성자 호출을 통해서 인스턴스를 만브니다.
		 */
		GhDao ghDao = new GhDao();
		Class clsA = ghDao.getClass();
		
		/*
		 * 2. 리플렉션으로 인스턴스를 생성합니다.
		 */
		String classname = "github.arenaaa.travelmap.dao.GhDao";
		Class<?> clsB = Class.forName(classname); // GhDao.class
		Object instance = clsB.newInstance();
		GhDao ghDao1 = (GhDao) instance;
		
		
		System.out.println(clsA == clsB );
		
		
		
		
	}
}
