package github.arenaaa.travelmap.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.mariadb.jdbc.Driver;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import github.arenaaa.travelmap.vo.*;

public class GhDao {

	private JdbcTemplate template ;
	
	public GhDao () {
		template = new JdbcTemplate();
		SimpleDriverDataSource ds = new SimpleDriverDataSource();
		
	
		ds.setDriver(new Driver());
		ds.setUsername("root");
		ds.setPassword("");
		ds.setUrl("jdbc:mysql://localhost:3306/GHDB");
		
		template.setDataSource(ds);
	}
	
	public List<GuestHouse> finalAll() {
		final List<GuestHouse> ghList;
		final String query = "select * from guesthouses ";
		
		ghList = template.query(query, new RowMapper<GuestHouse>(){

			@Override
			public GuestHouse mapRow(ResultSet rs, int rowNum) throws SQLException {
				Integer id = rs.getInt("id");
				String name = rs.getString("name");
				String info = rs.getString("info");
				Double lat = rs.getDouble("lat");
				Double lng = rs.getDouble("lng");
				String url = rs.getString("url");
				
				GuestHouse gh = new GuestHouse(id, name, info, lat, lng, url);
				return gh;
			}
		});
		return ghList;
	}
	
	public void addFavoriteGH ( String ghId, Integer uid ) {
		String query = "insert into favoriteGH (traveller, gh) values (?,?);";
		template.update(query, new Object[] {uid, ghId});
		
	}

	public List<GuestHouse> findFavoriteGH(UserVO user) {
		String query = "select * from guesthouses where id IN ( select `gh` from favoriteGH where traveller = ?); ";
		List<GuestHouse> ghList = template.query(query, new Object[]{user.getSeq()}, new RowMapper<GuestHouse>(){

			@Override
			public GuestHouse mapRow(ResultSet rs, int rowNum) throws SQLException {
				Integer id = rs.getInt("id");
				String name = rs.getString("name");
				String info = rs.getString("info");
				Double lat = rs.getDouble("lat");
				Double lng = rs.getDouble("lng");
				String url = rs.getString("url");
				
				GuestHouse gh = new GuestHouse(id, name, info, lat, lng, url);
				return gh;
			}
			
			
		});
		return ghList;
	}
}
