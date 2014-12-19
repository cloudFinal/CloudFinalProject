package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import beans.Location;

import com.google.gson.Gson;

import parse.JsonProcess;
import parse.Parse;

/**
 * Servlet implementation class InsertLocation
 */
public class InsertLocation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertLocation() {
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
		System.out.println("InsertLocation");
		JSONObject input = Parse.getJson(request);
		JSONObject output = new JSONObject();
		boolean result=false;
		Location location=null;
		if(Parse.plantForm(input)==null){
			String s = input.getString("1");
			Gson gson = new Gson();
			location = gson.fromJson(s, Location.class);
		}else{
			location = Location.fromJson(input.getJSONObject("location")); 
		}
		result = Center.db.insertLocation(location);
		output.put("result", result);
		JsonProcess.sendJson(response, output);
	}
}
