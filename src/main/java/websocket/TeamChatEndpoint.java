package websocket;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/teamChat/{projectId}")
public class TeamChatEndpoint {

    private static final Map<Integer, Set<Session>>
            projectSessions =
            new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(
            Session session,
            @PathParam("projectId")
            int projectId){

        projectSessions.putIfAbsent(
                projectId,
                new CopyOnWriteArraySet<>()
        );

        projectSessions
                .get(projectId)
                .add(session);
    }

    @OnClose
    public void onClose(
            Session session,
            @PathParam("projectId")
            int projectId){

        if(projectSessions.containsKey(
                projectId)){

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
            int projectId)
            throws IOException {

        Set<Session> sessions =
                projectSessions.get(projectId);

        if(sessions != null){

            for(Session s : sessions){

                s.getBasicRemote()
                        .sendText(message);
            }
        }
    }
}