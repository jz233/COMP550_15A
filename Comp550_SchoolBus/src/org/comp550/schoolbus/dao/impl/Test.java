package org.comp550.schoolbus.dao.impl;

import java.util.List;

import org.comp550.schoolbus.dao.SchoolBusDao;
import org.comp550.schoolbus.dao.TripHasUserDao;
import org.comp550.schoolbus.domain.TripHasUser;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class Test {

	@org.junit.Test
	public void test(){
		
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		
		SchoolBusDao dao = (SchoolBusDao) context.getBean("SchoolBusDao");
		dao.doUpdateTripHasUser();
	}
	
	@org.junit.Test
	public void test2(){
		/*TripHasUserDaoImpl tripHasUserDaoImpl = new TripHasUserDaoImpl();
		List<TripHasUser> list = tripHasUserDaoImpl.doQueryDriverLocation();
		System.out.println(list.size());
		for (TripHasUser tripHasUser : list) {
			System.out.println(tripHasUser.toString());
		}*/
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TripHasUserDao dao = (TripHasUserDao) context.getBean("TripHasUserDao");
		List<TripHasUser> location_list = dao.doQueryDriverLocation();
		
		for (TripHasUser tripHasUser : location_list) {
			System.out.println(tripHasUser.toString());
		}
		dao = null;
	}
	
}
