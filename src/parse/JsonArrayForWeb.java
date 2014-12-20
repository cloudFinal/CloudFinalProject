package parse;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import beans.JsonAble;


public class JsonArrayForWeb{
	public static <E extends JsonAble> JSONObject createJsonArray(String name, ArrayList<E> input){
		JSONArray ja = new JSONArray();
		for(E e:input){
			ja.put(e.toJson());
		}
		JSONObject jo = new JSONObject();
		jo.put(name, ja);
		return jo;
	}
}
