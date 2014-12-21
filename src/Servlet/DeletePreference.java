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

/**
 * Servlet implementation class DeletePreference
 */
public class DeletePreference extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletePreference() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userId = "";
		String preferenceName = "asdfssd";
		boolean result = Center.db.deletePreference(userId,preferenceName);
		JSONObject output = new JSONObject();
		output.put("result", result);
		JsonProcess.sendJson(response, output);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONObject input = Parse.getJson(request);
		String userId = input.getString("user_id");
		String preferenceName = input.getString("preference_name");
		boolean result = Center.db.deletePreference(userId,preferenceName);
		JSONObject output = new JSONObject();
		output.put("result", result);
		JsonProcess.sendJson(response, output);
	}
}
