package controller;

import dao.ProjectDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.http.HttpSession;
import model.Application;
import model.Project;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewApplications")
public class ViewApplicationsServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute(
                        "user"
                );

        int projectId =
                Integer.parseInt(
                        request.getParameter("projectId")
                );

        ProjectDAO projectDAO =
                new ProjectDAO();

        List<Application> applications =
                projectDAO.getApplicationsByProject(
                        projectId
                );

        request.setAttribute(
                "applications",
                applications
        );

        request.getRequestDispatcher(
                "applications.jsp"
        ).forward(request, response);

        Project project =
                projectDAO.getProjectById(
                        projectId
                );

        if(project.getCreatorId()
                != user.getId()){

            response.sendRedirect(
                    "dashboard"
            );

            return;
        }
    }
}