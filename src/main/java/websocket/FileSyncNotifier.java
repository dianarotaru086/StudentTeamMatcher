package websocket;

import jakarta.websocket.Session;

import java.util.Set;

public class FileSyncNotifier {

    public static void broadcast(
            int projectId,
            String fileName){

        Set<Session> sessions =
                FileSyncEndpoint
                        .projectSessions
                        .get(projectId);

        if(sessions != null){

            String html =
                    "<div class='task-item d-flex justify-content-between align-items-center'>"
                            +
                            "<div>"
                            +
                            "<h6 class='mb-1'>"
                            + fileName +
                            "</h6>"
                            +
                            "<small class='text-secondary'>Uploaded resource</small>"
                            +
                            "</div>"
                            +
                            "<span class='badge bg-info'>Uploaded</span>"
                            +
                            "</div>";

            for(Session session : sessions){

                try{

                    session.getBasicRemote()
                            .sendText(html);

                }catch(Exception e){

                    e.printStackTrace();
                }
            }
        }
    }
}