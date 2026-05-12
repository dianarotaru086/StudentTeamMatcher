package controller;

import dao.ProjectDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Project;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/myProjects")
public class MyProjectsServlet
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

        if(user == null){

            response.sendRedirect(
                    "login.jsp"
            );

            return;
        }

        ProjectDAO projectDAO =
                new ProjectDAO();

        List<Project> projects =
                projectDAO.getProjectsByUser(
                        user.getId()
                );

        request.setAttribute(
                "projects",
                projects
        );

        request.getRequestDispatcher(
                "myProjects.jsp"
        ).forward(
                request,
                response
        );
    }
}