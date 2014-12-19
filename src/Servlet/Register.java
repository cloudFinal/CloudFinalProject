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
 * Servlet implementation class Register
 */
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		boolean result = Center.db.register("zhangluoma","88522712");
		Center.db.setOnline("zhangluoma", false);
		JSONObject output = new JSONObject();
		output.put("result",result);
		JsonProcess.sendJson(response,output);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONObject input = Parse.getJson(request);
		String u = input.getString("username");
		String p = input.getString("password");
		boolean result = Center.db.register(u,p);
		Center.db.setOnline(u, false);
		JSONObject output = new JSONObject();
		output.put("result",result);
		JsonProcess.sendJson(response,output);
	}
}
