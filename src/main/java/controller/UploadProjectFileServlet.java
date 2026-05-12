package controller;

import dao.ProjectFileDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import dao.ActivityDAO;
import websocket.FileSyncNotifier;

import java.io.File;
import java.io.IOException;

@WebServlet("/uploadProjectFile")
@MultipartConfig
public class UploadProjectFileServlet
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

        int projectId =
                Integer.parseInt(
                        request.getParameter(
                                "projectId"
                        )
                );

        Part filePart =
                request.getPart("file");

        String fileName =
                System.currentTimeMillis()
                        + "_"
                        + filePart.getSubmittedFileName();

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

        ProjectFileDAO fileDAO =
                new ProjectFileDAO();

        fileDAO.uploadFile(
                projectId,
                user.getId(),
                fileName
        );
        FileSyncNotifier.broadcast(
                projectId,
                fileName
        );



        ActivityDAO activityDAO =
                new ActivityDAO();

        activityDAO.addActivity(
                projectId,
                user.getFullName()
                        + " uploaded file: "
                        + fileName
        );



        response.sendRedirect(
                "projectDetails?id="
                        + projectId
        );
    }
}