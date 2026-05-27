<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">
    <section class="hero-section text-center" style="padding-top:120px; padding-bottom:60px;">
        <div class="container-fl">
            <h1>Đội ngũ <span>phát triển</span></h1>
            <p style="color:var(--text-muted); max-width:600px; margin:0 auto;">
                Những người đứng sau nền tảng FLearn.
            </p>
        </div>
    </section>

    <section class="content-section">
        <div class="container-fl">
            <div class="row justify-content-center">
                <div class="col-md-4 text-center mb-4">
                    <div class="fl-card p-4">
                        <div style="width:100px; height:100px; border-radius:50%; background:var(--primary); margin:0 auto 1rem; display:flex; align-items:center; justify-content:center; color:#fff; font-size:2rem; font-weight:bold;">
                            D
                        </div>
                        <h4 style="color:var(--text-primary);">Developer Team</h4>
                        <p style="color:var(--text-muted); font-size:0.9rem;">Học viện Công nghệ Bưu chính Viễn thông</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@ include file="layout/user-sidebar.jsp" %>
<%@ include file="layout/footer.jsp" %>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
