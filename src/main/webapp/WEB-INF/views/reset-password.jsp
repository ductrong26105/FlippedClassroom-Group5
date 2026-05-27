<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi" data-theme="light">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${not empty pageTitle ? pageTitle : 'Đặt lại mật khẩu - FLearn'}</title>
    <meta name="description" content="Tạo mật khẩu mới cho tài khoản FLearn."/>
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

    <div class="login-card" id="loginCard" style="max-width: 440px;">
        <!-- Logo -->
        <div class="login-logo">
            <div class="brand-text"><i class="fas fa-graduation-cap"></i> FLearn</div>
            <p>Thiết lập mật khẩu mới</p>
        </div>

        <p style="color: var(--text-muted); font-size: .85rem; line-height: 1.6; text-align: center; margin-bottom: 1.5rem;">
            Vui lòng nhập mật khẩu mới cho tài khoản của bạn. Mật khẩu mới phải dài tối thiểu 6 ký tự.
        </p>

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

        <form id="resetForm" method="post" action="${pageContext.request.contextPath}/reset-password" novalidate>
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
            <!-- Hidden Token field -->
            <input type="hidden" name="token" value="${token}" />

            <!-- New Password -->
            <div class="form-group-fl">
                <label for="password">Mật khẩu mới</label>
                <div class="input-wrap">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Nhập mật khẩu mới..."
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
                           placeholder="Nhập lại mật khẩu mới..."
                           required
                           autocomplete="new-password"/>
                    <i class="fas fa-eye input-icon-right" id="toggleConfirmPassword" onclick="togglePwd('confirmPassword', 'toggleConfirmPassword')"></i>
                </div>
            </div>

            <button type="submit" class="btn-login" id="submitBtn" style="margin-top: 1.5rem;">
                <i class="fas fa-key me-2"></i> Lưu mật khẩu mới
            </button>
        </form>
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

// Client-side validation
document.getElementById('resetForm').addEventListener('submit', function(e) {
    const errorBox = document.getElementById('clientErrorBox');
    const errorMsg = document.getElementById('clientErrorMsg');
    
    errorBox.style.display = 'none';

    const pwd = document.getElementById('password').value;
    const cpwd = document.getElementById('confirmPassword').value;

    if (!pwd || !cpwd) {
        e.preventDefault();
        errorMsg.textContent = 'Vui lòng điền đầy đủ cả hai trường mật khẩu!';
        errorBox.style.display = 'block';
        return;
    }

    if (pwd.length < 6) {
        e.preventDefault();
        errorMsg.textContent = 'Mật khẩu mới phải dài tối thiểu 6 ký tự!';
        errorBox.style.display = 'block';
        return;
    }

    if (pwd !== cpwd) {
        e.preventDefault();
        errorMsg.textContent = 'Mật khẩu xác nhận không trùng khớp! Vui lòng kiểm tra lại.';
        errorBox.style.display = 'block';
        return;
    }

    const btn = document.getElementById('submitBtn');
    btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang lưu mật khẩu...';
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
