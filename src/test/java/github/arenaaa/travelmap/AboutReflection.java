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
		
		String name = readName();
		
//		System.out.println("length: " + name.length());
		
		/*
		 * 3. NullPointerException
		 *    메소드가 스태틱이 아니고.
		 *    메소드 앞에 붙어있는 변수가 null임!
		 *    그런데 메소드를 호출해버림!
		 *    
		 *    변수.메소드();
		 *    
		 */
		name = null;
		System.out.println(name.length());
		/*
		 public int length(String this) {
        	return this.value.length;
    	}
		 */
		
		
	}

	private static String readName() {
		return null; // null을 반환함.
	}
}
