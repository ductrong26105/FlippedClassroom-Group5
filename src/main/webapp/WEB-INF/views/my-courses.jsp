<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">
    <div class="container py-5">
        
        <!-- ===== PAGE HEADER ===== -->
        <div class="section-header mb-4">
            <div class="section-tag"><i class="fas fa-book-reader me-1"></i> Khóa học</div>
            <c:choose>
                <c:when test="${loggedInUser.role == 1}">
                    <h2>Khóa học <span>đang giảng dạy</span></h2>
                    <p>Quản lý danh sách các khóa học và lớp học do bạn làm giảng viên chủ nhiệm.</p>
                </c:when>
                <c:when test="${loggedInUser.role == 0}">
                    <h2>Tất cả <span>khóa học hệ thống</span></h2>
                    <p>Quản trị viên quản lý danh sách toàn bộ các khóa học đang hoạt động trên hệ thống.</p>
                </c:when>
                <c:otherwise>
                    <h2>Khóa học <span>của tôi</span></h2>
                    <p>Xem danh sách toàn bộ các lớp học và khóa học trực tuyến bạn đã đăng ký tham gia.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- ===== COURSES GRID ===== -->
        <div class="row g-4 mt-2">
            <c:choose>
                <c:when test="${not empty courses}">
                    <c:forEach var="course" items="${courses}">
                        <div class="col-lg-4 col-md-6">
                            <div class="course-card h-100 position-relative overflow-hidden d-flex flex-column" 
                                 onclick="location.href='${pageContext.request.contextPath}/learn/${course.classId}'"
                                 style="border-radius: var(--radius-lg); background: var(--bg-card); border: 1px solid var(--border); box-shadow: var(--shadow);">
                                
                                <!-- Card Thumbnail / Gradient Icon -->
                                <div class="card-thumb" style="width: 100%; aspect-ratio: 16/9; background: linear-gradient(135deg, #1e3a5f, #0f1f3a); display: flex; align-items: center; justify-content: center; position: relative;">
                                    <c:choose>
                                        <c:when test="${loggedInUser.role == 1}">
                                            <i class="fas fa-chalkboard-teacher" style="font-size: 3.5rem; color: rgba(255,255,255,0.25);"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-play-circle" style="font-size: 3.5rem; color: rgba(255,255,255,0.25);"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <!-- Joined Date Badge or Role Chip -->
                                    <span class="thumb-badge" style="position: absolute; top: 0.75rem; right: 0.75rem; background: rgba(0, 0, 0, 0.65); backdrop-filter: blur(8px); color: #fff; padding: 0.25rem 0.75rem; border-radius: 50px; font-size: 0.75rem; font-weight: 600;">
                                        <c:choose>
                                            <c:when test="${loggedInUser.role == 1}">Giảng dạy</c:when>
                                            <c:when test="${loggedInUser.role == 0}">Hệ thống</c:when>
                                            <c:otherwise>Đã tham gia</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                
                                <!-- Card Body -->
                                <div class="card-body p-4 d-flex flex-column flex-grow-1">
                                    <h3 class="card-title" style="font-size: 1.1rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.5rem; line-height: 1.45;">
                                        <c:out value="${course.className}"/>
                                    </h3>
                                    
                                    <p class="card-teacher mb-3" style="font-size: 0.85rem; color: var(--text-secondary); display: flex; align-items: center; gap: 0.5rem;">
                                        <i class="fas fa-chalkboard-teacher" style="color: var(--primary);"></i>
                                        Giảng viên: <strong><c:out value="${course.teacher.fullName}"/></strong>
                                    </p>
                                    
                                    <div class="d-flex align-items-center justify-content-between mt-auto pt-3" style="border-top: 1px solid var(--border);">
                                        <span class="card-invite" style="font-size: 0.8rem; color: var(--text-muted); background: var(--bg-surface); padding: 0.2rem 0.65rem; border-radius: 50px; border: 1px solid var(--border); font-family: monospace; font-weight: 600;">
                                            Mã: <c:out value="${course.inviteCode}"/>
                                        </span>
                                        
                                        <a href="${pageContext.request.contextPath}/learn/${course.classId}" 
                                           class="btn-primary-fl" 
                                           style="text-decoration: none; font-size: 0.8rem; padding: 0.45rem 1rem; border-radius: var(--radius);">
                                            <c:choose>
                                                <c:when test="${loggedInUser.role == 1}">Quản lý lớp <i class="fas fa-cog ms-1"></i></c:when>
                                                <c:otherwise>Vào học ngay <i class="fas fa-arrow-right ms-1"></i></c:otherwise>
                                            </c:choose>
                                            </a>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                
                <c:otherwise>
                    <!-- ===== EMPTY STATE ===== -->
                    <div class="col-12 text-center py-5">
                        <div class="empty-state-box mx-auto" style="max-width: 480px; padding: 3rem 1.5rem; background: var(--bg-card); border: 1.5px dashed var(--border); border-radius: var(--radius-lg);">
                            <div class="empty-icon-circle mb-4">
                                <i class="fas fa-book-open"></i>
                            </div>
                            <h3 style="font-size: 1.25rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.5rem;">
                                Bạn chưa tham gia lớp học nào!
                            </h3>
                            <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin-bottom: 1.75rem;">
                                FLearn có hàng trăm lớp học trực tuyến vô cùng hấp dẫn với mô hình lớp học đảo ngược, bài giảng sinh động và hệ thống trắc nghiệm thú vị đang chờ đón bạn.
                            </p>
                            <a href="${pageContext.request.contextPath}/courses" class="btn-primary-fl" style="text-decoration: none;">
                                <i class="fas fa-search me-2"></i> Khám phá khóa học ngay
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
    </div>
</div>

<%@ include file="layout/user-sidebar.jsp" %>
<%@ include file="layout/footer.jsp" %>

<!-- Custom styling for Empty State -->
<style>
    .empty-icon-circle {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: rgba(59, 130, 246, 0.1);
        color: var(--primary);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.2rem;
        margin: 0 auto;
        box-shadow: 0 8px 20px rgba(59, 130, 246, 0.15);
    }
</style>
