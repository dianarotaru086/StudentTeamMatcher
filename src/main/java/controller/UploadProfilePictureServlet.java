package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/uploadProfilePicture")
@MultipartConfig
public class UploadProfilePictureServlet
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

        Part filePart =
                request.getPart(
                        "profilePicture"
                );

        String fileName =
                filePart.getSubmittedFileName();

        String uploadPath =
                getServletContext()
                        .getRealPath("")
                        + File.separator
                        + "uploads";

        File uploadDir =
                new File(uploadPath);

        if(!uploadDir.exists()){

            uploadDir.mkdir();
        }

        filePart.write(
                uploadPath
                        + File.separator
                        + fileName
        );

        String imagePath =
                "uploads/" + fileName;

        UserDAO userDAO =
                new UserDAO();

        userDAO.updateProfilePicture(
                user.getId(),
                imagePath
        );

        user.setProfilePicture(
                imagePath
        );

        session.setAttribute(
                "user",
                user
        );

        response.sendRedirect(
                "profile.jsp"
        );
    }
}