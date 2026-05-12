<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Activity" %>

<%
    User user =
            (User) session.getAttribute("user");

    if(user == null){

        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>

<head>
<meta name="viewport"
      content="width=device-width, initial-scale=1">

    <title>Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
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

            min-height: 100vh;

            color: white;
        }

        .glass-card{

            background:
                rgba(255,255,255,0.08);

            backdrop-filter: blur(10px);

            border:
                1px solid rgba(255,255,255,0.1);

            border-radius: 20px;

            box-shadow:
                0 8px 32px rgba(0,0,0,0.3);
        }

        .card{

            transition: 0.3s;

            border-radius: 20px;

            border: none;
        }

        .card:hover{

            transform:
                translateY(-5px);

            box-shadow:
                0 15px 40px rgba(0,0,0,0.3);
        }

        .btn{

            border-radius: 12px;

            font-weight: 500;
        }

        h1, h2, h3, h4{

            font-weight: 600;
        }

        .progress{

            height: 25px;

            border-radius: 20px;

            overflow: hidden;
        }

        .progress-bar{

            font-weight: bold;
        }

        input,
        textarea,
        select{

            border-radius: 12px !important;

            border: none !important;

            padding: 12px !important;
        }

        canvas{

            background: white;

            border-radius: 20px;

            padding: 15px;
        }
        .sidebar{

            min-height: 100vh;

            background:
                rgba(255,255,255,0.05);

            backdrop-filter: blur(10px);

            border-right:
                1px solid rgba(255,255,255,0.1);

            position: sticky;

            top: 0;
        }

        .sidebar-link{

            display: flex;

            align-items: center;

            gap: 12px;

            color: white;

            text-decoration: none;

            padding: 14px;

            margin-bottom: 10px;

            border-radius: 12px;

            transition: 0.3s;
        }

        .sidebar-link:hover{

            background:
                rgba(255,255,255,0.1);

            color: #38bdf8;
        }

        .dashboard-icon{

            font-size: 2.5rem;

            color: #38bdf8;
        }
        .project-card{

            transition: 0.3s;

            overflow: hidden;
        }

        .project-card:hover{

            transform:
                translateY(-8px);

            box-shadow:
                0 20px 40px rgba(0,0,0,0.35);
        }

        .badge{

            padding: 10px 14px;

            border-radius: 10px;

            font-size: 0.85rem;
        }
        @media(max-width: 992px){

            .sidebar{

                min-height: auto;

                position: relative;

                border-right: none;

                border-bottom:
                    1px solid rgba(255,255,255,0.1);
            }

            .sidebar-link{

                justify-content: center;
            }

            .dashboard-icon{

                font-size: 2rem;
            }

            .glass-card{

                margin-bottom: 20px;
            }

            h1{

                font-size: 2rem;
            }

            .progress{

                height: 20px;
            }

            canvas{

                height: auto !important;
            }
        }

        @media(max-width: 768px){

            body{

                padding: 10px;
            }

            .col-lg-10{

                padding: 20px !important;
            }

            .sidebar{

                padding: 20px;
            }

            .sidebar-link{

                font-size: 0.95rem;
            }

            .btn{

                width: 100%;

                margin-bottom: 10px;
            }

            .project-card{

                padding: 20px !important;
            }

            .badge{

                display: block;

                width: fit-content;

                margin-bottom: 10px;
            }

            .row.g-4{

                gap: 10px;
            }
        }

        .dropdown-menu{

            border-radius: 16px;

            border:
                1px solid rgba(255,255,255,0.1);

            backdrop-filter: blur(10px);
        }

        .dropdown-item{

            border-radius: 10px;

            margin-bottom: 6px;

            transition: 0.3s;
        }

        .dropdown-item:hover{

            background:
                rgba(255,255,255,0.1);
        }
        .activity-item{

            display: flex;

            gap: 20px;

            align-items: flex-start;

            margin-bottom: 25px;
        }

        .activity-icon{

            width: 50px;

            height: 50px;

            border-radius: 14px;

            display: flex;

            justify-content: center;

            align-items: center;

            font-size: 1.2rem;

            color: white;

            flex-shrink: 0;
        }
        .quick-action-card{

            display: block;

            background:
                rgba(255,255,255,0.05);

            border:
                1px solid rgba(255,255,255,0.08);

            border-radius: 20px;

            padding: 30px;

            color: white;

            transition: 0.3s;

            height: 100%;
        }

        .quick-action-card:hover{

            transform:
                translateY(-5px);

            background:
                rgba(255,255,255,0.1);

            box-shadow:
                0 15px 35px rgba(0,0,0,0.3);

            color: white;
        }

        .quick-icon{

            font-size: 2.5rem;

            color: #38bdf8;
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

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>

<body id="pageBody">
<button class="mobile-menu-btn"
        id="mobileMenuBtn">

    <i class="bi bi-list"></i>

</button>

<div class="container-fluid">

    <div class="row">

        <div class="col-lg-2 sidebar p-4"
             id="sidebar">

            <h3 class="mb-5 fw-bold text-info">

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

                Explore Projects

            </a>

            <a href="#analytics"
               class="sidebar-link">

                <i class="bi bi-bar-chart-fill"></i>

                Analytics

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
            <a href="kanban"
               class="sidebar-link">

                <i class="bi bi-kanban-fill"></i>

                Kanban Board

            </a>

            <a href="myProjects"
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

<div class="d-flex justify-content-between align-items-center mb-4">

    <h1>
        Welcome <%= user.getFullName() %>
    </h1>

    <div class="dropdown">

        <button class="btn btn-outline-light position-relative"
                data-bs-toggle="dropdown">

            <i class="bi bi-bell-fill"></i>

            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">

                3

            </span>

        </button>

        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end p-2">

            <li>

                <div class="dropdown-item">

                    🔥 AI Project deadline tomorrow

                </div>

            </li>

            <li>

                <div class="dropdown-item">

                    👥 New teammate joined workspace

                </div>

            </li>

            <li>

                <div class="dropdown-item">

                    📊 Productivity score increased

                </div>

            </li>

        </ul>

    </div>

</div>

<div class="row g-4 mb-5">

    <div class="col-md-3">

        <div class="glass-card p-4">

            <div class="d-flex justify-content-between align-items-center">

                <div>

                    <h6 class="text-light">

                        Active Projects

                    </h6>

                    <h2 class="fw-bold">

                        <%= ((java.util.List)request.getAttribute("projects")).size() %>

                    </h2>

                </div>

                <i class="bi bi-kanban-fill dashboard-icon"></i>

            </div>

        </div>

    </div>

    <div class="col-md-3">

        <div class="glass-card p-4">

            <div class="d-flex justify-content-between align-items-center">

                <div>

                    <h6 class="text-light">

                        Urgent Deadlines

                    </h6>

                    <h2 class="fw-bold text-danger">

                        3

                    </h2>

                </div>

                <i class="bi bi-exclamation-triangle-fill dashboard-icon text-danger"></i>

            </div>

        </div>

    </div>

    <div class="col-md-3">

        <div class="glass-card p-4">

            <div class="d-flex justify-content-between align-items-center">

                <div>

                    <h6 class="text-light">

                        Productivity

                    </h6>

                    <h2 class="fw-bold text-info">

                        87%

                    </h2>

                </div>

                <i class="bi bi-graph-up-arrow dashboard-icon text-info"></i>

            </div>

        </div>

    </div>

    <div class="col-md-3">

        <div class="glass-card p-4">

            <div class="d-flex justify-content-between align-items-center">

                <div>

                    <h6 class="text-light">

                        Team Score

                    </h6>

                    <h2 class="fw-bold text-success">

                        92%

                    </h2>

                </div>

                <i class="bi bi-people-fill dashboard-icon text-success"></i>

            </div>

        </div>

    </div>

</div>

<div class="glass-card p-4 mb-5">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>

            Quick Actions

        </h3>

        <span class="badge bg-info">

            Productivity Hub

        </span>

    </div>

    <div class="row g-3">

        <div class="col-md-3">

            <a href="#createProject"
               class="quick-action-card text-decoration-none">

                <i class="bi bi-plus-circle-fill quick-icon"></i>

                <h5 class="mt-3">

                    Create Project

                </h5>

                <p class="text-light">

                    Start a new collaboration workspace.

                </p>

            </a>

        </div>

        <div class="col-md-3">

            <a href="myProjects"
               class="quick-action-card text-decoration-none">

                <i class="bi bi-people-fill quick-icon"></i>

                <h5 class="mt-3">

                    Team Workspace

                </h5>

                <p class="text-light">

                    Manage teams and collaboration.

                </p>

            </a>

        </div>

        <div class="col-md-3">

            <a href="schedule.jsp"
               class="quick-action-card text-decoration-none">

                <i class="bi bi-calendar-event-fill quick-icon"></i>

                <h5 class="mt-3">

                    Open Schedule

                </h5>

                <p class="text-light">

                    Organize meetings and deadlines.

                </p>

            </a>

        </div>

        <div class="col-md-3">

            <a href="#analytics"
               class="quick-action-card text-decoration-none">

                <i class="bi bi-bar-chart-fill quick-icon"></i>

                <h5 class="mt-3">

                    Analytics

                </h5>

                <p class="text-light">

                    View platform productivity metrics.

                </p>

            </a>

        </div>

    </div>

</div>

<%
    dao.UserDAO userDAO =
            new dao.UserDAO();

    int profileScore =
            userDAO.calculateProfileScore(
                    user
            );
%>

<div class="glass-card p-3 mb-4">

    <h4>
        Profile Completeness
    </h4>

    <div class="progress mt-3">

        <div class="progress-bar bg-success"
             role="progressbar"
             style="width: <%= profileScore %>%">

            <%= profileScore %>%

        </div>

    </div>

</div>

<div class="glass-card p-4 shadow-lg mb-4">

    <h3>Email</h3>

    <p>
        <%= user.getEmail() %>
    </p>

    <h3>Skills</h3>

    <p>
        <%= user.getSkills() %>
    </p>

    <h3>Work Style</h3>

    <p>
        <%= user.getWorkStyle() %>
    </p>

    <h3>Role</h3>

    <p>
        <%= user.getRole() %>
    </p>

    <%
        if(user.getRole().equals("admin")){
    %>

    <a href="admin.jsp"
       class="btn btn-danger mt-3">

        Admin Panel

    </a>

    <%
        }
    %>

    <a href="logout"
       class="btn btn-secondary mt-3">

        Logout

    </a>

    <button id="darkModeBtn"
            class="btn btn-dark mt-3">

        Toggle Dark Mode

    </button>

</div>

<hr>

<h2 class="mt-5 mb-4">
    Edit Profile
</h2>

<form action="editProfile"
      method="post">

    <div class="mb-3">

        <label class="form-label">

            Full Name

        </label>

        <input type="text"
               name="fullName"
               class="form-control"
               value="<%= user.getFullName() %>">

    </div>

    <div class="mb-3">

        <label class="form-label">

            Skills

        </label>

        <input type="text"
               name="skills"
               class="form-control"
               value="<%= user.getSkills() %>">

    </div>

    <div class="mb-3">

        <label class="form-label">

            Work Style

        </label>

        <input type="text"
               name="workStyle"
               class="form-control"
               value="<%= user.getWorkStyle() %>">

    </div>

    <button type="submit"
            class="btn btn-warning">

        Update Profile

    </button>

</form>

<hr>

<h2 class="mt-5 mb-4">
    Recommended Projects
</h2>

<%
    List<model.Project> recommendedProjects =
            (List<model.Project>)
                    request.getAttribute(
                            "recommendedProjects"
                    );
%>

<%
    if(recommendedProjects != null){

        for(model.Project recommended :
                recommendedProjects){
%>

<div class="glass-card p-4 mb-4 border border-success">

    <h4>
        <%= recommended.getTitle() %>
    </h4>

    <p>
        <%= recommended.getDescription() %>
    </p>

    <strong>
        Required Skills:
    </strong>

    <p>
        <%= recommended.getRequiredSkills() %>
    </p>

</div>

<%
        }
    }
%>

<hr>

<h2 id="createProject"
    class="mt-5 mb-4">

    Create New Project

</h2>

<form action="createProject"
      method="post">

    <div class="mb-3">

        <label class="form-label">

            Project Title

        </label>

        <input type="text"
               name="title"
               class="form-control"
               required>

    </div>

    <div class="mb-3">

        <label class="form-label">

            Description

        </label>

        <textarea name="description"
                  class="form-control"
                  rows="4"></textarea>

    </div>

    <div class="mb-3">

        <label class="form-label">

            Required Skills

        </label>

        <input type="text"
               name="requiredSkills"
               class="form-control">

    </div>

    <div class="mb-3">

        <label class="form-label">

            Deadline

        </label>

        <input type="date"
               name="deadline"
               class="form-control">

    </div>

    <div class="mb-3">

        <label class="form-label">

            Difficulty (1-10)

        </label>

        <input type="number"
               name="difficulty"
               class="form-control"
               min="1"
               max="10">

    </div>

    <button type="submit"
            class="btn btn-success">

        Create Project

    </button>

</form>

<hr>

<h2 class="mt-5 mb-4">
    Skills Analytics
</h2>

<hr>

<h2 class="mt-5 mb-4">
    Workload Analytics
</h2>

<canvas id="difficultyChart"
        height="100">

</canvas>

<canvas id="skillsChart"
        height="100">

</canvas>

<hr>

<div class="glass-card p-4 mb-5">

   <%
       List<Activity> activities =
               (List<Activity>)
                       request.getAttribute(
                               "activities"
                       );

       if(activities != null){

           for(Activity activity :
                   activities){
   %>

   <div class="activity-item">

       <div class="activity-icon bg-info">

           <i class="bi bi-lightning-fill"></i>

       </div>

       <div>

           <strong>

               Activity Update

           </strong>

           <p class="mb-0 text-light">

               <%= activity.getActivityText() %>

           </p>

           <small class="text-secondary">

               <%= activity.getCreatedAt() %>

           </small>

       </div>

   </div>

   <%
           }
       }
   %>

</div>

<h2 class="mt-5 mb-4">
    Available Projects
</h2>

<div class="row mb-4">

    <div class="col-md-6">

        <input type="text"
               id="searchInput"
               class="form-control"
               placeholder="Search projects...">

    </div>

    <div class="col-md-3">

        <input type="text"
               id="skillFilter"
               class="form-control"
               placeholder="Filter by skill">

    </div>

    <div class="col-md-3">

        <select id="difficultyFilter"
                class="form-select">

            <option value="">
                All Difficulties
            </option>

            <option value="3">
                Easy
            </option>

            <option value="6">
                Medium
            </option>

            <option value="10">
                Hard
            </option>

        </select>

    </div>

</div>

<%
    List<model.Project> projects =
            (List<model.Project>)
                    request.getAttribute("projects");
%>

<%
    if(projects != null){

        for(model.Project project : projects){
%>

<div class="project-card glass-card p-4 mb-4 position-relative

<%
    int difficulty =
            project.getDifficulty();

    if(difficulty >= 8){
%>

border border-danger

<%
    } else if(difficulty >= 5){
%>

border border-warning

<%
    } else {
%>

border border-success

<%
    }
%>

"
     data-title="<%= project.getTitle().toLowerCase() %>"
     data-skills="<%= project.getRequiredSkills().toLowerCase() %>"
     data-difficulty="<%= project.getDifficulty() %>">

    <h4>
        <%= project.getTitle() %>
    </h4>

    <div class="d-flex gap-2 mb-3">

        <span class="badge bg-info">

            Difficulty:
            <%= project.getDifficulty() %>/10

        </span>

        <span class="badge bg-warning text-dark">

            Deadline:
            <%= project.getDeadline() %>

        </span>

    </div>

    <p>
        <%= project.getDescription() %>
    </p>

    <strong>
        Skills:
    </strong>

    <p>
        <%= project.getRequiredSkills() %>
    </p>

    <%
        dao.ProjectDAO projectDAO =
                new dao.ProjectDAO();

        int compatibility =
                projectDAO.calculateCompatibility(
                        user.getSkills(),
                        project.getRequiredSkills()
                );
    %>

    <div class="progress mt-3">

        <div class="progress-bar"
             role="progressbar"
             style="width: <%= compatibility %>%">

            <%= compatibility %>%

        </div>

    </div>

    <a href="projectDetails?id=<%= project.getId() %>"
       class="btn btn-outline-light mt-3 me-2">

        View Details

    </a>

    <a href="kanban?projectId=<%= project.getId() %>"
       class="btn btn-info mt-3 me-2">

        Open Kanban

    </a>

    <a href="teamWorkspace?projectId=<%= project.getId() %>"
       class="btn btn-warning mt-3 me-2">

        Open Workspace

    </a>

    <form action="applyProject"
          method="post">

        <input type="hidden"
               name="projectId"
               value="<%= project.getId() %>">

        <input type="hidden"
               name="requiredSkills"
               value="<%= project.getRequiredSkills() %>">

        <button type="submit"
                class="btn btn-primary mt-3">

            Apply

        </button>

    </form>

   <%
       if(project.getCreatorId()
          == user.getId()){
   %>

   <a href="viewApplications?projectId=<%= project.getId() %>"
      class="btn btn-dark mt-2">

       View Applications

   </a>

   <%
       }
   %>


<%
    if(project.getCreatorId()
       == user.getId()
       || user.getRole().equals("admin")){
%>

<a href="deleteProject?projectId=<%= project.getId() %>"
   class="btn btn-danger mt-2">

    Delete Project

</a>

<%
    }
%>

</div>

<%
        }
    }
%>

<script>

    $("form[action='createProject']")
        .submit(function(event){

        let title =
            $("input[name='title']")
                .val();

        if(title.length < 3){

            alert(
                "Project title must contain at least 3 characters!"
            );

            event.preventDefault();
        }
    });

</script>

<script>

    $("form[action='editProfile']")
        .submit(function(event){

        let skills =
            $("input[name='skills']")
                .val();

        if(skills.length < 2){

            alert(
                "Please enter at least one skill!"
            );

            event.preventDefault();
        }
    });

</script>

<%
    Map<String, Integer> statistics =
            (Map<String, Integer>)
                    request.getAttribute(
                            "statistics"
                    );
%>

<script>

    const labels = [

        <%
            if(statistics != null){

                for(String skill :
                        statistics.keySet()){
        %>

        "<%= skill %>",

        <%
                }
            }
        %>
    ];

    const data = [

        <%
            if(statistics != null){

                for(Integer count :
                        statistics.values()){
        %>

        <%= count %>,

        <%
                }
            }
        %>
    ];

    new Chart(
        document.getElementById(
            "skillsChart"
        ),
        {
            type: 'bar',

            data: {

                labels: labels,

                datasets: [{

                    label:
                        'Most Requested Skills',

                    data: data
                }]
            }
        }
    );

</script>

<script>

    const projectLabels = [

        <%
            if(projects != null){

                for(model.Project project :
                        projects){
        %>

        "<%= project.getTitle() %>",

        <%
                }
            }
        %>
    ];

    const projectDifficulty = [

        <%
            if(projects != null){

                for(model.Project project :
                        projects){
        %>

        <%= project.getDifficulty() %>,

        <%
                }
            }
        %>
    ];

    new Chart(
        document.getElementById(
            "difficultyChart"
        ),
        {
            type: 'line',

            data: {

                labels:
                    projectLabels,

                datasets: [{

                    label:
                        'Project Difficulty',

                    data:
                        projectDifficulty,

                    tension: 0.4
                }]
            }
        }
    );

</script>

<script>

    $("#searchInput, #skillFilter, #difficultyFilter")
        .on("keyup change", function(){

        let search =
            $("#searchInput")
                .val()
                .toLowerCase();

        let skill =
            $("#skillFilter")
                .val()
                .toLowerCase();

        let difficulty =
            $("#difficultyFilter")
                .val();

        $(".project-card").each(function(){

            let title =
                $(this).data("title");

            let skills =
                $(this).data("skills");

            let projectDifficulty =
                $(this).data("difficulty");

            let matchesSearch =
                title.includes(search);

            let matchesSkill =
                skills.includes(skill);

            let matchesDifficulty =
                difficulty === "" ||
                projectDifficulty <= difficulty;

            if(matchesSearch &&
               matchesSkill &&
               matchesDifficulty){

                $(this).show();

            } else {

                $(this).hide();
            }
        });
    });

</script>

<script>

    $("#darkModeBtn").click(function(){

        $("#pageBody")
            .toggleClass(
                "bg-dark text-white"
            );

        $(".glass-card")
            .toggleClass(
                "bg-secondary text-white"
            );
    });

</script>

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