package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import parse.JsonArrayForWeb;
//class to store event
public class Event implements Serializable, JsonAble,Comparable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * Persistent Instance variables. This data is directly mapped to the
	 * columns of database table.
	 */
	private int eventId;
	private int heldIn;
	private String activityName;
	private long startTime;
	private long endTime;
	private int numberLimit;
	private boolean isEnrolled;
	private int numberOf;
	private int preferedLocation;
	private double distance;
	private int numberLimitTo;
	private String address;
	private float latitude;
	private float longitude;
	private ArrayList<String> urlList;
	private ArrayList<String> userList;

	/**
	 * Get- and Set-methods for persistent variables. The default behaviour does
	 * not make any checks against malformed data, so these might require some
	 * manual additions.
	 */
	public Event(int heldInIn, String activityNameIn, long startTimeIn,
			long endTimeIn, int numberLimitIn, int numberLimitToIn) {
		this.heldIn = heldInIn;
		this.activityName = activityNameIn;
		this.startTime = startTimeIn;
		this.endTime = endTimeIn;
		this.numberLimit = numberLimitIn;
		this.numberLimitTo = numberLimitToIn;
		eventId = new Random().nextInt(Integer.MAX_VALUE);
	}
	public Event() {
	}
	public int getPreferedLocation() {
		return preferedLocation;
	}
	public ArrayList<String> getUserList(){
		return userList;
	}
	public double getDistance() {
		return distance;
	}
	public ArrayList<String> getUrlList(){
		return urlList;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public void setPreferedLocation(int preferedLocation) {
		this.preferedLocation = preferedLocation;
	}

	public int getEventId() {
		return this.eventId;
	}

	public void setEventId(int eventIdIn) {
		this.eventId = eventIdIn;
	}
	public void setUserList(ArrayList<String> userList){
		this.userList= userList;
	}
	public int getHeldIn() {
		return this.heldIn;
	}

	public void setHeldIn(int heldInIn) {
		this.heldIn = heldInIn;
	}

	public String getActivityName() {
		return this.activityName;
	}

	public void setActivityName(String activityNameIn) {
		this.activityName = activityNameIn;
	}

	public long getStartTime() {
		return this.startTime;
	}

	public Calendar getEndCalendar() {
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(endTime);
		return c;
	}

	public Calendar getStartCalendar() {
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(startTime);
		return c;
	}

	public void setStartTime(long startTimeIn) {
		this.startTime = startTimeIn;
	}

	public long getEndTime() {
		return this.endTime;
	}

	public void setEndTime(long endTimeIn) {
		this.endTime = endTimeIn;
	}

	public int getNumberLimit() {
		return this.numberLimit;
	}

	public int getNumberLimitTo() {
		return this.numberLimitTo;
	}

	public void setNumberLimit(int numberLimitIn) {
		this.numberLimit = numberLimitIn;
	}
	public void setUrlList(ArrayList<String> urlList){
		this.urlList=urlList;
	}
	public void setNumberLimitTo(int numberLimitToIn) {
		this.numberLimitTo = numberLimitToIn;
	}

	public void setLocation(Location l) {
		this.address = l.getAddress();
		this.latitude = l.getY();
		this.longitude = l.getX();
	}

	public String getAddress() {
		return address;
	}

	public float getLatitude() {
		return latitude;
	}

	public float getLongitude() {
		return longitude;
	}
	public void setAddress(String address){
		this.address=address;
	}
	public void setLatitude(float latitude){
		this.latitude=latitude;
	}
	public void setLongitude(float longitude){
		this.longitude=longitude;
	}
	/**
	 * setAll allows to set all persistent variables in one method call. This is
	 * useful, when all data is available and it is needed to set the initial
	 * state of this object. Note that this method will directly modify instance
	 * variales, without going trough the individual set-methods.
	 */

	public void setAll(int eventIdIn, int heldInIn, String activityNameIn,
			long startTimeIn, long endTimeIn, int numberLimitIn,
			int numberLimitToIn) {
		this.eventId = eventIdIn;
		this.heldIn = heldInIn;
		this.activityName = activityNameIn;
		this.startTime = startTimeIn;
		this.endTime = endTimeIn;
		this.numberLimit = numberLimitIn;
		this.numberLimitTo = numberLimitToIn;
	}

	public JSONObject toJson() throws JSONException {
		JSONObject jo = new JSONObject();
		jo.put("event_id", eventId);
		jo.put("held_in", heldIn);
		jo.put("activity_name", activityName);
		jo.put("start_time", startTime);
		jo.put("end_time", endTime);
		jo.put("number_limit_from", numberLimit);
		jo.put("number_limit_to", numberLimitTo);
		jo.put("number_of", numberOf);
		jo.put("is_enrolled", isEnrolled);
		jo.put("address", address);
		jo.put("latitude", latitude);
		jo.put("longitude", longitude);
		JSONArray ja = new JSONArray();
		JSONArray ju = new JSONArray();
		for(String s:urlList){
			ja.put(s);
		}
		for(String u:userList){
			ju.put(u);
		}
		jo.put("urlList",ja);
		jo.put("userList",ju);
		return jo;
	}

	public static Event fromJson(JSONObject input) throws JSONException {
		Event result = new Event();
		result.setAll(input.getInt("event_id"), input.getInt("held_in"),
				input.getString("activity_name"), input.getLong("start_time"),
				input.getInt("end_time"), input.getInt("number_limit_from"),
				input.getInt("number_limit_to"));
		return result;
	}

	public boolean isEnrolled() {
		return isEnrolled;
	}

	public void setEnrolled(boolean isEnrolled) {
		this.isEnrolled = isEnrolled;
	}

	public int getNumberOf() {
		return numberOf;
	}

	public void setNumberOf(int numberOf) {
		this.numberOf = numberOf;
	}
	@Override
	public int compareTo(Object another) {
		// TODO Auto-generated method stub
		if ((this.startTime-((Event)another).getStartTime())>0)
			return 1;
		else if ((this.startTime-((Event)another).getStartTime())==0)
			return 0;
		else return -1;
	}
}