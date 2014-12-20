package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import parse.JsonArrayForWeb;
import parse.JsonArrayListGenerator;
import parse.JsonProcess;
import parse.Parse;
import beans.Event;
import beans.Preference;

import com.google.gson.Gson;

/**
 * Servlet implementation class LookUpPreference
 */
public class LookUpPreference extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LookUpPreference() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userId = "";
		ArrayList<Preference> result = Center.db.getPreferenceFromUserId(userId);
		JsonProcess.sendJson(response,JsonArrayForWeb.createJsonArray("preference",result));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONObject input = Parse.getJson(request);
		String userId = input.getString("userid");
		ArrayList<Preference> result = Center.db.getPreferenceFromUserId(userId);
		System.out.println("-------");
		if(Parse.plantForm(input)==null){
			JsonProcess.sendJson(response,new JsonArrayListGenerator<Preference>(result).getObject());
		}else{
			JsonProcess.sendJson(response,JsonArrayForWeb.createJsonArray("preference",result));
		}
	}

}
