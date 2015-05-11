package org.comp550.schoolbus.controller;


import java.util.List;

import org.comp550.schoolbus.dao.TripHasUserDao;
import org.comp550.schoolbus.domain.TripHasUser;
import org.comp550.schoolbus.domain.User;
import org.comp550.schoolbus.utils.ApplicationContextUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * Spring MVC Controller 
 * @author DouJ
 *
 */
@Controller
public class TestController {
	
	@RequestMapping("/toIndex.do")
	public String toIndex(){
		return "index";
	}

	@RequestMapping(value="/toUpdate.do",method=RequestMethod.GET)
	public @ResponseBody String[] toUpdate(){
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TripHasUserDao dao = (TripHasUserDao) context.getBean("TripHasUserDao");
		List<TripHasUser> tripinfo_list = dao.doQueryDriverLocation();
		TripHasUser tripHasUser = tripinfo_list.get(0);
		
		String[] driverLocation = {tripHasUser.driver_lat, tripHasUser.driver_lng};
		return driverLocation;
	}
	
	@RequestMapping(value="/toGetWayPoints.do",method=RequestMethod.GET)
	public @ResponseBody List<User> getWayPoints(){
//		String[] wayPoints = {};
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TripHasUserDao dao = (TripHasUserDao) context.getBean("TripHasUserDao");
		List<User> wayPoints = dao.doQueryUserLocation();

		
		return wayPoints;
	}
	
}
