package Servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import logic.MyTest;

import com.google.gson.Gson;

import parse.Parse;
import workPool.WorkPool;
import beans.Activity;
import beans.Location;
import database.Database;

/**
 * Servlet implementation class Center
 */
public class Center extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static WorkPool wp;
	public static Database db;
	public static Hashtable<Integer,Location> locationInfo = new Hashtable<Integer,Location>();
	static{
		db=new Database();
		wp=new WorkPool();
		wp.start();
	}
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Center(){
        super();
        //db.register("zhangluoma", "shkdshdksh");
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(MyTest.t());
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}
}
