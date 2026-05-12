package controller;

import dao.TaskDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateTaskStatus")
public class UpdateTaskStatusServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int taskId =
                Integer.parseInt(
                        request.getParameter(
                                "taskId"
                        )
                );

        String status =
                request.getParameter(
                        "status"
                );

        TaskDAO taskDAO =
                new TaskDAO();

        taskDAO.updateTaskStatus(
                taskId,
                status
        );
    }
}