package Servlet;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import parse.JsonProcess;
import parse.Parse;
import beans.Preference;
import beans.Profile;

import com.google.gson.Gson;

/**
 * Servlet implementation class UpdateProfile
 */
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Update Profile");
		JSONObject input = Parse.getJson(request);
		String userId = input.getString("user_id");
		String password = input.getString("password");
		boolean result=false;
		if(Center.db.userExist(userId, password)){
			Profile profile;
			if(Parse.plantForm(input)==null){
				String s = input.getString("1");
				Gson gson = new Gson();
				profile = gson.fromJson(s, Profile.class);
			}else{
				profile = Profile.fromJson(input.getJSONObject("profile"));
			}
			result = Center.db.updateProfile(profile);
		}
		JSONObject output = new JSONObject();
		output.put("result", result);
		JsonProcess.sendJson(response, output);
	}
}
