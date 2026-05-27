<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">
    <section class="hero-section text-center" style="padding-top:120px; padding-bottom:80px;">
        <div class="container-fl">
            <h1>Giới thiệu về <span>FLearn</span></h1>
            <p style="color:var(--text-muted); max-width:600px; margin:0 auto;">
                Nền tảng học trực tuyến tiên tiến nhất áp dụng mô hình Flipped Classroom.
            </p>
        </div>
    </section>

    <section class="content-section">
        <div class="container-fl">
            <div class="fl-card p-5 text-center">
                <i class="fas fa-info-circle" style="font-size:3rem; color:var(--primary); margin-bottom:1rem;"></i>
                <h3 style="margin-bottom:1rem; color:var(--text-primary);">Sứ mệnh của chúng tôi</h3>
                <p style="color:var(--text-secondary); line-height:1.8;">
                    FLearn được xây dựng với mục tiêu mang lại trải nghiệm học tập chủ động và tương tác cao.
                    Khắc phục hoàn toàn những nhược điểm của mô hình dạy học truyền thống bằng công nghệ và dữ liệu.
                </p>
            </div>
        </div>
    </section>
</div>

<%@ include file="layout/user-sidebar.jsp" %>
<%@ include file="layout/footer.jsp" %>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
