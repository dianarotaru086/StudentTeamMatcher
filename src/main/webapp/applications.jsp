<%@ page import="java.util.List" %>
<%@ page import="model.Application" %>

<%@ page contentType="text/html;charset=UTF-8"
         language="java" %>

<html>

<head>

    <title>
        Applications
    </title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body{

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

        .profile-img{

            width: 80px;

            height: 80px;

            border-radius: 50%;

            object-fit: cover;

            border:
                3px solid #38bdf8;
        }

    </style>

</head>

<body>

<div class="container py-5">

    <h1 class="mb-5 fw-bold">

        Project Applications

    </h1>

    <%
        List<Application> applications =
                (List<Application>)
                        request.getAttribute(
                                "applications"
                        );
    %>

    <%
        if(applications != null &&
           !applications.isEmpty()){

            for(Application app :
                    applications){

                String image =
                        app.getProfilePicture();

                if(image == null ||
                   image.isEmpty()){

                    image =
                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
                }
    %>

    <div class="glass-card p-4 mb-4">

        <div class="d-flex align-items-center">

            <img src="<%= image %>"
                 class="profile-img me-4">

            <div class="w-100">

                <div class="d-flex justify-content-between align-items-center">

                    <div>

                        <h3 class="mb-1">

                            <%= app.getFullName() %>

                        </h3>

                        <p class="mb-2 text-light">

                            <%= app.getEmail() %>

                        </p>

                    </div>

                    <span class="badge bg-success p-2">

                        <%= app.getCompatibilityScore() %>%
                        Match

                    </span>

                </div>

                <p class="mt-3">

                    <strong>
                        Skills:
                    </strong>

                    <%= app.getSkills() %>

                </p>

            </div>

        </div>

    </div>

    <%
            }

        } else {
    %>

    <div class="alert alert-light">

        No applications yet.

    </div>

    <%
        }
    %>

</div>

</body>

</html>