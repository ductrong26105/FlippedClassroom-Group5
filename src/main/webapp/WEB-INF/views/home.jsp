<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">

    <!-- ===== HERO SECTION ===== -->
    <section class="hero-section">
        <div class="hero-glow"></div>
        <div class="hero-glow-2"></div>
        <div class="container-fl" style="position:relative;z-index:1;">
            <div class="row align-items-center g-5">
                <div class="col-lg-7">
                    <div class="hero-content">
                        <div class="hero-badge">
                            <i class="fas fa-bolt"></i>
                            Lớp học đảo ngược · Học linh hoạt · Tương tác thực tế
                        </div>
                        <h1>
                            Nền tảng học tập<br/>
                            <span>thế hệ mới</span><br/>
                            cho mọi người
                        </h1>
                        <p>
                            FLearn áp dụng mô hình Flipped Classroom — học video trước, thực hành tại lớp.
                            Quiz tương tác bật ra ngay trong video, giúp bạn nắm chắc kiến thức.
                        </p>
                        <div class="d-flex gap-3 flex-wrap">
                            <a href="${pageContext.request.contextPath}/courses" class="btn-primary-fl" style="text-decoration:none;font-size:1rem;padding:.8rem 1.8rem;">
                                <i class="fas fa-rocket"></i> Khám phá khóa học
                            </a>
                            <a href="${pageContext.request.contextPath}/login" class="btn-outline-fl" style="text-decoration:none;font-size:1rem;padding:.8rem 1.8rem;color:#fff;border-color:rgba(255,255,255,.4);"
                               onmouseover="this.style.background='rgba(255,255,255,.1)'"
                               onmouseout="this.style.background='transparent'">
                                <i class="fas fa-play-circle"></i> Bắt đầu ngay
                            </a>
                        </div>
                        <div class="hero-stats">
                            <div class="stat-item">
                                <span class="stat-number" id="counterStudents">0</span>
                                <span class="stat-label">Học viên</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number" id="counterCourses">0</span>
                                <span class="stat-label">Khóa học</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number" id="counterTeachers">0</span>
                                <span class="stat-label">Giảng viên</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 d-none d-lg-block">
                    <!-- Animated feature cards -->
                    <div style="position:relative;height:380px;">
                        <div class="fl-card" style="position:absolute;top:0;right:0;width:260px;animation:float 3s ease-in-out infinite;">
                            <div style="display:flex;align-items:center;gap:.75rem;margin-bottom:.75rem;">
                                <div style="width:40px;height:40px;border-radius:10px;background:linear-gradient(135deg,var(--primary),var(--accent));display:flex;align-items:center;justify-content:center;color:#fff;">
                                    <i class="fas fa-video"></i>
                                </div>
                                <div>
                                    <div style="font-weight:700;font-size:.88rem;color:var(--text-primary);">Video tương tác</div>
                                    <div style="font-size:.75rem;color:var(--text-muted);">Quiz xuất hiện trong video</div>
                                </div>
                            </div>
                            <div class="progress-bar-fl"><div class="progress-fill" style="width:72%;"></div></div>
                            <div style="font-size:.75rem;color:var(--text-muted);margin-top:.4rem;">72% hoàn thành</div>
                        </div>
                        <div class="fl-card" style="position:absolute;bottom:40px;left:0;width:240px;animation:float 3s ease-in-out infinite;animation-delay:.8s;">
                            <div style="display:flex;align-items:center;gap:.6rem;margin-bottom:.5rem;">
                                <i class="fas fa-star" style="color:var(--warning);"></i>
                                <span style="font-weight:700;font-size:.88rem;color:var(--text-primary);">+50 điểm thưởng!</span>
                            </div>
                            <div style="font-size:.78rem;color:var(--text-muted);">Trả lời đúng câu hỏi bonus</div>
                        </div>
                        <div class="fl-card" style="position:absolute;top:160px;left:20px;width:200px;animation:float 3s ease-in-out infinite;animation-delay:1.5s;">
                            <div style="display:flex;align-items:center;gap:.6rem;">
                                <div class="live-dot"></div>
                                <span style="font-weight:700;font-size:.85rem;color:var(--danger);">Live Session</span>
                            </div>
                            <div style="font-size:.75rem;color:var(--text-muted);margin-top:.3rem;">12 học viên đang học</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== FEATURES SECTION ===== -->
    <section class="content-section">
        <div class="container-fl">
            <div class="row g-4">
                <div class="col-md-3 col-6">
                    <div class="fl-card text-center" style="padding:1.75rem 1rem;">
                        <div style="width:56px;height:56px;border-radius:var(--radius-lg);background:rgba(59,130,246,.1);display:flex;align-items:center;justify-content:center;margin:0 auto .9rem;font-size:1.5rem;color:var(--primary);">
                            <i class="fas fa-film"></i>
                        </div>
                        <div style="font-weight:700;font-size:.95rem;color:var(--text-primary);">Video bài giảng</div>
                        <div style="font-size:.8rem;color:var(--text-muted);margin-top:.3rem;">Xem bất kỳ lúc nào</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="fl-card text-center" style="padding:1.75rem 1rem;">
                        <div style="width:56px;height:56px;border-radius:var(--radius-lg);background:rgba(139,92,246,.1);display:flex;align-items:center;justify-content:center;margin:0 auto .9rem;font-size:1.5rem;color:var(--accent);">
                            <i class="fas fa-question-circle"></i>
                        </div>
                        <div style="font-weight:700;font-size:.95rem;color:var(--text-primary);">Quiz tương tác</div>
                        <div style="font-size:.8rem;color:var(--text-muted);margin-top:.3rem;">Bật trong video</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="fl-card text-center" style="padding:1.75rem 1rem;">
                        <div style="width:56px;height:56px;border-radius:var(--radius-lg);background:rgba(16,185,129,.1);display:flex;align-items:center;justify-content:center;margin:0 auto .9rem;font-size:1.5rem;color:var(--success);">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <div style="font-weight:700;font-size:.95rem;color:var(--text-primary);">Điểm thưởng</div>
                        <div style="font-size:.8rem;color:var(--text-muted);margin-top:.3rem;">Tích lũy thành tích</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="fl-card text-center" style="padding:1.75rem 1rem;">
                        <div style="width:56px;height:56px;border-radius:var(--radius-lg);background:rgba(245,158,11,.1);display:flex;align-items:center;justify-content:center;margin:0 auto .9rem;font-size:1.5rem;color:var(--warning);">
                            <i class="fas fa-broadcast-tower"></i>
                        </div>
                        <div style="font-weight:700;font-size:.95rem;color:var(--text-primary);">Live Session</div>
                        <div style="font-size:.8rem;color:var(--text-muted);margin-top:.3rem;">Học trực tiếp</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== COURSES SECTION ===== -->
    <section class="content-section" style="padding-top:0;">
        <div class="container-fl">
            <div class="d-flex align-items-end justify-content-between mb-4">
                <div class="section-header" style="margin-bottom:0;">
                    <div class="section-tag"><i class="fas fa-fire me-1"></i> Phổ biến</div>
                    <h2>Khóa học <span>nổi bật</span></h2>
                </div>
                <a href="${pageContext.request.contextPath}/courses" class="btn-outline-fl" style="text-decoration:none;">
                    Xem tất cả <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <div class="row g-4">
                <c:choose>
                    <c:when test="${not empty courses}">
                        <c:forEach var="course" items="${courses}" end="3">
                            <div class="col-lg-3 col-md-6">
                                <div class="course-card" onclick="location.href='${pageContext.request.contextPath}/learn/${course.classId}'">
                                    <div class="card-thumb">
                                        <div style="width:100%;height:100%;background:linear-gradient(135deg,#1e3a5f,#0f1f3a);display:flex;align-items:center;justify-content:center;">
                                            <i class="fas fa-play-circle" style="font-size:3rem;color:rgba(255,255,255,.2);"></i>
                                        </div>
                                        <span class="thumb-badge"><i class="fas fa-users me-1"></i>Lớp học</span>
                                    </div>
                                    <div class="card-body">
                                        <div class="card-title">${course.className}</div>
                                        <div class="card-teacher">
                                            <i class="fas fa-chalkboard-teacher me-1"></i>
                                            ${course.teacher.fullName}
                                        </div>
                                        <div class="card-footer-row">
                                            <span class="card-invite">
                                                <i class="fas fa-key me-1"></i>${course.inviteCode}
                                            </span>
                                            <span class="joined-badge">
                                                <i class="fas fa-check-circle"></i> Tham gia
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center py-5">
                            <i class="fas fa-book-open" style="font-size:3rem;color:var(--text-muted);margin-bottom:1rem;display:block;"></i>
                            <p style="color:var(--text-muted);">Chưa có khóa học nào. Hãy quay lại sau!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- ===== HOW IT WORKS ===== -->
    <section class="content-section" style="background:var(--bg-card);border-top:1px solid var(--border);border-bottom:1px solid var(--border);">
        <div class="container-fl">
            <div class="section-header text-center" style="margin-bottom:3rem;">
                <div class="section-tag">Quy trình</div>
                <h2>Cách hoạt động <span>như thế nào?</span></h2>
                <p>Chỉ 3 bước đơn giản để bắt đầu hành trình học tập</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div style="text-align:center;padding:1.5rem;">
                        <div style="width:70px;height:70px;border-radius:50%;background:linear-gradient(135deg,var(--primary),var(--accent));display:flex;align-items:center;justify-content:center;margin:0 auto 1.2rem;font-size:1.5rem;color:#fff;box-shadow:0 8px 24px rgba(59,130,246,.35);">
                            <i class="fas fa-search"></i>
                        </div>
                        <div style="font-weight:700;font-size:1rem;margin-bottom:.5rem;color:var(--text-primary);">1. Tìm khóa học</div>
                        <div style="font-size:.87rem;color:var(--text-muted);line-height:1.7;">Duyệt qua danh sách khóa học và tham gia bằng mã mời từ giảng viên</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div style="text-align:center;padding:1.5rem;">
                        <div style="width:70px;height:70px;border-radius:50%;background:linear-gradient(135deg,var(--accent),#EC4899);display:flex;align-items:center;justify-content:center;margin:0 auto 1.2rem;font-size:1.5rem;color:#fff;box-shadow:0 8px 24px rgba(139,92,246,.35);">
                            <i class="fas fa-play"></i>
                        </div>
                        <div style="font-weight:700;font-size:1rem;margin-bottom:.5rem;color:var(--text-primary);">2. Xem bài giảng</div>
                        <div style="font-size:.87rem;color:var(--text-muted);line-height:1.7;">Học video theo tiến độ của bạn. Quiz sẽ xuất hiện tự động trong video</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div style="text-align:center;padding:1.5rem;">
                        <div style="width:70px;height:70px;border-radius:50%;background:linear-gradient(135deg,var(--success),#14B8A6);display:flex;align-items:center;justify-content:center;margin:0 auto 1.2rem;font-size:1.5rem;color:#fff;box-shadow:0 8px 24px rgba(16,185,129,.35);">
                            <i class="fas fa-medal"></i>
                        </div>
                        <div style="font-weight:700;font-size:1rem;margin-bottom:.5rem;color:var(--text-primary);">3. Nhận chứng chỉ</div>
                        <div style="font-size:.87rem;color:var(--text-muted);line-height:1.7;">Hoàn thành tất cả bài học và milestone để nhận chứng chỉ hoàn thành</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== CTA SECTION ===== -->
    <c:if test="${empty sessionScope.loggedInUser}">
        <section class="content-section text-center">
            <div class="container-fl" style="max-width:640px;">
                <div class="section-tag" style="margin-bottom:.75rem;">Bắt đầu ngay</div>
                <h2 style="font-size:2rem;margin-bottom:1rem;">Sẵn sàng bắt đầu<br/><span style="color:var(--primary);">hành trình học tập?</span></h2>
                <p style="color:var(--text-secondary);margin-bottom:2rem;line-height:1.8;">
                    Tham gia cùng hàng nghìn học viên đang học tập trên FLearn.
                    Hoàn toàn miễn phí để bắt đầu.
                </p>
                <a href="${pageContext.request.contextPath}/login" class="btn-primary-fl" style="font-size:1rem;padding:.85rem 2.5rem;text-decoration:none;">
                    <i class="fas fa-user-plus"></i> Tạo tài khoản miễn phí
                </a>
            </div>
        </section>
    </c:if>


</div><!-- end page-wrapper -->

<%@ include file="layout/user-sidebar.jsp" %>
<%@ include file="layout/footer.jsp" %>

<style>
@keyframes float {
    0%, 100% { transform: translateY(0); }
    50%       { transform: translateY(-12px); }
}
</style>
<script>
// Counter animation
function animateCounter(id, target, suffix) {
    const el = document.getElementById(id);
    if (!el) return;
    let start = 0;
    const step = target / 60;
    const timer = setInterval(() => {
        start += step;
        if (start >= target) { el.textContent = target + (suffix||''); clearInterval(timer); }
        else el.textContent = Math.floor(start) + (suffix||'');
    }, 20);
}
window.addEventListener('DOMContentLoaded', () => {
    animateCounter('counterStudents', 1200, '+');
    animateCounter('counterCourses', 48, '');
    animateCounter('counterTeachers', 15, '');
});
</script>
