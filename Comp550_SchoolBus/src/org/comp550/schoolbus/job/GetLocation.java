package org.comp550.schoolbus.job;

import java.util.ArrayList;
import java.util.List;

import org.comp550.schoolbus.dao.TripHasUserDao;
import org.comp550.schoolbus.dao.impl.TripHasUserDaoImpl;
import org.comp550.schoolbus.domain.TripHasUser;
import org.comp550.schoolbus.utils.ApplicationContextUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

@Service
public class GetLocation{

	private ApplicationContextUtil appContextUtil;
	
	public void setAppContextUtil(ApplicationContextUtil appContextUtil) {
		this.appContextUtil = appContextUtil;
	}


	public void execute(){
		/*
		ApplicationContext context = appContextUtil.getContext();
		TripHasUserDao dao = (TripHasUserDao) context.getBean("TripHasUserDao");
		
		List<TripHasUser> location_list = dao.doQueryDriverLocation();
		
		for (TripHasUser tripHasUser : location_list) {
			System.out.println(tripHasUser.toString());
		}*/
		
	}
	
	
	
}
