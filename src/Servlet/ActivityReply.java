package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import beans.Activity;
import parse.JsonArrayForWeb;
import parse.JsonArrayListGenerator;
import parse.JsonProcess;
import parse.Parse;

/**
 * Servlet implementation class ActivityReply
 */
public class ActivityReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActivityReply() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<Activity> result = Center.db.findActivityList();
		JSONObject jo = new JSONObject();
		JsonProcess.sendJson(response, JsonArrayForWeb.createJsonArray("activity",result));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("activity Reply!");
		JSONObject input = Parse.getJson(request);
		ArrayList<Activity> result = Center.db.findActivityList();
		if(Parse.plantForm(input)==null){
			JsonProcess.sendJson(response,new JsonArrayListGenerator<Activity>(result).getObject());
		}else{
			JsonProcess.sendJson(response, JsonArrayForWeb.createJsonArray("activity",result));
		}
	}

}
