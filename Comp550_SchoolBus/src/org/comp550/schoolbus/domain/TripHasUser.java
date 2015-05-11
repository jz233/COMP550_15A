package org.comp550.schoolbus.domain;

public class TripHasUser {
	
	public int trip_tripID;
	public int user_userID;
	public String driver_lat;
	public String driver_lng;
	public double user_in_trip_status;

	
	
	@Override
	public String toString() {
		return "TripHasUser [trip_tripID=" + trip_tripID + ", user_userID="
				+ user_userID + ", driver_lat=" + driver_lat + ", driver_lng="
				+ driver_lng + ", user_in_trip_status=" + user_in_trip_status
				+ "]";
	}
	
	
	
}
