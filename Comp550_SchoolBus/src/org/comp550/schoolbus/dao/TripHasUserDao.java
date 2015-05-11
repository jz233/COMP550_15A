package org.comp550.schoolbus.dao;

import java.util.ArrayList;
import java.util.List;

import org.comp550.schoolbus.domain.TripHasUser;
import org.comp550.schoolbus.domain.User;

public interface TripHasUserDao {

	public List<TripHasUser> doQueryDriverLocation();
	
	public List<User> doQueryUserLocation();
}
