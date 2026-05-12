package controller;

import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;

import java.io.IOException;

@WebServlet("/editProfile")
public class EditProfileServlet
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

        String fullName =
                request.getParameter("fullName");

        String skills =
                request.getParameter("skills");

        String workStyle =
                request.getParameter("workStyle");

        user.setFullName(fullName);

        user.setSkills(skills);

        user.setWorkStyle(workStyle);

        UserDAO userDAO =
                new UserDAO();

        boolean result =
                userDAO.updateUser(user);

        if(result){

            session.setAttribute(
                    "user",
                    user
            );

            response.sendRedirect("dashboard");

        } else {

            response.getWriter()
                    .println("Profile update failed!");
        }
    }
}