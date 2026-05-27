<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">
    <section class="hero-section text-center" style="padding-top:120px; padding-bottom:60px;">
        <div class="container-fl">
            <h1>Đánh giá từ <span>học viên</span></h1>
            <p style="color:var(--text-muted); max-width:600px; margin:0 auto;">
                Hãy nghe xem học viên nói gì về FLearn.
            </p>
        </div>
    </section>

    <section class="content-section">
        <div class="container-fl">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="fl-card p-4">
                        <div style="color:var(--warning); margin-bottom:1rem;">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                        </div>
                        <p style="color:var(--text-secondary); line-height:1.7;">
                            "Hệ thống Quiz xuất hiện giữa video giúp mình không bị buồn ngủ và nhớ bài lâu hơn hẳn!"
                        </p>
                        <div class="mt-3 d-flex align-items-center">
                            <div style="width:40px;height:40px;background:var(--primary);border-radius:50%;color:#fff;display:flex;align-items:center;justify-content:center;font-weight:bold;margin-right:1rem;">N</div>
                            <strong style="color:var(--text-primary);">Nguyễn Văn A</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@ include file="layout/user-sidebar.jsp" %>
<%@ include file="layout/footer.jsp" %>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
