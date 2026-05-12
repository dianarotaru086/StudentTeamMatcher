package controller;

import dao.ProjectDAO;
import dao.ProjectMemberDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Project;
import model.User;

import java.io.IOException;

@WebServlet("/applyProject")
public class ApplyProjectServlet
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

        if(user == null){

            response.sendRedirect("login.jsp");
            return;
        }

        int projectId =
                Integer.parseInt(
                        request.getParameter(
                                "projectId"
                        )
                );

        ProjectDAO projectDAO =
                new ProjectDAO();

        Project project =
                projectDAO.getProjectById(
                        projectId
                );

        if(project == null){

            response.getWriter()
                    .println("Project not found!");

            return;
        }

        if(projectDAO.alreadyApplied(
                user.getId(),
                projectId)){

            response.getWriter()
                    .println(
                            "You already applied!"
                    );

            return;
        }

        int compatibility =
                projectDAO.calculateCompatibility(
                        user.getSkills(),
                        project.getRequiredSkills()
                );

        boolean result =
                projectDAO.applyToProject(
                        user.getId(),
                        projectId,
                        compatibility
                );

        if(result){

            ProjectMemberDAO memberDAO =
                    new ProjectMemberDAO();

            memberDAO.addMember(
                    projectId,
                    user.getId(),
                    "Team Member"
            );

            response.sendRedirect(
                    "dashboard"
            );

        } else {

            response.getWriter()
                    .println(
                            "Application failed!"
                    );
        }
    }
}