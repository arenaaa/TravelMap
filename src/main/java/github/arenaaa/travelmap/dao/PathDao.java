package github.arenaaa.travelmap.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

@Repository
public class PathDao {
	
	@Autowired
	private JdbcTemplate template;

	public String getPath(String path) {
		String query = "select path from routes where id = ?";
		return template.query(query, new Object[] {path}, new ResultSetExtractor<String>(){

			@Override
			public String extractData(ResultSet rs) throws SQLException, DataAccessException {
				if ( rs.next() ) {
					String pathString = rs.getString(1);
					return pathString;
				} else {
					return null;
				}
			}
		});
	}

	public void updatePath(String updatepathstr, String pathid) {
		String query = "update routes set path= ? where id = ?";
		template.update(query, new Object[] { updatepathstr, pathid });
	}


}
