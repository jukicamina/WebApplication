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


@ServerEndpoint(value = "/websocket/users")
public class WebSockServlet {

    private static final String GUEST_PREFIX = "Guest";
    private static final AtomicInteger connectionIds = new AtomicInteger(0);
    private static final Set<WebSockServlet> connections = new CopyOnWriteArraySet<>();
    private static int count = 0;

    private boolean playing;
    private Session session;

    public WebSockServlet() {
        this.playing = false;
    }


    @OnOpen
    public void start(Session session) {
        this.session = session;
        connections.add(this);
    }


    @OnClose
    public void end() {
        connections.remove(this);
    	if(this.playing) {
    		if(count > 0) {
    		 count--;
    		}
    		String msg = String.format("%d", count);
             broadcast(msg);
    	} 
	}


    @OnMessage
    public void incoming(String message) {
       if((message.contentEquals("New player")) || (message.contentEquals("Not finished"))) {
    	   count++;
    	   this.playing = true;
    	   String msg = String.format("%d", count);
           broadcast(msg);
       } 
       if(message.contentEquals("Finished playing")) {
    	   if(count > 0) {
    	   count--;
    	   }
    	   this.playing = false;
    	   String msg = String.format("%d", count);
           broadcast(msg);
       }
       if(message.contentEquals("Admin here")) {
    	   this.playing = true;
    	   String mess = String.format("%d", count);
    	   broadcast(mess);
       }
    }


    @OnError
    public void onError(Throwable t) throws Throwable {
        System.out.println("Web socket error: " + t);
    }


    private static void broadcast(String msg) {
        for (WebSockServlet client : connections) {
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