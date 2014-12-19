package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		if(Parse.plantForm(input)==null){
			String s = input.getString("1");
			Gson gson = new Gson();
			Preference preference = gson.fromJson(s, Preference.class);
			boolean result = Center.db.insertPreference(preference);
			System.out.println("the result is"+result);
			JSONObject output = new JSONObject();
			output.put("result", result);
			JsonProcess.sendJson(response, output);
		}else{
			
		}
	}

}
