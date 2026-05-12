<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>

    <title>
        Login
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
        }

        .login-card{

            width: 100%;

            max-width: 450px;

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

        .form-control{

            background:
                    rgba(255,255,255,0.08);

            border: none;

            color: white;

            padding: 14px;

            border-radius: 12px;
        }

        .form-control:focus{

            background:
                    rgba(255,255,255,0.12);

            color: white;

            box-shadow: none;
        }

        .form-control::placeholder{

            color: #cbd5e1;
        }

        .btn-login{

            width: 100%;

            padding: 14px;

            border-radius: 12px;

            font-weight: 600;
        }

        .logo{

            font-size: 3rem;

            color: #38bdf8;
        }

        a{

            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="login-card">

    <div class="text-center mb-4">

        <i class="bi bi-mortarboard-fill logo"></i>

        <h2 class="mt-3">

            Welcome Back

        </h2>

        <p class="text-light">

            Login to continue
            your collaboration journey.

        </p>

    </div>

    <form action="login"
          method="post">

        <div class="mb-3">

            <label class="form-label">

                Email

            </label>

            <input type="email"
                   name="email"
                   class="form-control"
                   placeholder="Enter your email"
                   required>

        </div>

        <div class="mb-4">

            <label class="form-label">

                Password

            </label>

            <input type="password"
                   name="password"
                   class="form-control"
                   placeholder="Enter your password"
                   required>

        </div>

        <button type="submit"
                class="btn btn-info btn-login">

            Login

        </button>

    </form>

    <div class="text-center mt-4">

        <p>

            Don't have an account?

            <a href="register.jsp"
               class="text-info">

                Create one

            </a>

        </p>

    </div>

</div>

</body>

</html>