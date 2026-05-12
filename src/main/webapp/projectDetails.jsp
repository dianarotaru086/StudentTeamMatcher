<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Project" %>
<%@ page import="dao.CommentDAO" %>
<%@ page import="model.Comment" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.ProjectMemberDAO" %>
<%@ page import="model.ProjectMember" %>
<%@ page import="dao.ProjectFileDAO" %>
<%@ page import="model.ProjectFile" %>
<%@ page import="dao.ActivityDAO" %>
<%@ page import="model.Activity" %>

<%
    Project project =
            (Project)
            request.getAttribute(
                    "project"
            );
%>

<%
    CommentDAO commentDAO =
            new CommentDAO();

    List<Comment> comments =
            commentDAO.getCommentsByProject(
                    project.getId()
            );
%>

<%
    ProjectMemberDAO memberDAO =
            new ProjectMemberDAO();

    List<ProjectMember> members =
            memberDAO.getMembersByProject(
                    project.getId()
            );
%>

<%
    ProjectFileDAO fileDAO =
            new ProjectFileDAO();

    List<ProjectFile> files =
            fileDAO.getFilesByProject(
                    project.getId()
            );
%>

<%
    ActivityDAO activityDAO =
            new ActivityDAO();

    List<Activity> activities =
            activityDAO.getActivitiesByProject(
                    project.getId()
            );
%>

<html>

<head>

    <title>
        Project Details
    </title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>

        body{

            font-family: 'Poppins', sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #0f172a,
                    #1e293b,
                    #334155
                );

            color: white;

            min-height: 100vh;
        }

        .sidebar{

            min-height: 100vh;

            background:
                rgba(255,255,255,0.05);

            border-right:
                1px solid rgba(255,255,255,0.1);

            padding: 30px;
        }

        .sidebar-link{

            display: flex;

            align-items: center;

            gap: 12px;

            color: white;

            text-decoration: none;

            padding: 14px;

            margin-bottom: 12px;

            border-radius: 12px;

            transition: 0.3s;
        }

        .sidebar-link:hover{

            background:
                rgba(255,255,255,0.1);

            color: #38bdf8;
        }

        .glass-card{

            background:
                rgba(255,255,255,0.08);

            border:
                1px solid rgba(255,255,255,0.1);

            border-radius: 20px;

            backdrop-filter: blur(10px);

            transition: 0.3s;
        }

        .glass-card:hover{

            transform:
                translateY(-5px);
        }

        .task-item{

            background:
                rgba(255,255,255,0.05);

            padding: 15px;

            border-radius: 12px;

            margin-bottom: 15px;
        }

        .member-avatar{

            width: 60px;

            height: 60px;

            border-radius: 50%;

            border:
                3px solid #38bdf8;
        }

        canvas{

            background: white;

            border-radius: 20px;

            padding: 20px;
        }
        .comment-item{

            display: flex;

            gap: 18px;

            margin-bottom: 30px;
        }

        .comment-avatar{

            width: 55px;

            height: 55px;

            border-radius: 50%;

            object-fit: cover;

            border:
                3px solid #38bdf8;

            flex-shrink: 0;
        }

        .comment-content{

            background:
                rgba(255,255,255,0.05);

            border:
                1px solid rgba(255,255,255,0.08);

            border-radius: 18px;

            padding: 20px;

            width: 100%;
        }

        .discussion-input{

            background:
                rgba(255,255,255,0.08);

            border: none;

            color: white;

            padding: 14px;

            border-radius: 14px 0 0 14px;
        }

        .discussion-input:focus{

            background:
                rgba(255,255,255,0.12);

            color: white;

            box-shadow: none;
        }

        .discussion-input::placeholder{

            color: #cbd5e1;
        }

        .mobile-menu-btn{

            position: fixed;

            top: 20px;

            left: 20px;

            z-index: 9999;

            background: #38bdf8;

            border: none;

            color: white;

            width: 50px;

            height: 50px;

            border-radius: 14px;

            display: none;

            font-size: 24px;

            box-shadow:
                0 8px 20px rgba(0,0,0,0.3);
        }

        @media(max-width: 991px){

            .mobile-menu-btn{

                display: block;
            }

            .sidebar{

                position: fixed;

                left: -300px;

                top: 0;

                width: 280px;

                z-index: 9998;

                background:
                    rgba(15,23,42,0.98);

                transition: 0.4s;

                overflow-y: auto;
            }

            .sidebar.active{

                left: 0;
            }

            .col-lg-10{

                width: 100%;

                padding-top: 90px !important;
            }
        }

    </style>

</head>

<body>

<button class="mobile-menu-btn"
        id="mobileMenuBtn">

    <i class="bi bi-list"></i>

</button>

<div class="container-fluid">

    <div class="row">

        <div class="col-lg-2 sidebar"
             id="sidebar">

            <h3 class="fw-bold text-info mb-5">

                STM

            </h3>

            <a href="dashboard"
               class="sidebar-link">

                <i class="bi bi-grid-fill"></i>

                Dashboard

            </a>

            <a href="myProjects.jsp"
               class="sidebar-link">

                <i class="bi bi-kanban-fill"></i>

                My Projects

            </a>

            <a href="teamWorkspace"
               class="sidebar-link">

                <i class="bi bi-people-fill"></i>

                Team Workspace

            </a>

            <a href="logout"
               class="sidebar-link text-danger">

                <i class="bi bi-box-arrow-right"></i>

                Logout

            </a>

        </div>

        <div class="col-lg-10 p-5">

            <div class="glass-card p-5 mb-5">

                <div class="d-flex justify-content-between align-items-center">

                    <div>

                        <h1>

                            <%= project.getTitle() %>

                        </h1>

                        <p class="text-light">

                            <%= project.getDescription() %>

                        </p>

                    </div>

                    <span class="badge bg-danger p-3">

                        High Priority

                    </span>

                </div>

                <div class="mt-4">

                    <span class="badge bg-info">

                        Difficulty:
                        <%= project.getDifficulty() %>/10

                    </span>

                    <span class="badge bg-warning text-dark">

                        Deadline:
                        <%= project.getDeadline() %>

                    </span>

                    <span class="badge bg-success">

                        Progress: 72%

                    </span>

                </div>

            </div>

            <div class="row g-4 mb-5">

                <div class="col-lg-8">

                    <div class="glass-card p-5 h-100">

                        <h3 class="mb-4">

                            Project Overview

                        </h3>

                        <p>

                            This platform helps students
                            collaborate more efficiently
                            through intelligent matching,
                            workload analytics and productivity tools.

                        </p>

                        <h4 class="mt-5 mb-3">

                            Main Objectives

                        </h4>

                        <ul>

                            <li>

                                Smart student matching

                            </li>

                            <li>

                                Project workload optimization

                            </li>

                            <li>

                                Mobile responsive workspace

                            </li>

                            <li>

                                Team collaboration tools

                            </li>

                        </ul>

                    </div>

                </div>

                <div class="col-lg-4">

                    <div class="glass-card p-5 h-100">

                        <h3 class="mb-4">

                            Team Members

                        </h3>

                        <%
                            for(ProjectMember member : members){

                                String image =
                                        member.getProfilePicture();

                                if(image == null ||
                                   image.isEmpty()){

                                    image =
                                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
                                }
                        %>

                        <div class="d-flex align-items-center mb-4">

                            <img src="<%= image %>"
                                 class="member-avatar me-3">

                            <div>

                                <h6 class="mb-0">

                                    <%= member.getFullName() %>

                                </h6>

                                <small class="text-light">

                                    <%= member.getRole() %>

                                </small>

                            </div>

                        </div>

                        <%
                            }
                        %>

                    </div>

                </div>

            </div>

            <div class="row g-4">

                <div class="col-lg-6">

                    <div class="glass-card p-5 h-100">

                        <h3 class="mb-4">

                            Task Progress

                        </h3>

                        <div class="task-item">

                            Dashboard Redesign

                        </div>

                        <div class="task-item">

                            Azure Deployment

                        </div>

                        <div class="task-item">

                            Mobile Optimization

                        </div>

                        <div class="task-item">

                            Team Analytics

                        </div>

                    </div>

                </div>

                <div class="col-lg-6">

                    <div class="glass-card p-5 h-100">

                        <h3 class="mb-4">

                            Analytics

                        </h3>

                        <canvas id="projectChart"
                                height="180">

                        </canvas>

                    </div>

                </div>

            </div>
            <div class="glass-card p-5 mt-5">

                <div class="d-flex justify-content-between align-items-center mb-5">

                    <div>

                        <div class="glass-card p-5 mt-5 mb-5">

                            <div class="d-flex justify-content-between align-items-center mb-4">

                                <h3>

                                    Project Resources

                                </h3>

                                <span class="badge bg-info">

                                    <%= files.size() %> Files

                                </span>

                            </div>

                            <form action="uploadProjectFile"
                                  method="post"
                                  enctype="multipart/form-data"
                                  class="mb-5">

                                <input type="hidden"
                                       name="projectId"
                                       value="<%= project.getId() %>">

                                <div class="input-group">

                                    <input type="file"
                                           name="file"
                                           class="form-control"
                                           required>

                                    <button class="btn btn-info">

                                        Upload

                                    </button>

                                </div>

                            </form>

                            <%
                                for(ProjectFile file : files){
                            %>

                            <div class="task-item d-flex justify-content-between align-items-center">

                                <div>

                                    <h6 class="mb-1">

                                        <%= file.getFileName() %>

                                    </h6>

                                    <small class="text-secondary">

                                        Uploaded:
                                        <%= file.getUploadedAt() %>

                                    </small>

                                </div>

                                <a href="uploads/<%= file.getFileName() %>"
                                   target="_blank"
                                   class="btn btn-outline-info">

                                    Open

                                </a>

                            </div>

                            <%
                                }
                            %>

                        </div>

                        <div class="glass-card p-5 mt-5 mb-5">

                            <div class="d-flex justify-content-between align-items-center mb-4">

                                <h3>

                                    Activity Feed

                                </h3>

                                <span class="badge bg-success">

                                    Live Activity

                                </span>

                            </div>

                            <%
                                for(Activity activity : activities){
                            %>

                            <div class="task-item">

                                <div class="d-flex justify-content-between align-items-center">

                                    <div>

                                        <p class="mb-1">

                                            <%= activity.getActivityText() %>

                                        </p>

                                        <small class="text-secondary">

                                            <%= activity.getCreatedAt() %>

                                        </small>

                                    </div>

                                    <i class="bi bi-activity text-info"></i>

                                </div>

                            </div>

                            <%
                                }
                            %>

                        </div>

                        <h3>

                            Team Discussion

                        </h3>

                        <p class="text-light">

                            Collaborate and share updates with the team.

                        </p>

                    </div>

                    <span class="badge bg-info">

                        12 Messages

                    </span>

                </div>


               <%
                   for(Comment comment : comments){

                       String image =
                               comment.getProfilePicture();

                       if(image == null ||
                          image.isEmpty()){

                           image =
                           "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
                       }
               %>

               <div class="comment-item">

                   <img src="<%= image %>"
                        class="comment-avatar">

                   <div class="comment-content">

                       <div class="d-flex justify-content-between align-items-center">

                           <h6 class="mb-0">

                               <%= comment.getUserName() %>

                           </h6>

                           <small class="text-secondary">

                               <%= comment.getCreatedAt() %>

                           </small>

                       </div>

                       <p class="mt-2 mb-0">

                           <%= comment.getMessage() %>

                       </p>

                   </div>

               </div>

               <%
                   }
               %>


                <div class="mt-5">

                    <form action="addComment"
                          method="post">

                        <div class="input-group">

                        <input type="hidden"
                               name="projectId"
                               value="<%= project.getId() %>">

                            <input type="text"
                                   name="message"
                                   class="form-control discussion-input"
                                   placeholder="Write a message...">

                            <button class="btn btn-info px-4">

                                <i class="bi bi-send-fill"></i>

                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

<script>

    new Chart(
        document.getElementById(
            "projectChart"
        ),
        {
            type: 'bar',

            data: {

                labels: [

                    'Frontend',
                    'Backend',
                    'Database',
                    'Testing'

                ],

                datasets: [{

                    label:
                        'Completion',

                    data: [
                        80,
                        70,
                        65,
                        40
                    ]
                }]
            }
        }
    );

</script>

<script>

    const mobileMenuBtn =
        document.getElementById(
            "mobileMenuBtn"
        );

    const sidebar =
        document.getElementById(
            "sidebar"
        );

    mobileMenuBtn.addEventListener(
        "click",
        () => {

            sidebar.classList.toggle(
                "active"
            );
        }
    );

</script>

</body>

</html>