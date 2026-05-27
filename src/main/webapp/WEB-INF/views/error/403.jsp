<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi" data-theme="light">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>403 - Không có quyền truy cập | FLearn</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"/>
</head>
<body>
<div style="min-height:100vh;display:flex;align-items:center;justify-content:center;background:var(--bg);padding:2rem;">
    <div style="text-align:center;max-width:500px;">
        <div style="font-size:8rem;font-weight:900;background:linear-gradient(135deg,var(--primary),var(--accent));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;line-height:1;margin-bottom:.5rem;">403</div>
        <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);margin-bottom:.75rem;">Không có quyền truy cập</h2>
        <p style="color:var(--text-muted);margin-bottom:2rem;line-height:1.7;">
            Bạn không có quyền truy cập vào tài liệu hoặc chức năng tại trang này. Vui lòng đăng nhập bằng tài khoản có vai trò phù hợp.
        </p>
        <a href="${pageContext.request.contextPath}/home" class="btn-primary-fl" style="text-decoration:none;font-size:1rem;padding:.85rem 2rem;">
            <i class="fas fa-home me-2"></i>Về trang chủ
        </a>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
