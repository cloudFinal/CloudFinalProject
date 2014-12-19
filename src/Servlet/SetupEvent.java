package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import parse.JsonArrayListGenerator;
import parse.JsonProcess;
import parse.Parse;
import beans.Event;
import beans.Preference;

import com.google.gson.Gson;

/**
 * Servlet implementation class SetupEvent
 */
public class SetupEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetupEvent() {
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
		JSONObject input = Parse.getJson(request);
		if(Parse.plantForm(input)==null){
			String obj = input.getString("1");
			Gson gson = new Gson();
			Preference preference = gson.fromJson(obj, Preference.class);
			Event e =new Event(preference.getLocationId(),preference.getActivityName(),preference.getStartTime(),preference.getEndTime(),preference.getNumberLimitFrom(),preference.getNumberLimitTo());
			boolean result = Center.db.insertEvent(e);
			boolean result2 = Center.db.insertParticipatesIn(preference, e);
			JSONObject output = new JSONObject();
			output.put("result", result&&result2);
			Gson gson2 = new Gson();
			String objOut = gson2.toJson(e);
			output.put("object",objOut);
			JsonProcess.sendJson(response, output);
		}else{
			
		}
	}
}
