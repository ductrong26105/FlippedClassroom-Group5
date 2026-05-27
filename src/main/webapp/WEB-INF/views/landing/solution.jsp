<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- ===== HEADER ===== --%>
<jsp:include page="/WEB-INF/views/landing/layout/header.jsp"/>

<!-- ============================================================
     SOLUTION HERO — compact
     ============================================================ -->
<section class="page-hero-compact page-hero-solution">
    <div class="hero-bg-shapes">
        <div class="shape shape-3"></div>
        <div class="shape shape-1"></div>
    </div>
    <div class="container position-relative z-1">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <span class="section-label mb-3 d-inline-flex fade-up">
                    <i class="fas fa-lightbulb"></i>&nbsp;Giải pháp Active Learning
                </span>
                <h1 class="page-title-lg fade-up delay-1">
                    Blueprint <span class="text-accent-gradient">học tập chủ động</span><br/>4 giai đoạn
                </h1>
                <p class="page-subtitle-sm fade-up delay-2">
                    Chuyển đổi lớp học thụ động thành môi trường học tập chủ động với
                    mô hình 4 Blueprint, kết hợp công nghệ theo dõi tiến trình thực tế.
                </p>
                <div class="d-flex gap-3 flex-wrap fade-up delay-3">
                    <a href="${pageContext.request.contextPath}/home" class="btn-glow">
                        <i class="fas fa-rocket"></i> Vào hệ thống
                    </a>
                    <a href="${pageContext.request.contextPath}/landing/problem" class="btn-outline-glass">
                        <i class="fas fa-arrow-left"></i> Xem vấn đề
                    </a>
                </div>
            </div>
            <div class="col-lg-5 d-none d-lg-flex justify-content-center">
                <div class="sol-hero-visual fade-right delay-2">
                    <div class="sol-bp-stack">
                        <div class="sol-bp-chip bp1">BP1</div>
                        <div class="sol-bp-chip bp2">BP2</div>
                        <div class="sol-bp-chip bp3">BP3</div>
                        <div class="sol-bp-chip bpx">BPx</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================================================
     BLUEPRINTS — horizontal timeline
     ============================================================ -->
<section class="py-5 bg-dark-alt" id="blueprints">
    <div class="container">
        <div class="text-center mb-4 fade-up">
            <span class="section-label" style="background:rgba(67,97,238,.15); color:#818cf8; border-color:rgba(67,97,238,.3);">
                <i class="fas fa-map"></i>&nbsp;Lộ trình
            </span>
            <h2 class="section-title text-white mt-3">Hành trình 4 Giai đoạn (Blueprints)</h2>
        </div>

        <div class="bp-grid fade-up delay-1">
            <c:forEach var="bp" items="${blueprints}" varStatus="st">
                <div class="bp-grid-card">
                    <span class="bp-label ${bp.labelClass}">${bp.label}</span>
                    <h4>${bp.title}</h4>
                    <p>${bp.desc}</p>
                    <div class="feature-tags">
                        <c:forEach var="feature" items="${bp.features}">
                            <span class="tag"><i class="fas fa-check"></i> ${feature}</span>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ============================================================
     BEFORE / AFTER COMPARISON — side by side
     ============================================================ -->
<section class="py-5" id="comparison">
    <div class="container">
        <div class="text-center mb-4 fade-up">
            <h2 class="section-title">Sự khác biệt cốt lõi</h2>
        </div>

        <div class="row g-3 fade-up delay-1">
            <div class="col-md-6">
                <div class="compare-card-new before-card">
                    <div class="compare-label-row">
                        <i class="fas fa-times-circle"></i>
                        <span>Truyền thống</span>
                    </div>
                    <ul class="compare-list-new">
                        <c:forEach var="item" items="${beforeItems}">
                            <li><i class="fas fa-minus"></i> ${item}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="col-md-6">
                <div class="compare-card-new after-card">
                    <div class="compare-label-row">
                        <i class="fas fa-check-circle"></i>
                        <span>FLearn</span>
                    </div>
                    <ul class="compare-list-new">
                        <c:forEach var="item" items="${afterItems}">
                            <li><i class="fas fa-check"></i> ${item}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================================================
     CODE SHOWCASE
     ============================================================ -->
<section class="py-5 code-showcase-section" id="code">
    <div class="container">
        <div class="text-center mb-4 fade-up">
            <span class="section-label" style="background:rgba(20,184,166,.12); color:#2dd4bf; border-color:rgba(20,184,166,.25);">
                <i class="fas fa-code"></i>&nbsp;Demo Code
            </span>
            <h2 class="section-title text-white mt-3">Kiến trúc Code Thực tế</h2>
            <p class="section-desc" style="color:#94a3b8;">Minh họa triển khai logic bằng Java Servlet, Hibernate JPA</p>
        </div>

        <div class="code-editor-mockup fade-up delay-1">
            <div class="editor-header">
                <div class="editor-dots">
                    <span></span><span></span><span></span>
                </div>
                <div class="editor-tabs">
                    <ul class="nav nav-tabs" id="codeTabs" role="tablist">
                        <c:forEach var="file" items="${codeFiles}" varStatus="st">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link ${st.first ? 'active' : ''}"
                                        id="tab-${file.id}"
                                        data-bs-toggle="tab"
                                        data-bs-target="#content-${file.id}"
                                        type="button" role="tab">
                                    ${file.icon} ${file.name}
                                </button>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="editor-body">
                <div class="tab-content" id="codeTabsContent">
                    <c:forEach var="file" items="${codeFiles}" varStatus="st">
                        <div class="tab-pane fade ${st.first ? 'show active' : ''}"
                             id="content-${file.id}" role="tabpanel">
                            <div class="file-path">// Path: ${file.path}</div>
                            <pre><code class="language-${file.lang}"><c:out value="${file.code}"/></code></pre>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================================================
     DATABASE STRUCTURE
     ============================================================ -->
<section class="py-5" id="db">
    <div class="container">
        <div class="text-center mb-4 fade-up">
            <h2 class="section-title">Mô hình Dữ liệu (ERD)</h2>
            <p class="section-desc">Cấu trúc cơ sở dữ liệu cốt lõi phục vụ hệ thống học tập chủ động</p>
        </div>

        <div class="row g-3 fade-up delay-1">
            <c:forEach var="tbl" items="${dbTables}">
                <div class="col-lg-4 col-md-6">
                    <div class="db-table-card">
                        <div class="db-table-header">
                            <i class="fas ${tbl.icon}"></i> ${tbl.name}
                        </div>
                        <div class="db-table-body">
                            <table class="table table-sm table-borderless m-0">
                                <c:forEach var="col" items="${tbl.columns}">
                                    <tr>
                                        <td class="col-name">${col.name}</td>
                                        <td class="col-type">${col.type}</td>
                                        <td class="col-key">
                                            <c:if test="${col.key == 'PK'}"><span class="badge bg-warning text-dark">PK</span></c:if>
                                            <c:if test="${col.key == 'FK'}"><span class="badge bg-info text-dark">FK</span></c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- CTA -->
        <div class="cta-strip fade-up delay-2">
            <div>
                <p class="fw-bold fs-5 text-white mb-1">Trải nghiệm ngay sản phẩm thực tế!</p>
                <p class="text-light mb-0 opacity-75">Đăng nhập và khám phá toàn bộ tính năng của FLearn</p>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn-glow">
                <i class="fas fa-rocket"></i> Vào hệ thống ngay
            </a>
        </div>
    </div>
</section>

<%-- ===== FOOTER ===== --%>
<jsp:include page="/WEB-INF/views/landing/layout/footer.jsp"/>
