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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        UserDAO userDAO = new UserDAO();

        User user =
                userDAO.loginUser(email, password);

        if (user != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute("user", user);

            response.sendRedirect("dashboard");

        } else {

            response.getWriter()
                    .println("Invalid credentials!");
        }
    }
}