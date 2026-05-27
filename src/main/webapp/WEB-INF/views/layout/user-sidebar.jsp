<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    org.flearn.model.User currentUser =
        (org.flearn.model.User) session.getAttribute("loggedInUser");
%>

<% if (currentUser != null) { %>
<!-- ===== USER SIDEBAR MINI ===== -->
<div class="user-sidebar-mini" id="userSidebarMini">
    <!-- Dropdown menu -->
    <div class="user-sidebar-dropdown" id="userDropdown">
        <div style="padding:.5rem 1rem .75rem; border-bottom:1px solid var(--border); margin-bottom:.4rem;">
            <div style="font-weight:700; font-size:.9rem; color:var(--text-primary);">
                <%= currentUser.getFullName() != null && !currentUser.getFullName().isEmpty() ? currentUser.getFullName() : currentUser.getUsername() %>
            </div>
            <div style="font-size:.78rem; color:var(--text-muted); margin-top:.15rem;">
                <%= currentUser.getEmail() %>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/profile" class="dropdown-item-fl">
            <i class="fas fa-user-circle"></i> Trang cá nhân
        </a>
        <a href="${pageContext.request.contextPath}/profile/edit" class="dropdown-item-fl">
            <i class="fas fa-cog"></i> Thông tin cá nhân
        </a>
        <a href="${pageContext.request.contextPath}/my-courses" class="dropdown-item-fl">
            <i class="fas fa-book-reader"></i> Khóa học của tôi
        </a>
        <a href="${pageContext.request.contextPath}/certificates" class="dropdown-item-fl">
            <i class="fas fa-certificate"></i> Kho chứng chỉ
        </a>
        <div class="dropdown-item-fl" style="cursor:default;">
            <i class="fas fa-star" style="color:var(--warning);"></i>
            Điểm thưởng
            <span class="bonus-chip">0 pts</span>
        </div>

        <div class="dropdown-divider-fl"></div>

        <!-- Dark mode toggle in dropdown -->
        <div class="dropdown-item-fl" onclick="toggleTheme()" style="cursor:pointer;">
            <i class="fas fa-moon" id="dropdownThemeIcon"></i>
            <span id="dropdownThemeLabel">Chế độ tối</span>
            <div style="margin-left:auto;">
                <div class="toggle-track" style="display:inline-block;">
                    <div class="toggle-thumb"></div>
                </div>
            </div>
        </div>

        <div class="dropdown-divider-fl"></div>

        <a href="${pageContext.request.contextPath}/login?action=logout" class="dropdown-item-fl"
           style="color:var(--danger);">
            <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </a>
    </div>

    <!-- Mini card trigger -->
    <div class="user-mini-card" id="userMiniCard" onclick="toggleUserDropdown()">
        <div class="avatar">
            <%= currentUser.getFullName() != null && !currentUser.getFullName().isEmpty() ? currentUser.getFullName().substring(0,1).toUpperCase() : "U" %>
        </div>
        <div class="user-info">
            <div class="user-name"><%= currentUser.getFullName() != null && !currentUser.getFullName().isEmpty() ? currentUser.getFullName() : currentUser.getUsername() %></div>
            <div class="user-role">
                <%
                    String roleLabel = "Học viên";
                    if (currentUser.getRole() == 0) roleLabel = "Quản trị viên";
                    else if (currentUser.getRole() == 1) roleLabel = "Giảng viên";
                    out.print(roleLabel);
                %>
            </div>
        </div>
        <i class="fas fa-chevron-up" style="color:var(--text-muted); font-size:.7rem;" id="userChevron"></i>
    </div>
</div>
<% } %>
