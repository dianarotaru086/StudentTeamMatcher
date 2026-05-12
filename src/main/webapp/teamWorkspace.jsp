<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ProjectMember" %>
<%@ page import="model.Project" %>
<%@ page import="model.TeamMessage" %>
<%@ page import="model.ProjectFile" %>
<%@ page import="model.ProjectCode" %>


<%
    Project project =
            (Project)
            request.getAttribute(
                    "project"
            );

    List<ProjectMember> members =
            (List<ProjectMember>)
                    request.getAttribute(
                            "members"
                    );

    List<TeamMessage> messages =
            (List<TeamMessage>)
                    request.getAttribute(
                            "messages"
                    );

    List<ProjectCode> codeList =
                (List<ProjectCode>)
                        request.getAttribute(
                                "codeList"
                        );

    List<ProjectFile> files =
            (List<ProjectFile>)
                    request.getAttribute(
                            "files"
                    );

%>

<html>

<head>

    <title>
        Team Workspace
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

        .member-avatar{

            width: 70px;

            height: 70px;

            border-radius: 50%;

            object-fit: cover;

            border:
                3px solid #38bdf8;
        }

        .task-item{

            padding: 15px;

            border-radius: 12px;

            background:
                rgba(255,255,255,0.05);

            margin-bottom: 15px;
        }

        .chat-message{

            background:
                rgba(255,255,255,0.05);

            border:
                1px solid rgba(255,255,255,0.08);

            border-radius: 16px;

            padding: 18px;

            margin-bottom: 20px;
        }

        .chat-box{

            max-height: 500px;

            overflow-y: auto;

            padding-right: 10px;
        }

        .chat-box::-webkit-scrollbar{

            width: 8px;
        }

        .chat-box::-webkit-scrollbar-thumb{

            background: #38bdf8;

            border-radius: 20px;
        }

        canvas{

            background: white;

            border-radius: 20px;

            padding: 20px;
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

            <div class="d-flex justify-content-between align-items-center mb-5">

                <div>

                    <h1>

                        <%= project.getTitle() %>

                    </h1>

                    <p class="text-light">

                        Real collaborative workspace for the team.

                    </p>

                </div>

                <span class="badge bg-info p-3">

                    <%= members.size() %> Members

                </span>

            </div>

            <div class="row g-4 mb-5">

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

            <div class="col-md-3">

                <div class="glass-card p-4 text-center">

                    <img src="<%= image %>"
                         class="member-avatar mb-3">

                    <h5>

                        <%= member.getFullName() %>

                    </h5>

                    <p class="text-light">

                        <%= member.getRole() %>

                    </p>

                </div>

            </div>

            <%
                }
            %>

            </div>

            <div class="row g-4">

                <div class="col-lg-6">

                    <div class="glass-card p-5 h-100">

                        <h3 class="mb-4">

                            Team Progress

                        </h3>

                        <canvas id="teamChart"
                                height="180">

                        </canvas>

                    </div>

                </div>

                <div class="col-lg-6">

                    <div class="glass-card p-5 h-100">

                        <h3 class="mb-4">

                            Workspace Features

                        </h3>

                        <div class="task-item">

                            Real team members

                        </div>

                        <div class="task-item">

                            Shared communication

                        </div>

                        <div class="task-item">

                            File collaboration

                        </div>

                        <div class="task-item">

                            Real-time teamwork

                        </div>

                    </div>

                </div>

            </div>

            <div class="glass-card p-5 mt-5">

                <h3 class="mb-4">

                    Team Chat

                </h3>

                <div class="chat-box">

                    <%
                        if(messages != null){

                            for(TeamMessage msg : messages){

                                String image =
                                        msg.getProfilePicture();

                                if(image == null ||
                                   image.isEmpty()){

                                    image =
                                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
                                }
                    %>

                    <div class="glass-card p-4 mt-5">

                        <h3 class="mb-4">

                            Team Chat

                        </h3>

                        <div id="chatMessages"
                             style="
                             height:300px;
                             overflow-y:auto;
                             ">

                        </div>

                        <div class="input-group mt-4">

                            <input type="text"
                                   id="messageInput"
                                   class="form-control"
                                   placeholder="Write a message...">

                            <button class="btn btn-info"
                                    onclick="sendMessage()">

                                Send

                            </button>

                        </div>

                    </div>

                    <div class="glass-card p-5 mt-5 mb-5">

                        <h3 class="mb-4">

                            Project Resources

                        </h3>
                        <div class="glass-card p-5 mt-5 mb-5">

                            <h3 class="mb-4">

                                Shared Code Space

                            </h3>

                            <form action="addProjectCode"
                                  method="post">

                                <input type="hidden"
                                       name="projectId"
                                       value="<%= project.getId() %>">

                                <div class="mb-3">

                                    <input type="text"
                                           name="title"
                                           class="form-control"
                                           placeholder="Snippet title"
                                           required>

                                </div>

                                <div class="mb-3">

                                    <select name="language"
                                            class="form-select">

                                        <option>
                                            Java
                                        </option>

                                        <option>
                                            Python
                                        </option>

                                        <option>
                                            JavaScript
                                        </option>

                                        <option>
                                            SQL
                                        </option>

                                        <option>
                                            C++
                                        </option>

                                    </select>

                                </div>

                                <div class="mb-3">

                                    <textarea name="code"
                                              rows="10"
                                              class="form-control"
                                              placeholder="Paste code here..."
                                              required></textarea>

                                </div>

                                <button class="btn btn-info">

                                    Save Code

                                </button>

                            </form>

                            <hr class="my-5">

                            <%
                                if(codeList != null){

                                    for(ProjectCode code : codeList){
                            %>

                            <div class="task-item mb-4">

                                <div class="d-flex justify-content-between align-items-center mb-3">

                                    <div>

                                        <h5>

                                            <%= code.getTitle() %>

                                        </h5>

                                        <span class="badge bg-info">

                                            <%= code.getLanguage() %>

                                        </span>

                                    </div>

                                    <small class="text-secondary">

                                        <%= code.getCreatedAt() %>

                                    </small>

                                </div>

                                <pre style="
                                     background:#0f172a;
                                     color:#38bdf8;
                                     padding:20px;
                                     border-radius:16px;
                                     overflow:auto;
                                     "><code><%= code.getCode() %></code></pre>

                            </div>

                            <%
                                    }
                                }
                            %>

                        </div>

                        <form action="uploadProjectFile"
                              method="post"
                              enctype="multipart/form-data"
                              class="mb-4">

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

                        <div id="filesContainer">

                        <%
                            if(files != null){

                                for(ProjectFile file : files){
                        %>

                        <div class="task-item d-flex justify-content-between align-items-center">

                            <div>

                                <h6 class="mb-1">

                                    <%= file.getFileName() %>

                                </h6>

                                <small class="text-secondary">

                                    Uploaded resource

                                </small>

                            </div>

                            <span class="badge bg-info">

                                Uploaded

                            </span>

                        </div>

                        <%
                                }
                            }
                        %>

                        </div>

                    </div>

                    <div class="chat-message">

                        <div class="d-flex">

                            <img src="<%= image %>"
                                 class="member-avatar me-3"
                                 style="
                                 width:55px;
                                 height:55px;
                                 ">

                            <div>

                                <h6>

                                    <%= msg.getFullName() %>

                                </h6>

                                <p class="mb-1">

                                    <%= msg.getMessage() %>

                                </p>

                                <small class="text-secondary">

                                    <%= msg.getCreatedAt() %>

                                </small>

                            </div>

                        </div>

                    </div>

                    <%
                            }
                        }
                    %>

                </div>

                <div class="glass-card p-5 mt-5 mb-5">

                    <h3 class="mb-4">

                        Shared Code Space

                    </h3>

                    <form action="addProjectCode"
                          method="post">

                        <input type="hidden"
                               name="projectId"
                               value="<%= project.getId() %>">

                        <div class="mb-3">

                            <input type="text"
                                   name="title"
                                   class="form-control"
                                   placeholder="Snippet title"
                                   required>

                        </div>

                        <div class="mb-3">

                            <select name="language"
                                    class="form-select">

                                <option>
                                    Java
                                </option>

                                <option>
                                    Python
                                </option>

                                <option>
                                    JavaScript
                                </option>

                                <option>
                                    SQL
                                </option>

                                <option>
                                    C++
                                </option>

                            </select>

                        </div>

                        <div class="mb-3">

                            <textarea name="code"
                                      rows="10"
                                      class="form-control"
                                      placeholder="Paste code here..."
                                      required></textarea>

                        </div>

                        <button class="btn btn-info">

                            Save Code

                        </button>

                    </form>

                    <hr class="my-5">

                    <%
                        if(codeList != null){

                            for(ProjectCode code : codeList){
                    %>

                    <div class="task-item mb-4">

                        <div class="d-flex justify-content-between align-items-center mb-3">

                            <div>

                                <h5>

                                    <%= code.getTitle() %>

                                </h5>

                                <span class="badge bg-info">

                                    <%= code.getLanguage() %>

                                </span>

                            </div>

                            <small class="text-secondary">

                                <%= code.getCreatedAt() %>

                            </small>

                        </div>

                        <pre style="
                             background:#0f172a;
                             color:#38bdf8;
                             padding:20px;
                             border-radius:16px;
                             overflow:auto;
                             "><code><%= code.getCode() %></code></pre>

                    </div>

                    <%
                            }
                        }
                    %>

                </div>

                <form action="addTeamMessage"
                      method="post"
                      class="mt-4">

                    <input type="hidden"
                           name="projectId"
                           value="<%= project.getId() %>">

                    <div class="input-group">

                        <input type="text"
                               name="message"
                               class="form-control"
                               placeholder="Write a message..."
                               required>

                        <button class="btn btn-info">

                            Send

                        </button>

                    </div>

                </form>

            </div>

        </div>

    </div>

</div>

<script>

    new Chart(
        document.getElementById(
            "teamChart"
        ),
        {
            type: 'doughnut',

            data: {

                labels: [

                    'Completed',
                    'In Progress',
                    'Pending'

                ],

                datasets: [{

                    data: [
                        65,
                        25,
                        10
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

<script>

const projectId =
    <%= project.getId() %>;

const socket =
    new WebSocket(
        "ws://"
        + window.location.host
        + "/StudentTeamMatcher/teamChat/"
        + projectId
    );

    socket.onmessage = function(event){

        const chatBox =
            document.getElementById(
                "chatMessages"
            );

        chatBox.innerHTML +=
            `
            <div class="task-item">
                ${event.data}
            </div>
            `;
    };

    function sendMessage(){

        const input =
            document.getElementById(
                "messageInput"
            );

        if(input.value.trim() !== ""){

            socket.send(
                input.value
            );

            input.value = "";
        }
    }

</script>

<script>

    const fileSocket =
        new WebSocket(
            "ws://localhost:8080/StudentTeamMatcher/fileSync/"
            + projectId
        );

    fileSocket.onmessage = function(event){

        const filesContainer =
            document.getElementById(
                "filesContainer"
            );

        filesContainer.innerHTML =
            event.data
            +
            filesContainer.innerHTML;
    };

</script>

</body>

</html>