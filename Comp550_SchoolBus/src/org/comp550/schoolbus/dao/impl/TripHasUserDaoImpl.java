package org.comp550.schoolbus.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.comp550.schoolbus.dao.TripHasUserDao;
import org.comp550.schoolbus.domain.TripHasUser;
import org.comp550.schoolbus.domain.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class TripHasUserDaoImpl extends JdbcTemplate implements TripHasUserDao {

	
	public List<TripHasUser> doQueryDriverLocation() {

		String sql = "select * from trip_has_user";
//		System.out.println(sql);
		List<TripHasUser> list = this.query(sql, new RowMapper<TripHasUser>() {

			public TripHasUser mapRow(ResultSet rs, int pos) throws SQLException {
				TripHasUser tripHasUser = new TripHasUser();
				tripHasUser.trip_tripID = rs.getInt("trip_tripID");
				tripHasUser.user_userID = rs.getInt("user_userID");
				tripHasUser.driver_lat = rs.getString("driver_lat");
				tripHasUser.driver_lng = rs.getString("driver_lng");
				tripHasUser.user_in_trip_status = rs.getDouble("user_in_trip_status");
				
				return tripHasUser;
			}
		});
		
		return list;
	}

	public List<User> doQueryUserLocation() {
		String sql = "select * from user";
		List<User> user_list = this.query(sql, new RowMapper<User>() {

			public User mapRow(ResultSet rs, int pos) throws SQLException {
				User user = new User();
				user.username = rs.getString("username");
				user.password = rs.getString("password");
				user.role = rs.getInt("role");
				user.user_lat = rs.getString("user_lat");
				user.user_lng = rs.getString("user_lng");
				
				return user;
			}
		});
		
		
		return user_list;
	}

}
