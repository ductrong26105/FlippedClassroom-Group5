<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- ===== HEADER ===== --%>
<jsp:include page="/WEB-INF/views/landing/layout/header.jsp"/>

<!-- ============================================================
     PROBLEM HERO — compact
     ============================================================ -->
<section class="page-hero-compact">
    <div class="hero-bg-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
    </div>
    <div class="container position-relative z-1">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <span class="section-label mb-3 d-inline-flex fade-up">
                    <i class="fas fa-exclamation-triangle"></i>&nbsp;Thực trạng giáo dục
                </span>
                <h1 class="page-title-lg fade-up delay-1">
                    Đối mặt với <span class="highlight">3 vấn đề</span><br/>cốt lõi
                </h1>
                <p class="page-subtitle-sm fade-up delay-2">
                    Mô hình giáo dục truyền thống đang bộc lộ nhiều hạn chế. FLearn phân tích
                    và cung cấp giải pháp trực tiếp cho từng vấn đề.
                </p>
                <div class="d-flex gap-3 flex-wrap fade-up delay-3">
                    <a href="${pageContext.request.contextPath}/landing/solution" class="btn-glow">
                        <i class="fas fa-lightbulb"></i> Xem giải pháp
                    </a>
                    <a href="${pageContext.request.contextPath}/landing" class="btn-outline-glass">
                        <i class="fas fa-arrow-left"></i> Trang chủ
                    </a>
                </div>
            </div>
            <div class="col-lg-5 d-none d-lg-flex justify-content-center">
                <div class="problem-hero-visual fade-right delay-2">
                    <div class="prob-icon-cluster">
                        <div class="prob-icon-big"><i class="fas fa-clock"></i></div>
                        <div class="prob-icon-sm top-right"><i class="fas fa-eye-slash"></i></div>
                        <div class="prob-icon-sm bottom-left"><i class="fas fa-users-slash"></i></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================================================
     PROBLEMS DETAILS — side-by-side compact cards
     ============================================================ -->
<section class="py-5" id="problems">
    <div class="container">

        <!-- Problem 1 -->
        <div class="prob-item fade-up">
            <div class="prob-index">01</div>
            <div class="prob-body">
                <div class="prob-icon-wrap icon-red">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="prob-text">
                    <h2>${prob1.title}</h2>
                    <p>${prob1.desc}</p>
                    <div class="evidence-pills">
                        <c:forEach var="ev" items="${prob1.evidence}">
                            <span class="ev-pill ev-red"><i class="fas fa-chart-bar"></i> ${ev}</span>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Problem 2 -->
        <div class="prob-item fade-up delay-1">
            <div class="prob-index">02</div>
            <div class="prob-body">
                <div class="prob-icon-wrap icon-amber">
                    <i class="fas fa-eye-slash"></i>
                </div>
                <div class="prob-text">
                    <h2>${prob2.title}</h2>
                    <p>${prob2.desc}</p>
                    <div class="evidence-pills">
                        <c:forEach var="ev" items="${prob2.evidence}">
                            <span class="ev-pill ev-amber"><i class="fas fa-chart-bar"></i> ${ev}</span>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Problem 3 -->
        <div class="prob-item fade-up delay-2">
            <div class="prob-index">03</div>
            <div class="prob-body">
                <div class="prob-icon-wrap icon-blue">
                    <i class="fas fa-users-slash"></i>
                </div>
                <div class="prob-text">
                    <h2>${prob3.title}</h2>
                    <p>${prob3.desc}</p>
                    <div class="evidence-pills">
                        <c:forEach var="ev" items="${prob3.evidence}">
                            <span class="ev-pill ev-blue"><i class="fas fa-chart-bar"></i> ${ev}</span>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================================================
     IMPACT STATS BANNER
     ============================================================ -->
<section class="impact-compact-section fade-up">
    <div class="container">
        <div class="impact-compact-banner">
            <div class="impact-compact-stats">
                <div class="impact-stat-item">
                    <span class="ic-num text-danger">${dropoutRate}%</span>
                    <span class="ic-label">Tỷ lệ bỏ học</span>
                </div>
                <div class="ic-divider"></div>
                <div class="impact-stat-item">
                    <span class="ic-num text-warning">${avgScore}</span>
                    <span class="ic-label">GPA trung bình</span>
                </div>
                <div class="ic-divider"></div>
                <div class="impact-stat-item">
                    <span class="ic-num text-danger">${retakeRate}%</span>
                    <span class="ic-label">Tỷ lệ học lại</span>
                </div>
                <div class="ic-divider"></div>
                <div class="impact-stat-item">
                    <span class="ic-num text-muted">${satisfactionOld}%</span>
                    <span class="ic-label">Mức hài lòng</span>
                </div>
            </div>
            <div class="impact-compact-cta">
                <p class="fw-semibold text-white mb-2">Đã đến lúc cần thay đổi!</p>
                <a href="${pageContext.request.contextPath}/landing/solution" class="btn-glow">
                    <i class="fas fa-arrow-right"></i> Xem Giải pháp FLearn
                </a>
            </div>
        </div>
    </div>
</section>

<%-- ===== FOOTER ===== --%>
<jsp:include page="/WEB-INF/views/landing/layout/footer.jsp"/>
