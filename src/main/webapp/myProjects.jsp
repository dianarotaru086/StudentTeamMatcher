<%@ page import="java.util.List" %>
<%@ page import="model.Project" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user =
            (User) session.getAttribute("user");

    if(user == null){

        response.sendRedirect("login.jsp");
        return;
    }

    List<Project> projects =
            (List<Project>)
                    request.getAttribute("projects");
%>

<html>

<head>
<meta name="viewport"
      content="width=device-width, initial-scale=1">

    <title>
        My Projects
    </title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

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

            box-shadow:
                0 10px 30px rgba(0,0,0,0.3);
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

        .badge{

            padding: 10px 14px;

            border-radius: 10px;
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

            <a href="logout"
               class="sidebar-link text-danger">

                <i class="bi bi-box-arrow-right"></i>

                Logout

            </a>

        </div>

        <div class="col-lg-10 p-5">

            <h1 class="mb-5">

                My Projects

            </h1>

            <div class="row g-4">

                <%
                    if(projects != null){

                        for(Project project : projects){
                %>

                <div class="col-md-6">

                    <div class="glass-card p-4 h-100">

                        <div class="d-flex justify-content-between">

                            <h4>

                                <%= project.getTitle() %>

                            </h4>

                            <span class="badge bg-info">

                                <%= project.getDifficulty() %>/10

                            </span>

                        </div>

                        <p class="mt-3">

                            <%= project.getDescription() %>

                        </p>

                        <div class="mb-3">

                            <span class="badge bg-warning text-dark">

                                Deadline:
                                <%= project.getDeadline() %>

                            </span>

                        </div>

                        <strong>

                            Required Skills

                        </strong>

                        <p class="mt-2">

                            <%= project.getRequiredSkills() %>

                        </p>

                        <div class="progress mt-4">

                            <div class="progress-bar bg-success"
                                 style="width: 70%">

                                70%

                            </div>

                        </div>

                        <div class="mt-4 d-flex gap-2">

                            <a href="projectDetails?id=<%= project.getId() %>"
                               class="btn btn-info">

                                Open

                            </a>

                            <a href="deleteProject?projectId=<%= project.getId() %>"
                               class="btn btn-danger">

                                Delete

                            </a>

                            <a href="teamWorkspace?projectId=<%= project.getId() %>"
                               class="btn btn-warning">

                                Team

                            </a>

                            <a href="teamWorkspace?projectId=<%= project.getId() %>"
                               class="btn btn-info">

                                Open Workspace

                            </a>

                        </div>



                    </div>

                </div>

                <%
                        }
                    }
                %>

            </div>

        </div>

    </div>

</div>

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