package controller;

import dao.ProjectCodeDAO;
import model.ProjectCode;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/addProjectCode")
public class AddProjectCodeServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute(
                        "user"
                );

        int projectId =
                Integer.parseInt(
                        request.getParameter(
                                "projectId"
                        )
                );

        String title =
                request.getParameter(
                        "title"
                );

        String language =
                request.getParameter(
                        "language"
                );

        String codeText =
                request.getParameter(
                        "code"
                );

        ProjectCode code =
                new ProjectCode();

        code.setProjectId(
                projectId
        );

        code.setUserId(
                user.getId()
        );

        code.setTitle(
                title
        );

        code.setLanguage(
                language
        );

        code.setCode(
                codeText
        );

        ProjectCodeDAO dao =
                new ProjectCodeDAO();

        dao.addCode(code);

        response.sendRedirect(
                "teamWorkspace?projectId="
                        + projectId
        );
    }
}