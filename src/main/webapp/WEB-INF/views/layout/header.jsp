<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String activePage = (String) request.getAttribute("activePage");
    if (activePage == null) activePage = "";
    org.flearn.model.User loggedInUser =
        (org.flearn.model.User) session.getAttribute("loggedInUser");
%>
<!DOCTYPE html>
<html lang="vi" data-theme="light">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${not empty pageTitle ? pageTitle : 'FLearn - Nền tảng học trực tuyến'}</title>
    <meta name="description" content="FLearn - Nền tảng học trực tuyến hiện đại với lớp học đảo ngược, video tương tác và quiz thông minh."/>

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <!-- FLearn CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"/>
</head>
<body>

<!-- ===== NAVBAR ===== -->
<nav class="flearn-navbar" id="mainNavbar">
    <a href="${pageContext.request.contextPath}/home" class="brand">
        <i class="fas fa-graduation-cap"></i> FLearn
    </a>

    <div class="search-box">
        <i class="fas fa-search search-icon"></i>
        <input type="text" id="globalSearch" placeholder="Tìm kiếm khóa học hoặc người dùng..." autocomplete="off"/>
    </div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home"
           class="<%= "home".equals(activePage) ? "active" : "" %>">
            <i class="fas fa-home me-1"></i>Trang chủ
        </a>
        <a href="${pageContext.request.contextPath}/courses"
           class="<%= "courses".equals(activePage) ? "active" : "" %>">
            <i class="fas fa-book-open me-1"></i>Khóa học
        </a>
        <a href="${pageContext.request.contextPath}/landing" class="nav-link">
            <i class="fas fa-rocket me-1"></i>Giới thiệu
        </a>
        <% if (loggedInUser != null && loggedInUser.getRole() == 1) { %>
        <a href="${pageContext.request.contextPath}/teacher/dashboard"
           class="<%= "teacher".equals(activePage) ? "active" : "" %>">
            <i class="fas fa-chalkboard-teacher me-1"></i>Studio
        </a>
        <% } %>
        <% if (loggedInUser != null && loggedInUser.getRole() == 0) { %>
        <a href="${pageContext.request.contextPath}/admin/panel"
           class="<%= "admin".equals(activePage) ? "active" : "" %>">
            <i class="fas fa-shield-alt me-1"></i>Admin
        </a>
        <% } %>
    </div>

    <div class="nav-actions">
        <!-- Dark mode toggle -->
        <button class="theme-toggle" id="themeToggle" title="Chuyển chế độ">
            <i class="fas fa-moon" id="themeIcon"></i>
            <span class="toggle-track"><span class="toggle-thumb"></span></span>
        </button>

        <% if (loggedInUser == null) { %>
        <a href="${pageContext.request.contextPath}/login" class="btn-primary-fl" style="text-decoration:none;">
            <i class="fas fa-sign-in-alt"></i> Đăng nhập
        </a>
        <% } else { %>
        <a href="${pageContext.request.contextPath}/login?action=logout" class="btn-outline-fl" style="text-decoration:none;">
            <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </a>
        <% } %>
    </div>
</nav>
