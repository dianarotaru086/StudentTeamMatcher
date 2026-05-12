package controller;

import dao.CommentDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.ActivityDAO;

import java.io.IOException;

@WebServlet("/addComment")
public class AddCommentServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute("user");

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

        CommentDAO commentDAO =
                new CommentDAO();

        commentDAO.addComment(
                projectId,
                user.getId(),
                message
        );

        ActivityDAO activityDAO =
                new ActivityDAO();

        activityDAO.addActivity(
                projectId,
                user.getFullName()
                        + " added a new comment."
        );

        response.sendRedirect(
                "projectDetails?id="
                        + projectId
        );
    }
}