package github.arenaaa.travelmap.vo;

public class UserVO {

	private int seq;
	private String userid;
	private String password;
	private String email;
	
	
	public UserVO() {
		
	}
	
	public UserVO(int seq, String userid, String password, String email) {
		super();
		this.seq = seq;
		this.userid = userid;
		this.password = password;
		this.email = email;
	}
	
	public UserVO(String userid, String password, String email) {
		this.userid = userid;
		this.password = password;
		this.email = email;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	
}
