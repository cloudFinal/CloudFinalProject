import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;

public class Activity implements Serializable, JsonAble, Comparable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private String type;

	public void setName(String name) {
		this.name = name;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public String getType() {
		return type;
	}

	public void setAll(String name, String type) {
		this.name = name;
		this.type = type;
	}

	public JSONObject toJson() throws JSONException {
		JSONObject jo = new JSONObject();
		jo.put("name", name);
		jo.put("type", type);
		return jo;
	}

	public static Activity fromJson(JSONObject input) throws JSONException {
		Activity result = new Activity();
		result.setAll(input.getString("name"), input.getString("type"));
		return result;
	}

	@Override
	public int compareTo(Object another) {
		// TODO Auto-generated method stub
		return this.name.compareTo(((Activity) another).getName());
	}
}