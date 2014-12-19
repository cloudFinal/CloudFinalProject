package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import parse.JsonProcess;
import parse.Parse;

/**
 * Servlet implementation class NumberOfEvent
 */
public class NumberOfEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NumberOfEvent() {
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
		String text = Parse.getPostData(request);
		JSONObject input = JsonProcess.getJason(text);
		int eventId = input.getInt("eventid");
		int number= Center.db.numberInEvent(Center.db.getEvent(eventId));
		JSONObject output = new JSONObject();
		output.put("number", number);
		JsonProcess.sendJson(response, output);
	}
}
