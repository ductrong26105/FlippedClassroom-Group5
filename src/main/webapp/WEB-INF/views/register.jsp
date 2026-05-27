<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi" data-theme="light">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${not empty pageTitle ? pageTitle : 'Đăng ký tài khoản - FLearn'}</title>
    <meta name="description" content="Đăng ký tài khoản mới trên FLearn để bắt đầu hành trình học tập trực tuyến."/>
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

    <div class="login-card" id="loginCard" style="max-width: 480px; margin: 2rem auto;">
        <!-- Logo -->
        <div class="login-logo">
            <div class="brand-text"><i class="fas fa-graduation-cap"></i> FLearn</div>
            <p>Tạo tài khoản học viên mới</p>
        </div>

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

        <!-- Register Form -->
        <form id="registerForm" method="post" action="${pageContext.request.contextPath}/register" class="needs-validation" novalidate>
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">

            <!-- Full Name -->
            <div class="form-group-fl">
                <label for="fullName">Họ và tên</label>
                <div class="input-wrap">
                    <i class="fas fa-id-card input-icon"></i>
                    <input type="text"
                           id="fullName"
                           name="fullName"
                           placeholder="Nhập họ và tên của bạn..."
                           value="${param.fullName}"
                           required
                           autocomplete="name"/>
                </div>
            </div>

            <!-- Username -->
            <div class="form-group-fl">
                <label for="username">Tên đăng nhập</label>
                <div class="input-wrap">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text"
                           id="username"
                           name="username"
                           placeholder="Nhập tên đăng nhập (viết liền, không dấu)..."
                           value="${param.username}"
                           required
                           pattern="^[a-zA-Z0-9._-]{3,30}$"
                           autocomplete="username"/>
                </div>
            </div>

            <!-- Email -->
            <div class="form-group-fl">
                <label for="email">Địa chỉ Email</label>
                <div class="input-wrap">
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="Nhập địa chỉ email..."
                           value="${param.email}"
                           required
                           autocomplete="email"/>
                </div>
            </div>

            <!-- Password -->
            <div class="form-group-fl">
                <label for="password">Mật khẩu</label>
                <div class="input-wrap">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Tạo mật khẩu (tối thiểu 6 ký tự)..."
                           required
                           minlength="6"
                           autocomplete="new-password"/>
                    <i class="fas fa-eye input-icon-right" id="togglePassword" onclick="togglePwd('password', 'togglePassword')"></i>
                </div>
            </div>

            <!-- Confirm Password -->
            <div class="form-group-fl">
                <label for="confirmPassword">Xác nhận mật khẩu</label>
                <div class="input-wrap">
                    <i class="fas fa-shield-alt input-icon"></i>
                    <input type="password"
                           id="confirmPassword"
                           name="confirmPassword"
                           placeholder="Nhập lại mật khẩu để xác nhận..."
                           required
                           autocomplete="new-password"/>
                    <i class="fas fa-eye input-icon-right" id="toggleConfirmPassword" onclick="togglePwd('confirmPassword', 'toggleConfirmPassword')"></i>
                </div>
            </div>

            <!-- Submit -->
            <button type="submit" class="btn-login" id="registerBtn" style="margin-top: 1.5rem;">
                <i class="fas fa-user-plus me-2"></i> Đăng ký tài khoản
            </button>
        </form>

        <div class="login-divider" style="margin: 1.5rem 0;">
            <span>Đã có tài khoản?</span>
        </div>

        <!-- Back to login -->
        <div style="text-align:center;">
            <a href="${pageContext.request.contextPath}/login"
               class="btn-outline-fl"
               style="text-decoration:none; display:inline-block; width:100%; text-align:center; padding:.8rem;">
                <i class="fas fa-sign-in-alt me-2"></i> Đăng nhập ngay
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js?v=2" charset="UTF-8"></script>
<script>
function togglePwd(inputId, iconId) {
    const inp = document.getElementById(inputId);
    const icon = document.getElementById(iconId);
    if (inp.type === 'password') {
        inp.type = 'text';
        icon.className = 'fas fa-eye-slash input-icon-right';
    } else {
        inp.type = 'password';
        icon.className = 'fas fa-eye input-icon-right';
    }
}

// Client-side Validation & Matching Password check
document.getElementById('registerForm').addEventListener('submit', function(e) {
    const errorBox = document.getElementById('clientErrorBox');
    const errorMsg = document.getElementById('clientErrorMsg');
    
    // Hide previous errors
    errorBox.style.display = 'none';

    const fullName = document.getElementById('fullName').value.trim();
    const username = document.getElementById('username').value.trim();
    const email = document.getElementById('email').value.trim();
    const pwd = document.getElementById('password').value;
    const cpwd = document.getElementById('confirmPassword').value;

    // Check empty fields
    if (!fullName || !username || !email || !pwd || !cpwd) {
        e.preventDefault();
        errorMsg.textContent = 'Vui lòng điền đầy đủ tất cả các trường thông tin!';
        errorBox.style.display = 'block';
        return;
    }

    // Check username pattern
    const usernameRegex = /^[a-zA-Z0-9._-]{3,30}$/;
    if (!usernameRegex.test(username)) {
        e.preventDefault();
        errorMsg.textContent = 'Tên đăng nhập không hợp lệ! (Chỉ chứa chữ cái, số, dấu chấm, gạch dưới, gạch ngang và dài 3-30 ký tự)';
        errorBox.style.display = 'block';
        return;
    }

    // Check password length
    if (pwd.length < 6) {
        e.preventDefault();
        errorMsg.textContent = 'Mật khẩu phải chứa tối thiểu 6 ký tự!';
        errorBox.style.display = 'block';
        return;
    }

    // Check matching passwords
    if (pwd !== cpwd) {
        e.preventDefault();
        errorMsg.textContent = 'Mật khẩu xác nhận không trùng khớp! Vui lòng kiểm tra lại.';
        errorBox.style.display = 'block';
        return;
    }

    // Loading state on successful check
    const btn = document.getElementById('registerBtn');
    btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang tạo tài khoản...';
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
