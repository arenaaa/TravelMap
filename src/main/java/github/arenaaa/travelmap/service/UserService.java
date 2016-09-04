package github.arenaaa.travelmap.service;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import github.arenaaa.travelmap.dao.UserDao;

@Service
public class UserService {

	@Autowired(required=true)
	private UserDao userDao ;
	
	@Autowired(required=true)
	private MailService mailService ;
	
	public void resetPw (Integer userSeq, String email, int expMins ) {
		/*
		 *  1. 존재하는 이메일
		 *  -1 이메일에 대응하는 seq값 얻어내기 ( * )
		 *  -2  url 토큰 만들고 ( ex "dkdkdk2dkdkdksld2kdkjd" )
		 *  -3 새로운 비번 생성 하고
		 *  -4 만료 시간은 현재 입력의 1시간? ( * )
		 *  
		 *  1, 2, 3, 4를 디비에 인서트!
		 *  
		 *  2. 메일 전송
		 *     /resetpw/dkdkdk2dkdkdksld2kdkjd
		 *  
		 *  3. json 응답 - "dddd@naver.com으로 메일 전송했습니다.
		 *  
		 *  메일 전송 후 
		 *  
		 */
		
		//List<Integer> seq = userDao.findByEmail(email);
		String token = generateToken(); //"aldkjfads;lkfjds;lakj";
		String genPw = generatePw();
		
		userDao.insertResetPw(userSeq, token, genPw, expMins);
		
		mailService.sendMail(email, "RESET PASSWORD", 
				"PASSWORD CHANGED <a href=http://localhost:8080/tmap/resetpw/" + token + "> LINK </a>" );
	}

	private String generatePw() {
		String t = "0123456789abcdefghikdlskdkdk$#$%@";
		Random rand = new Random();
		String pw = "";
		for ( int i = 0 ; i < 8 ; i ++ ) {
			pw += t.charAt( rand.nextInt(t.length()) );
		}
		return pw;
	}

	private String generateToken() {
		String uid =  java.util.UUID.randomUUID().toString();
		System.out.println("token length : " + uid.length());
		return uid;
	}
	
	
}
