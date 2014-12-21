package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import parse.JsonArrayForWeb;
import parse.JsonArrayListGenerator;
import parse.JsonProcess;
import parse.Parse;
import beans.Event;
import beans.Preference;

import com.google.gson.Gson;

/**
 * Servlet implementation class LookUpUserEvents
 */
public class LookUpUserEvents extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LookUpUserEvents() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<Event> result = Center.db.getUserEvents("l");
		for(Event e:result){
			System.out.println(e.getEventId());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONObject input = Parse.getJson(request);
		String userId = input.getString("username");
		if(Parse.plantForm(input)==null){
			JsonProcess.sendJson(response,new JsonArrayListGenerator<Event>(Center.db.getUserEvents(userId)).getObject());
		}else{
			ArrayList<Event> result = Center.db.getUserEvents(userId);
			JsonProcess.sendJson(response, JsonArrayForWeb.createJsonArray("event",result));
		}
	}

}
