package controller;

import dao.SkillDAO;
import dao.UserDAO;
import model.Skill;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/profile")
public class ProfileServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        User user =
                (User) request
                        .getSession()
                        .getAttribute("user");

        if(user == null){

            response.sendRedirect(
                    "login.jsp"
            );

            return;
        }

        SkillDAO skillDAO =
                new SkillDAO();

        List<Skill> skills =
                skillDAO.getSkillsByUser(
                        user.getId()
                );

        request.setAttribute(
                "skills",
                skills
        );

        request.getRequestDispatcher(
                "profile.jsp"
        ).forward(
                request,
                response
        );
    }
}