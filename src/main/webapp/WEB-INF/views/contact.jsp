<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">
    <section class="hero-section text-center" style="padding-top:120px; padding-bottom:60px;">
        <div class="container-fl">
            <h1>Liên hệ với <span>chúng tôi</span></h1>
            <p style="color:var(--text-muted); max-width:600px; margin:0 auto;">
                Có câu hỏi hoặc cần hỗ trợ? Đội ngũ FLearn luôn sẵn sàng giúp đỡ.
            </p>
        </div>
    </section>

    <section class="content-section">
        <div class="container-fl" style="max-width:600px;">
            <div class="fl-card p-4">
                <form action="#" method="post">
                    <div class="mb-3">
                        <label class="form-label" style="color:var(--text-primary);">Họ và tên</label>
                        <input type="text" class="fl-input" placeholder="Nhập tên của bạn">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" style="color:var(--text-primary);">Email</label>
                        <input type="email" class="fl-input" placeholder="name@example.com">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" style="color:var(--text-primary);">Nội dung tin nhắn</label>
                        <textarea class="fl-textarea" rows="4" placeholder="Nhập nội dung..."></textarea>
                    </div>
                    <button type="button" class="btn-primary-fl w-100" onclick="alert('Cảm ơn bạn đã liên hệ!')">Gửi tin nhắn</button>
                </form>
            </div>
        </div>
    </section>
</div>

<%@ include file="layout/user-sidebar.jsp" %>
<%@ include file="layout/footer.jsp" %>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
