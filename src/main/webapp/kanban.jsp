<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Task" %>

<%
    List<Task> tasks =
            (List<Task>)
            request.getAttribute(
                    "tasks"
            );
%>

<html>

<head>

    <title>
        Kanban Board
    </title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.2/Sortable.min.js"></script>

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

        .board-column{

            background:
                rgba(255,255,255,0.05);

            border:
                1px solid rgba(255,255,255,0.1);

            border-radius: 20px;

            padding: 20px;

            min-height: 700px;
        }

        .task-card{

            background:
                rgba(255,255,255,0.08);

            border:
                1px solid rgba(255,255,255,0.08);

            border-radius: 18px;

            padding: 20px;

            margin-bottom: 20px;

            transition: 0.3s;

            cursor: grab;
        }

        .task-card:hover{

            transform:
                translateY(-5px);

            box-shadow:
                0 15px 35px rgba(0,0,0,0.3);
        }

        .priority-high{

            border-left:
                6px solid #ef4444;
        }

        .priority-medium{

            border-left:
                6px solid #facc15;
        }

        .priority-low{

            border-left:
                6px solid #22c55e;
        }

        .member{

            width: 40px;

            height: 40px;

            border-radius: 50%;

            border:
                2px solid white;

            object-fit: cover;
        }

        .column-title{

            font-weight: 700;

            margin-bottom: 25px;
        }

        .add-task-btn{

            width: 100%;

            border-radius: 14px;
        }

        .sortable-ghost{

            opacity: 0.4;
        }

        .sortable-drag{

            transform: rotate(3deg);

            cursor: grabbing;
        }

        .board-column{

            transition: 0.3s;
        }

        .board-column.drag-over{

            background:
                rgba(56,189,248,0.08);

            border:
                2px dashed #38bdf8;
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

                Kanban Board

            </a>

            <a href="myProjects"
               class="sidebar-link">

                <i class="bi bi-people-fill"></i>

                Team Workspace

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

                <div>

                    <h1>

                        Project Kanban Board

                    </h1>

                    <p class="text-light">

                        Organize tasks and workflow visually.

                    </p>

                </div>


                <button class="btn btn-info px-4"
                        data-bs-toggle="modal"
                        data-bs-target="#taskModal">

                    <i class="bi bi-plus-circle-fill"></i>

                    New Task

                </button>


            </div>

            <div class="row g-4">

                <div class="col-lg-4">
                <div class="board-column todo-column">

                    <div class="d-flex justify-content-between align-items-center">

                        <h4 class="column-title">

                            To Do

                        </h4>

                    </div>

                    <%
                        for(Task task : tasks){

                            if(task.getStatus()
                                    .equals("todo")){
                    %>

                    <div class="task-card priority-<%= task.getPriority() %>"
                         data-task-id="<%= task.getId() %>">

                        <div class="d-flex justify-content-between align-items-start">

                            <h5>

                                <%= task.getTitle() %>

                            </h5>

                            <a href="deleteTask?id=<%= task.getId() %>"
                               class="btn btn-sm btn-danger">

                                <i class="bi bi-trash-fill"></i>

                            </a>

                            <span class="badge bg-danger">

                                <%= task.getPriority() %>

                            </span>

                        </div>

                        <p class="mt-3 text-light">

                            <%= task.getDescription() %>

                        </p>

                        <div class="d-flex justify-content-between align-items-center mt-4">

                            <small>

                                Deadline:
                                <%= task.getDeadline() %>

                            </small>

                        </div>

                    </div>

                    <%
                            }
                        }
                    %>

                </div>

                </div>

                <div class="col-lg-4">

                   <div class="board-column progress-column">

                       <div class="d-flex justify-content-between align-items-center">

                           <h4 class="column-title">

                               In Progress

                           </h4>

                       </div>

                       <%
                           for(Task task : tasks){

                               if(task.getStatus()
                                       .equals("progress")){
                       %>

                       <div class="task-card priority-<%= task.getPriority() %>">

                           <div class="d-flex justify-content-between">

                               <h5>

                                   <%= task.getTitle() %>

                               </h5>

                               <span class="badge bg-warning text-dark">

                                   <%= task.getPriority() %>

                               </span>

                           </div>

                           <p class="mt-3 text-light">

                               <%= task.getDescription() %>

                           </p>

                           <div class="d-flex justify-content-between align-items-center mt-4">

                               <small>

                                   Deadline:
                                   <%= task.getDeadline() %>

                               </small>

                           </div>

                       </div>

                       <%
                               }
                           }
                       %>

                   </div>

                </div>

                <div class="col-lg-4">

                  <div class="board-column done-column">

                      <div class="d-flex justify-content-between align-items-center">

                          <h4 class="column-title">

                              Done

                          </h4>

                      </div>

                      <%
                          for(Task task : tasks){

                              if(task.getStatus()
                                      .equals("done")){
                      %>

                      <div class="task-card priority-<%= task.getPriority() %>">

                          <div class="d-flex justify-content-between">

                              <h5>

                                  <%= task.getTitle() %>

                              </h5>

                              <span class="badge bg-success">

                                  <%= task.getPriority() %>

                              </span>

                          </div>

                          <p class="mt-3 text-light">

                              <%= task.getDescription() %>

                          </p>

                          <div class="d-flex justify-content-between align-items-center mt-4">

                              <small>

                                  Deadline:
                                  <%= task.getDeadline() %>

                              </small>

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

    </div>

</div>


<div class="modal fade"
     id="taskModal"
     tabindex="-1">

    <div class="modal-dialog">

        <div class="modal-content bg-dark text-white">

            <div class="modal-header border-secondary">

                <h5 class="modal-title">

                    Create Task

                </h5>

                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal">

                </button>

            </div>

            <form action="createTask"
                  method="post">

                  <input type="hidden"
                         name="projectId"
                         value="<%= request.getParameter("projectId") %>">

                <div class="modal-body">

                    <div class="mb-3">

                        <label class="form-label">

                            Title

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
                                  class="form-control">

                        </textarea>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">

                            Priority

                        </label>

                        <select name="priority"
                                class="form-select">

                            <option value="high">

                                High

                            </option>

                            <option value="medium">

                                Medium

                            </option>

                            <option value="low">

                                Low

                            </option>

                        </select>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">

                            Deadline

                        </label>

                        <input type="date"
                               name="deadline"
                               class="form-control">

                    </div>

                </div>

                <div class="modal-footer border-secondary">

                    <button class="btn btn-info">

                        Create Task

                    </button>

                </div>

            </form>

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

<script>

    function initializeSortable(
            column,
            status){

        new Sortable(
            column,
            {
                group: 'shared',

                animation: 250,

                ghostClass:
                    'sortable-ghost',

                dragClass:
                    'sortable-drag',

                onAdd: function(event){

                    let taskId =
                        event.item.dataset.taskId;

                    fetch(
                        "updateTaskStatus",
                        {
                            method: "POST",

                            headers: {
                                "Content-Type":
                                "application/x-www-form-urlencoded"
                            },

                            body:
                                "taskId="
                                + taskId
                                + "&status="
                                + status
                        }
                    );
                }
            }
        );
    }

    initializeSortable(
        document.querySelector(
            ".todo-column"
        ),
        "todo"
    );

    initializeSortable(
        document.querySelector(
            ".progress-column"
        ),
        "progress"
    );

    initializeSortable(
        document.querySelector(
            ".done-column"
        ),
        "done"
    );

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>