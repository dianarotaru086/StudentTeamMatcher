<%@ page import="model.User" %>

<%@ page contentType="text/html;charset=UTF-8"
         language="java" %>

<%
    User user =
            (User) session.getAttribute("user");

    if(user == null ||
       !user.getRole().equals("admin")){

        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>

<head>

    <title>Admin Panel</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="container mt-5">

<h1 class="mb-4">
    Admin Panel
</h1>

<div class="alert alert-danger">

    Administrator access only

</div>

<a href="dashboard"
   class="btn btn-dark">

    Back to Dashboard

</a>

</body>

</html>