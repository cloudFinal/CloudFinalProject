package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import parse.JsonProcess;
import parse.Parse;
import beans.Location;
import beans.Preference;

import com.google.gson.Gson;

/**
 * Servlet implementation class InsertPreference
 */
public class InsertPreference extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertPreference() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("InsertPreference!");
		JSONObject input = Parse.getJson(request);
		Preference preference=null;
		boolean result;
		if(Parse.plantForm(input)==null){
			String s = input.getString("1");
			Gson gson = new Gson();
			preference = gson.fromJson(s, Preference.class);
			result = Center.db.insertPreference(preference);
		}else{
			ArrayList<Preference> preferences = new ArrayList<Preference>();
			JSONArray ja = input.getJSONArray("preference");
			for(int i=0;i<ja.length();i++){
				preferences.add(Preference.fromJson(ja.getJSONObject(i)));
			}
			result=true;
			for(Preference p:preferences){
				if(Center.db.insertPreference(p)){
					result=false;
					break;
				}
			}
			//preference=Preference.fromJson(input.getJSONObject("preference"));
		}
		//System.out.println("the result is"+result);
		JSONObject output = new JSONObject();
		output.put("result", result);
		JsonProcess.sendJson(response, output);
	}

}
