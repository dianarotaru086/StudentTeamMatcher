package controller;

import dao.TaskDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteTask")
public class DeleteTaskServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int taskId =
                Integer.parseInt(
                        request.getParameter("id")
                );

        TaskDAO taskDAO =
                new TaskDAO();

        taskDAO.deleteTask(taskId);

        response.sendRedirect(
                "kanban"
        );
    }
}