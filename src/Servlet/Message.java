package Servlet;

import java.io.IOException;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONObject;

@ServerEndpoint(value = "/Message/{room}")
public class Message {

	@OnOpen
	public void open(final Session session, @PathParam("room") final String room) {
		System.out.println("Hello!CloudFinal");
		session.getUserProperties().put("room", room);
	}

	@OnMessage
	public void onMessage(final Session session, String message)
			throws IOException {
		String room = (String) session.getUserProperties().get("room");
		for (Session s : session.getOpenSessions()) {
			if (s.isOpen() && room.equals(s.getUserProperties().get("room"))) {
				JSONObject jo = new JSONObject(message);
				String url = Center.db.getUserUrl(jo.getString("sender"));
				if (url != null)
					jo.put("url", url);
				else
					jo.put("url",
							"https://s3-us-west-2.amazonaws.com/eventplanner/765-default-avatar.png");
				s.getBasicRemote().sendText(jo.toString());
				System.out.println(jo.toString());
			}
		}
	}

}
