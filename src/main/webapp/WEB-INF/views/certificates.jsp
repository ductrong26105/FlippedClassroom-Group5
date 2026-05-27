<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="layout/header.jsp" %>

<div class="page-wrapper">
    <div class="container py-5">
        
        <!-- ===== PAGE HEADER ===== -->
        <div class="section-header mb-4">
            <div class="section-tag"><i class="fas fa-award me-1"></i> Thành tích</div>
            <h2>Kho <span>chứng chỉ</span> của bạn</h2>
            <p>Nơi lưu giữ các chứng nhận học tập xuất sắc khi bạn hoàn thành 100% tiến độ bài học trên FLearn.</p>
        </div>

        <!-- ===== CERTIFICATES SECTION ===== -->
        <div class="row g-4 mt-2">
            <c:choose>
                <c:when test="${not empty progressList}">
                    <c:forEach var="cp" items="${progressList}">
                        <div class="col-lg-6">
                            <div class="fl-card position-relative overflow-hidden h-100 d-flex flex-column" 
                                 style="border-radius: var(--radius-lg); background: var(--bg-card); border: 1px solid var(--border); box-shadow: var(--shadow); transition: var(--transition);">
                                
                                <!-- Glow indicator for completed certificates -->
                                <c:if test="${cp.completed}">
                                    <div style="position: absolute; top: -50px; right: -50px; width: 120px; height: 120px; border-radius: 50%; background: radial-gradient(circle, rgba(16,185,129,0.18) 0%, transparent 70%); pointer-events: none;"></div>
                                </c:if>

                                <div class="d-flex align-items-start gap-3 flex-grow-1">
                                    <!-- Medallion Badge Container -->
                                    <div class="cert-badge-box ${cp.completed ? 'cert-gold' : 'cert-locked'} flex-shrink-0">
                                        <c:choose>
                                            <c:when test="${cp.completed}">
                                                <i class="fas fa-medal" style="font-size: 2.2rem;"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-lock" style="font-size: 1.8rem;"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Main details -->
                                    <div style="min-width: 0; flex: 1;">
                                        <h3 style="font-size: 1.15rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.35rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                            <c:out value="${cp.classRoom.className}"/>
                                        </h3>
                                        <p style="font-size: 0.85rem; color: var(--text-secondary); margin-bottom: 1rem;">
                                            Giảng viên: <strong><c:out value="${cp.classRoom.teacher.fullName}"/></strong>
                                        </p>

                                        <!-- Progress Bar -->
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between mb-1" style="font-size: 0.78rem;">
                                                <span style="color: var(--text-muted);">Tiến độ bài học</span>
                                                <strong style="color: ${cp.completed ? 'var(--success)' : 'var(--primary)'};">
                                                    <c:out value="${cp.progressPercent}"/>%
                                                </strong>
                                            </div>
                                            <div class="progress" style="height: 6px; background-color: var(--border); border-radius: 50px; overflow: hidden;">
                                                <div class="progress-bar ${cp.completed ? 'bg-success' : 'bg-primary'}" 
                                                     role="progressbar" 
                                                     style="width: ${cp.progressPercent}%; border-radius: 50px; transition: width 0.6s ease;" 
                                                     aria-valuenow="${cp.progressPercent}" 
                                                     aria-valuemin="0" 
                                                     aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Section -->
                                <div class="d-flex align-items-center justify-content-between mt-3 pt-3" style="border-top: 1px solid var(--border);">
                                    <span style="font-size: 0.8rem; color: var(--text-muted);">
                                        Bài học: <strong>${cp.completedNodes} / ${cp.totalNodes}</strong>
                                    </span>
                                    
                                    <c:choose>
                                        <c:when test="${cp.completed}">
                                            <button class="btn-success-fl" 
                                                    style="font-size: 0.8rem; padding: 0.45rem 1rem;"
                                                    onclick="viewCertificate('${loggedInUser.fullName}', '${cp.classRoom.className}', '${cp.classRoom.teacher.fullName}')">
                                                <i class="fas fa-certificate me-1"></i> Xem chứng chỉ
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/learn/${cp.classRoom.classId}" 
                                               class="btn-outline-fl" 
                                               style="text-decoration: none; font-size: 0.8rem; padding: 0.45rem 1rem;">
                                                Học tiếp <i class="fas fa-play ms-1" style="font-size: 0.7rem;"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                            </div>
                        </div>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <!-- Empty State -->
                    <div class="col-12 text-center py-5">
                        <div class="empty-state-box mx-auto" style="max-width: 480px; padding: 3rem 1.5rem; background: var(--bg-card); border: 1.5px dashed var(--border); border-radius: var(--radius-lg);">
                            <div class="empty-icon-circle mb-4">
                                <i class="fas fa-certificate"></i>
                            </div>
                            <h3 style="font-size: 1.25rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.5rem;">
                                Chưa có chứng chỉ nào!
                            </h3>
                            <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin-bottom: 1.75rem;">
                                Hoàn thành 100% các bài học và các nhiệm vụ trắc nghiệm (quiz) của các lớp học tham gia để chính thức nhận chứng chỉ hoàn thành xuất sắc từ giảng viên chủ nhiệm.
                            </p>
                            <a href="${pageContext.request.contextPath}/my-courses" class="btn-primary-fl" style="text-decoration: none;">
                                <i class="fas fa-book-reader me-2"></i> Học ngay lớp của bạn
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<!-- ===== PREMIUM MODAL FOR RENDERING THE CERTIFICATE ===== -->
<div class="modal fade" id="certModal" tabindex="-1" aria-hidden="true" style="backdrop-filter: blur(12px);">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="background: transparent; border: none;">
            
            <div class="modal-body p-0">
                <div class="premium-certificate-frame position-relative text-center">
                    
                    <!-- Decorative borders -->
                    <div class="cert-outer-border">
                        <div class="cert-inner-border">
                            
                            <!-- Certificate Header -->
                            <div class="cert-header mb-4">
                                <div class="cert-cap-icon mb-2">
                                    <i class="fas fa-graduation-cap"></i>
                                </div>
                                <span class="cert-brand-text">FLEARN CERTIFICATION OF COMPLETION</span>
                            </div>
                            
                            <!-- Main Text -->
                            <p class="cert-subtitle">Chứng nhận này được trao một cách trang trọng cho</p>
                            
                            <h2 class="cert-student-name" id="certStudentName">TÊN HỌC VIÊN</h2>
                            
                            <div class="cert-line my-4"></div>
                            
                            <p class="cert-body-text">
                                Đã hoàn thành xuất sắc 100% bài học, vượt qua toàn bộ các thử thách trắc nghiệm của khóa học
                            </p>
                            
                            <h3 class="cert-course-name" id="certCourseName">TÊN KHÓA HỌC</h3>
                            
                            <p class="cert-body-text mt-3">
                                Với tinh thần tự học xuất sắc theo phương pháp lớp học đảo ngược (Flipped Classroom).
                            </p>

                            <!-- Certificate Footer Signature and Seal -->
                            <div class="row align-items-center mt-5">
                                <div class="col-4">
                                    <div class="signature-line" id="certTeacherName">TÊN GIẢNG VIÊN</div>
                                    <span style="font-size: 0.72rem; color: #94A3B8; display: block; margin-top: 0.25rem;">Giảng viên chủ nhiệm</span>
                                </div>
                                <div class="col-4 d-flex justify-content-center">
                                    <div class="official-seal">
                                        <i class="fas fa-ribbon seal-ribbon-1"></i>
                                        <i class="fas fa-ribbon seal-ribbon-2"></i>
                                        <div class="seal-inner">
                                            <i class="fas fa-check" style="font-size: 1.2rem; color: #d4af37;"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="signature-line">FLearn Group</div>
                                    <span style="font-size: 0.72rem; color: #94A3B8; display: block; margin-top: 0.25rem;">Nền tảng kiểm định</span>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    
                    <!-- Close button in modal -->
                    <button class="cert-close-btn" data-bs-dismiss="modal" aria-label="Close">
                        <i class="fas fa-times"></i>
                    </button>
                    
                </div>
            </div>
            
        </div>
    </div>
</div>

<%@ include file="layout/user-sidebar.jsp" %>
<%@ include file="layout/footer.jsp" %>

<!-- Premium Styling for Medallion Container & Certificates Page -->
<style>
    /* Empty State Circle */
    .empty-icon-circle {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: rgba(139, 92, 246, 0.1);
        color: var(--accent);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.2rem;
        margin: 0 auto;
        box-shadow: 0 8px 20px rgba(139, 92, 246, 0.15);
    }

    /* Badge Medallions */
    .cert-badge-box {
        width: 65px;
        height: 65px;
        border-radius: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .cert-gold {
        background: linear-gradient(135deg, #F59E0B, #D97706);
        color: #fff;
        box-shadow: 0 6px 18px rgba(245, 158, 11, 0.35);
        border: 2px solid rgba(255, 255, 255, 0.25);
    }
    .cert-locked {
        background: var(--bg-surface);
        color: var(--text-muted);
        border: 1.5px solid var(--border);
    }

    /* Premium Certificate Frame */
    .premium-certificate-frame {
        background: linear-gradient(135deg, #10172A, #0F172A);
        color: #fff;
        border-radius: 20px;
        box-shadow: 0 30px 90px rgba(0, 0, 0, 0.85);
        padding: 2.5rem;
        overflow: hidden;
        border: 1px solid rgba(255, 255, 255, 0.1);
        font-family: 'Georgia', serif;
    }
    .cert-outer-border {
        border: 5px solid #d4af37;
        padding: 1.5rem;
        border-radius: 10px;
    }
    .cert-inner-border {
        border: 2px double #d4af37;
        padding: 2.5rem 1.5rem;
        border-radius: 5px;
    }
    .cert-brand-text {
        font-family: 'Inter', sans-serif;
        font-size: 0.85rem;
        font-weight: 700;
        letter-spacing: 2px;
        color: #94A3B8;
        display: block;
    }
    .cert-cap-icon {
        color: #d4af37;
        font-size: 2.2rem;
    }
    .cert-subtitle {
        font-style: italic;
        color: #94A3B8;
        font-size: 0.95rem;
        margin-bottom: 1.5rem;
    }
    .cert-student-name {
        font-size: 2.3rem;
        font-weight: 700;
        color: #fff;
        font-family: 'Inter', sans-serif;
        letter-spacing: 1px;
    }
    .cert-line {
        height: 1.5px;
        background: linear-gradient(90deg, transparent, #d4af37, transparent);
    }
    .cert-body-text {
        font-size: 0.95rem;
        color: #CBD5E1;
        line-height: 1.6;
        font-style: italic;
    }
    .cert-course-name {
        font-size: 1.6rem;
        font-weight: 700;
        color: #d4af37;
        font-family: 'Inter', sans-serif;
        margin-top: 1rem;
        letter-spacing: 0.5px;
    }
    
    /* Seal Design */
    .official-seal {
        width: 65px;
        height: 65px;
        border-radius: 50%;
        background: #1e293b;
        border: 3.5px dotted #d4af37;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
    }
    .seal-inner {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        background: #0f172a;
        border: 2px solid #d4af37;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .seal-ribbon-1 {
        position: absolute;
        bottom: -20px;
        left: 10px;
        color: #d4af37;
        font-size: 1.6rem;
        transform: rotate(25deg);
        z-index: -1;
    }
    .seal-ribbon-2 {
        position: absolute;
        bottom: -20px;
        right: 10px;
        color: #d4af37;
        font-size: 1.6rem;
        transform: rotate(-25deg);
        z-index: -1;
    }

    .signature-line {
        border-bottom: 1.5px solid #CBD5E1;
        padding-bottom: 0.35rem;
        font-size: 0.9rem;
        font-weight: 600;
        font-family: 'Inter', sans-serif;
        color: #F8FAFC;
    }

    /* Close Button */
    .cert-close-btn {
        position: absolute;
        top: 1.25rem;
        right: 1.25rem;
        background: rgba(255, 255, 255, 0.1);
        border: none;
        color: #fff;
        width: 32px;
        height: 32px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: var(--transition);
    }
    .cert-close-btn:hover {
        background: rgba(239, 68, 68, 0.2);
        color: var(--danger);
    }
</style>

<!-- Modal Display Script -->
<script>
    function viewCertificate(studentName, courseName, teacherName) {
        document.getElementById('certStudentName').textContent = studentName.toUpperCase();
        document.getElementById('certCourseName').textContent = courseName;
        document.getElementById('certTeacherName').textContent = teacherName;
        
        // Show modal
        const myModal = new bootstrap.Modal(document.getElementById('certModal'));
        myModal.show();
    }
</script>
