package controller;

import dao.TeamMessageDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

import java.io.IOException;

@WebServlet("/addTeamMessage")
public class AddTeamMessageServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User)
                        session.getAttribute(
                                "user"
                        );

        int projectId =
                Integer.parseInt(
                        request.getParameter(
                                "projectId"
                        )
                );

        String message =
                request.getParameter(
                        "message"
                );

        TeamMessageDAO dao =
                new TeamMessageDAO();

        dao.addMessage(
                projectId,
                user.getId(),
                message
        );

        response.sendRedirect(
                "teamWorkspace?projectId="
                        + projectId
        );
    }
}