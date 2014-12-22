package Servlet;

import java.io.IOException;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/Message/{room}")
public class Message {

	@OnOpen
	public void open(final Session session, @PathParam("room") final String room) {
		System.out.println("Hello!CloudFinal");
		session.getUserProperties().put("room", room);
	}

	@OnMessage
	public void onMessage(final Session session, String message) throws IOException {
		System.out.println(message);
		String room = (String) session.getUserProperties().get("room");
		for (Session s : session.getOpenSessions()) {
			if (s.isOpen() && room.equals(s.getUserProperties().get("room"))) {
				s.getBasicRemote().sendText(message);
			}
		}
	}
	
}