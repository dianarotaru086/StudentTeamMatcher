<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>

    <title>
        Register
    </title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

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

            min-height: 100vh;

            display: flex;

            justify-content: center;

            align-items: center;

            color: white;

            padding: 40px 15px;
        }

        .register-card{

            width: 100%;

            max-width: 650px;

            background:
                    rgba(255,255,255,0.08);

            border:
                    1px solid rgba(255,255,255,0.1);

            backdrop-filter: blur(12px);

            border-radius: 24px;

            padding: 40px;

            box-shadow:
                    0 10px 40px rgba(0,0,0,0.3);
        }

        .form-control,
        .form-select{

            background:
                    rgba(255,255,255,0.08);

            border: none;

            color: white;

            padding: 14px;

            border-radius: 12px;
        }

        .form-control:focus,
        .form-select:focus{

            background:
                    rgba(255,255,255,0.12);

            color: white;

            box-shadow: none;
        }

        .form-control::placeholder{

            color: #cbd5e1;
        }

        .btn-register{

            width: 100%;

            padding: 14px;

            border-radius: 12px;

            font-weight: 600;
        }

        .logo{

            font-size: 3rem;

            color: #38bdf8;
        }

        .form-select option{

            color: black;
        }

        a{

            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="register-card">

    <div class="text-center mb-4">

        <i class="bi bi-person-plus-fill logo"></i>

        <h2 class="mt-3">

            Create Account

        </h2>

        <p class="text-light">

            Join the academic collaboration ecosystem.

        </p>

    </div>

    <form action="register"
          method="post">

        <div class="row">

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Full Name

                </label>

                <input type="text"
                       name="fullName"
                       class="form-control"
                       placeholder="Enter full name"
                       required>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Email

                </label>

                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="Enter email"
                       required>

            </div>

        </div>

        <div class="row">

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Password

                </label>

                <input type="password"
                       name="password"
                       class="form-control"
                       placeholder="Enter password"
                       required>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Work Style

                </label>

                <select name="workStyle"
                        class="form-select">

                    <option value="Remote">

                        Remote

                    </option>

                    <option value="Hybrid">

                        Hybrid

                    </option>

                    <option value="On-site">

                        On-site

                    </option>

                </select>

            </div>

        </div>

        <div class="mb-3">

            <label class="form-label">

                Skills

            </label>

            <input type="text"
                   name="skills"
                   class="form-control"
                   placeholder="Java, Spring, React, MySQL..."
                   required>

        </div>

        <div class="mb-3">

            <label class="form-label">

                Weekly Availability

            </label>

            <select class="form-select"
                    name="availability">

                <option>

                    5 hours / week

                </option>

                <option>

                    10 hours / week

                </option>

                <option>

                    20 hours / week

                </option>

                <option>

                    30+ hours / week

                </option>

            </select>

        </div>

        <div class="mb-4">

            <label class="form-label">

                Account Type

            </label>

            <select name="role"
                    class="form-select">

                <option value="student">

                    Student

                </option>

                <option value="admin">

                    Admin

                </option>

            </select>

        </div>

        <button type="submit"
                class="btn btn-info btn-register">

            Create Account

        </button>

    </form>

    <div class="text-center mt-4">

        <p>

            Already have an account?

            <a href="login.jsp"
               class="text-info">

                Login

            </a>

        </p>

    </div>

</div>

</body>

</html>