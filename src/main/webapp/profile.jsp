<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.SkillDAO" %>
<%@ page import="model.Skill" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.List" %>

<%
    User user =
            (User) session.getAttribute("user");

    if(user == null){

        response.sendRedirect("login.jsp");
        return;
    }
%>

<%
                UserDAO userDAO =
                        new UserDAO();

                int projectsCompleted =
                        userDAO.getCompletedProjectsCount(
                                user.getId()
                        );

                int skillsCount =
                        userDAO.getSkillsCount(
                                user.getId()
                        );

                int collaborations =
                        userDAO.getApplicationsCount(
                                user.getId()
                        );

                int collaborationScore =
                        (skillsCount * 10)
                        + (collaborations * 5);

                if(collaborationScore > 100){

                    collaborationScore = 100;
                }
            %>

<html>

<head>
<meta name="viewport"
      content="width=device-width, initial-scale=1">

    <title>
        Profile
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

        .profile-avatar{

            width: 140px;

            height: 140px;

            border-radius: 50%;

            object-fit: cover;

            border:
                4px solid #38bdf8;

            display: block;

            margin: auto;
        }

        .skill-badge{

            background:
                rgba(56,189,248,0.2);

            color: #38bdf8;

            padding: 10px 16px;

            border-radius: 30px;

            display: inline-block;

            margin: 5px;

            font-weight: 500;
        }

        canvas{

            background: white;

            border-radius: 20px;

            padding: 20px;
        }

        .skill-badge{

            background:
                linear-gradient(
                    135deg,
                    #38bdf8,
                    #0ea5e9
                );

            padding: 10px 18px;

            border-radius: 30px;

            font-weight: 500;

            display: flex;

            align-items: center;

            transition: 0.3s;
        }

        .skill-badge:hover{

            transform:
                scale(1.05);
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

            <a href="myProjects"
               class="sidebar-link">

                <i class="bi bi-kanban-fill"></i>

                My Projects

            </a>

            <a href="schedule.jsp"
               class="sidebar-link">

                <i class="bi bi-calendar-event-fill"></i>

                Schedule

            </a>

            <a href="profile"
               class="sidebar-link">

                <i class="bi bi-person-circle"></i>

                Profile

            </a>

            <a href="logout"
               class="sidebar-link text-danger">

                <i class="bi bi-box-arrow-right"></i>

                Logout

            </a>

        </div>

        <div class="col-lg-10 p-5">

            <div class="glass-card p-5 mb-5">

                <div class="row align-items-center">

                    <div class="col-md-3 text-center">

                        <%
                            String profileImage =
                                    user.getProfilePicture();

                            if(profileImage == null ||
                               profileImage.isEmpty()){

                                profileImage =
                                "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
                            }
                        %>

                        <img src="<%= profileImage %>"
                             class="profile-avatar">
                    </div>



                    <div class="col-md-9">

                        <h1>

                            <%= user.getFullName() %>

                        </h1>

                        <p class="text-light">

                            Passionate student focused on
                            collaboration, innovation and academic projects.

                        </p>

                        <div class="mt-4">

                            <span class="badge bg-info">

                                Collaboration Score:
                                <%= collaborationScore %>%

                            </span>

                            <span class="badge bg-success">

                                Productivity: High

                            </span>

                            <span class="badge bg-warning text-dark">

                                Team Player

                            </span>

                        </div>

                    </div>

                   <form action="uploadProfilePicture"
                         method="post"
                         enctype="multipart/form-data"
                         class="mt-4">

                       <div class="input-group"
                            style="max-width:400px;">

                           <input type="file"
                                  name="profilePicture"
                                  class="form-control"
                                  required>

                           <button class="btn btn-info">

                               Upload

                           </button>

                       </div>

                   </form>

                </div>

            </div>



            <div class="row g-4 mb-5">

                <div class="col-md-4">

                    <div class="glass-card p-4 text-center">

                        <h2 class="fw-bold text-info">

                            <%= projectsCompleted %>

                        </h2>

                        <p>

                            Projects Completed

                        </p>

                    </div>

                </div>

                <div class="col-md-4">

                    <div class="glass-card p-4 text-center">

                        <h2 class="fw-bold text-success">

                            <%= collaborations %>

                        </h2>

                        <p>

                            Team Collaborations

                        </p>

                    </div>

                </div>

                <div class="col-md-4">

                    <div class="glass-card p-4 text-center">

                        <h2 class="fw-bold text-warning">

                            <%= skillsCount %>

                        </h2>

                        <p>

                            Skills Tracked

                        </p>

                    </div>

                </div>

            </div>

            <div class="glass-card p-5 mb-5">

                <h3 class="mb-4">

                    Skills

                </h3>

                <%
                    List<Skill> skills =
                            (List<Skill>)
                            request.getAttribute(
                                    "skills"
                            );
                %>

                <div class="d-flex flex-wrap gap-3 mt-4">

                <%
                    for(Skill skill : skills){
                %>

                    <div class="skill-badge">

                        <%= skill.getSkillName() %>

                        <a href="deleteSkill?id=<%= skill.getId() %>"
                           class="text-white text-decoration-none ms-2">

                            ×

                        </a>

                    </div>

                <%
                    }
                %>

                </div>

            </div>

            <div class="glass-card p-4 mt-4">

                <h4 class="mb-4">

                    Add New Skill

                </h4>

                <form action="addSkill"
                      method="post">

                    <div class="input-group">

                        <input type="text"
                               name="skillName"
                               class="form-control"
                               placeholder="Enter a skill..."
                               required>

                        <button class="btn btn-info">

                            Add Skill

                        </button>

                    </div>

                </form>

            </div>

            <div class="glass-card p-5">

                <h3 class="mb-4">

                    Activity Analytics

                </h3>

                <canvas id="activityChart"
                        height="100">

                </canvas>

            </div>

        </div>

    </div>

</div>

<script>

    new Chart(
        document.getElementById(
            "activityChart"
        ),
        {
            type: 'line',

            data: {

                labels: [

                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'

                ],

                datasets: [{

                    label:
                        'Productivity',

                    data: [
                        4,
                        7,
                        5,
                        9,
                        6,
                        8,
                        10
                    ],

                    tension: 0.4
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