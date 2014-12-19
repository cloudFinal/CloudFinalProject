package parse;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.json.JSONObject;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
public class Parse{
	public static String getPostData(HttpServletRequest req) {
	    StringBuilder sb = new StringBuilder();
	    try {
	        BufferedReader reader = req.getReader();
	        reader.mark(10000);
	        String line;
	        do {
	            line = reader.readLine();
	            sb.append(line).append("\n");
	        } while (line != null);
	        reader.reset();
	        // do NOT close the reader here, or you won't be able to get the post data twice
	    } catch(IOException e) {
	        System.out.println("getPostData couldn't.. get the post data");  // This has happened if the request's reader is closed    
	    }
	    return sb.toString();
	}
	public static BufferedImage decodeToImage(String imageString) {

        BufferedImage image = null;
        byte[] imageByte;
        try {
            BASE64Decoder decoder = new BASE64Decoder();
            imageByte = decoder.decodeBuffer(imageString);
            ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
            image = ImageIO.read(bis);
            bis.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return image;
    }
    public static String encodeToString(BufferedImage image, String type) {
        String imageString = null;
        ByteArrayOutputStream bos = new ByteArrayOutputStream();

        try {
            ImageIO.write(image, type, bos);
            byte[] imageBytes = bos.toByteArray();

            BASE64Encoder encoder = new BASE64Encoder();
            imageString = encoder.encode(imageBytes);

            bos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return imageString;
    }
    public static JSONObject getJson(HttpServletRequest request){
    	String text = Parse.getPostData(request);
    	System.out.println(text);
		JSONObject input = JsonProcess.getJason(text);
    	return input;
    }
    public static String plantForm(JSONObject jo){
    	try{
    		return jo.getString("plantform");
    	}catch(JSONException jse){
    		return null;
    	}
    }
	/*
	public static String objectToString(Object myObject){
		ByteArrayOutputStream bo = new ByteArrayOutputStream();
	    ObjectOutputStream so;
		try {
			so = new ObjectOutputStream(bo);
		    so.writeObject(myObject);
		    so.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return bo.toString();
	}
	public static Object stringToObject(String serializedObject) throws ClassNotFoundException, IOException{
		byte b[] = serializedObject.getBytes(); 
	    ByteArrayInputStream bi = new ByteArrayInputStream(b);
	    ObjectInputStream si = new ObjectInputStream(bi);
	    return si.readObject();
	}*/
}