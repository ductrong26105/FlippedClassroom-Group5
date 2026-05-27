<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi" data-theme="light">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${not empty pageTitle ? pageTitle : 'Đăng nhập - FLearn'}</title>
    <meta name="description" content="Đăng nhập vào FLearn để truy cập khóa học và bắt đầu học tập."/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"/>
</head>
<body>

<div class="login-page" id="loginPage">
    <div class="bg-glow-1"></div>
    <div class="bg-glow-2"></div>
    <div class="grid-bg"></div>

    <div class="login-card" id="loginCard">
        <!-- Logo -->
        <div class="login-logo">
            <div class="brand-text"><i class="fas fa-graduation-cap"></i> FLearn</div>
            <p>Nền tảng học trực tuyến thế hệ mới</p>
        </div>

        <!-- Success message -->
        <c:if test="${param.registered == 'true'}">
            <div style="background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.3); color: #10b981; padding: .8rem 1rem; border-radius: var(--border-radius); font-size: .88rem; margin-bottom: 1.25rem; display: flex; align-items: center; gap: .6rem;">
                <i class="fas fa-check-circle"></i>
                Đăng ký tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.
            </div>
        </c:if>
        <c:if test="${param.resetSuccess == 'true'}">
            <div style="background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.3); color: #10b981; padding: .8rem 1rem; border-radius: var(--border-radius); font-size: .88rem; margin-bottom: 1.25rem; display: flex; align-items: center; gap: .6rem;">
                <i class="fas fa-check-circle"></i>
                Khôi phục mật khẩu thành công! Bạn có thể đăng nhập bằng mật khẩu mới.
            </div>
        </c:if>

        <!-- Error message -->
        <div class="alert-error" id="clientErrorBox" style="display:none; margin-bottom: 1.25rem;">
            <i class="fas fa-exclamation-circle"></i>
            <span id="clientErrorMsg"></span>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert-error" style="margin-bottom: 1.25rem;">
                <i class="fas fa-exclamation-circle"></i>
                ${errorMessage}
            </div>
        </c:if>

        <!-- Login Form -->
        <form id="loginForm" method="post" action="${pageContext.request.contextPath}/login" novalidate>
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">

            <div class="form-group-fl">
                <label for="username">Tên đăng nhập</label>
                <div class="input-wrap">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text"
                           id="username"
                           name="username"
                           placeholder="Nhập tên đăng nhập..."
                           value="${param.username}"
                           required
                           autocomplete="username"/>
                </div>
            </div>

            <div class="form-group-fl">
                <label for="password">Mật khẩu</label>
                <div class="input-wrap">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Nhập mật khẩu..."
                           required
                           autocomplete="current-password"/>
                    <i class="fas fa-eye input-icon-right" id="togglePassword" onclick="togglePwd()"></i>
                </div>
            </div>

            <div class="form-group-fl" style="margin-bottom: 1.25rem;">
                <div class="form-check" style="text-align: left; display: flex; align-items: center; gap: 0.5rem; padding-left: 0;">
                    <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe" value="true" style="cursor: pointer; margin: 0; width: 1rem; height: 1rem; background-color: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.25);"/>
                    <label class="form-check-label text-light" for="rememberMe" style="font-size: 0.88rem; opacity: 0.85; cursor: pointer; user-select: none; line-height: 1;">
                        Ghi nhớ đăng nhập (7 ngày)
                    </label>
                </div>
            </div>

            <button type="submit" class="btn-login" id="loginBtn">
                <i class="fas fa-sign-in-alt me-2"></i> Đăng nhập
            </button>
        </form>

        <div class="login-divider">
            <span>Hoặc tiếp tục với</span>
        </div>

        <button class="btn-google" onclick="alert('Google login chưa tích hợp')">
            <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M17.64 9.2c0-.637-.057-1.251-.164-1.84H9v3.481h4.844c-.209 1.125-.843 2.078-1.796 2.717v2.258h2.908c1.702-1.567 2.684-3.874 2.684-6.615z" fill="#4285F4"/>
                <path d="M9 18c2.43 0 4.467-.806 5.956-2.18l-2.908-2.259c-.806.54-1.837.86-3.048.86-2.344 0-4.328-1.584-5.036-3.711H.957v2.332A8.997 8.997 0 0 0 9 18z" fill="#34A853"/>
                <path d="M3.964 10.71A5.41 5.41 0 0 1 3.682 9c0-.593.102-1.17.282-1.71V4.958H.957A8.996 8.996 0 0 0 0 9c0 1.452.348 2.827.957 4.042l3.007-2.332z" fill="#FBBC05"/>
                <path d="M9 3.58c1.321 0 2.508.454 3.44 1.345l2.582-2.58C13.463.891 11.426 0 9 0A8.997 8.997 0 0 0 .957 4.958L3.964 7.29C4.672 5.163 6.656 3.58 9 3.58z" fill="#EA4335"/>
            </svg>
            Đăng nhập bằng Google
        </button>

        <div class="login-links">
            <a href="${pageContext.request.contextPath}/register">
                <i class="fas fa-user-plus me-1"></i>Tạo tài khoản mới
            </a>
            <a href="${pageContext.request.contextPath}/forgot-password">
                <i class="fas fa-key me-1"></i>Quên mật khẩu
            </a>
        </div>

        <!-- Back to home -->
        <div style="text-align:center;margin-top:1.25rem;">
            <a href="${pageContext.request.contextPath}/home"
               style="color:rgba(255,255,255,.35);font-size:.8rem;transition:var(--transition);"
               onmouseover="this.style.color='rgba(255,255,255,.7)'"
               onmouseout="this.style.color='rgba(255,255,255,.35)'">
                <i class="fas fa-arrow-left me-1"></i>Quay về trang chủ
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js?v=2" charset="UTF-8"></script>
<script>
function togglePwd() {
    const inp = document.getElementById('password');
    const icon = document.getElementById('togglePassword');
    if (inp.type === 'password') {
        inp.type = 'text';
        icon.className = 'fas fa-eye-slash input-icon-right';
    } else {
        inp.type = 'password';
        icon.className = 'fas fa-eye input-icon-right';
    }
}

// Client-side Validation & Loading state on submit
document.getElementById('loginForm').addEventListener('submit', function(e) {
    const errorBox = document.getElementById('clientErrorBox');
    const errorMsg = document.getElementById('clientErrorMsg');
    errorBox.style.display = 'none';

    const username = document.getElementById('username').value.trim();
    const pwd = document.getElementById('password').value;

    if (!username || !pwd) {
        e.preventDefault();
        errorMsg.textContent = 'Vui lòng điền đầy đủ tên đăng nhập và mật khẩu!';
        errorBox.style.display = 'block';
        return;
    }

    const btn = document.getElementById('loginBtn');
    btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang đăng nhập...';
    btn.disabled = true;
});

// Card entrance animation
document.addEventListener('DOMContentLoaded', function() {
    const card = document.getElementById('loginCard');
    card.style.opacity = '0';
    card.style.transform = 'translateY(24px)';
    card.style.transition = 'all .5s cubic-bezier(.34,1.56,.64,1)';
    setTimeout(() => {
        card.style.opacity = '1';
        card.style.transform = 'translateY(0)';
    }, 100);
});
</script>
</body>
</html>
