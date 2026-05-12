package controller;

import dao.ProjectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Project;

import java.io.IOException;
import java.util.List;

import java.util.Map;

import dao.ActivityDAO;
import model.Activity;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        ProjectDAO projectDAO =
                new ProjectDAO();

        ActivityDAO activityDAO =
                new ActivityDAO();

        List<Project> projects =
                projectDAO.getAllProjects();

        Map<String, Integer> statistics =
                projectDAO.getSkillsStatistics();

        request.setAttribute(
                "statistics",
                statistics
        );

        request.setAttribute(
                "projects",
                projects
        );

        List<Activity> activities =
                activityDAO.getRecentActivities();

        request.setAttribute(
                "activities",
                activities
        );

        model.User user =
                (model.User)
                        request.getSession()
                                .getAttribute("user");

        if(user != null){

            List<Project> recommendedProjects =
                    projectDAO.getRecommendedProjects(
                            user.getSkills()
                    );

            request.setAttribute(
                    "recommendedProjects",
                    recommendedProjects
            );
        }

        request.getRequestDispatcher(
                "dashboard.jsp"
        ).forward(request, response);
    }
}