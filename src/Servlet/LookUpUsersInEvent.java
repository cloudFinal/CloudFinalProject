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
import beans.Preference;
import beans.Profile;

/**
 * Servlet implementation class LookUpUsersInEvent
 */
public class LookUpUsersInEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LookUpUsersInEvent() {
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
		int eventId = input.getInt("eventid");
		ArrayList<Profile> result = Center.db.getUsersInEvent(eventId);
		//System.out.println("-------");
		if(Parse.plantForm(input)==null){
			JsonProcess.sendJson(response,new JsonArrayListGenerator<Profile>(result).getObject());
		}else{
			JsonProcess.sendJson(response,JsonArrayForWeb.createJsonArray("preference",result));
		}
	}

}
