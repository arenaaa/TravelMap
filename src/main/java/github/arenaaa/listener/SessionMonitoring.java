package github.arenaaa.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class SessionMonitoring
 *
 */
public class SessionMonitoring implements HttpSessionListener {

    /**
     * Default constructor. 
     */
    public SessionMonitoring() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
     */
    public void sessionCreated(HttpSessionEvent se)  { 
    	System.out.println("## SESSION 생성: " + se.getSource().getClass().getName());
    }

	/**
     * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
     */
    public void sessionDestroyed(HttpSessionEvent se)  { 
    	System.out.println("## SESSION 파괴: " + se.getSource().getClass().getName());
    }
	
}
