package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import parse.JsonProcess;
import parse.Parse;
import beans.Event;
import beans.Preference;

import com.google.gson.Gson;

/**
 * Servlet implementation class JoinEvent
 */
public class JoinEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinEvent() {
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
		String userId = input.getString("userid");
		String preferenceName = input.getString("preferencename");
		int eventId = input.getInt("eventid");
		Event event = Center.db.getEvent(eventId);
		Preference preference = Center.db.getPreference(userId, preferenceName);
		//System.out.println("the result"+preference==null);
		boolean result=false;
		if(event==null){
			event = new Event();
			event.setAll(eventId, preference.getLocationId(), preference.getActivityName(), preference.getStartTime(), preference.getEndTime(), preference.getNumberLimitFrom(), preference.getNumberLimitTo());
			event.setLocation(Center.db.getLocation(event.getHeldIn()));
			result=(Center.db.insertEvent(event) && Center.db.insertParticipatesIn(preference, event));
		}else{
			result = Center.db.joinEvent(preference, event);
		}
		JSONObject output = new JSONObject();
		output.put("result", result);
		JsonProcess.sendJson(response, output);
	}

}
