package parse;

import java.util.ArrayList;

import org.json.JSONArray;

import beans.JsonAble;


public class JsonArrayForWeb{
	public static <E extends JsonAble> JSONArray createJsonArray(ArrayList<E> input){
		JSONArray ja = new JSONArray();
		for(E e:input){
			ja.put(e.toJson());
		}
		return ja;
	}
}
