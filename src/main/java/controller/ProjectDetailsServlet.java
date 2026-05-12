package controller;

import dao.ProjectDAO;
import model.Project;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/projectDetails")
public class ProjectDetailsServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int projectId =
                Integer.parseInt(
                        request.getParameter(
                                "id"
                        )
                );

        ProjectDAO projectDAO =
                new ProjectDAO();

        Project project =
                projectDAO.getProjectById(
                        projectId
                );

        request.setAttribute(
                "project",
                project
        );

        request.getRequestDispatcher(
                "projectDetails.jsp"
        ).forward(
                request,
                response
        );

        if(project == null){

            response.sendRedirect("dashboard");
            return;
        }
    }
}