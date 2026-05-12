<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>

    <title>
        Student Team Matcher
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

            color: white;

            overflow-x: hidden;
        }

        .navbar{

            background:
                    rgba(255,255,255,0.05);

            backdrop-filter: blur(10px);
        }

        .hero{

            min-height: 100vh;

            display: flex;

            align-items: center;
        }

        .hero-title{

            font-size: 4rem;

            font-weight: 700;
        }

        .hero-subtitle{

            font-size: 1.3rem;

            color: #cbd5e1;
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

        .feature-icon{

            font-size: 2.5rem;

            margin-bottom: 20px;

            color: #38bdf8;
        }

        .btn-custom{

            padding: 12px 28px;

            border-radius: 12px;

            font-weight: 500;
        }

        .stats-card{

            text-align: center;

            padding: 30px;
        }

        .stats-number{

            font-size: 2.5rem;

            font-weight: 700;
        }

        .section-title{

            font-size: 2.5rem;

            font-weight: 700;

            margin-bottom: 50px;
        }

        footer{

            background:
                    rgba(255,255,255,0.05);

            padding: 30px;

            text-align: center;

            margin-top: 100px;
        }

        @media(max-width: 768px){

            .hero-title{

                font-size: 2.5rem;
            }

            .hero{

                text-align: center;
            }
        }
        @media(max-width: 768px){

            .hero{

                padding-top: 120px;

                text-align: center;
            }

            .hero-title{

                font-size: 2.5rem;
            }

            .hero-subtitle{

                font-size: 1rem;
            }

            .btn-custom{

                width: 100%;

                margin-bottom: 15px;
            }

            .navbar{

                padding: 15px;
            }

            .section-title{

                font-size: 2rem;
            }

            .stats-number{

                font-size: 2rem;
            }
        }

    </style>

</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">

    <div class="container">

        <a class="navbar-brand fw-bold"
           href="#">

            Student Team Matcher

        </a>

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse"
             id="navbarNav">

            <ul class="navbar-nav ms-auto">

                <li class="nav-item">

                    <a class="nav-link"
                       href="#features">

                        Features

                    </a>

                </li>

                <li class="nav-item">

                    <a class="nav-link"
                       href="#stats">

                        Statistics

                    </a>

                </li>

                <li class="nav-item">

                    <a class="btn btn-outline-light ms-3"
                       href="login.jsp">

                        Login

                    </a>

                </li>

                <li class="nav-item">

                    <a class="btn btn-info ms-2"
                       href="register.jsp">

                        Register

                    </a>

                </li>

            </ul>

        </div>

    </div>

</nav>

<section class="hero">

    <div class="container">

        <div class="row align-items-center">

            <div class="col-lg-6">

                <h1 class="hero-title">

                    Build Better
                    Student Teams

                </h1>

                <p class="hero-subtitle mt-4">

                    AI-powered collaboration platform
                    for students, projects and academic teams.

                </p>

                <div class="mt-5">

                    <a href="register.jsp"
                       class="btn btn-info btn-custom">

                        Get Started

                    </a>

                    <a href="login.jsp"
                       class="btn btn-outline-light btn-custom ms-3">

                        Explore Platform

                    </a>

                </div>

            </div>

            <div class="col-lg-6 text-center">

                <img src="https://cdn-icons-png.flaticon.com/512/2620/2620971.png"
                     class="img-fluid"
                     width="400">

            </div>

        </div>

    </div>

</section>

<section id="features"
         class="py-5">

    <div class="container">

        <h2 class="section-title text-center">

            Platform Features

        </h2>

        <div class="row g-4">

            <div class="col-md-3">

                <div class="glass-card p-4 h-100 text-center">

                    <i class="bi bi-people-fill feature-icon"></i>

                    <h4>

                        Smart Matching

                    </h4>

                    <p>

                        Match students based on
                        skills and compatibility.

                    </p>

                </div>

            </div>

            <div class="col-md-3">

                <div class="glass-card p-4 h-100 text-center">

                    <i class="bi bi-bar-chart-fill feature-icon"></i>

                    <h4>

                        Analytics

                    </h4>

                    <p>

                        Visualize workload,
                        projects and progress.

                    </p>

                </div>

            </div>

            <div class="col-md-3">

                <div class="glass-card p-4 h-100 text-center">

                    <i class="bi bi-calendar-event-fill feature-icon"></i>

                    <h4>

                        Scheduling

                    </h4>

                    <p>

                        Organize deadlines,
                        meetings and tasks.

                    </p>

                </div>

            </div>

            <div class="col-md-3">

                <div class="glass-card p-4 h-100 text-center">

                    <i class="bi bi-diagram-3-fill feature-icon"></i>

                    <h4>

                        Team Workspace

                    </h4>

                    <p>

                        Collaborate inside
                        organized student teams.

                    </p>

                </div>

            </div>

        </div>

    </div>

</section>

<section id="stats"
         class="py-5">

    <div class="container">

        <h2 class="section-title text-center">

            Platform Statistics

        </h2>

        <div class="row g-4">

            <div class="col-md-4">

                <div class="glass-card stats-card">

                    <div class="stats-number">

                        250+

                    </div>

                    <p>

                        Active Students

                    </p>

                </div>

            </div>

            <div class="col-md-4">

                <div class="glass-card stats-card">

                    <div class="stats-number">

                        120+

                    </div>

                    <p>

                        Projects Created

                    </p>

                </div>

            </div>

            <div class="col-md-4">

                <div class="glass-card stats-card">

                    <div class="stats-number">

                        80+

                    </div>

                    <p>

                        Skills Tracked

                    </p>

                </div>

            </div>

        </div>

    </div>

</section>

<footer>

    <h5>

        Student Team Matcher

    </h5>

    <p>

        Intelligent Academic Collaboration Platform

    </p>

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>