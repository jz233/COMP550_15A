package org.comp550.schoolbus.dao.impl;

import org.comp550.schoolbus.dao.SchoolBusDao;
import org.comp550.schoolbus.domain.TripHasUser;
import org.springframework.jdbc.core.JdbcTemplate;

public class SchoolBusDaoImpl extends JdbcTemplate implements SchoolBusDao {

	

	
	public boolean doUpdateUser() {

		String sql = "insert into user values('1','student1','123','1','-37.787568','175.267308')";
		this.execute(sql);
		
		return true;
		
	}

	public boolean doUpdateTrip() {

		String sql = "insert into trip values('1',NOW(),'trip_1','1.0')";
		this.execute(sql);
		
		return true;
	}

	public boolean doUpdateTripHasUser() {

		String sql = "insert into trip_has_user values('1','1','-37.791905','175.317524','0')";
		this.execute(sql);
		
		return true;
	}

	
	

}
