package org.comp550.schoolbus.dao;

import java.util.List;

import org.comp550.schoolbus.domain.TripHasUser;


public interface SchoolBusDao {
	public boolean doUpdateUser();
	public boolean doUpdateTripHasUser();
	public boolean doUpdateTrip();
	
	
}
