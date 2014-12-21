package Servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

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
	public static Hashtable<Integer, Location> locationInfo = new Hashtable<Integer, Location>();
	private final String UPLOAD_DIRECTORY = "http://localhost:8080/CloudFinal/my.jpg";
	static {
		db = new Database();
		wp = new WorkPool();
		wp.start();
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Center() {
		super();
		// db.register("zhangluoma", "shkdshdksh");
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		//System.out.println(MyTest.t());
		try{
			File f = new File("http://localhost:8080/CloudFinal/my.jpg");
			System.out.println(f.exists());
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try{
			File f = new File("sd");
			if(f.exists()){
				f.createNewFile();
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		// TODO Auto-generated method stub
		/*if (ServletFileUpload.isMultipartContent(request)) {
			try {
				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(new ServletRequestContext(request));
				for (FileItem item : multiparts) {
					if (!item.isFormField()) {
						String name = new File(item.getName()).getName();
						File a = new File(UPLOAD_DIRECTORY + File.separator+ name);
						System.out.println(UPLOAD_DIRECTORY + File.separator+ name);
						a.createNewFile();
						System.out.println(a.exists());
						item.write(a);
					}
				}
				// File uploaded successfully
				request.setAttribute("message", "File Uploaded Successfully");
			} catch (Exception ex) {
				ex.printStackTrace();
				request.setAttribute("message", "File Upload Failed due to "+ ex);
			}
		} else {
			request.setAttribute("message","Sorry this Servlet only handles file upload request");
		}
		request.getRequestDispatcher("/result.jsp").forward(request, response);*/
	}
}
