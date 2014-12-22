package beans;

import java.io.Serializable;

import org.json.JSONObject;

public class Location implements Serializable,JsonAble{
	private int locationid;
	private String address;
	private float x;
	private float y;
	public int getLocationid(){
		return locationid;
	}
	public String getAddress(){
		return address;
	}
	public float getX(){
		return x;
	}
	public float getY(){
		return y;
	}
	public void setAddress(String address){
		this.locationid=address.hashCode();
		this.address=address;
	}
	public void setX(float x){
		this.x=x;
	}
	public void setY(float y){
		this.y=y;
	}
	public void setAll(int locationid,String address,float x, float y){
		this.locationid=locationid;
		setAddress(address);
		this.x=x;
		this.y=y;
	}
	public double distance(Location target){
		double eventLon = Math.toRadians(this.x);
		double eventLat = Math.toRadians(this.y);
		double preferLon = Math.toRadians(target.x);
		double preferLat = Math.toRadians(target.y);
		double dlon = eventLon - preferLon; 
		double dlat = eventLat - preferLat; 
		double a = Math.pow((Math.sin(dlat/2)),2) + Math.cos(eventLat) * Math.cos(preferLat) * Math.pow((Math.sin(dlon/2)),2);
		double c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a)); 
		double d = 3959 * c;
		return d;
	}
	@Override
	public JSONObject toJson(){
		JSONObject jo = new JSONObject();
		jo.put("location_id", locationid);
		jo.put("address", address);
		jo.put("latitude", y);
		jo.put("longitude", x);
		return jo;
	}
	public static Location fromJson(JSONObject input){
		Location result = new Location();
		result.setAll(input.getInt("location_id"), input.getString("address"),(float)input.getDouble("longitude"),(float)input.getDouble("latitude"));
		return result;
	}
}
