<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- ===== FOOTER ===== -->
<footer class="flearn-footer">
    <div class="container-fl">
        <div class="row g-4">
            <div class="col-lg-4">
                <div class="footer-brand"><i class="fas fa-graduation-cap"></i> FLearn</div>
                <p class="footer-desc mt-2">
                    Nền tảng học trực tuyến hiện đại áp dụng mô hình lớp học đảo ngược.
                    Học theo tiến độ của bạn, tương tác trực tiếp với giảng viên.
                </p>
                <div class="d-flex gap-2 mt-3">
                    <a href="#" style="width:36px;height:36px;border-radius:50%;background:var(--bg-surface);border:1px solid var(--border);display:flex;align-items:center;justify-content:center;color:var(--text-muted);transition:var(--transition);"
                       onmouseover="this.style.color='var(--primary)';this.style.borderColor='var(--primary)'"
                       onmouseout="this.style.color='var(--text-muted)';this.style.borderColor='var(--border)'">
                        <i class="fab fa-facebook-f" style="font-size:.82rem;"></i>
                    </a>
                    <a href="#" style="width:36px;height:36px;border-radius:50%;background:var(--bg-surface);border:1px solid var(--border);display:flex;align-items:center;justify-content:center;color:var(--text-muted);transition:var(--transition);"
                       onmouseover="this.style.color='var(--primary)';this.style.borderColor='var(--primary)'"
                       onmouseout="this.style.color='var(--text-muted)';this.style.borderColor='var(--border)'">
                        <i class="fab fa-youtube" style="font-size:.82rem;"></i>
                    </a>
                    <a href="#" style="width:36px;height:36px;border-radius:50%;background:var(--bg-surface);border:1px solid var(--border);display:flex;align-items:center;justify-content:center;color:var(--text-muted);transition:var(--transition);"
                       onmouseover="this.style.color='var(--primary)';this.style.borderColor='var(--primary)'"
                       onmouseout="this.style.color='var(--text-muted)';this.style.borderColor='var(--border)'">
                        <i class="fab fa-github" style="font-size:.82rem;"></i>
                    </a>
                </div>
            </div>
            <div class="col-lg-2 col-6">
                <div class="footer-title">Khám phá</div>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/courses">Khóa học</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">Về chúng tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/team">Đội ngũ</a></li>
                </ul>
            </div>
            <div class="col-lg-2 col-6">
                <div class="footer-title">Hỗ trợ</div>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                    <li><a href="#">Trung tâm trợ giúp</a></li>
                    <li><a href="#">Điều khoản</a></li>
                    <li><a href="#">Chính sách</a></li>
                </ul>
            </div>
            <% if (session.getAttribute("loggedInUser") == null) { %>
            <div class="col-lg-4">
                <div class="footer-title">Nhận thông báo mới</div>
                <p style="font-size:.85rem;color:var(--text-muted);margin-bottom:.85rem;">
                    Đăng ký để nhận thông tin về khóa học mới nhất.
                </p>
                <div class="d-flex gap-2">
                    <input type="email" class="fl-input" placeholder="Email của bạn..." style="flex:1;"/>
                    <button class="btn-primary-fl" style="white-space:nowrap;">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </div>
            </div>
            <% } %>
        </div>

        <div class="footer-bottom">
            <span>© 2026 FLearn. Nhóm 5 - SWP.</span>
            <span style="display:flex;align-items:center;gap:.4rem;">
                <i class="fas fa-heart" style="color:var(--danger);font-size:.8rem;"></i>
                Made with love for learning
            </span>
        </div>
    </div>
</footer>

<!-- ===== TOAST CONTAINER ===== -->
<div class="toast-container-fl" id="toastContainer"></div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- SortableJS -->
<script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.2/Sortable.min.js"></script>
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
<!-- FLearn JS -->
<script src="${pageContext.request.contextPath}/assets/js/main.js?v=2" charset="UTF-8"></script>

</body>
</html>
