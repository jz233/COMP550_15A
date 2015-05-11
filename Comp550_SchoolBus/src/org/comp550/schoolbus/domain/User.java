package org.comp550.schoolbus.domain;

public class User {
	public String username;
	public String password;
	public int role;
	public String user_lat;
	public String user_lng;

	
	@Override
	public String toString() {
		return "User [username=" + username + ", password=" + password
				+ ", role=" + role + ", user_lat=" + user_lat + ", user_lng="
				+ user_lng + "]";
	}
	
	
	
	
}
