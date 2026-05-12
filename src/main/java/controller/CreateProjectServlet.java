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

@WebServlet("/createProject")
public class CreateProjectServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
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

        String title =
                request.getParameter("title");

        String description =
                request.getParameter("description");

        String requiredSkills =
                request.getParameter("requiredSkills");

        Project project =
                new Project();

        project.setTitle(title);

        project.setDescription(description);

        project.setRequiredSkills(requiredSkills);

        project.setCreatorId(user.getId());

        String deadline =
                request.getParameter("deadline");

        int difficulty =
                Integer.parseInt(
                        request.getParameter("difficulty")
                );

        project.setDeadline(deadline);

        project.setDifficulty(difficulty);

        ProjectDAO projectDAO =
                new ProjectDAO();

        boolean result =
                projectDAO.createProject(project);

        if(result){

            response.sendRedirect("dashboard");

        } else {

            response.getWriter()
                    .println("Project creation failed!");
        }


    }
}