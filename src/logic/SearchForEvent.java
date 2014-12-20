package logic;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Servlet.Center;
import beans.Event;
import beans.Location;
import beans.Preference;

public class SearchForEvent {
	public static boolean testPreferenceWithOthers(Preference tested, ArrayList<Preference> old){
		//ArrayList<Preference> waitingList = new ArrayList<Preference>();
		for(Preference op:old){
			double dis = Center.db.getLocation(tested.getLocationId()).distance(Center.db.getLocation(op.getLocationId()));
			if(dis>op.getDistanceTolerance()||dis>tested.getDistanceTolerance()){
				return false;
			}
		}
		return true;
	}
	public static Location testPreferenceWithOthers(Preference tested, Event targetEvent){//ArrayList<Preference> old){
		ArrayList<Preference> waitingList = new ArrayList<Preference>();
		ArrayList<Preference> old = Center.db.getRelatedPreference(targetEvent);
		for(Preference op:old){
			//System.out.println(tested.getUserId());
			//System.out.println(op.getUserId());
			//System.out.println(tested.getLocationId());
			//System.out.println(Center.db.getLocation(tested.getLocationId()).getAddress());
			double dis = Center.db.getLocation(tested.getLocationId()).distance(Center.db.getLocation(op.getLocationId()));
			//System.out.println(dis);
			if(dis<op.getDistanceTolerance()&&dis<tested.getDistanceTolerance()){
				waitingList.add(op);
			}
		}
		if(waitingList.size()==old.size()){
			return Center.db.getLocation(targetEvent.getHeldIn());
		}
		//System.out.println(waitingList.size());
		for(Preference op:waitingList){
			boolean flag=true;
			for(Preference target:old){
				double dis = Center.db.getLocation(op.getLocationId()).distance(Center.db.getLocation(target.getLocationId()));
				if(dis>op.getDistanceTolerance()||dis>target.getDistanceTolerance()){
					flag=false;
				}
			}
			if(flag){
				return Center.db.getLocation(op.getLocationId());
			}
		}
		double dis = Center.db.getLocation(tested.getLocationId()).distance(Center.db.getLocation(targetEvent.getHeldIn()));
		if(dis<=tested.getDistanceTolerance()){
			return Center.db.getLocation(targetEvent.getHeldIn());
		}
		return null;
	}
}
