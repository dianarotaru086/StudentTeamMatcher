package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String skills =
                request.getParameter("skills");

        String workStyle =
                request.getParameter("workStyle");

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("student");
        user.setSkills(skills);
        user.setWorkStyle(workStyle);

        UserDAO userDAO = new UserDAO();

        boolean result =
                userDAO.registerUser(user);

        if (result) {

            response.getWriter()
                    .println("Registration successful!");

        } else {

            response.getWriter()
                    .println("Registration failed!");
        }
    }
}