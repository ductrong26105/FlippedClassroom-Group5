<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${not empty pageTitle ? pageTitle : 'FLearn — Hệ thống Học tập Chủ động'}</title>
    <meta name="description" content="FLearn — Hệ thống học tập chủ động giúp sinh viên tự học hiệu quả, giảng viên nắm bắt tiến trình, và tối ưu thời gian trên lớp."/>
    <meta name="keywords" content="FLearn, Active Learning, Flipped Classroom, E-Learning, Java Servlet"/>
    <meta name="author" content="FLearn Team"/>

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet"/>
    <!-- Prism.js for syntax highlighting -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/themes/prism-tomorrow.min.css"/>
    <!-- Landing CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css"/>
</head>
<body>

<!-- ===== NAVBAR ===== -->
<nav class="landing-navbar" id="landingNavbar">
    <div class="container">
        <div class="d-flex align-items-center justify-content-between w-100">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/landing">
                <i class="fas fa-graduation-cap me-2"></i>FLearn<span class="brand-dot"></span>
            </a>

            <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="collapse" data-bs-target="#landingNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="landingNav">
                <ul class="navbar-nav align-items-center gap-1" style="list-style:none; display:flex; margin:0; padding:0;">
                    <li class="nav-item">
                        <a class="nav-link ${activePage == 'landing-home' ? 'active' : ''}" href="${pageContext.request.contextPath}/landing">
                            <i class="fas fa-home me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activePage == 'landing-problem' ? 'active' : ''}" href="${pageContext.request.contextPath}/landing/problem">
                            <i class="fas fa-exclamation-triangle me-1"></i>Vấn đề
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activePage == 'landing-solution' ? 'active' : ''}" href="${pageContext.request.contextPath}/landing/solution">
                            <i class="fas fa-lightbulb me-1"></i>Giải pháp
                        </a>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="btn-glow" href="${pageContext.request.contextPath}/home" style="text-decoration:none; font-size:0.88rem; padding:0.55rem 1.3rem;">
                            <i class="fas fa-rocket"></i> Vào hệ thống
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>
