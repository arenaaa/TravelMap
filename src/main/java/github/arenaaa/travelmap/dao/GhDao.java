package github.arenaaa.travelmap.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mariadb.jdbc.Driver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.stereotype.Repository;

import github.arenaaa.travelmap.vo.*;

public class GhDao {

	@Autowired
	private JdbcTemplate template;

	public GhDao() {
	}
	
//	public void setTemplate ( JdbcTemplate template) {
//		this.template = template;
//	}

	public GuestHouse findGhBySeq(String ghSeq) {
		final String query = "select * from guesthouses where id = ?";
		;
		return null;
	}

	public List<GuestHouse> finalAll() {
		final List<GuestHouse> ghList;
		final String query = "select * from guesthouses ";

		ghList = template.query(query, new RowMapper<GuestHouse>() {

			@Override
			public GuestHouse mapRow(ResultSet rs, int rowNum) throws SQLException {
				Integer id = rs.getInt("id");
				String name = rs.getString("name");
				String info = rs.getString("info");
				Double lat = rs.getDouble("lat");
				Double lng = rs.getDouble("lng");
				String url = rs.getString("url");
				String address = rs.getString("address");
				String phone = rs.getString("phone");

				GuestHouse gh = new GuestHouse(id, name, info, lat, lng, url, address, phone);
				return gh;
			}
		});
		return ghList;
	}

	public void addFavoriteGH(String ghId, Integer uid) {
		String query = "insert into favoriteGH (traveller, gh) values (?,?);";
		// 변하는 것 update ( insert, update, delete )
		template.update(query, new Object[] { uid, ghId });

	}

	public List<GuestHouse> findFavoriteGH(UserVO user) {
		String query = "select * from guesthouses where id IN ( select `gh` from favoriteGH where traveller = ?); ";
		List<GuestHouse> ghList = template.query(query, new Object[] { user.getSeq() }, new RowMapper<GuestHouse>() {

			@Override
			public GuestHouse mapRow(ResultSet rs, int rowNum) throws SQLException {
				Integer id = rs.getInt("id");
				String name = rs.getString("name");
				String info = rs.getString("info");
				Double lat = rs.getDouble("lat");
				Double lng = rs.getDouble("lng");
				String url = rs.getString("url");
				String address= rs.getString("address");
				String phone = rs.getString("phone");
						

				GuestHouse gh = new GuestHouse(id, name, info, lat, lng, url, address, phone);
				return gh;
			}

		});
		return ghList;
	}

	public void delFavoriteGH(String ghSeq, Integer uid) {
		String query = "delete from favoriteGH where traveller = ? and gh = ?";
		template.update(query, new Object[] { uid, ghSeq });
	}

	public List<GuestHouse> findByName(String searchWord) {
		// 입력받은 문자열은 "시드" -> 쿼리를 만들때는 %시드% 로 바꿔줘야함.
		String param = "%"+searchWord+"%";
		String query = "select * from guesthouses where name like ? ";
		
		List<GuestHouse> ghList = template.query(query, new Object[] { param }, new RowMapper<GuestHouse>() {

			@Override
			public GuestHouse mapRow(ResultSet rs, int rowNum) throws SQLException {
				Integer id = rs.getInt("id");
				String name = rs.getString("name");
				String info = rs.getString("info");
				Double lat = rs.getDouble("lat");
				Double lng = rs.getDouble("lng");
				String url = rs.getString("url");
				String address= rs.getString("address");
				String phone = rs.getString("phone");
						

				GuestHouse gh = new GuestHouse(id, name, info, lat, lng, url, address, phone);
				return gh;
			}

		});
		return ghList;
	}

//	public ArrayList<String> getGhName() {
//
//		String query = "select name from guesthouses";
//		template.query(query, rse)
//		return null;
//	}
}
