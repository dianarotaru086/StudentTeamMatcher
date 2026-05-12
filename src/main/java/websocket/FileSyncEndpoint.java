package websocket;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@ServerEndpoint("/fileSync/{projectId}")
public class FileSyncEndpoint {

    public static final Map<Integer, Set<Session>>
            projectSessions =
            new HashMap<>();

    @OnOpen
    public void onOpen(
            Session session,
            @PathParam("projectId")
            int projectId){

        projectSessions
                .computeIfAbsent(
                        projectId,
                        k -> new HashSet<>()
                )
                .add(session);
    }

    @OnClose
    public void onClose(
            Session session,
            @PathParam("projectId")
            int projectId){

        if(projectSessions.containsKey(projectId)){

            projectSessions
                    .get(projectId)
                    .remove(session);
        }
    }

    @OnMessage
    public void onMessage(
            String message,
            Session session,
            @PathParam("projectId")
            int projectId){

    }
}