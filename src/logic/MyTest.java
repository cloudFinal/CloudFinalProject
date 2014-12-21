package logic;

import java.util.Date;

import beans.Location;
import beans.Preference;
import beans.Profile;
import database.Database;
import Servlet.Center;

public class MyTest {
	public static boolean t(){
		for(Profile p:Center.db.getUsersInEvent(1977140399)){
			System.out.println(p.getUserid());
		}
		Date a = new Date();
		a.setTime(Long.valueOf("1417465980000"));
		System.out.println(a.toString());
		/*Database db = Center.db;
		db.register("zhangluoma", "hello");
		db.insertLocation(newLoc("New York",10,10));
		Preference p= new Preference();*/
		/*p.setAll("zhangluoma", preferenceNameIn, locationIdIn, distanceToleranceIn, startTimeIn, endTimeIn, keyWordIn, activityNameIn, numberLimitFrom, numberLimitTo);
		db.insertPreference(preference)*/
		return true;
	}
	public static Location newLoc(String a,float latitude, float longitude)
	{
		Location l = new Location();
		l.setAddress(a);
		l.setX(longitude);
		l.setY(latitude);
		return l;
	}
}
