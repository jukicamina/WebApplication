package servlets;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;


@ServerEndpoint(value = "/websocket/question")
public class WebSockQuestionServlet {

    private static final String GUEST_PREFIX = "Guest";
    private static final AtomicInteger connectionIds = new AtomicInteger(0);
    private static final Set<WebSockQuestionServlet> connections = new CopyOnWriteArraySet<>();

    private boolean playing;
    private Session session;
    public boolean adminstart;
    
    public WebSockQuestionServlet() {
        this.playing = false;
    }

    public boolean getAdmin() { 
    	return this.adminstart;}

    @OnOpen
    public void start(Session session) {
        this.session = session;
        connections.add(this);
 	    this.adminstart = true;
}

    @OnClose
    public void end() {
        connections.remove(this);
    		 
      	     String msg = "Admin end";
             broadcast(msg);
      	    this.adminstart = false;
	}

    @OnMessage
    public void incoming(String message) {
      
       if(message.contentEquals("Next for user")) {
    	   System.out.print("Admin pritisnuo next");

    	   this.playing = true;
    	   broadcast("User next");
       }
    }

    @OnError
    public void onError(Throwable t) throws Throwable {
        System.out.println("Web socket error: " + t);
    }


    private static void broadcast(String msg) {
    	if(msg.contentEquals("User next")) {     	   
    		System.out.print("Poslano useru next");
    	}
        for (WebSockQuestionServlet client : connections) {
            try {
                synchronized (client) {
                    client.session.getBasicRemote().sendText(msg);
                }
            } catch (IOException e) {
                System.out.println("Chat Error: Failed to send message to client" + e);
                connections.remove(client);
                try {
                    client.session.close();
                } catch (IOException e1) {
                    // Ignore
                }
                String message = String.format(" %s","Client has been disconnected.");
                broadcast(message);
            }
        }
    }
}