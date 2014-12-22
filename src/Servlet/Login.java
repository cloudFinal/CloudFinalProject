package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import parse.JsonProcess;
import parse.Parse;

/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		String u = input.getString("username");
		String p = input.getString("password");
		/*
		if(u!=null&&p!=null){
			System.out.println("!!!!!");
			Cookie userid = new Cookie("userid",u);
			Cookie password = new Cookie("password",p);
			userid.setMaxAge(60*60*24); 
			password.setMaxAge(60*60*24);
			response.addCookie(userid);
			response.addCookie(password);
		}*/
		boolean result = Center.db.login(u,p);
		if(result){
			HttpSession session = request.getSession();
			session.setAttribute("userid",u);
			session.setAttribute("password",p);
		}
		JSONObject output = new JSONObject();
		output.put("result",result);
		JsonProcess.sendJson(response,output);
		System.out.println(result);
	}
}
