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

import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
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
	public static String publickey = "";
	private static String secretKey = "fU0LiBmyZGUvSHuFD3ev7EEJSvwJSZJhQAVjsllt";
	private static final long serialVersionUID = 1L;
	public static WorkPool wp;
	public static Database db;
	public static Hashtable<Integer, Location> locationInfo = new Hashtable<Integer, Location>();
	private final String UPLOAD_DIRECTORY = "https://s3-us-west-2.amazonaws.com/eventplanner/";
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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				String userId=null;
				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(new ServletRequestContext(request));
				for(FileItem item:multiparts){
					if(item.isFormField()){
						if(item.getFieldName().equals("user_id")){
							userId=item.getString();
						}
					}
				}
				for (FileItem item : multiparts) {
					if (!item.isFormField()) {
						/*String name = new File(item.getName()).getName();
						File a = new File(UPLOAD_DIRECTORY + File.separator+ name);
						System.out.println(UPLOAD_DIRECTORY + File.separator+ name);
						a.createNewFile();
						System.out.println(a.exists());*/
						/*for(int i=0;i<item.get().length;i++){
							System.out.print(item.get()[i]);
						}*/
						String identifier = (userId+"-"+item.getName());
						ObjectMetadata o = new ObjectMetadata();
						o.setContentLength(item.getSize());
						AmazonS3 s3Client = new AmazonS3Client(new BasicAWSCredentials(publickey,secretKey));
						PutObjectRequest pir = new PutObjectRequest("eventplanner",identifier, item.getInputStream(), o);
						pir.withCannedAcl(CannedAccessControlList.PublicReadWrite);
						s3Client.putObject(pir);
						System.out.println(identifier);
						Center.db.insertUserImage(userId, UPLOAD_DIRECTORY+identifier);
						/*System.out.println("Downloading an object");
			            S3Object s3object = s3Client.getObject(new GetObjectRequest(
			            		"elasticbeanstalk-us-east-1-668249848517", "output1/output.out"));
			            System.out.println("Content-Type: "  + 
			            		s3object.getObjectMetadata().getContentType());*/
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
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
}
