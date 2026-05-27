<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="vi" data-theme="light">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>500 - Lỗi máy chủ | FLearn</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"/>
</head>
<body>
<div style="min-height:100vh;display:flex;align-items:center;justify-content:center;background:var(--bg);padding:2rem;">
    <div style="text-align:center;max-width:500px;">
        <div style="font-size:8rem;font-weight:900;background:linear-gradient(135deg,#e3342f,#f6993f);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;line-height:1;margin-bottom:.5rem;">500</div>
        <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);margin-bottom:.75rem;">Đã xảy ra lỗi máy chủ</h2>
        <p style="color:var(--text-muted);margin-bottom:2rem;line-height:1.7;">
            Hệ thống đang gặp sự cố. Vui lòng thử lại sau.
        </p>
        <a href="${pageContext.request.contextPath}/landing" class="btn-primary-fl" style="text-decoration:none;font-size:1rem;padding:.85rem 2rem;">
            <i class="fas fa-home me-2"></i>Về trang chủ
        </a>
        <div style="text-align:left; background:#1e1e1e; color:#ff5555; padding:10px; overflow:auto; max-height:400px; font-size:12px; margin-top:20px; border-radius:5px; width:100%;">
            <strong>Error Details for Debugging:</strong><br/>
            <% 
                if (exception != null) { 
                    exception.printStackTrace(new java.io.PrintWriter(out)); 
                    try {
                        exception.printStackTrace(new java.io.PrintStream(new java.io.FileOutputStream("d:/Downloads/FLEARN-main/error_jsp_log.txt", true)));
                    } catch(Exception ex) {}
                } else {
                    out.print("No exception object available in JSP.");
                }
            %>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
