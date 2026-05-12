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

@WebServlet("/createTask")
public class CreateTaskServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute(
                        "user"
                );

        if(user == null){

            response.sendRedirect(
                    "login.jsp"
            );

            return;
        }

        String title =
                request.getParameter(
                        "title"
                );

        String description =
                request.getParameter(
                        "description"
                );

        String priority =
                request.getParameter(
                        "priority"
                );

        String deadline =
                request.getParameter(
                        "deadline"
                );

        String projectParam =
                request.getParameter(
                        "projectId"
                );

        int projectId = 1;

        if(projectParam != null
                && !projectParam.equals("null")
                && !projectParam.isEmpty()){

            projectId =
                    Integer.parseInt(
                            projectParam
                    );
        }

        Task task =
                new Task();

        task.setProjectId(
                projectId
        );

        task.setUserId(
                user.getId()
        );

        task.setTitle(title);

        task.setDescription(
                description
        );

        task.setPriority(
                priority
        );

        task.setDeadline(
                deadline
        );

        task.setStatus("todo");

        TaskDAO taskDAO =
                new TaskDAO();

        boolean created =
                taskDAO.createTask(task);

        System.out.println(
                "TASK CREATED: "
                        + created
        );

        response.sendRedirect(
                "kanban?projectId="
                        + projectId
        );
    }
}