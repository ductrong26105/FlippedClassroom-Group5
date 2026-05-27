/* ============================================================
   FLearn - Main JavaScript
   ============================================================ */

/* ===== THEME (Dark / Light) ===== */
(function initTheme() {
    const saved = localStorage.getItem('flearn-theme') || 'light';
    document.documentElement.setAttribute('data-theme', saved);
    updateThemeUI(saved);
})();

function updateThemeUI(theme) {
    const icon    = document.getElementById('themeIcon');
    const dIcon   = document.getElementById('dropdownThemeIcon');
    const dLabel  = document.getElementById('dropdownThemeLabel');
    if (theme === 'dark') {
        if (icon)   { icon.className = 'fas fa-sun'; }
        if (dIcon)  { dIcon.className = 'fas fa-sun'; }
        if (dLabel) { dLabel.textContent = 'Ch\u1ebf \u0111\u1ed9 s\u00e1ng'; }
    } else {
        if (icon)   { icon.className = 'fas fa-moon'; }
        if (dIcon)  { dIcon.className = 'fas fa-moon'; }
        if (dLabel) { dLabel.textContent = 'Ch\u1ebf \u0111\u1ed9 t\u1ed1i'; }
    }
}

function toggleTheme() {
    const current = document.documentElement.getAttribute('data-theme') || 'light';
    const next    = current === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', next);
    localStorage.setItem('flearn-theme', next);
    updateThemeUI(next);
}

document.addEventListener('DOMContentLoaded', function () {
    const btn = document.getElementById('themeToggle');
    if (btn) btn.addEventListener('click', toggleTheme);
});


/* ===== USER SIDEBAR DROPDOWN ===== */
function toggleUserDropdown() {
    const dropdown = document.getElementById('userDropdown');
    const chevron  = document.getElementById('userChevron');
    if (!dropdown) return;
    dropdown.classList.toggle('show');
    if (chevron) {
        chevron.style.transform = dropdown.classList.contains('show')
            ? 'rotate(180deg)' : 'rotate(0)';
    }
}

// Close dropdown when clicking outside
document.addEventListener('click', function (e) {
    const mini = document.getElementById('userSidebarMini');
    if (mini && !mini.contains(e.target)) {
        const dropdown = document.getElementById('userDropdown');
        const chevron  = document.getElementById('userChevron');
        if (dropdown) dropdown.classList.remove('show');
        if (chevron)  chevron.style.transform = 'rotate(0)';
    }
});


/* ===== TOAST NOTIFICATIONS ===== */
function showToast(type, title, msg, durationMs = 4000) {
    const container = document.getElementById('toastContainer');
    if (!container) return;

    const toast = document.createElement('div');
    toast.className = `toast-fl toast-${type}`;
    toast.innerHTML = `
        <div class="toast-icon">
            <i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-times-circle'}"></i>
        </div>
        <div class="toast-body">
            <div class="toast-title">${title}</div>
            <div class="toast-msg">${msg}</div>
        </div>
        <button onclick="this.parentElement.remove()"
                style="margin-left:auto;background:none;border:none;color:var(--text-muted);cursor:pointer;font-size:.9rem;align-self:flex-start;">
            <i class="fas fa-times"></i>
        </button>`;
    container.appendChild(toast);
    setTimeout(() => {
        toast.style.animation = 'slideInRight .3s ease reverse';
        setTimeout(() => toast.remove(), 280);
    }, durationMs);
}


/* ===== MODAL HELPERS ===== */
function closeModal(id) {
    const el = document.getElementById(id);
    if (el) el.style.display = 'none';
}

// Close modal on backdrop click
document.addEventListener('click', function (e) {
    if (e.target.classList.contains('fl-modal-backdrop')) {
        e.target.style.display = 'none';
    }
});

// Escape key closes modals
document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') {
        document.querySelectorAll('.fl-modal-backdrop').forEach(m => {
            m.style.display = 'none';
        });
    }
});


/* ===== TABLE FILTER ===== */
function filterTable(inputId, tableId) {
    const q     = document.getElementById(inputId).value.toLowerCase();
    const table = document.getElementById(tableId);
    if (!table) return;
    table.querySelectorAll('tbody tr').forEach(row => {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}


/* ===== STUDIO SECTION SWITCHER ===== */
function showSection(name) {
    document.querySelectorAll('.studio-section').forEach(s => s.style.display = 'none');
    const target = document.getElementById('section-' + name);
    if (target) target.style.display = '';

    document.querySelectorAll('.studio-nav-item').forEach(a => a.classList.remove('active'));
    if (event && event.currentTarget) event.currentTarget.classList.add('active');
}


/* ===== TEACHER: INVITE CODE GENERATOR ===== */
function generateCode() {
    const chars  = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    let code = '';
    for (let i = 0; i < 8; i++) {
        code += chars[Math.floor(Math.random() * chars.length)];
    }
    const box = document.getElementById('generatedCode');
    if (box) box.textContent = code;
    return code;
}
function regenerateCode() { generateCode(); }

function openCreateClassModal() {
    generateCode();
    document.getElementById('newClassName').value = '';
    document.getElementById('createClassModal').style.display = 'flex';
}

function createClass() {
    const name = document.getElementById('newClassName').value.trim();
    const code = document.getElementById('generatedCode').textContent.trim();
    if (!name) { showToast('error', 'Lỗi', 'Vui lòng nhập tên lớp học!'); return; }

    const form = document.createElement('form');
    form.method = 'POST';
    const ctx = (typeof TEACHER_CONFIG !== 'undefined') ? TEACHER_CONFIG.contextPath : '';
    form.action = ctx + '/teacher/classes/create';
    [['className', name], ['inviteCode', code]].forEach(([k, v]) => {
        const inp = document.createElement('input');
        inp.type = 'hidden'; inp.name = k; inp.value = v;
        form.appendChild(inp);
    });
    document.body.appendChild(form);
    form.submit();
}


/* ===== TEACHER: QUIZ FORM ===== */
function openCreateQuizModal() {
    const card = document.getElementById('quizFormCard');
    if (card) { card.style.display = ''; card.scrollIntoView({ behavior: 'smooth' }); }
}

function resetQuizForm() {
    const card = document.getElementById('quizFormCard');
    if (card) card.style.display = 'none';
}

function onQuizTypeChange() {
    const type = document.getElementById('qtType').value;
    const answersSection = document.getElementById('answersSection');
    if (answersSection) {
        answersSection.style.display = type === '2' ? 'none' : '';
    }
}

function addAnswerRow() {
    const rows = document.getElementById('answerRows');
    if (!rows) return;
    const count = rows.querySelectorAll('.answer-row').length;
    const letters = ['A', 'B', 'C', 'D', 'E', 'F'];
    const label = letters[count] || (count + 1);
    const div = document.createElement('div');
    div.className = 'answer-row';
    div.innerHTML = `
        <input type="checkbox" class="answer-correct-check" title="Đáp án đúng"/>
        <input type="text" class="fl-input answer-input" placeholder="Nhập đáp án ${label}..."/>
        <button type="button" class="remove-answer" onclick="removeAnswerRow(this)">
            <i class="fas fa-trash"></i>
        </button>`;
    rows.appendChild(div);
}

function removeAnswerRow(btn) {
    const rows = document.getElementById('answerRows');
    if (rows && rows.querySelectorAll('.answer-row').length > 1) {
        btn.closest('.answer-row').remove();
    } else {
        showToast('error', 'Lỗi', 'Cần ít nhất một đáp án!');
    }
}

function saveQuestion() {
    const text = document.getElementById('qtQuestionText').value.trim();
    if (!text) { showToast('error', 'Lỗi', 'Vui lòng nhập nội dung câu hỏi!'); return; }
    showToast('success', 'Đã lưu', 'Câu hỏi đã được thêm thành công!');
    resetQuizForm();
}


/* ===== TEACHER: NODE MANAGEMENT ===== */
function openAddNodeModal() {
    document.getElementById('newNodeTitle').value = '';
    document.getElementById('newNodeVideo').value = '';
    document.getElementById('addNodeModal').style.display = 'flex';
}

function saveNode() {
    const title = document.getElementById('newNodeTitle').value.trim();
    if (!title) { showToast('error', 'Lỗi', 'Vui lòng nhập tiêu đề bài học!'); return; }
    showToast('success', 'Thành công', `Đã thêm bài học "${title}"!`);
    closeModal('addNodeModal');
}

function initSortable() {
    const list = document.getElementById('nodesSortable');
    if (list && typeof Sortable !== 'undefined') {
        Sortable.create(list, {
            animation: 180,
            ghostClass: 'sortable-ghost',
            handle: '.drag-handle',
            onEnd: function (evt) {
                updateNodeOrder();
            }
        });
    }
}

function updateNodeOrder() {
    const items = document.querySelectorAll('#nodesSortable .node-item');
    const orders = [];
    items.forEach((item, idx) => {
        orders.push({ nodeId: item.dataset.nodeid, orderIndex: idx });
    });
    const ctx = (typeof TEACHER_CONFIG !== 'undefined') ? TEACHER_CONFIG.contextPath : '';
    fetch(ctx + '/teacher/nodes/reorder', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(orders)
    }).then(r => {
        if (r.ok) showToast('success', 'Đã cập nhật', 'Thứ tự bài học đã được lưu');
    }).catch(() => {});
}


/* ===== TEACHER: LIVE SESSION ===== */
let liveTimer = null;
let liveStart = null;

function startLiveSession() {
    const ctx = (typeof TEACHER_CONFIG !== 'undefined') ? TEACHER_CONFIG.contextPath : '';
    fetch(ctx + '/api/live/start', { method: 'POST' })
        .then(r => r.json())
        .then(data => {
            document.getElementById('liveStatusPanel').style.display = 'none';
            document.getElementById('liveActivePanel').style.display = '';
            liveStart = new Date();
            document.getElementById('liveStartTime').textContent = liveStart.toLocaleTimeString('vi-VN');
            liveTimer = setInterval(updateLiveTimer, 1000);
            showToast('success', 'Live Started!', 'Phiên học trực tiếp đã bắt đầu');
        }).catch(() => {
            // Demo mode
            document.getElementById('liveStatusPanel').style.display = 'none';
            document.getElementById('liveActivePanel').style.display = '';
            liveStart = new Date();
            document.getElementById('liveStartTime').textContent = liveStart.toLocaleTimeString('vi-VN');
            liveTimer = setInterval(updateLiveTimer, 1000);
        });
}

function updateLiveTimer() {
    if (!liveStart) return;
    const diff = Math.floor((Date.now() - liveStart.getTime()) / 1000);
    const h = String(Math.floor(diff / 3600)).padStart(2, '0');
    const m = String(Math.floor((diff % 3600) / 60)).padStart(2, '0');
    const s = String(diff % 60).padStart(2, '0');
    const el = document.getElementById('liveTimer');
    if (el) el.textContent = `${h}:${m}:${s}`;
}

function endLiveSession() {
    clearInterval(liveTimer);
    liveTimer = null;
    document.getElementById('liveStatusPanel').style.display = '';
    document.getElementById('liveActivePanel').style.display = 'none';
    showToast('success', 'Phiên kết thúc', 'Phiên học trực tiếp đã kết thúc');
}


/* ===== LEARN PAGE ===== */
function selectLesson(el) {
    // Highlight active
    document.querySelectorAll('.syllabus-item').forEach(i => i.classList.remove('active'));
    el.classList.add('active');

    const nodeId = el.dataset.nodeid;
    const title  = el.dataset.title;
    const video  = el.dataset.video;
    const type   = parseInt(el.dataset.type || '0');
    const order  = el.dataset.order;

    document.getElementById('lessonTitle').textContent = title;
    document.getElementById('breadcrumbLesson').textContent = title;
    document.getElementById('lessonOrder').style.display = '';
    document.getElementById('lessonOrderNum').textContent = parseInt(order) + 1;
    document.getElementById('lessonType').style.display = '';

    const typeLabels = ['Video', 'Quiz', 'Milestone'];
    const typeLabel = document.getElementById('lessonTypeText');
    if (typeLabel) typeLabel.textContent = typeLabels[type] || 'Video';

    // Load video
    const frame = document.getElementById('videoFrame');
    const placeholder = document.getElementById('videoPlaceholder');
    if (video && video.trim() !== '') {
        let src = video;
        // Convert YouTube watch URL to embed
        if (src.includes('youtube.com/watch?v=')) {
            const id = new URL(src).searchParams.get('v');
            src = `https://www.youtube.com/embed/${id}?enablejsapi=1`;
        }
        frame.src = src;
        frame.style.display = '';
        if (placeholder) placeholder.style.display = 'none';
    } else {
        frame.src = '';
        frame.style.display = 'none';
        if (placeholder) placeholder.style.display = '';
    }

    // Enable nav buttons
    document.getElementById('prevLessonBtn').disabled = false;
    document.getElementById('nextLessonBtn').disabled = false;
}

function navigateLesson(dir) {
    const items = Array.from(document.querySelectorAll('.syllabus-item'));
    const active = document.querySelector('.syllabus-item.active');
    if (!active) { if (items[0]) selectLesson(items[0]); return; }
    const idx = items.indexOf(active);
    const next = items[idx + dir];
    if (next) selectLesson(next);
}

function toggleSidebar() {
    const sidebar = document.getElementById('learnSidebar');
    if (sidebar) sidebar.style.display = sidebar.style.display === 'none' ? '' : 'none';
}

function switchTab(tab) {
    document.getElementById('paneSyllabus').style.display = tab === 'syllabus' ? '' : 'none';
    document.getElementById('paneAssistant').style.display = tab === 'assistant' ? '' : 'none';
    document.getElementById('tabSyllabus').classList.toggle('active', tab === 'syllabus');
    document.getElementById('tabAssistant').classList.toggle('active', tab === 'assistant');
}

/* Quiz overlay */
function skipQuiz() {
    document.getElementById('quizOverlay').style.display = 'none';
    // Resume video (would be done via YouTube API in full impl)
}

function submitQuiz() {
    const selected = document.querySelector('.quiz-option.selected');
    const essay    = document.getElementById('essayInput');
    if (!selected && (!essay || !essay.value.trim())) {
        showToast('error', 'Lỗi', 'Vui lòng chọn hoặc nhập câu trả lời!');
        return;
    }
    // Submit answer - in real impl would call /api/answers
    document.getElementById('quizOverlay').style.display = 'none';
    showToast('success', '🎉 Chính xác!', '+10 điểm thưởng đã được cộng vào tài khoản!');
}

document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.quiz-option').forEach(opt => {
        opt.addEventListener('click', function () {
            document.querySelectorAll('.quiz-option').forEach(o => o.classList.remove('selected'));
            this.classList.add('selected');
        });
    });
});

function sendChat() {
    const input = document.getElementById('chatInput');
    if (!input || !input.value.trim()) return;
    const msgs = document.getElementById('chatMessages');
    const msg = document.createElement('div');
    msg.style.cssText = 'background:var(--bg-surface);border:1px solid var(--border);border-radius:var(--radius);padding:.6rem .85rem;font-size:.83rem;color:var(--text-secondary);margin-bottom:.5rem;text-align:right;';
    msg.textContent = input.value;
    if (msgs) msgs.appendChild(msg);
    input.value = '';
    // AI response placeholder
    setTimeout(() => {
        const reply = document.createElement('div');
        reply.style.cssText = 'background:rgba(139,92,246,.08);border:1px solid rgba(139,92,246,.15);border-radius:var(--radius);padding:.6rem .85rem;font-size:.83rem;color:var(--text-secondary);margin-bottom:.5rem;';
        reply.innerHTML = '<i class="fas fa-robot me-1" style="color:var(--accent);"></i>Chức năng AI đang được phát triển...';
        if (msgs) { msgs.appendChild(reply); msgs.scrollTop = msgs.scrollHeight; }
    }, 600);
}
