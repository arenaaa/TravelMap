package github.arenaaa.travelmap.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.mariadb.jdbc.Driver;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;

import github.arenaaa.travelmap.vo.UserVO;

public class UserDao {


	private JdbcTemplate template ;
	
	public UserDao () {
		template = new JdbcTemplate();
		SimpleDriverDataSource ds = new SimpleDriverDataSource();
		
	
		ds.setDriver(new Driver());
		ds.setUsername("root");
		ds.setPassword("");
		ds.setUrl("jdbc:mysql://localhost:3306/GHDB");
		
		template.setDataSource(ds);
	}
	
	public void insertUser ( UserVO user ) {
		String query = "INSERT INTO users (userid, email, password) values (?, ?, ?)";
		SqlParameterSource sqlsource = new BeanPropertySqlParameterSource(user);
		template.update(query, 
				new Object[] {
						user.getUserid(), 
						user.getEmail(), 
						user.getPassword()});
		
		
	}
}

