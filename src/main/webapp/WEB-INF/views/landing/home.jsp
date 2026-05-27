<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- ===== HEADER ===== --%>
<jsp:include page="/WEB-INF/views/landing/layout/header.jsp"/>

<!-- ============================================================
     HERO SECTION
     ============================================================ -->
<section class="hero-section" id="hero">
    <!-- Background Shapes -->
    <div class="hero-bg-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
    </div>
    <div class="hero-grid-overlay"></div>

    <div class="container">
        <div class="row align-items-center">
            <!-- Left Content -->
            <div class="col-lg-6 hero-content">
                <div class="hero-badge fade-up">
                    <span class="badge-dot"></span>
                    Active Learning Platform
                </div>

                <h1 class="hero-title fade-up delay-1">
                    Học tập <span class="highlight">chủ động</span>,<br/>
                    hiệu quả <span class="highlight">vượt trội</span>
                </h1>

                <p class="hero-subtitle fade-up delay-2">
                    Hệ thống FLearn giúp chuyển đổi lớp học truyền thống sang mô hình
                    học tập chủ động — sinh viên tự chuẩn bị trước, thời gian trên lớp
                    dành cho thực hành và tương tác.
                </p>

                <div class="hero-buttons fade-up delay-3">
                    <a href="${pageContext.request.contextPath}/landing/solution" class="btn-glow">
                        <i class="fas fa-lightbulb"></i> Xem giải pháp
                    </a>
                    <a href="${pageContext.request.contextPath}/landing/problem" class="btn-outline-glass">
                        <i class="fas fa-search"></i> Tìm hiểu vấn đề
                    </a>
                </div>

                <!-- Hero Stats -->
                <div class="hero-stats fade-up delay-4">
                    <div class="hero-stat">
                        <div class="stat-number" data-count="${totalStudents}" data-suffix="+">0</div>
                        <div class="stat-label">Sinh viên</div>
                    </div>
                    <div class="hero-stat">
                        <div class="stat-number" data-count="${totalCourses}">0</div>
                        <div class="stat-label">Khóa học</div>
                    </div>
                    <div class="hero-stat">
                        <div class="stat-number" data-count="${completionRate}" data-suffix="%">0</div>
                        <div class="stat-label">Tỷ lệ hoàn thành</div>
                    </div>
                    <div class="hero-stat">
                        <div class="stat-number" data-count="${satisfactionRate}" data-suffix="%">0</div>
                        <div class="stat-label">Hài lòng</div>
                    </div>
                </div>
            </div>

            <!-- Right Illustration -->
            <div class="col-lg-6 hero-illustration">
                <div class="hero-card-stack fade-right delay-2">
                    <div class="hero-floating-card card-behind"></div>
                    <div class="hero-floating-card card-main">
                        <div class="card-header-row">
                            <div class="card-icon-box">
                                <i class="fas fa-play"></i>
                            </div>
                            <span class="card-status-badge">
                                <i class="fas fa-check-circle me-1"></i> Đang học
                            </span>
                        </div>
                        <div class="card-title-sm">Lập trình Web với Java Servlet</div>
                        <div class="card-desc-sm">Node 5/12 — Xử lý form với JSP & JSTL</div>
                        <div class="progress-bar-track">
                            <div class="progress-bar-fill" data-width="68%"></div>
                        </div>
                        <div class="progress-label">
                            <span>Tiến trình</span>
                            <span>68%</span>
                        </div>
                        <div class="mini-avatars">
                            <div class="mini-avatar av-1">NT</div>
                            <div class="mini-avatar av-2">HM</div>
                            <div class="mini-avatar av-3">PL</div>
                            <div class="mini-avatar av-more">+12</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================================================
     PROBLEMS OVERVIEW
     ============================================================ -->
<section class="section-padding" id="problems">
    <div class="container">
        <div class="section-header fade-up">
            <span class="section-label">
                <i class="fas fa-exclamation-circle"></i> Thách thức
            </span>
            <h2 class="section-title">
                Vấn đề trong giáo dục <span class="text-gradient">hiện tại</span>
            </h2>
            <p class="section-desc">
                Ba vấn đề cốt lõi mà hệ thống giáo dục truyền thống đang đối mặt,
                cần được giải quyết để nâng cao chất lượng dạy và học.
            </p>
        </div>

        <div class="row g-4">
            <c:forEach var="p" items="${problems}" varStatus="st">
                <div class="col-md-4">
                    <div class="problem-card fade-up delay-${st.index + 1}">
                        <div class="problem-icon ${p.iconClass}">
                            <i class="fas ${p.icon}"></i>
                        </div>
                        <h4>${p.title}</h4>
                        <p>${p.desc}</p>
                        <span class="problem-stat">
                            <i class="fas fa-chart-bar"></i> ${p.stat}
                        </span>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="text-center mt-5 fade-up">
            <a href="${pageContext.request.contextPath}/landing/problem" class="btn-glow">
                <i class="fas fa-arrow-right"></i> Xem chi tiết vấn đề
            </a>
        </div>
    </div>
</section>

<!-- ============================================================
     SOLUTION OVERVIEW
     ============================================================ -->
<section class="blueprint-section section-padding" id="solution">
    <div class="container">
        <div class="section-header fade-up">
            <span class="section-label">
                <i class="fas fa-lightbulb"></i> Giải pháp
            </span>
            <h2 class="section-title">
                Blueprint <span class="text-accent-gradient">học tập chủ động</span>
            </h2>
            <p class="section-desc">
                Mô hình 4 giai đoạn chuyển đổi lớp học truyền thống sang hệ thống
                học tập chủ động, tập trung vào thực hành và tương tác.
            </p>
        </div>

        <div class="row g-4">
            <!-- BP1 -->
            <div class="col-md-6 col-lg-3 fade-up delay-1">
                <div class="blueprint-card h-100">
                    <span class="bp-label bp1">BP1</span>
                    <h4>Nền tảng cơ bản</h4>
                    <p>Mô hình dạy tập trung vào thực hành, không nặng nề chấm điểm.</p>
                    <div class="bp-features">
                        <span class="bp-feature-tag"><i class="fas fa-check"></i> Thực hành</span>
                        <span class="bp-feature-tag"><i class="fas fa-check"></i> Mentor</span>
                    </div>
                </div>
            </div>
            <!-- BP2 -->
            <div class="col-md-6 col-lg-3 fade-up delay-2">
                <div class="blueprint-card h-100">
                    <span class="bp-label bp2">BP2</span>
                    <h4>Học trước ở nhà</h4>
                    <p>Video, tài liệu, tracking tiến trình & quiz kiểm tra hiểu bài.</p>
                    <div class="bp-features">
                        <span class="bp-feature-tag"><i class="fas fa-check"></i> Video</span>
                        <span class="bp-feature-tag"><i class="fas fa-check"></i> Tracking</span>
                        <span class="bp-feature-tag"><i class="fas fa-check"></i> Quiz</span>
                    </div>
                </div>
            </div>
            <!-- BP3 -->
            <div class="col-md-6 col-lg-3 fade-up delay-3">
                <div class="blueprint-card h-100">
                    <span class="bp-label bp3">BP3</span>
                    <h4>Vận hành tại lớp</h4>
                    <p>Q&A, thực hành tại lớp, nhóm phản biện & hỗ trợ kỹ thuật.</p>
                    <div class="bp-features">
                        <span class="bp-feature-tag"><i class="fas fa-check"></i> Q&A</span>
                        <span class="bp-feature-tag"><i class="fas fa-check"></i> Phản biện</span>
                    </div>
                </div>
            </div>
            <!-- BPx -->
            <div class="col-md-6 col-lg-3 fade-up delay-4">
                <div class="blueprint-card h-100">
                    <span class="bp-label bpx">BPx</span>
                    <h4>Có điều kiện</h4>
                    <p>Prerequisites, milestone tracking, project management & dashboard.</p>
                    <div class="bp-features">
                        <span class="bp-feature-tag"><i class="fas fa-check"></i> Milestone</span>
                        <span class="bp-feature-tag"><i class="fas fa-check"></i> Dashboard</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mt-5 fade-up">
            <a href="${pageContext.request.contextPath}/landing/solution" class="btn-glow">
                <i class="fas fa-arrow-right"></i> Xem chi tiết giải pháp & demo code
            </a>
        </div>
    </div>
</section>

<!-- ============================================================
     ARCHITECTURE OVERVIEW
     ============================================================ -->
<section class="section-padding" id="architecture">
    <div class="container">
        <div class="section-header fade-up">
            <span class="section-label">
                <i class="fas fa-layer-group"></i> Kiến trúc
            </span>
            <h2 class="section-title">
                Tech Stack <span class="text-gradient">hiện đại</span>
            </h2>
            <p class="section-desc">
                Xây dựng trên nền tảng Jakarta EE vững chắc với kiến trúc MVC rõ ràng,
                tích hợp Hibernate ORM và Bootstrap 5.
            </p>
        </div>

        <div class="row g-4 align-items-center justify-content-center">
            <div class="col-6 col-md-3 col-lg-2 fade-up delay-1">
                <div class="arch-card">
                    <div class="arch-icon">
                        <i class="fas fa-globe"></i>
                    </div>
                    <h5>Browser</h5>
                    <p>HTML/CSS/JS</p>
                </div>
            </div>
            <div class="col-auto d-none d-md-block fade-up delay-1">
                <div class="arch-arrow"><i class="fas fa-arrow-right"></i></div>
            </div>
            <div class="col-6 col-md-3 col-lg-2 fade-up delay-2">
                <div class="arch-card">
                    <div class="arch-icon" style="background: #fef3c7; color: #d97706;">
                        <i class="fas fa-server"></i>
                    </div>
                    <h5>Servlet</h5>
                    <p>Controller Layer</p>
                </div>
            </div>
            <div class="col-auto d-none d-md-block fade-up delay-2">
                <div class="arch-arrow"><i class="fas fa-arrow-right"></i></div>
            </div>
            <div class="col-6 col-md-3 col-lg-2 fade-up delay-3">
                <div class="arch-card">
                    <div class="arch-icon" style="background: #f0fdf4; color: #16a34a;">
                        <i class="fas fa-file-code"></i>
                    </div>
                    <h5>JSP + JSTL</h5>
                    <p>View Layer</p>
                </div>
            </div>
            <div class="col-auto d-none d-md-block fade-up delay-3">
                <div class="arch-arrow"><i class="fas fa-arrow-right"></i></div>
            </div>
            <div class="col-6 col-md-3 col-lg-2 fade-up delay-4">
                <div class="arch-card">
                    <div class="arch-icon" style="background: #fdf2f8; color: #db2777;">
                        <i class="fas fa-database"></i>
                    </div>
                    <h5>Hibernate</h5>
                    <p>ORM + SQL Server</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================================================
     CTA SECTION
     ============================================================ -->
<section class="cta-section section-padding" id="cta">
    <div class="container">
        <div class="cta-content fade-up">
            <h2>Sẵn sàng trải nghiệm<br/><span class="highlight">học tập chủ động</span>?</h2>
            <p>Khám phá hệ thống FLearn và thay đổi cách bạn dạy & học.</p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="${pageContext.request.contextPath}/landing/solution" class="btn-glow">
                    <i class="fas fa-code"></i> Xem demo code
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn-outline-glass">
                    <i class="fas fa-rocket"></i> Vào hệ thống
                </a>
            </div>
        </div>
    </div>
</section>

<%-- ===== FOOTER ===== --%>
<jsp:include page="/WEB-INF/views/landing/layout/footer.jsp"/>
