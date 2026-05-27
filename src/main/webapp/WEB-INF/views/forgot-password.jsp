<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi" data-theme="light">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${not empty pageTitle ? pageTitle : 'Quên mật khẩu - FLearn'}</title>
    <meta name="description" content="Khôi phục mật khẩu tài khoản học trực tuyến FLearn."/>
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
            <p>Khôi phục mật khẩu tài khoản</p>
        </div>

        <c:choose>
            <c:when test="${not empty successMessage}">
                <!-- Success view -->
                <div style="text-align: center; padding: 1.5rem 0;">
                    <div style="font-size: 3.5rem; color: #10b981; margin-bottom: 1.5rem;">
                        <i class="fas fa-paper-plane animate-bounce"></i>
                    </div>
                    <h3 style="font-size: 1.25rem; font-weight: 700; color: var(--text-primary); margin-bottom: .75rem;">
                        Đã gửi Email thành công!
                    </h3>
                    <p style="color: var(--text-muted); font-size: .88rem; line-height: 1.6; margin-bottom: 2rem;">
                        ${successMessage}
                    </p>
                    <a href="${pageContext.request.contextPath}/login" class="btn-primary-fl" style="text-decoration: none; display: inline-block; padding: .75rem 2rem;">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại Đăng nhập
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Form view -->
                <p style="color: var(--text-muted); font-size: .85rem; line-height: 1.6; text-align: center; margin-bottom: 1.5rem;">
                    Vui lòng nhập địa chỉ Email liên kết với tài khoản của bạn. Chúng tôi sẽ gửi một liên kết bảo mật để đặt lại mật khẩu của bạn.
                </p>

                <!-- Error messages -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert-error" style="margin-bottom: 1.25rem;">
                        <i class="fas fa-exclamation-circle"></i>
                        ${errorMessage}
                    </div>
                </c:if>

                <form id="forgotForm" method="post" action="${pageContext.request.contextPath}/forgot-password" novalidate>
                    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                    <div class="form-group-fl">
                        <label for="email">Địa chỉ Email</label>
                        <div class="input-wrap">
                            <i class="fas fa-envelope input-icon"></i>
                            <input type="email"
                                   id="email"
                                   name="email"
                                   placeholder="Nhập địa chỉ email của bạn..."
                                   value="${param.email}"
                                   required
                                   autocomplete="email"/>
                        </div>
                    </div>

                    <button type="submit" class="btn-login" id="submitBtn" style="margin-top: 1.5rem;">
                        <i class="fas fa-paper-plane me-2"></i> Gửi yêu cầu khôi phục
                    </button>
                </form>

                <div class="login-divider" style="margin: 1.5rem 0;">
                    <span>Hoặc</span>
                </div>

                <div style="text-align:center;">
                    <a href="${pageContext.request.contextPath}/login"
                       class="btn-outline-fl"
                       style="text-decoration:none; display:inline-block; width:100%; text-align:center; padding:.8rem;">
                        <i class="fas fa-arrow-left me-2"></i> Quay về Đăng nhập
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js?v=2" charset="UTF-8"></script>
<script>
// Loading state on submit
const form = document.getElementById('forgotForm');
if (form) {
    form.addEventListener('submit', function(e) {
        const email = document.getElementById('email').value.trim();
        if (!email) {
            e.preventDefault();
            alert('Vui lòng nhập địa chỉ Email của bạn!');
            return;
        }

        const btn = document.getElementById('submitBtn');
        btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi yêu cầu...';
        btn.disabled = true;
    });
}

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
