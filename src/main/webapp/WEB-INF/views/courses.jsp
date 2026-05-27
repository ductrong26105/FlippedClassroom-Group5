<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">

    <!-- Page Header -->
    <div style="background:var(--bg-card);border-bottom:1px solid var(--border);padding:2.5rem 2rem;">
        <div class="container-fl">
            <div class="section-header" style="margin-bottom:0;">
                <div class="section-tag"><i class="fas fa-book-open me-1"></i>Danh sách</div>
                <h2>Tất cả <span>Khóa học</span></h2>
                <p>Tham gia lớp học với mã mời từ giảng viên hoặc duyệt qua các khóa học công khai</p>
            </div>
        </div>
    </div>

    <section class="content-section">
        <div class="container-fl">

            <!-- Filter / Search bar -->
            <div class="fl-card" style="padding:1.2rem 1.5rem;margin-bottom:2rem;">
                <div class="d-flex gap-3 flex-wrap align-items-center">
                    <div style="position:relative;flex:1;min-width:200px;">
                        <i class="fas fa-search" style="position:absolute;left:.9rem;top:50%;transform:translateY(-50%);color:var(--text-muted);"></i>
                        <input type="text" id="courseSearch" class="fl-input" style="padding-left:2.5rem;"
                               placeholder="Tìm khóa học..."/>
                    </div>

                    <!-- Join by invite code -->
                    <div style="display:flex;gap:.6rem;align-items:center;">
                        <div style="position:relative;">
                            <i class="fas fa-key" style="position:absolute;left:.9rem;top:50%;transform:translateY(-50%);color:var(--text-muted);"></i>
                            <input type="text" id="inviteCodeInput" class="fl-input"
                                   style="padding-left:2.5rem;width:180px;letter-spacing:2px;text-transform:uppercase;"
                                   placeholder="Mã mời..." maxlength="10"/>
                        </div>
                        <button class="btn-primary-fl" onclick="joinByCode()" id="joinBtn">
                            <i class="fas fa-sign-in-alt"></i> Tham gia
                        </button>
                    </div>
                </div>
            </div>

            <!-- Courses Grid -->
            <div class="row g-4" id="coursesGrid">
                <c:choose>
                    <c:when test="${not empty courses}">
                        <c:forEach var="course" items="${courses}">
                            <div class="col-lg-3 col-md-4 col-sm-6 course-col">
                                <div class="course-card h-100"
                                     data-name="${course.className}"
                                     onclick="location.href='${pageContext.request.contextPath}/courses/${course.classId}'">
                                    <div class="card-thumb">
                                        <div style="width:100%;height:160px;background:linear-gradient(135deg,#1e3a5f,#0f1f3a);display:flex;align-items:center;justify-content:center;position:relative;">
                                            <i class="fas fa-play-circle" style="font-size:3.5rem;color:rgba(255,255,255,.15);"></i>
                                            <!-- Gradient overlay with class name initial -->
                                            <div style="position:absolute;bottom:.75rem;left:.85rem;font-size:2rem;font-weight:900;color:rgba(255,255,255,.08);letter-spacing:-1px;">
                                                ${course.className != null && course.className.length() >= 2 ? course.className.substring(0,2).toUpperCase() : (course.className != null ? course.className.toUpperCase() : '')}
                                            </div>
                                        </div>
                                        <span class="thumb-badge">
                                            <i class="fas fa-users me-1"></i>Lớp học
                                        </span>
                                    </div>
                                    <div class="card-body" style="padding:1.1rem;">
                                        <div class="card-title">${course.className}</div>
                                        <div class="card-teacher">
                                            <i class="fas fa-chalkboard-teacher me-1" style="color:var(--primary);"></i>
                                            ${course.teacher.fullName}
                                        </div>
                                        <div style="margin-top:.75rem;">
                                            <div class="invite-code-box" style="font-size:.85rem;padding:.4rem .75rem;letter-spacing:2px;display:inline-flex;">
                                                <i class="fas fa-key" style="font-size:.75rem;opacity:.7;"></i>
                                                ${course.inviteCode}
                                            </div>
                                        </div>
                                        <div class="card-footer-row" style="margin-top:.9rem;">
                                            <span style="font-size:.78rem;color:var(--text-muted);">
                                                <i class="fas fa-calendar me-1"></i>
                                                Hoạt động
                                            </span>
                                            <button class="btn-primary-fl"
                                                    style="padding:.35rem .9rem;font-size:.8rem;"
                                                    onclick="event.stopPropagation(); joinCourse(${course.classId}, '${course.className}')">
                                                <i class="fas fa-plus"></i> Tham gia
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center py-5">
                            <i class="fas fa-book-open" style="font-size:3.5rem;color:var(--text-muted);display:block;margin-bottom:1rem;"></i>
                            <h5 style="color:var(--text-secondary);">Chưa có khóa học nào</h5>
                            <p style="color:var(--text-muted);">Hãy nhập mã mời từ giảng viên để tham gia lớp học</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>
</div>

<%@ include file="layout/user-sidebar.jsp" %>
<%@ include file="layout/footer.jsp" %>

<!-- Join Course Modal -->
<div class="fl-modal-backdrop" id="joinModal" style="display:none;">
    <div class="fl-modal" style="max-width:440px;">
        <div class="fl-modal-header">
            <h3><i class="fas fa-sign-in-alt me-2" style="color:var(--primary);"></i>Xác nhận tham gia</h3>
            <button class="close-btn" onclick="closeJoinModal()"><i class="fas fa-times"></i></button>
        </div>
        <p style="color:var(--text-secondary);font-size:.9rem;" id="joinModalMsg">
            Bạn có chắc muốn tham gia khóa học này không?
        </p>
        <div class="fl-modal-footer">
            <button class="btn-outline-fl" onclick="closeJoinModal()">Hủy</button>
            <form id="joinForm" method="post" action="${pageContext.request.contextPath}/courses/join" style="margin:0;">
                <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                <input type="hidden" name="classId" id="joinClassId"/>
                <button type="submit" class="btn-primary-fl">
                    <i class="fas fa-check"></i> Xác nhận tham gia
                </button>
            </form>
        </div>
    </div>
</div>

<script>
// Course search filter
document.getElementById('courseSearch').addEventListener('input', function() {
    const q = this.value.toLowerCase();
    document.querySelectorAll('.course-col').forEach(col => {
        const name = col.querySelector('.course-card').dataset.name.toLowerCase();
        col.style.display = name.includes(q) ? '' : 'none';
    });
});

// Join by invite code
function joinByCode() {
    const code = document.getElementById('inviteCodeInput').value.trim().toUpperCase();
    if (!code) { showToast('error', 'Lỗi', 'Vui lòng nhập mã mời!'); return; }
    if (code.length < 4) { showToast('error', 'Lỗi', 'Mã mời không hợp lệ!'); return; }
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '${pageContext.request.contextPath}/courses/join-by-code';
    const input = document.createElement('input');
    input.type = 'hidden'; input.name = 'inviteCode'; input.value = code;
    form.appendChild(input); document.body.appendChild(form); form.submit();
}

// Join course modal
let joinClassId = null;
function joinCourse(classId, name) {
    joinClassId = classId;
    document.getElementById('joinClassId').value = classId;
    document.getElementById('joinModalMsg').textContent = `Bạn có chắc muốn tham gia khóa học "${name}"?`;
    document.getElementById('joinModal').style.display = 'flex';
}
function closeJoinModal() {
    document.getElementById('joinModal').style.display = 'none';
}

// Enter key for invite code
document.getElementById('inviteCodeInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') joinByCode();
});
</script>
