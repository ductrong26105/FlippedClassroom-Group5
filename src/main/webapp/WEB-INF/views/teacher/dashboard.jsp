<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../layout/header.jsp" %>

<div class="page-wrapper">
<div class="studio-layout">

    <!-- ===== STUDIO SIDEBAR ===== -->
    <div class="studio-sidebar">
        <div style="padding:.5rem .75rem 1.25rem;border-bottom:1px solid var(--border);margin-bottom:.75rem;">
            <div style="font-size:1rem;font-weight:800;color:var(--text-primary);">
                <i class="fas fa-chalkboard-teacher me-2" style="color:var(--primary);"></i>
                Teacher Studio
            </div>
            <div style="font-size:.75rem;color:var(--text-muted);margin-top:.2rem;">
                Xin chào, <strong>${loggedInUser.fullName}</strong>
            </div>
        </div>

        <div class="studio-section-title">Lớp học</div>
        <a href="#section-classes" class="studio-nav-item active" onclick="showSection('classes')">
            <i class="fas fa-home"></i> Tổng quan
        </a>
        <a href="#section-members" class="studio-nav-item" onclick="showSection('members')">
            <i class="fas fa-users"></i> Danh sách học viên
        </a>

        <div class="studio-section-title">Nội dung</div>
        <a href="#section-nodes" class="studio-nav-item" onclick="showSection('nodes')">
            <i class="fas fa-film"></i> Bài giảng (Nodes)
        </a>
        <a href="#section-quiz" class="studio-nav-item" onclick="showSection('quiz')">
            <i class="fas fa-question-circle"></i> Câu hỏi Quiz
        </a>

        <div class="studio-section-title">Theo dõi</div>
        <a href="#section-progress" class="studio-nav-item" onclick="showSection('progress')">
            <i class="fas fa-chart-bar"></i> Tiến độ học viên
        </a>
        <a href="#section-grading" class="studio-nav-item" onclick="showSection('grading')">
            <i class="fas fa-pen"></i> Chấm bài tự luận
        </a>
        <a href="#section-live" class="studio-nav-item" onclick="showSection('live')">
            <i class="fas fa-broadcast-tower"></i> Live Session
        </a>
    </div>

    <!-- ===== STUDIO MAIN ===== -->
    <div class="studio-main">

        <!-- ============ SECTION: OVERVIEW ============ -->
        <div id="section-classes" class="studio-section">
            <div style="margin-bottom:1.75rem;">
                <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);">
                    <i class="fas fa-home me-2" style="color:var(--primary);"></i>Tổng quan
                </h2>
                <p style="color:var(--text-muted);font-size:.88rem;margin-top:.3rem;">
                    Quản lý lớp học và theo dõi hoạt động giảng dạy của bạn
                </p>
            </div>

            <!-- Stats -->
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-6">
                    <div class="stat-card">
                        <div class="stat-icon blue"><i class="fas fa-users"></i></div>
                        <div>
                            <div class="stat-value" id="statStudents">--</div>
                            <div class="stat-label">Học viên</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-card">
                        <div class="stat-icon purple"><i class="fas fa-film"></i></div>
                        <div>
                            <div class="stat-value" id="statNodes">--</div>
                            <div class="stat-label">Bài giảng</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-card">
                        <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
                        <div>
                            <div class="stat-value" id="statCompleted">--</div>
                            <div class="stat-label">Đã hoàn thành</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-card">
                        <div class="stat-icon yellow"><i class="fas fa-star"></i></div>
                        <div>
                            <div class="stat-value" id="statBonus">--</div>
                            <div class="stat-label">Tổng điểm thưởng</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- My Classes -->
            <div class="fl-table-wrap">
                <div class="fl-table-header">
                    <h3>Lớp học của tôi</h3>
                    <button class="btn-primary-fl" onclick="openCreateClassModal()">
                        <i class="fas fa-plus"></i> Tạo lớp mới
                    </button>
                </div>
                <table class="fl-table">
                    <thead>
                        <tr>
                            <th>Tên lớp</th>
                            <th>Mã mời</th>
                            <th>Học viên</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="classesTableBody">
                        <c:choose>
                            <c:when test="${not empty myClasses}">
                                <c:forEach var="cls" items="${myClasses}">
                                    <tr>
                                        <td>
                                            <div style="font-weight:600;color:var(--text-primary);">${cls.className}</div>
                                        </td>
                                        <td>
                                            <div class="invite-code-box" style="font-size:.8rem;padding:.3rem .7rem;letter-spacing:2px;">
                                                ${cls.inviteCode}
                                            </div>
                                        </td>
                                        <td><span style="color:var(--text-secondary);">-- học viên</span></td>
                                        <td>
                                            <span style="background:rgba(16,185,129,.1);color:var(--success);padding:.2rem .65rem;border-radius:50px;font-size:.75rem;font-weight:700;">
                                                ● Hoạt động
                                            </span>
                                        </td>
                                        <td>
                                            <div style="display:flex;gap:.4rem;">
                                                <button class="btn-outline-fl" style="padding:.3rem .7rem;font-size:.78rem;"
                                                        onclick="selectClass(${cls.classId}, '${cls.className}')">
                                                    <i class="fas fa-cog"></i> Quản lý
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" style="text-align:center;padding:2.5rem;color:var(--text-muted);">
                                        <i class="fas fa-inbox" style="font-size:2rem;display:block;margin-bottom:.75rem;"></i>
                                        Chưa có lớp học nào. Hãy tạo lớp đầu tiên!
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ============ SECTION: MEMBERS ============ -->
        <div id="section-members" class="studio-section" style="display:none;">
            <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);margin-bottom:1.5rem;">
                <i class="fas fa-users me-2" style="color:var(--primary);"></i>Danh sách học viên
            </h2>
            <div class="fl-table-wrap">
                <div class="fl-table-header">
                    <h3>Học viên trong lớp</h3>
                    <div class="table-search">
                        <i class="fas fa-search"></i>
                        <input type="text" id="memberSearch" placeholder="Tìm học viên..." oninput="filterTable('memberSearch','membersTable')"/>
                    </div>
                </div>
                <table class="fl-table" id="membersTable">
                    <thead>
                        <tr>
                            <th>Học viên</th>
                            <th>Email</th>
                            <th>Ngày tham gia</th>
                            <th>Tiến độ</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="membersTableBody">
                        <tr>
                            <td colspan="5" style="text-align:center;padding:2rem;color:var(--text-muted);">
                                Chọn lớp học để xem danh sách học viên
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ============ SECTION: NODES ============ -->
        <div id="section-nodes" class="studio-section" style="display:none;">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);">
                    <i class="fas fa-film me-2" style="color:var(--primary);"></i>Quản lý bài giảng
                </h2>
                <div class="d-flex gap-2">
                    <button class="btn-outline-fl" onclick="openAddNodeModal()">
                        <i class="fas fa-plus"></i> Thêm bài học
                    </button>
                </div>
            </div>
            <p style="font-size:.85rem;color:var(--text-muted);margin-bottom:1.25rem;">
                <i class="fas fa-grip-lines me-1"></i>Kéo thả để thay đổi thứ tự bài học
            </p>
            <div class="nodes-list" id="nodesSortable">
                <!-- Nodes rendered by JS after class selection -->
                <div style="padding:2.5rem;text-align:center;color:var(--text-muted);border:2px dashed var(--border);border-radius:var(--radius-lg);">
                    <i class="fas fa-film" style="font-size:2rem;display:block;margin-bottom:.75rem;"></i>
                    Chọn lớp học để quản lý bài giảng
                </div>
            </div>
        </div>

        <!-- ============ SECTION: QUIZ ============ -->
        <div id="section-quiz" class="studio-section" style="display:none;">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);">
                    <i class="fas fa-question-circle me-2" style="color:var(--accent);"></i>Câu hỏi Quiz
                </h2>
                <button class="btn-primary-fl" onclick="openCreateQuizModal()">
                    <i class="fas fa-plus"></i> Tạo câu hỏi mới
                </button>
            </div>

            <!-- Quiz Form -->
            <div class="fl-card" style="margin-bottom:1.5rem;" id="quizFormCard" style="display:none;">
                <h4 style="font-weight:700;margin-bottom:1.25rem;color:var(--text-primary);">
                    <i class="fas fa-edit me-2" style="color:var(--accent);"></i>Soạn câu hỏi mới
                </h4>
                <div class="gap-form">
                    <div>
                        <label class="fl-label">Nội dung câu hỏi *</label>
                        <textarea id="qtQuestionText" class="fl-textarea" rows="3" placeholder="Nhập nội dung câu hỏi..."></textarea>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="fl-label">Loại câu hỏi</label>
                            <select id="qtType" class="fl-select" onchange="onQuizTypeChange()">
                                <option value="0">Trắc nghiệm</option>
                                <option value="1">Đúng / Sai</option>
                                <option value="2">Tự luận</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="fl-label">Thời điểm xuất hiện (giây)</label>
                            <input type="number" id="qtPopUpTime" class="fl-input" placeholder="VD: 120" min="0"/>
                        </div>
                        <div class="col-md-4">
                            <label class="fl-label">Điểm thưởng</label>
                            <input type="number" id="qtBonus" class="fl-input" placeholder="VD: 50" min="0" value="10"/>
                        </div>
                    </div>

                    <!-- Answer options -->
                    <div id="answersSection">
                        <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:.75rem;">
                            <label class="fl-label" style="margin:0;">Đáp án <span style="color:var(--text-muted);font-weight:400;">(tích vào ô đúng)</span></label>
                            <button type="button" class="btn-outline-fl" style="padding:.3rem .7rem;font-size:.8rem;" onclick="addAnswerRow()">
                                <i class="fas fa-plus"></i> Thêm đáp án
                            </button>
                        </div>
                        <div id="answerRows">
                            <div class="answer-row">
                                <input type="checkbox" class="answer-correct-check" title="Đáp án đúng"/>
                                <input type="text" class="fl-input answer-input" placeholder="Nhập đáp án A..."/>
                                <button type="button" class="remove-answer" onclick="removeAnswerRow(this)"><i class="fas fa-trash"></i></button>
                            </div>
                            <div class="answer-row">
                                <input type="checkbox" class="answer-correct-check" title="Đáp án đúng"/>
                                <input type="text" class="fl-input answer-input" placeholder="Nhập đáp án B..."/>
                                <button type="button" class="remove-answer" onclick="removeAnswerRow(this)"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>

                    <div style="display:flex;justify-content:flex-end;gap:.75rem;">
                        <button class="btn-outline-fl" onclick="resetQuizForm()">Hủy</button>
                        <button class="btn-primary-fl" onclick="saveQuestion()">
                            <i class="fas fa-save"></i> Lưu câu hỏi
                        </button>
                    </div>
                </div>
            </div>

            <div class="fl-table-wrap">
                <div class="fl-table-header"><h3>Danh sách câu hỏi</h3></div>
                <table class="fl-table">
                    <thead>
                        <tr>
                            <th>Câu hỏi</th>
                            <th>Loại</th>
                            <th>PopUp (giây)</th>
                            <th>Điểm thưởng</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="quizTableBody">
                        <tr>
                            <td colspan="5" style="text-align:center;padding:2rem;color:var(--text-muted);">
                                Chưa có câu hỏi nào
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ============ SECTION: PROGRESS ============ -->
        <div id="section-progress" class="studio-section" style="display:none;">
            <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);margin-bottom:1.5rem;">
                <i class="fas fa-chart-bar me-2" style="color:var(--primary);"></i>Tiến độ học viên
            </h2>
            <div class="fl-table-wrap">
                <div class="fl-table-header">
                    <h3>Progress Tracker</h3>
                    <div class="table-search">
                        <i class="fas fa-search"></i>
                        <input type="text" id="progressSearch" placeholder="Tìm học viên..."/>
                    </div>
                </div>
                <table class="fl-table">
                    <thead>
                        <tr>
                            <th>Học viên</th>
                            <th>% Hoàn thành</th>
                            <th>Thời gian xem</th>
                            <th>Điểm thưởng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="4" style="text-align:center;padding:2rem;color:var(--text-muted);">
                                Chọn lớp học để xem tiến độ
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ============ SECTION: GRADING ============ -->
        <div id="section-grading" class="studio-section" style="display:none;">
            <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);margin-bottom:1.5rem;">
                <i class="fas fa-pen me-2" style="color:var(--warning);"></i>Chấm bài tự luận
            </h2>
            <div class="fl-table-wrap">
                <div class="fl-table-header"><h3>Bài tự luận chưa chấm</h3></div>
                <table class="fl-table">
                    <thead>
                        <tr>
                            <th>Học viên</th>
                            <th>Câu hỏi</th>
                            <th>Nội dung trả lời</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="gradingTableBody">
                        <tr>
                            <td colspan="4" style="text-align:center;padding:2rem;color:var(--text-muted);">
                                Không có bài tự luận chờ chấm
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ============ SECTION: LIVE ============ -->
        <div id="section-live" class="studio-section" style="display:none;">
            <h2 style="font-size:1.5rem;font-weight:800;color:var(--text-primary);margin-bottom:1.5rem;">
                <i class="fas fa-broadcast-tower me-2" style="color:var(--danger);"></i>Live Session
            </h2>
            <div class="fl-card" style="text-align:center;padding:3rem 2rem;">
                <div id="liveStatusPanel">
                    <div style="width:80px;height:80px;border-radius:50%;background:rgba(239,68,68,.1);display:flex;align-items:center;justify-content:center;margin:0 auto 1.5rem;font-size:2rem;color:var(--danger);">
                        <i class="fas fa-broadcast-tower"></i>
                    </div>
                    <h4 style="font-weight:700;color:var(--text-primary);margin-bottom:.5rem;">Phiên học trực tiếp</h4>
                    <p style="color:var(--text-muted);font-size:.9rem;margin-bottom:2rem;max-width:400px;margin-left:auto;margin-right:auto;line-height:1.7;">
                        Bắt đầu phiên học trực tiếp để học viên có thể tham gia và tương tác với câu hỏi real-time.
                    </p>
                    <button class="btn-primary-fl" style="font-size:1rem;padding:.85rem 2.5rem;" onclick="startLiveSession()">
                        <i class="fas fa-play"></i> Bắt đầu phiên học
                    </button>
                </div>

                <div id="liveActivePanel" style="display:none;">
                    <div class="live-badge" style="margin-bottom:1.5rem;font-size:.9rem;padding:.4rem 1.1rem;">
                        <div class="live-dot"></div> ĐANG TRỰC TIẾP
                    </div>
                    <h4 style="font-weight:700;color:var(--text-primary);margin-bottom:.3rem;">Phiên đang diễn ra</h4>
                    <p style="color:var(--text-muted);font-size:.85rem;margin-bottom:1rem;">
                        Bắt đầu: <span id="liveStartTime">--</span>
                    </p>
                    <div style="font-size:2rem;font-weight:800;color:var(--danger);margin-bottom:1.5rem;" id="liveTimer">00:00:00</div>
                    <button class="btn-danger-fl" style="font-size:1rem;padding:.85rem 2.5rem;" onclick="endLiveSession()">
                        <i class="fas fa-stop"></i> Kết thúc phiên học
                    </button>
                </div>
            </div>
        </div>

    </div><!-- end studio-main -->
</div><!-- end studio-layout -->
</div><!-- end page-wrapper -->

<%@ include file="../layout/user-sidebar.jsp" %>

<!-- Modals -->
<!-- Create Class Modal -->
<div class="fl-modal-backdrop" id="createClassModal" style="display:none;">
    <div class="fl-modal" style="max-width:480px;">
        <div class="fl-modal-header">
            <h3><i class="fas fa-plus me-2" style="color:var(--primary);"></i>Tạo lớp học mới</h3>
            <button class="close-btn" onclick="closeModal('createClassModal')"><i class="fas fa-times"></i></button>
        </div>
        <div class="gap-form">
            <div>
                <label class="fl-label">Tên lớp học *</label>
                <input type="text" id="newClassName" class="fl-input" placeholder="VD: Lập trình Web cơ bản - K24"/>
            </div>
            <div>
                <label class="fl-label">Mã mời (tự động sinh)</label>
                <div class="invite-code-box" id="generatedCode" style="font-size:1rem;letter-spacing:4px;">
                    --------
                </div>
                <div style="font-size:.78rem;color:var(--text-muted);margin-top:.4rem;">
                    <i class="fas fa-sync me-1"></i>
                    <a href="#" onclick="regenerateCode(); return false;">Tạo mã khác</a>
                </div>
            </div>
        </div>
        <div class="fl-modal-footer">
            <button class="btn-outline-fl" onclick="closeModal('createClassModal')">Hủy</button>
            <button class="btn-primary-fl" onclick="createClass()">
                <i class="fas fa-check"></i> Tạo lớp
            </button>
        </div>
    </div>
</div>

<!-- Add Node Modal -->
<div class="fl-modal-backdrop" id="addNodeModal" style="display:none;">
    <div class="fl-modal">
        <div class="fl-modal-header">
            <h3><i class="fas fa-plus me-2" style="color:var(--primary);"></i>Thêm bài học mới</h3>
            <button class="close-btn" onclick="closeModal('addNodeModal')"><i class="fas fa-times"></i></button>
        </div>
        <div class="gap-form">
            <div>
                <label class="fl-label">Tiêu đề bài học *</label>
                <input type="text" id="newNodeTitle" class="fl-input" placeholder="VD: Bài 1 - Giới thiệu HTML"/>
            </div>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="fl-label">Loại bài học</label>
                    <select id="newNodeType" class="fl-select">
                        <option value="0">📹 Video</option>
                        <option value="1">❓ Quiz</option>
                        <option value="2">🏆 Milestone</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="fl-label">Mở khóa lúc (tùy chọn)</label>
                    <input type="datetime-local" id="newNodeUnlock" class="fl-input"/>
                </div>
            </div>
            <div>
                <label class="fl-label">URL Video (YouTube/Drive)</label>
                <input type="url" id="newNodeVideo" class="fl-input" placeholder="https://youtube.com/embed/..."/>
            </div>
        </div>
        <div class="fl-modal-footer">
            <button class="btn-outline-fl" onclick="closeModal('addNodeModal')">Hủy</button>
            <button class="btn-primary-fl" onclick="saveNode()">
                <i class="fas fa-save"></i> Lưu bài học
            </button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.2/Sortable.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/teacher.js"></script>
<script>
const TEACHER_CONFIG = {
    contextPath: '${pageContext.request.contextPath}'
};
// Load initial stats
document.addEventListener('DOMContentLoaded', () => {
    initSortable();
    generateCode();
});
</script>
<%@ include file="../layout/footer.jsp" %>
