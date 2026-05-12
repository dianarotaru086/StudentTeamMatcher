package controller;

import dao.SkillDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/addSkill")
public class AddSkillServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute("user");

        String skillName =
                request.getParameter("skillName");

        SkillDAO skillDAO =
                new SkillDAO();

        skillDAO.addSkill(
                user.getId(),
                skillName
        );

        response.sendRedirect(
                "profile.jsp"
        );
    }
}