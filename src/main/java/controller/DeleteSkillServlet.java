package controller;

import dao.SkillDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteSkill")
public class DeleteSkillServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int skillId =
                Integer.parseInt(
                        request.getParameter("id")
                );

        SkillDAO skillDAO =
                new SkillDAO();

        skillDAO.deleteSkill(skillId);

        response.sendRedirect(
                "profile.jsp"
        );
    }
}