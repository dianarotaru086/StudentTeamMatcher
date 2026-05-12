<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.CalendarDAO" %>
<%@ page import="model.CalendarEvent" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>

<%
    User user =
            (User) session.getAttribute(
                    "user"
            );

    if(user == null){

        response.sendRedirect(
                "login.jsp"
        );

        return;
    }
%>

<%
    CalendarDAO calendarDAO =
            new CalendarDAO();

    List<CalendarEvent> events =
            calendarDAO.getEventsByUser(
                    user.getId()
            );
%>

<html>

<head>
<meta name="viewport"
      content="width=device-width, initial-scale=1">

    <title>
        Schedule
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

        .task-card{

            border-left: 6px solid #38bdf8;
        }

        .form-control,
        .form-select{

            background:
                rgba(255,255,255,0.08);

            border: none;

            color: white;

            padding: 12px;

            border-radius: 12px;
        }

        .form-select option{

            color: black;
        }
        .calendar-grid{

            display: grid;

            grid-template-columns:
                repeat(7, 1fr);

            gap: 15px;
        }

        .calendar-day-name{

            text-align: center;

            font-weight: 600;

            color: #cbd5e1;
        }

        .calendar-day{

            background:
                rgba(255,255,255,0.05);

            border:
                1px solid rgba(255,255,255,0.08);

            border-radius: 16px;

            min-height: 110px;

            padding: 12px;

            font-weight: 600;

            transition: 0.3s;

            display: flex;

            flex-direction: column;

            justify-content: space-between;
        }

        .calendar-day:hover{

            transform:
                translateY(-4px);

            background:
                rgba(255,255,255,0.1);
        }

        .current-day{

            border:
                2px solid #38bdf8;
        }

        .event-high{

            border-left:
                6px solid #ef4444;
        }

        .event-medium{

            border-left:
                6px solid #facc15;
        }

        .event-low{

            border-left:
                6px solid #22c55e;
        }

        .calendar-day small{

            color: #cbd5e1;
        }

        @media(max-width: 768px){

            .calendar-grid{

                grid-template-columns:
                    repeat(2, 1fr);
            }

            .calendar-day{

                min-height: 90px;
            }
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
        .task-item{

            background:
                rgba(255,255,255,0.05);

            border:
                1px solid rgba(255,255,255,0.08);

            border-radius: 16px;

            padding: 20px;

            transition: 0.3s;
        }

        .task-item:hover{

            transform:
                translateY(-3px);

            background:
                rgba(255,255,255,0.1);
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

            <a href="logout"
               class="sidebar-link text-danger">

                <i class="bi bi-box-arrow-right"></i>

                Logout

            </a>

        </div>

        <div class="col-lg-10 p-5">

            <div class="d-flex justify-content-between align-items-center mb-5">

                <h1>

                    Schedule Planner

                </h1>

                <button class="btn btn-info"
                        data-bs-toggle="modal"
                        data-bs-target="#taskModal">

                    <i class="bi bi-plus-circle-fill"></i>

                    Add Event

                </button>

            </div>

                <div class="glass-card p-5 mb-5">

                    <div class="d-flex justify-content-between align-items-center mb-4">

                        <h3>

                            My Schedule

                        </h3>

                        <span class="badge bg-info">

                            <%= events.size() %> Events

                        </span>

                    </div>

                    <form action="createEvent"
                          method="post"
                          class="mb-5">

                        <div class="row g-3">

                            <div class="col-md-4">

                                <input type="text"
                                       name="title"
                                       class="form-control"
                                       placeholder="Event title"
                                       required>

                            </div>

                            <div class="col-md-4">

                                <input type="text"
                                       name="description"
                                       class="form-control"
                                       placeholder="Description">

                            </div>

                            <div class="col-md-3">

                                <input type="date"
                                       name="eventDate"
                                       class="form-control"
                                       required>

                            </div>

                            <div class="col-md-1">

                                <button class="btn btn-info w-100">

                                    +

                                </button>

                            </div>

                        </div>

                    </form>

                    <%
                        for(CalendarEvent event : events){
                    %>

                    <div class="task-item mb-3">

                        <div class="d-flex justify-content-between align-items-center">

                            <div>

                                <h5 class="mb-1">

                                    <%= event.getTitle() %>

                                </h5>

                                <p class="mb-1 text-light">

                                    <%= event.getDescription() %>

                                </p>

                            </div>

                            <span class="badge bg-warning text-dark">

                                <%= event.getEventDate() %>

                            </span>

                        </div>

                    </div>

                    <%
                        }
                    %>

                </div>
        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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