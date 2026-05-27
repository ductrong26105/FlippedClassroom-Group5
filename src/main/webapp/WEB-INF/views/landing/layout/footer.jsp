<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- ===== FOOTER ===== -->
<footer class="landing-footer">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <p><i class="fas fa-graduation-cap me-2"></i>© 2025 FLearn — Active Learning Platform. Nhóm 5 SWP.</p>
            </div>
            <div class="col-md-6">
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/landing">Trang chủ</a>
                    <a href="${pageContext.request.contextPath}/landing/problem">Vấn đề</a>
                    <a href="${pageContext.request.contextPath}/landing/solution">Giải pháp</a>
                    <a href="${pageContext.request.contextPath}/home">Hệ thống</a>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Prism.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/prism.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-java.min.js"></script>
<!-- Landing JS -->
<script src="${pageContext.request.contextPath}/assets/js/landing.js"></script>
</body>
</html>
