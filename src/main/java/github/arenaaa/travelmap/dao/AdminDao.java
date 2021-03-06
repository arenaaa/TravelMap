package github.arenaaa.travelmap.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;

import github.arenaaa.travelmap.vo.DetailVO;
import github.arenaaa.travelmap.vo.GuestHouse;

public class AdminDao {

	@Autowired
	private JdbcTemplate template;

	public AdminDao() {
	}

	public List<GuestHouse> findGHbyowner(Integer seq) {
		String query = "select * from guesthouses where owner = ?";
		return template.query(query, new Object[] {seq}, new RowMapper<GuestHouse>(){
			
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
	}

	public DetailVO findDetail(String ghid) {
		String query = "select * from ghdetails where id = ?";
		
		DetailVO detail = template.query(query, new Object[]{ghid}, new ResultSetExtractor<DetailVO>(){

			@Override
			public DetailVO extractData(ResultSet rs) throws SQLException, DataAccessException {
				if ( rs.next() ) {
					
					Integer id = rs.getInt("id");
					boolean womanOnly = asBoolean (rs.getString("womanonly"));
					String breakfastStart = rs.getString("breakfaststart");
					String breakfastEnd = rs.getString("breakfastend");
					String limitTime = rs.getString("limittime");
					boolean foodOutsideOnly = asBoolean(rs.getString("food_outside_only"));
					String extra = rs.getString("extra");
					Integer parkingLot = rs.getInt("parkinglot");
					boolean bbq = asBoolean(rs.getString("bbq"));
					String bbqMemo = rs.getString("bbqmemo");
					String checkin = rs.getString("checkin");
					String checkout = rs.getString("checkout");
					
					return new DetailVO(id, womanOnly, breakfastStart, breakfastEnd, limitTime,
							foodOutsideOnly, extra, parkingLot, bbq, bbqMemo, checkin,
							checkout);
				} else {
					return null;
				}
			}

			private boolean asBoolean(String ch) {
				ch = ch.toUpperCase();
				if ( "Y".equals(ch) ) {
					return true;
				} else if ( "N".equals(ch) ) {
					return false;
				} else {
					throw new RuntimeException("enum 인데 Y, N 아닌 값은 뭐임? ");
				}
			}
			
			
		}); 
		
		return detail;
	}

	public void updateGH () {
		;
	}
	public void updateDetail(DetailVO detail) {
		String query="UPDATE ghdetails SET "
				+ "womanonly = ?, "
				+ "breakfaststart = ?, "
				+ "breakfastend = ?, "
				+ "limittime = ?, "
				+ "food_outside_only = ?, "
				+ "extra = ?, "
				+ "parkinglot = ?, "
				+ "bbq = ?, "
				+ "bbqmemo = ?, "
				+ "checkin = ?, "
				+ "checkout = ? "
				+ "WHERE id=?";
		/*
		template.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement stmt = con.prepareStatement(query);
				return null;
			}
		});
		*/
		Object [] params = new Object[] {
				detail.isWomanOnly() ? "Y" :"N", 
				detail.getBreakfastStart(), detail.getBreakfastEnd(),
				detail.getLimitTime().equals("null") ? null : detail.getLimitTime(),
				detail.isFoodOutsideOnly() ? "Y" :"N",
				detail.getExtra(),
				detail.getParkingLot(),
				detail.isBbq() ? "Y" :"N",
				detail.getBbqMemo(),
				detail.getCheckin(),
				detail.getCheckout(),
				detail.getId() };
		System.out.println(Arrays.toString(params));
		template.update(query, params );
	}

	public boolean existDetails(Integer id) {
		String query = "select count(id) from ghdetails where id = ?";
		
		 Integer detail = template.query(query, new Object[] {id}, new ResultSetExtractor<Integer>(){

			@Override
			public Integer extractData(ResultSet rs) throws SQLException, DataAccessException {
				rs.next();
				return rs.getInt(1);
			}
		 });
	
		 if ( detail >= 1 ){
			 return true;
		} else {
			return false;
		} 
	}

	public void insertDetail(DetailVO detail) {
		String query = "INSERT INTO  ghdetails ( " +
    " id               ,  " +
    " womanonly        ,  " +
    " breakfaststart   ,  " +
    " breakfastend     ,  " +
    " limittime        ,  " +
    " food_outside_only,  " +
    " extra            ,  " +
    " parkinglot       ,  " +
    " bbq              ,  " +
    " bbqmemo          ,  " +
    " checkin          ,  " +
    " checkout         )  " +
    " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
		
		template.update(query, new Object [] {
				detail.getId(),
				 detail.isWomanOnly() ? "Y" :"N", 
				 detail.getBreakfastStart(), detail.getBreakfastEnd(),
					detail.getLimitTime(),
					detail.isFoodOutsideOnly() ? "Y" :"N",
					detail.getExtra(),
					detail.getParkingLot(),
					detail.isBbq() ? "Y" :"N",
					detail.getBbqMemo(),
					detail.getCheckin(),
					detail.getCheckout()
					});
	}
	
}
