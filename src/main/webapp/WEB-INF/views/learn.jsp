<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">
<div class="learn-layout">

    <!-- ===== VIDEO MAIN AREA ===== -->
    <div class="learn-main">

        <!-- Breadcrumb -->
        <div style="display:flex;align-items:center;gap:.5rem;font-size:.82rem;color:var(--text-muted);margin-bottom:1rem;">
            <a href="${pageContext.request.contextPath}/courses" style="color:var(--text-muted);text-decoration:none;"
               onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='var(--text-muted)'">
                <i class="fas fa-book-open me-1"></i>Khóa học
            </a>
            <i class="fas fa-chevron-right" style="font-size:.65rem;"></i>
            <span style="color:var(--text-primary);font-weight:600;" id="breadcrumbClass">${classRoom.className}</span>
            <i class="fas fa-chevron-right" style="font-size:.65rem;"></i>
            <span id="breadcrumbLesson">Đang tải...</span>
        </div>

        <!-- Video Container -->
        <div class="video-container" id="videoContainer">
            <iframe id="videoFrame"
                    src=""
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen
                    style="display:none;">
            </iframe>

            <!-- Placeholder -->
            <div id="videoPlaceholder" style="width:100%;height:100%;background:linear-gradient(135deg,#0B1120,#1a237e);display:flex;flex-direction:column;align-items:center;justify-content:center;color:rgba(255,255,255,.6);">
                <i class="fas fa-play-circle" style="font-size:4rem;margin-bottom:1rem;opacity:.4;"></i>
                <p style="font-size:1rem;font-weight:600;">Chọn bài học để bắt đầu</p>
                <p style="font-size:.82rem;opacity:.6;margin-top:.3rem;">Từ danh sách bài học bên phải</p>
            </div>

            <!-- Quiz Pop-up Overlay -->
            <div class="quiz-overlay" id="quizOverlay" style="display:none;">
                <div class="quiz-modal" id="quizModal">
                    <div class="quiz-header">
                        <span class="quiz-badge"><i class="fas fa-question me-1"></i>Câu hỏi</span>
                        <span id="quizTimer" style="font-size:.82rem;color:var(--text-muted);"></span>
                        <div class="quiz-bonus" id="quizBonus" style="display:none;">
                            <i class="fas fa-star"></i>
                            <span id="quizBonusVal">+0</span> điểm
                        </div>
                    </div>
                    <h3 id="quizQuestion">Câu hỏi đang tải...</h3>

                    <!-- Multiple choice options -->
                    <div class="quiz-options" id="quizOptions"></div>

                    <!-- Essay textarea -->
                    <textarea id="essayInput" class="fl-textarea"
                              placeholder="Nhập câu trả lời của bạn..."
                              style="display:none;margin-top:1rem;"></textarea>

                    <div class="quiz-actions">
                        <button class="btn-outline-fl" id="quizSkipBtn" onclick="skipQuiz()">
                            <i class="fas fa-forward"></i> Bỏ qua
                        </button>
                        <button class="btn-primary-fl" id="quizSubmitBtn" onclick="submitQuiz()">
                            <i class="fas fa-paper-plane"></i> Trả lời
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Lesson Info -->
        <div style="margin-top:1.25rem;">
            <div class="d-flex align-items-start justify-content-between gap-1 flex-wrap">
                <div>
                    <h2 id="lessonTitle" style="font-size:1.25rem;font-weight:800;color:var(--text-primary);margin-bottom:.4rem;">
                        Chọn bài học từ danh sách
                    </h2>
                    <div style="display:flex;align-items:center;gap:1rem;font-size:.82rem;color:var(--text-muted);">
                        <span id="lessonType" style="display:none;">
                            <i class="fas fa-video me-1" style="color:var(--primary);"></i>
                            <span id="lessonTypeText">Video</span>
                        </span>
                        <span id="lessonOrder" style="display:none;">
                            <i class="fas fa-list-ol me-1"></i>
                            Bài <span id="lessonOrderNum">1</span>
                        </span>
                    </div>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn-outline-fl" id="prevLessonBtn" onclick="navigateLesson(-1)" disabled>
                        <i class="fas fa-chevron-left"></i> Trước
                    </button>
                    <button class="btn-primary-fl" id="nextLessonBtn" onclick="navigateLesson(1)" disabled>
                        Tiếp <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>

            <!-- Progress info -->
            <div class="fl-card" style="padding:1rem 1.25rem;margin-top:1rem;">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <span style="font-size:.85rem;font-weight:600;color:var(--text-secondary);">
                        <i class="fas fa-chart-line me-1" style="color:var(--primary);"></i>
                        Tiến độ khóa học
                    </span>
                    <span id="progressPct" style="font-size:.85rem;font-weight:700;color:var(--primary);">0%</span>
                </div>
                <div class="progress-bar-fl">
                    <div class="progress-fill" id="progressFill" style="width:0%;"></div>
                </div>
                <div style="display:flex;justify-content:space-between;margin-top:.5rem;font-size:.78rem;color:var(--text-muted);">
                    <span id="progressDone">0 bài hoàn thành</span>
                    <span id="progressTotal">0 bài tổng cộng</span>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== SYLLABUS SIDEBAR ===== -->
    <div class="learn-sidebar" id="learnSidebar">
        <div class="sidebar-header">
            <h3><i class="fas fa-list-ul me-2" style="color:var(--primary);"></i>Nội dung bài học</h3>
            <button style="background:none;border:none;color:var(--text-muted);cursor:pointer;font-size:.9rem;"
                    onclick="toggleSidebar()" title="Ẩn/hiện">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <!-- Tabs -->
        <div class="learn-sidebar .sidebar-tabs" style="display:flex;border-bottom:1px solid var(--border);">
            <button class="tab-btn active" id="tabSyllabus" onclick="switchTab('syllabus')">
                <i class="fas fa-book me-1"></i>Bài học
            </button>
            <button class="tab-btn" id="tabAssistant" onclick="switchTab('assistant')">
                <i class="fas fa-robot me-1"></i>Trợ lý
            </button>
        </div>

        <!-- Syllabus Tab -->
        <div id="paneSyllabus" class="syllabus-list">
            <c:choose>
                <c:when test="${not empty nodes}">
                    <c:forEach var="node" items="${nodes}" varStatus="st">
                        <c:set var="isLocked" value="${lockedNodeIds.contains(node.nodeId)}" />
                        <c:set var="isCompleted" value="${completedNodeIds.contains(node.nodeId)}" />
                        <c:set var="onClickAction" value="selectLesson(this)" />
                        <c:if test="${isLocked}">
                            <c:set var="onClickAction" value="showToast('warning', 'Đã khóa', 'Bạn cần hoàn thành bài học trước đó!')" />
                        </c:if>
                        <div class="syllabus-item ${isLocked ? 'locked' : ''} ${isCompleted ? 'completed' : ''}"
                             id="sitem-${node.nodeId}"
                             data-nodeid="${node.nodeId}"
                             data-video="${isLocked ? '' : node.videoUrl}"
                             data-title="${node.title}"
                             data-type="${node.nodeType}"
                             data-order="${node.orderIndex}"
                             data-locked="${isLocked}"
                             onclick="${onClickAction}">
                            <div class="item-icon
                                <c:choose>
                                    <c:when test='${node.nodeType == 0}'>video</c:when>
                                    <c:when test='${node.nodeType == 1}'>quiz</c:when>
                                    <c:otherwise>video</c:otherwise>
                                </c:choose>">
                                <c:choose>
                                    <c:when test="${node.nodeType == 0}"><i class="fas fa-play"></i></c:when>
                                    <c:when test="${node.nodeType == 1}"><i class="fas fa-question"></i></c:when>
                                    <c:otherwise><i class="fas fa-flag"></i></c:otherwise>
                                </c:choose>
                            </div>
                            <div class="item-title">${node.title}</div>
                            <div id="sitem-status-${node.nodeId}" style="margin-left: auto; color: var(--text-muted); font-size: .85rem;">
                                <c:choose>
                                    <c:when test="${isLocked}"><i class="fas fa-lock"></i></c:when>
                                    <c:when test="${isCompleted}"><i class="fas fa-check-circle" style="color:var(--success);"></i></c:when>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="padding:2rem;text-align:center;color:var(--text-muted);">
                        <i class="fas fa-inbox" style="font-size:2rem;margin-bottom:.75rem;display:block;"></i>
                        Chưa có bài học nào trong lớp này
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- AI Assistant Tab -->
        <div id="paneAssistant" style="display:none;padding:1rem;flex:1;display:flex;flex-direction:column;gap:.75rem;">
            <div style="background:var(--bg-surface);border-radius:var(--radius);padding:.85rem;font-size:.85rem;color:var(--text-secondary);line-height:1.6;border:1px solid var(--border);">
                <i class="fas fa-robot me-1" style="color:var(--accent);"></i>
                Xin chào! Tôi là trợ lý học tập. Hãy hỏi tôi bất kỳ điều gì về bài học này.
            </div>
            <div style="flex:1;overflow-y:auto;" id="chatMessages"></div>
            <div style="display:flex;gap:.5rem;margin-top:auto;">
                <input type="text" id="chatInput" class="fl-input" placeholder="Đặt câu hỏi..." style="flex:1;"/>
                <button class="btn-primary-fl" style="padding:.6rem .85rem;" onclick="sendChat()">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
        </div>

        <!-- Progress footer -->
        <div style="padding:1rem 1.25rem;border-top:1px solid var(--border);background:var(--bg-surface);">
            <div style="font-size:.78rem;color:var(--text-muted);margin-bottom:.5rem;font-weight:600;">
                <i class="fas fa-star me-1" style="color:var(--warning);"></i>
                Điểm thưởng: <span id="totalBonusDisplay">0</span> pts
            </div>
            <div class="progress-bar-fl"><div class="progress-fill" id="sidebarProgressFill" style="width:0%;"></div></div>
        </div>
    </div>

</div><!-- end learn-layout -->
</div><!-- end page-wrapper -->

<%@ include file="layout/user-sidebar.jsp" %>

<!-- Bootstrap + Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/learn.js"></script>

<script>
// Initialize learn page data from JSP
const LEARN_CONFIG = {
    contextPath: '${pageContext.request.contextPath}',
    classId: '${classRoom.classId}',
    className: '${classRoom.className}',
    totalNodes: ${not empty nodes ? nodes.size() : 0}
};
</script>
