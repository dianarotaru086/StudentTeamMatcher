package controller;

import dao.TaskDAO;
import jakarta.servlet.http.HttpSession;
import model.Task;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/kanban")
public class KanbanServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String projectParam =
                request.getParameter(
                        "projectId"
                );

        int projectId = 1;

        if(projectParam != null){

            projectId =
                    Integer.parseInt(
                            projectParam
                    );
        }

        TaskDAO taskDAO =
                new TaskDAO();

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute(
                        "user"
                );

        List<Task> tasks =
                taskDAO.getTasksByProject(
                        projectId,
                        user.getId()
                );

        request.setAttribute(
                "tasks",
                tasks
        );

        request.setAttribute(
                "projectId",
                projectId
        );

        request.getRequestDispatcher(
                "kanban.jsp"
        ).forward(
                request,
                response
        );
    }
}