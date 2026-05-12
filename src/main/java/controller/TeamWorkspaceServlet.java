package controller;

import dao.ProjectCodeDAO;
import dao.ProjectDAO;
import dao.ProjectFileDAO;
import dao.ProjectMemberDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Project;
import model.ProjectCode;
import model.ProjectFile;
import model.ProjectMember;

import java.io.IOException;
import java.util.List;

@WebServlet("/teamWorkspace")
public class TeamWorkspaceServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int projectId =
                Integer.parseInt(
                        request.getParameter(
                                "projectId"
                        )
                );

        ProjectDAO projectDAO =
                new ProjectDAO();

        Project project =
                projectDAO.getProjectById(
                        projectId
                );

        ProjectMemberDAO memberDAO =
                new ProjectMemberDAO();

        List<ProjectMember> members =
                memberDAO.getMembersByProject(
                        projectId
                );

        ProjectFileDAO fileDAO =
                new ProjectFileDAO();

        List<ProjectFile> files =
                fileDAO.getFilesByProject(
                        projectId
                );

        ProjectCodeDAO codeDAO =
                new ProjectCodeDAO();

        List<ProjectCode> codeList =
                codeDAO.getCodeByProject(
                        projectId
                );

        request.setAttribute(
                "codeList",
                codeList
        );

        request.setAttribute(
                "files",
                files
        );

        request.setAttribute(
                "project",
                project
        );

        request.setAttribute(
                "members",
                members
        );


        request.getRequestDispatcher(
                "teamWorkspace.jsp"
        ).forward(
                request,
                response
        );


    }
}