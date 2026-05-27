<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>

<div class="page-wrapper">
<div class="studio-layout">

    <!-- Admin Sidebar -->
    <div class="studio-sidebar">
        <div style="padding:.5rem .75rem 1.25rem;border-bottom:1px solid var(--border);margin-bottom:.75rem;">
            <div style="font-size:1rem;font-weight:800;color:var(--text-primary);">
                <i class="fas fa-shield-alt me-2" style="color:var(--danger);"></i>
                Admin Panel
            </div>
            <div style="font-size:.75rem;color:var(--text-muted);margin-top:.2rem;">
                Quản trị hệ thống
            </div>
        </div>
        <div class="studio-section-title">Quản lý</div>
        <a class="studio-nav-item active" onclick="showAdminSection('dashboard')">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <a class="studio-nav-item" onclick="showAdminSection('users')">
            <i class="fas fa-users"></i> Người dùng
        </a>
        <a class="studio-nav-item" onclick="showAdminSection('classes')">
            <i class="fas fa-book-open"></i> Lớp học
        </a>
        <div class="studio-section-title">Hệ thống</div>
        <a class="studio-nav-item" onclick="showAdminSection('sessions')">
            <i class="fas fa-broadcast-tower"></i> Live Sessions
        </a>
    </div>

    <!-- Admin Main -->
    <div class="studio-main">

        <!-- ============ DASHBOARD ============ -->
        <div id="admin-dashboard" class="admin-section">
            <div style="margin-bottom:1.75rem;">
                <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);">
                    <i class="fas fa-tachometer-alt me-2" style="color:var(--primary);"></i>Dashboard Analytics
                </h2>
                <p style="color:var(--text-muted);font-size:.88rem;">Tổng quan hệ thống FLearn</p>
            </div>

            <!-- Stat cards -->
            <div class="analytics-grid">
                <div class="stat-card">
                    <div class="stat-icon blue"><i class="fas fa-users"></i></div>
                    <div>
                        <div class="stat-value">${totalUsers != null ? totalUsers : '--'}</div>
                        <div class="stat-label">Tổng người dùng</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon purple"><i class="fas fa-chalkboard-teacher"></i></div>
                    <div>
                        <div class="stat-value">${totalTeachers != null ? totalTeachers : '--'}</div>
                        <div class="stat-label">Giảng viên</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon green"><i class="fas fa-graduation-cap"></i></div>
                    <div>
                        <div class="stat-value">${totalStudents != null ? totalStudents : '--'}</div>
                        <div class="stat-label">Học viên</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon yellow"><i class="fas fa-book-open"></i></div>
                    <div>
                        <div class="stat-value">${totalClasses != null ? totalClasses : '--'}</div>
                        <div class="stat-label">Lớp học hoạt động</div>
                    </div>
                </div>
            </div>

            <!-- Charts -->
            <div class="row g-4 mt-1">
                <div class="col-lg-8">
                    <div class="fl-card">
                        <h5 style="font-weight:700;margin-bottom:1rem;color:var(--text-primary);">
                            <i class="fas fa-chart-bar me-1" style="color:var(--primary);"></i>
                            Phân bổ người dùng theo vai trò
                        </h5>
                        <canvas id="roleChart" height="200"></canvas>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="fl-card">
                        <h5 style="font-weight:700;margin-bottom:1rem;color:var(--text-primary);">
                            <i class="fas fa-chart-pie me-1" style="color:var(--accent);"></i>
                            Tỉ lệ vai trò
                        </h5>
                        <canvas id="rolePieChart" height="200"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- ============ USERS ============ -->
        <div id="admin-users" class="admin-section" style="display:none;">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);">
                    <i class="fas fa-users me-2" style="color:var(--primary);"></i>Quản lý người dùng
                </h2>
                <button class="btn-primary-fl" onclick="openCreateUserModal()">
                    <i class="fas fa-user-plus"></i> Thêm người dùng
                </button>
            </div>

            <div class="fl-table-wrap">
                <div class="fl-table-header">
                    <h3>Danh sách thành viên</h3>
                    <div class="table-search">
                        <i class="fas fa-search"></i>
                        <input type="text" id="userSearch" placeholder="Tìm người dùng..." oninput="filterUsers()"/>
                    </div>
                </div>
                <div style="overflow-x:auto;">
                    <table class="fl-table" id="usersTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người dùng</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty users}">
                                    <c:forEach var="u" items="${users}">
                                        <tr data-name="${u.fullName}" data-email="${u.email}">
                                            <td style="color:var(--text-muted);font-size:.8rem;">#${u.userId}</td>
                                            <td>
                                                <div style="display:flex;align-items:center;gap:.75rem;">
                                                    <div class="avatar-sm">${not empty u.fullName ? u.fullName.substring(0,1).toUpperCase() : 'U'}</div>
                                                    <div>
                                                        <div style="font-weight:600;color:var(--text-primary);font-size:.88rem;">${u.fullName}</div>
                                                        <div style="font-size:.75rem;color:var(--text-muted);">@${u.username}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td style="font-size:.85rem;">${u.email}</td>
                                            <td>
                                                <select class="fl-select"
                                                        style="padding:.25rem .5rem;font-size:.8rem;width:auto;border-radius:50px;"
                                                        onchange="changeRole(${u.userId}, this.value)">
                                                    <option value="0" ${u.role == 0 ? 'selected' : ''}>Admin</option>
                                                    <option value="1" ${u.role == 1 ? 'selected' : ''}>Giảng viên</option>
                                                    <option value="2" ${u.role == 2 ? 'selected' : ''}>Học viên</option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="status-toggle" onclick="toggleUserStatus(${u.userId}, this)">
                                                    <div class="toggle-switch ${u.active ? 'on' : ''}" id="toggle-${u.userId}"></div>
                                                    <span style="font-size:.8rem;color:var(--text-secondary);" id="toggle-label-${u.userId}">
                                                        ${u.active ? 'Hoạt động' : 'Đã khóa'}
                                                    </span>
                                                </div>
                                            </td>
                                            <td style="font-size:.82rem;color:var(--text-muted);">
                                                ${u.createdAt}
                                            </td>
                                            <td>
                                                <button class="btn-danger-fl" style="padding:.3rem .7rem;font-size:.78rem;"
                                                        onclick="confirmDeleteUser(${u.userId}, '${u.fullName}')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" style="text-align:center;padding:2rem;color:var(--text-muted);">
                                            Không có người dùng nào
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- ============ CLASSES ============ -->
        <div id="admin-classes" class="admin-section" style="display:none;">
            <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);margin-bottom:1.5rem;">
                <i class="fas fa-book-open me-2" style="color:var(--primary);"></i>Quản lý lớp học
            </h2>
            <div class="fl-table-wrap">
                <div class="fl-table-header"><h3>Tất cả lớp học</h3></div>
                <table class="fl-table">
                    <thead>
                        <tr>
                            <th>Tên lớp</th>
                            <th>Giảng viên</th>
                            <th>Mã mời</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cls" items="${allClasses}">
                            <tr>
                                <td style="font-weight:600;color:var(--text-primary);">${cls.className}</td>
                                <td>${not empty cls.teacher and not empty cls.teacher.fullName ? cls.teacher.fullName : 'N/A'}</td>
                                <td><span class="invite-code-box" style="font-size:.78rem;padding:.2rem .5rem;letter-spacing:2px;">${cls.inviteCode}</span></td>
                                <td>
                                    <span style="background:rgba(16,185,129,.1);color:var(--success);padding:.2rem .65rem;border-radius:50px;font-size:.75rem;font-weight:700;">
                                        ● Hoạt động
                                    </span>
                                </td>
                                <td style="font-size:.82rem;color:var(--text-muted);">${cls.createdAt}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ============ LIVE SESSIONS ============ -->
        <div id="admin-sessions" class="admin-section" style="display:none;">
            <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);margin-bottom:1.5rem;">
                <i class="fas fa-broadcast-tower me-2" style="color:var(--danger);"></i>Live Sessions
            </h2>
            <div class="fl-table-wrap">
                <div class="fl-table-header"><h3>Lịch sử phiên học trực tiếp</h3></div>
                <table class="fl-table">
                    <thead>
                        <tr>
                            <th>Lớp học</th>
                            <th>Giảng viên</th>
                            <th>Bắt đầu</th>
                            <th>Kết thúc</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="5" style="text-align:center;padding:2rem;color:var(--text-muted);">
                                Chưa có phiên học nào
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div><!-- end studio-main -->
</div><!-- end studio-layout -->
</div><!-- end page-wrapper -->

<%@ include file="../layout/user-sidebar.jsp" %>

<!-- Delete user modal -->
<div class="fl-modal-backdrop" id="deleteUserModal" style="display:none;">
    <div class="fl-modal" style="max-width:420px;">
        <div class="fl-modal-header">
            <h3 style="color:var(--danger);"><i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa</h3>
            <button class="close-btn" onclick="closeModal('deleteUserModal')"><i class="fas fa-times"></i></button>
        </div>
        <p style="color:var(--text-secondary);font-size:.9rem;" id="deleteUserMsg">
            Bạn có chắc muốn xóa người dùng này?
        </p>
        <div class="fl-modal-footer">
            <button class="btn-outline-fl" onclick="closeModal('deleteUserModal')">Hủy</button>
            <button class="btn-danger-fl" id="confirmDeleteBtn">
                <i class="fas fa-trash"></i> Xóa
            </button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js?v=2" charset="UTF-8"></script>
<script>
const ADMIN_CONFIG = {
    contextPath: '${pageContext.request.contextPath}',
    totalUsers: ${totalUsers != null ? totalUsers : 0},
    totalTeachers: ${totalTeachers != null ? totalTeachers : 0},
    totalStudents: ${totalStudents != null ? totalStudents : 0},
    totalAdmins: ${totalAdmins != null ? totalAdmins : 0}
};

function showAdminSection(name) {
    document.querySelectorAll('.admin-section').forEach(s => s.style.display = 'none');
    document.getElementById('admin-' + name).style.display = '';
    document.querySelectorAll('.studio-nav-item').forEach(a => a.classList.remove('active'));
    event.currentTarget.classList.add('active');
}

function filterUsers() {
    const q = document.getElementById('userSearch').value.toLowerCase();
    document.querySelectorAll('#usersTable tbody tr').forEach(row => {
        const name = (row.dataset.name || '').toLowerCase();
        const email = (row.dataset.email || '').toLowerCase();
        row.style.display = (name.includes(q) || email.includes(q)) ? '' : 'none';
    });
}

function changeRole(userId, role) {
    fetch(`${pageContext.request.contextPath}/admin/users/role`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `userId=${userId}&role=${role}`
    }).then(r => {
        if (r.ok) showToast('success', 'Thành công', 'Đã cập nhật vai trò!');
        else showToast('error', 'Lỗi', 'Không thể cập nhật vai trò.');
    });
}

function toggleUserStatus(userId, el) {
    const toggle = document.getElementById('toggle-' + userId);
    const label = document.getElementById('toggle-label-' + userId);
    const isNowActive = !toggle.classList.contains('on');
    fetch(`${pageContext.request.contextPath}/admin/users/status`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `userId=${userId}&isActive=${isNowActive}`
    }).then(r => {
        if (r.ok) {
            toggle.classList.toggle('on');
            label.textContent = isNowActive ? 'Hoạt động' : 'Đã khóa';
            showToast('success', 'Đã cập nhật', isNowActive ? 'Tài khoản đã được mở khóa' : 'Tài khoản đã bị khóa');
        }
    });
}

function confirmDeleteUser(userId, name) {
    document.getElementById('deleteUserMsg').textContent = `Xóa người dùng "${name}"? Hành động này không thể hoàn tác!`;
    document.getElementById('confirmDeleteBtn').onclick = () => deleteUser(userId);
    document.getElementById('deleteUserModal').style.display = 'flex';
}

function deleteUser(userId) {
    fetch(`${pageContext.request.contextPath}/admin/users/delete`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `userId=${userId}`
    }).then(r => {
        if (r.ok) {
            closeModal('deleteUserModal');
            location.reload();
        }
    });
}

// Charts
document.addEventListener('DOMContentLoaded', () => {
    // Bar chart
    const ctx1 = document.getElementById('roleChart');
    if (ctx1) {
        new Chart(ctx1, {
            type: 'bar',
            data: {
                labels: ['Admin', 'Giảng viên', 'Học viên'],
                datasets: [{
                    label: 'Số lượng',
                    data: [ADMIN_CONFIG.totalAdmins, ADMIN_CONFIG.totalTeachers, ADMIN_CONFIG.totalStudents],
                    backgroundColor: ['rgba(239,68,68,.7)', 'rgba(59,130,246,.7)', 'rgba(16,185,129,.7)'],
                    borderRadius: 8,
                    borderSkipped: false
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, grid: { color: 'rgba(100,116,139,.1)' } },
                    x: { grid: { display: false } }
                }
            }
        });
    }
    // Pie chart
    const ctx2 = document.getElementById('rolePieChart');
    if (ctx2) {
        new Chart(ctx2, {
            type: 'doughnut',
            data: {
                labels: ['Admin', 'Giảng viên', 'Học viên'],
                datasets: [{
                    data: [ADMIN_CONFIG.totalAdmins, ADMIN_CONFIG.totalTeachers, ADMIN_CONFIG.totalStudents],
                    backgroundColor: ['rgba(239,68,68,.8)', 'rgba(59,130,246,.8)', 'rgba(16,185,129,.8)'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                cutout: '65%',
                plugins: { legend: { position: 'bottom' } }
            }
        });
    }
});
</script>
<%@ include file="../layout/footer.jsp" %>
