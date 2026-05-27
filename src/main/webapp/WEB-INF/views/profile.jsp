<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">
    <div class="container py-5">
        
        <!-- ===== PAGE HEADER ===== -->
        <div class="section-header mb-4">
            <div class="section-tag"><i class="fas fa-user me-1"></i> Hồ sơ</div>
            <h2>Trang <span>cá nhân</span> của bạn</h2>
            <p>Quản lý thông tin tài khoản, chỉnh sửa hồ sơ và bảo mật mật khẩu của bạn.</p>
        </div>

        <div class="row g-4">
            
            <!-- ===== LEFT COLUMN: PROFILE CARD ===== -->
            <div class="col-lg-4">
                <div class="fl-card text-center position-relative overflow-hidden" style="padding: 2.5rem 1.5rem;">
                    <!-- Decorative background glow -->
                    <div style="position: absolute; top: -100px; left: -100px; width: 200px; height: 200px; border-radius: 50%; background: radial-gradient(circle, rgba(59,130,246,0.15) 0%, transparent 70%); pointer-events: none;"></div>
                    <div style="position: absolute; bottom: -100px; right: -100px; width: 200px; height: 200px; border-radius: 50%; background: radial-gradient(circle, rgba(139,92,246,0.12) 0%, transparent 70%); pointer-events: none;"></div>
                    
                    <!-- Avatar circle with custom gradient -->
                    <div class="profile-avatar-circle mx-auto mb-3">
                        <c:out value="${user.fullName.substring(0,1).toUpperCase()}"/>
                    </div>
                    
                    <!-- Name & Email -->
                    <h3 style="font-size: 1.35rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.35rem;">
                        <c:out value="${user.fullName}"/>
                    </h3>
                    <p style="font-size: 0.88rem; color: var(--text-secondary); margin-bottom: 1rem;">
                        <c:out value="${user.email}"/>
                    </p>
                    
                    <!-- Dynamic Role Badge -->
                    <div class="mb-4">
                        <c:choose>
                            <c:when test="${user.role == 0}">
                                <span class="role-badge badge-admin">
                                    <i class="fas fa-shield-alt me-1"></i> Quản trị viên
                                </span>
                            </c:when>
                            <c:when test="${user.role == 1}">
                                <span class="role-badge badge-teacher">
                                    <i class="fas fa-chalkboard-teacher me-1"></i> Giảng viên
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="role-badge badge-student">
                                    <i class="fas fa-user-graduate me-1"></i> Học viên
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div style="height: 1px; background: var(--border); margin: 1.5rem 0;"></div>
                    
                    <!-- Side Stats -->
                    <div class="row text-start g-3" style="font-size: 0.85rem;">
                        <div class="col-6">
                            <span style="color: var(--text-muted); display: block; margin-bottom: 0.15rem;">Tham gia từ</span>
                            <strong style="color: var(--text-primary); font-weight: 600;"><c:out value="${joinedDate}"/></strong>
                        </div>
                        <div class="col-6">
                            <span style="color: var(--text-muted); display: block; margin-bottom: 0.15rem;">Trạng thái</span>
                            <strong style="color: var(--success); font-weight: 600; display: inline-flex; align-items: center; gap: 0.25rem;">
                                <span style="width: 7px; height: 7px; border-radius: 50%; background-color: var(--success); display: inline-block;"></span>
                                Hoạt động
                            </strong>
                        </div>
                    </div>
                    
                </div>
            </div>
            
            <!-- ===== RIGHT COLUMN: MAIN FUNCTION CARD ===== -->
            <div class="col-lg-8">
                <div class="fl-card" style="padding: 2rem;">
                    
                    <!-- Notification Banners -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert-error mb-4" id="serverErrorBox">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <c:out value="${errorMessage}"/>
                        </div>
                    </c:if>
                    
                    <c:if test="${param.success == 'true'}">
                        <div class="alert-success mb-4" style="background: rgba(16,185,129,0.12); border: 1px solid rgba(16,185,129,0.3); color: #A7F3D0; border-radius: var(--radius); padding: 0.75rem 1rem; font-size: 0.87rem; display: flex; align-items: center; gap: 0.5rem;">
                            <i class="fas fa-check-circle me-2"></i>
                            Cập nhật thông tin tài khoản thành công!
                        </div>
                    </c:if>
                    
                    <c:if test="${param.pwdSuccess == 'true'}">
                        <div class="alert-success mb-4" style="background: rgba(16,185,129,0.12); border: 1px solid rgba(16,185,129,0.3); color: #A7F3D0; border-radius: var(--radius); padding: 0.75rem 1rem; font-size: 0.87rem; display: flex; align-items: center; gap: 0.5rem;">
                            <i class="fas fa-check-circle me-2"></i>
                            Thay đổi mật khẩu tài khoản thành công!
                        </div>
                    </c:if>

                    <div class="alert-error mb-4" id="clientErrorBox" style="display: none;">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <span id="clientErrorMsg"></span>
                    </div>

                    <!-- Custom Interactive Tabs -->
                    <div class="profile-tabs mb-4">
                        <button class="profile-tab-btn active" id="btn-overview" onclick="switchTab('overview')">
                            <i class="fas fa-th-large me-2"></i> Tổng quan
                        </button>
                        <button class="profile-tab-btn" id="btn-edit-info" onclick="switchTab('edit-info')">
                            <i class="fas fa-user-edit me-2"></i> Sửa thông tin
                        </button>
                        <button class="profile-tab-btn" id="btn-change-password" onclick="switchTab('change-password')">
                            <i class="fas fa-key me-2"></i> Đổi mật khẩu
                        </button>
                    </div>

                    <!-- ===== TAB CONTENT 1: OVERVIEW ===== -->
                    <div class="tab-content-panel active" id="tab-overview">
                        <h4 class="tab-title"><i class="fas fa-info-circle me-2 text-primary"></i> Chi tiết tài khoản</h4>
                        
                        <div class="row g-3 mt-2">
                            <div class="col-md-6">
                                <div class="info-field-box">
                                    <span class="info-label">Tên đăng nhập (Username)</span>
                                    <span class="info-value"><c:out value="${user.username}"/></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-field-box">
                                    <span class="info-label">Họ và tên</span>
                                    <span class="info-value"><c:out value="${user.fullName}"/></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-field-box">
                                    <span class="info-label">Email đăng ký</span>
                                    <span class="info-value"><c:out value="${user.email}"/></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-field-box">
                                    <span class="info-label">Ngày tạo tài khoản</span>
                                    <span class="info-value"><c:out value="${joinedDate}"/></span>
                                </div>
                            </div>
                        </div>

                        <!-- Extra interactive section -->
                        <div style="height: 1px; background: var(--border); margin: 2rem 0;"></div>
                        
                        <c:choose>
                            <c:when test="${user.role == 1}">
                                <h4 class="tab-title mb-3"><i class="fas fa-chalkboard-teacher me-2 text-accent"></i> Studio của Giảng viên</h4>
                                <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6;">
                                    Với tư cách là Giảng viên, bạn có quyền truy cập vào <strong>Studio</strong> để tạo khóa học mới, cập nhật video bài giảng, soạn thảo các bài trắc nghiệm (quiz) và quản lý tiến trình học tập của từng lớp học.
                                </p>
                                <a href="${pageContext.request.contextPath}/teacher/dashboard" class="btn-primary-fl mt-2" style="text-decoration:none;">
                                    <i class="fas fa-rocket"></i> Truy cập Dashboard Giảng viên
                                </a>
                            </c:when>
                            <c:when test="${user.role == 0}">
                                <h4 class="tab-title mb-3"><i class="fas fa-shield-alt me-2 text-danger"></i> Quyền Quản trị viên</h4>
                                <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6;">
                                    Tài khoản của bạn có quyền Quản trị tối cao. Bạn có thể truy cập <strong>Bảng quản trị (Admin Panel)</strong> để kiểm soát danh sách người dùng, phê duyệt tài khoản giảng viên, quản lý khóa học và xem báo cáo hệ thống.
                                </p>
                                <a href="${pageContext.request.contextPath}/admin/panel" class="btn-primary-fl mt-2" style="text-decoration:none;">
                                    <i class="fas fa-cogs"></i> Đi tới trang Quản trị
                                </a>
                            </c:when>
                            <c:otherwise>
                                <h4 class="tab-title mb-3"><i class="fas fa-graduation-cap me-2 text-primary"></i> Tiến trình học tập</h4>
                                <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin-bottom: 1.25rem;">
                                    Theo dõi và tham gia các bài học để nhận về điểm thưởng cũng như kho chứng chỉ uy tín từ FLearn.
                                </p>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="fl-card text-center" style="padding: 1rem; border-color: rgba(59,130,246,0.15);">
                                            <div style="font-size: 1.5rem; font-weight: 800; color: var(--primary);">0</div>
                                            <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 0.15rem;">Khóa học tham gia</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="fl-card text-center" style="padding: 1rem; border-color: rgba(139,92,246,0.15);">
                                            <div style="font-size: 1.5rem; font-weight: 800; color: var(--accent);">0 pts</div>
                                            <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 0.15rem;">Điểm thưởng tích lũy</div>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- ===== TAB CONTENT 2: EDIT INFO ===== -->
                    <div class="tab-content-panel" id="tab-edit-info">
                        <h4 class="tab-title"><i class="fas fa-edit me-2 text-primary"></i> Chỉnh sửa thông tin cá nhân</h4>
                        
                        <form id="editInfoForm" method="post" action="${pageContext.request.contextPath}/profile" class="mt-4">
                            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                            <input type="hidden" name="action" value="updateInfo"/>
                            
                            <div class="form-group-fl mb-3">
                                <label for="fullName" style="color: var(--text-primary);">Họ và tên</label>
                                <div class="input-wrap">
                                    <i class="fas fa-id-card input-icon" style="color: var(--text-muted);"></i>
                                    <input type="text"
                                           id="fullName"
                                           name="fullName"
                                           placeholder="Nhập họ và tên..."
                                           value="<c:out value="${user.fullName}"/>"
                                           required
                                           style="background: var(--bg-surface); border-color: var(--border); color: var(--text-primary);"/>
                                </div>
                            </div>
                            
                            <div class="form-group-fl mb-4">
                                <label for="email" style="color: var(--text-primary);">Địa chỉ Email</label>
                                <div class="input-wrap">
                                    <i class="fas fa-envelope input-icon" style="color: var(--text-muted);"></i>
                                    <input type="email"
                                           id="email"
                                           name="email"
                                           placeholder="Nhập địa chỉ email..."
                                           value="<c:out value="${user.email}"/>"
                                           required
                                           style="background: var(--bg-surface); border-color: var(--border); color: var(--text-primary);"/>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn-primary-fl" id="saveInfoBtn">
                                <i class="fas fa-save me-2"></i> Lưu thay đổi
                            </button>
                        </form>
                    </div>

                    <!-- ===== TAB CONTENT 3: CHANGE PASSWORD ===== -->
                    <div class="tab-content-panel" id="tab-change-password">
                        <h4 class="tab-title"><i class="fas fa-key me-2 text-primary"></i> Thay đổi mật khẩu an toàn</h4>
                        
                        <form id="changePasswordForm" method="post" action="${pageContext.request.contextPath}/profile" class="mt-4">
                            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                            <input type="hidden" name="action" value="changePassword"/>
                            
                            <div class="form-group-fl mb-3">
                                <label for="oldPassword" style="color: var(--text-primary);">Mật khẩu cũ</label>
                                <div class="input-wrap">
                                    <i class="fas fa-lock input-icon" style="color: var(--text-muted);"></i>
                                    <input type="password"
                                           id="oldPassword"
                                           name="oldPassword"
                                           placeholder="Nhập mật khẩu hiện tại..."
                                           required
                                           style="background: var(--bg-surface); border-color: var(--border); color: var(--text-primary);"/>
                                    <i class="fas fa-eye input-icon-right" id="toggleOldPassword" onclick="togglePwd('oldPassword', 'toggleOldPassword')" style="color: var(--text-muted);"></i>
                                </div>
                            </div>
                            
                            <div class="form-group-fl mb-3">
                                <label for="newPassword" style="color: var(--text-primary);">Mật khẩu mới</label>
                                <div class="input-wrap">
                                    <i class="fas fa-lock-open input-icon" style="color: var(--text-muted);"></i>
                                    <input type="password"
                                           id="newPassword"
                                           name="newPassword"
                                           placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)..."
                                           required
                                           style="background: var(--bg-surface); border-color: var(--border); color: var(--text-primary);"/>
                                    <i class="fas fa-eye input-icon-right" id="toggleNewPassword" onclick="togglePwd('newPassword', 'toggleNewPassword')" style="color: var(--text-muted);"></i>
                                </div>
                            </div>
                            
                            <div class="form-group-fl mb-4">
                                <label for="confirmPassword" style="color: var(--text-primary);">Xác nhận mật khẩu mới</label>
                                <div class="input-wrap">
                                    <i class="fas fa-shield-alt input-icon" style="color: var(--text-muted);"></i>
                                    <input type="password"
                                           id="confirmPassword"
                                           name="confirmPassword"
                                           placeholder="Nhập lại mật khẩu mới..."
                                           required
                                           style="background: var(--bg-surface); border-color: var(--border); color: var(--text-primary);"/>
                                    <i class="fas fa-eye input-icon-right" id="toggleConfirmPassword" onclick="togglePwd('confirmPassword', 'toggleConfirmPassword')" style="color: var(--text-muted);"></i>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn-primary-fl" id="savePasswordBtn">
                                <i class="fas fa-lock me-2"></i> Đổi mật khẩu
                            </button>
                        </form>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

<%@ include file="layout/user-sidebar.jsp" %>
<%@ include file="layout/footer.jsp" %>

<!-- ===== PREMIUM EMBEDDED STYLING FOR PROFILE ===== -->
<style>
    /* Profile Circle Avatar */
    .profile-avatar-circle {
        width: 110px;
        height: 110px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary), var(--accent));
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-weight: 800;
        font-size: 2.8rem;
        box-shadow: 0 10px 25px rgba(59, 130, 246, 0.35);
        border: 4px solid rgba(255, 255, 255, 0.15);
    }
    [data-theme="light"] .profile-avatar-circle {
        border-color: rgba(255, 255, 255, 0.9);
    }

    /* Role Badges */
    .role-badge {
        display: inline-flex;
        align-items: center;
        padding: 0.35rem 1rem;
        border-radius: 50px;
        font-size: 0.78rem;
        font-weight: 700;
        color: #fff;
    }
    .badge-admin {
        background: linear-gradient(135deg, var(--danger), #EC4899);
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.25);
    }
    .badge-teacher {
        background: linear-gradient(135deg, var(--accent), #EC4899);
        box-shadow: 0 4px 12px rgba(139, 92, 246, 0.25);
    }
    .badge-student {
        background: linear-gradient(135deg, var(--primary), var(--primary-light));
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.25);
    }

    /* Tabs Styling */
    .profile-tabs {
        display: flex;
        gap: 0.5rem;
        border-bottom: 1.5px solid var(--border);
        padding-bottom: 0.5rem;
        flex-wrap: wrap;
    }
    .profile-tab-btn {
        background: transparent;
        border: none;
        padding: 0.7rem 1.25rem;
        border-radius: var(--radius);
        color: var(--text-secondary);
        font-weight: 600;
        font-size: 0.9rem;
        transition: var(--transition);
        cursor: pointer;
        display: flex;
        align-items: center;
    }
    .profile-tab-btn:hover {
        color: var(--primary);
        background: rgba(59, 130, 246, 0.08);
    }
    .profile-tab-btn.active {
        color: #fff;
        background: linear-gradient(135deg, var(--primary), var(--accent));
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.25);
    }
    
    /* Content Panels */
    .tab-content-panel {
        display: none;
        animation: fadeIn 0.4s ease;
    }
    .tab-content-panel.active {
        display: block;
    }
    .tab-title {
        font-size: 1.15rem;
        font-weight: 700;
        color: var(--text-primary);
        margin-bottom: 0.5rem;
    }

    /* Info Field Boxes */
    .info-field-box {
        background: var(--bg-surface);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        padding: 0.85rem 1.1rem;
        transition: var(--transition);
    }
    .info-field-box:hover {
        border-color: var(--primary);
        transform: translateY(-2px);
    }
    .info-label {
        font-size: 0.72rem;
        color: var(--text-muted);
        display: block;
        margin-bottom: 0.25rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    .info-value {
        font-size: 0.95rem;
        font-weight: 600;
        color: var(--text-primary);
        word-break: break-all;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(8px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<!-- ===== INTERACTIVE JAVASCRIPT FOR TABS & VALIDATION ===== -->
<script>
    // Tab switching engine
    function switchTab(tabName) {
        // Deactivate all buttons & panels
        document.querySelectorAll('.profile-tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelectorAll('.tab-content-panel').forEach(panel => panel.classList.remove('active'));

        // Activate matching button & panel
        const activeBtn = document.getElementById('btn-' + tabName);
        const activePanel = document.getElementById('tab-' + tabName);
        if (activeBtn) activeBtn.classList.add('active');
        if (activePanel) activePanel.classList.add('active');
        
        // Hide general client error box
        document.getElementById('clientErrorBox').style.display = 'none';
    }

    // Toggle Password Visibility
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

    // Client-side forms verification
    document.addEventListener('DOMContentLoaded', function() {
        
        // Determine active tab on initial load based on controller parameter
        const activeTabAttr = '${activeTab}';
        if (activeTabAttr && (activeTabAttr === 'edit-info' || activeTabAttr === 'change-password')) {
            switchTab(activeTabAttr);
        }

        // 1. Info form validation
        const infoForm = document.getElementById('editInfoForm');
        infoForm.addEventListener('submit', function(e) {
            const errorBox = document.getElementById('clientErrorBox');
            const errorMsg = document.getElementById('clientErrorMsg');
            errorBox.style.display = 'none';

            const fullName = document.getElementById('fullName').value.trim();
            const email = document.getElementById('email').value.trim();

            if (!fullName || !email) {
                e.preventDefault();
                errorMsg.textContent = 'Vui lòng nhập đầy đủ Họ và tên, và địa chỉ Email!';
                errorBox.style.display = 'block';
                return;
            }

            // Simple email validation regex
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                errorMsg.textContent = 'Định dạng địa chỉ Email không hợp lệ!';
                errorBox.style.display = 'block';
                return;
            }

            // Set loading state
            const saveBtn = document.getElementById('saveInfoBtn');
            saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Đang lưu...';
            saveBtn.disabled = true;
        });

        // 2. Change password validation
        const pwdForm = document.getElementById('changePasswordForm');
        pwdForm.addEventListener('submit', function(e) {
            const errorBox = document.getElementById('clientErrorBox');
            const errorMsg = document.getElementById('clientErrorMsg');
            errorBox.style.display = 'none';

            const oldPwd = document.getElementById('oldPassword').value;
            const newPwd = document.getElementById('newPassword').value;
            const confirmPwd = document.getElementById('confirmPassword').value;

            if (!oldPwd || !newPwd || !confirmPwd) {
                e.preventDefault();
                errorMsg.textContent = 'Vui lòng nhập đầy đủ mật khẩu cũ và mật khẩu mới!';
                errorBox.style.display = 'block';
                return;
            }

            if (newPwd.length < 6) {
                e.preventDefault();
                errorMsg.textContent = 'Mật khẩu mới phải chứa ít nhất 6 ký tự!';
                errorBox.style.display = 'block';
                return;
            }

            if (newPwd !== confirmPwd) {
                e.preventDefault();
                errorMsg.textContent = 'Mật khẩu mới và Mật khẩu xác nhận không khớp!';
                errorBox.style.display = 'block';
                return;
            }

            if (oldPwd === newPwd) {
                e.preventDefault();
                errorMsg.textContent = 'Mật khẩu mới không được trùng với mật khẩu cũ hiện tại!';
                errorBox.style.display = 'block';
                return;
            }

            // Set loading state
            const pwdBtn = document.getElementById('savePasswordBtn');
            pwdBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Đang cập nhật mật khẩu...';
            pwdBtn.disabled = true;
        });
    });
</script>
