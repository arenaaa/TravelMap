package github.arenaaa.travelmap.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.mariadb.jdbc.Driver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;

import github.arenaaa.travelmap.vo.UserVO;

public class UserDao {

	@Autowired
	private JdbcTemplate template;

	public UserDao() {
		
	}

	public void insertUser(UserVO user) {
		String query = "INSERT INTO users (userid, email, password) values (?, ?, ?)";
		SqlParameterSource sqlsource = new BeanPropertySqlParameterSource(user);
		template.update(query, new Object[] { user.getUserid(), user.getEmail(), user.getPassword() });

	}

	/*
	 * 파라미터를 UserVO로 하니까 사용하는 쪽에서 불편함. 아래처럼 id와 password를 각각 전달받게 하면 쓰는 쪽이 좀 더
	 * 편함!
	 * 
	 */
	public UserVO Login(String userId, String password) {
		String query = "select seq, userid, password, email from users where userid = ? and password = ?";
		// 익명 클래스라고 합니다.
		/*
		 * 인스턴스를 만들때 항상 클래스 파일이 있었습니다. 그런데 어떤 경우에는 클래스를 별도로 만들어서 쓰는게 귀찮음!!! 그냥
		 * 바로 하나 만들어서 쓰고 싶다!!
		 */
		// RowMapper<UserVO> mapper = new UserMapper();

		List<UserVO> users = template.query(query, new Object[] { userId, password }, new RowMapper<UserVO>() {
			/*
			 * mapRow는 다음의 상황에서 호출됩니다.
			 * 
			 * PreparedStatement stmt = con.preparedSttem ( "select *.... ");
			 * stmt.setString ( 1, "xxxx");
			 * 
			 * ResultSet rs = stmt.executeQuery(); int idx = 0; List<UserVO>
			 * users = new ArrayList<>(); while ( rs.next() ) { UserVO user =
			 * mapper.mapRow ( rs, idx ); users.add ( user ); idx ++; }
			 * 
			 * return users;
			 */
			@Override
			public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {

				Integer pk = rs.getInt("seq");
				String userId = rs.getString("userid");
				String password = rs.getString("password");
				String email = rs.getString("email");

				UserVO user = new UserVO(pk, userId, password, email);
				return user;
			}
		});

		if (users.isEmpty()) {
			return null;
		} else {
			return users.get(0);
		}
	}

	

	public void Join(UserVO joinUser) {
		String query = "insert into users(userid, email, password) values (?, ?, ?)";
		template.update(query, joinUser.getUserid(), joinUser.getEmail(), joinUser.getPassword() );

	}
	/**
	 * 주어진 이메일이 존재하면 대응하는 seq반환 , 그렇지 않으면 -1 반환.
	 * @param email
	 * @return
	 */
	public List<Integer> findByEmail(String email) {
		String query = "select seq from users where email = ?";
		List<Integer> seq = template.query(query, new Object[] {email}, new RowMapper<Integer> (){

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				
				Integer seq = rs.getInt(1);
				return seq;
			}
		});
		return seq; 
	}

	public void insertResetPw(Integer userSeq, String token, String genPw, int expMins) {
		String query = "insert into resetpw (genpw, userid, expired, token, closed) values ( ?, ? , DATE_ADD(NOW(), INTERVAL ? MINUTE), ?, 'n' )";
		template.update(query, new Object[] { genPw, userSeq, expMins, token });
	}

}
