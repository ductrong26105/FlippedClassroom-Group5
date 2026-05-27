package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * Landing Solution Page — Blueprint giải pháp + demo code
 */
@WebServlet(name = "LandingSolutionServlet", urlPatterns = "/landing/solution")
public class LandingSolutionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "Giải pháp — FLearn");
        request.setAttribute("activePage", "landing-solution");

        // Blueprints
        List<Map<String, Object>> blueprints = new ArrayList<>();

        // BP1
        Map<String, Object> bp1 = new LinkedHashMap<>();
        bp1.put("id", "bp1");
        bp1.put("label", "BP1");
        bp1.put("labelClass", "bp1");
        bp1.put("dotClass", "dot-1");
        bp1.put("title", "Nền tảng cơ bản");
        bp1.put("desc", "Mô hình dạy phát triển phần mềm tập trung vào thực hành, không nặng nề chấm điểm. Xây dựng nền tảng vững chắc cho sinh viên trước khi đi vào các giai đoạn nâng cao.");
        bp1.put("features", Arrays.asList("Thực hành trước lý thuyết", "Đánh giá quá trình", "Không áp lực điểm số", "Mentor hỗ trợ"));
        blueprints.add(bp1);

        // BP2
        Map<String, Object> bp2 = new LinkedHashMap<>();
        bp2.put("id", "bp2");
        bp2.put("label", "BP2");
        bp2.put("labelClass", "bp2");
        bp2.put("dotClass", "dot-2");
        bp2.put("title", "Học & chuẩn bị trước ở nhà");
        bp2.put("desc", "Sinh viên tự học qua tài liệu, video trước buổi học. Hệ thống tracking ghi nhận tiến trình, câu hỏi kiểm tra mức độ hiểu bài, và đăng ký chủ đề muốn được giải thích tại lớp.");
        bp2.put("features", Arrays.asList("Video bài giảng", "Tracking tiến trình", "Quiz kiểm tra", "Đăng ký chủ đề", "Hỗ trợ trước giờ học"));
        blueprints.add(bp2);

        // BP3
        Map<String, Object> bp3 = new LinkedHashMap<>();
        bp3.put("id", "bp3");
        bp3.put("label", "BP3");
        bp3.put("labelClass", "bp3");
        bp3.put("dotClass", "dot-3");
        bp3.put("title", "Vận hành tại lớp");
        bp3.put("desc", "Giải đáp câu hỏi tồn đọng, chấm điểm bài làm tại lớp với mẫu diễn hình, lộ trình hướng dẫn độc lập, nhóm hỗ trợ kỹ thuật và nhóm phản biện trực tiếp.");
        bp3.put("features", Arrays.asList("Giải đáp Q&A", "Chấm điểm thực hành", "Mẫu diễn hình", "Nhóm phản biện", "Hỗ trợ kỹ thuật"));
        blueprints.add(bp3);

        // BPx
        Map<String, Object> bpx = new LinkedHashMap<>();
        bpx.put("id", "bpx");
        bpx.put("label", "BPx");
        bpx.put("labelClass", "bpx");
        bpx.put("dotClass", "dot-4");
        bpx.put("title", "Khóa học có điều kiện");
        bpx.put("desc", "Sinh viên cần hoàn thành điều kiện trước mới được vào khóa tiếp theo. Quản lý project & milestone, dashboard giảng viên với lịch sử học, điểm số và tiến trình chi tiết.");
        bpx.put("features", Arrays.asList("Prerequisites", "Milestone tracking", "Project management", "Dashboard giảng viên", "Review & phản biện"));
        blueprints.add(bpx);

        request.setAttribute("blueprints", blueprints);

        // Before/After comparison
        List<String> beforeItems = Arrays.asList(
            "Sinh viên ngồi nghe thụ động 80% thời gian",
            "Không biết sinh viên hiểu bài ở mức nào",
            "Tương tác 1 chiều: giảng viên → sinh viên",
            "Đánh giá chỉ qua thi giữa kỳ / cuối kỳ",
            "Sinh viên yếu không được hỗ trợ kịp thời",
            "Không có tracking tiến trình học tập"
        );
        List<String> afterItems = Arrays.asList(
            "70% thời gian lớp dành cho thực hành & thảo luận",
            "Dashboard tracking real-time mức độ hiểu bài",
            "Tương tác đa chiều: GV ↔ SV ↔ SV",
            "Đánh giá liên tục qua quiz, milestone, peer review",
            "Hệ thống mentor + nhóm hỗ trợ kỹ thuật",
            "Tracking chi tiết: video watched, quiz score, progress"
        );
        request.setAttribute("beforeItems", beforeItems);
        request.setAttribute("afterItems", afterItems);

        // Code showcase data - filenames and content for tabs
        List<Map<String, String>> codeFiles = new ArrayList<>();

        Map<String, String> f1 = new LinkedHashMap<>();
        f1.put("id", "user-model");
        f1.put("name", "User.java");
        f1.put("icon", "☕");
        f1.put("path", "org/flearn/model/User.java");
        f1.put("lang", "java");
        f1.put("code", "package org.flearn.model;\n\nimport jakarta.persistence.*;\nimport lombok.*;\nimport java.time.LocalDateTime;\n\n@Entity\n@Table(name = \"Users\")\n@Getter @Setter\n@NoArgsConstructor @AllArgsConstructor\n@Builder\npublic class User {\n\n    @Id\n    @GeneratedValue(strategy = GenerationType.IDENTITY)\n    @Column(name = \"UserID\")\n    private int userId;\n\n    @Column(name = \"Username\", nullable = false,\n            length = 50, unique = true)\n    private String username;\n\n    @Column(name = \"PasswordHash\", nullable = false,\n            length = 255)\n    private String passwordHash;\n\n    @Column(name = \"FullName\", nullable = false,\n            length = 100)\n    private String fullName;\n\n    @Column(name = \"Email\", nullable = false,\n            length = 100, unique = true)\n    private String email;\n\n    /** 0 = Admin, 1 = Teacher, 2 = Student */\n    @Column(name = \"Role\", nullable = false)\n    private byte role;\n\n    @Column(name = \"IsActive\", nullable = false)\n    private boolean isActive;\n\n    @Column(name = \"CreatedAt\", nullable = false,\n            updatable = false)\n    private LocalDateTime createdAt;\n\n    @PrePersist\n    protected void onCreate() {\n        if (createdAt == null)\n            createdAt = LocalDateTime.now();\n        isActive = true;\n    }\n}");
        codeFiles.add(f1);

        Map<String, String> f2 = new LinkedHashMap<>();
        f2.put("id", "student-progress");
        f2.put("name", "StudentProgress.java");
        f2.put("icon", "☕");
        f2.put("path", "org/flearn/model/StudentProgress.java");
        f2.put("lang", "java");
        f2.put("code", "package org.flearn.model;\n\nimport jakarta.persistence.*;\nimport lombok.*;\nimport java.time.LocalDateTime;\n\n@Entity\n@Table(name = \"StudentProgress\",\n    uniqueConstraints = @UniqueConstraint(\n        columnNames = {\"StudentID\", \"NodeID\"}))\n@Getter @Setter\n@NoArgsConstructor @AllArgsConstructor\n@Builder\npublic class StudentProgress {\n\n    @Id\n    @GeneratedValue(strategy = GenerationType.IDENTITY)\n    @Column(name = \"ProgressID\")\n    private int progressId;\n\n    @ManyToOne(fetch = FetchType.LAZY)\n    @JoinColumn(name = \"StudentID\", nullable = false)\n    private User student;\n\n    @ManyToOne(fetch = FetchType.LAZY)\n    @JoinColumn(name = \"NodeID\", nullable = false)\n    private Node node;\n\n    @Column(name = \"IsCompleted\", nullable = false)\n    private boolean isCompleted;\n\n    @Column(name = \"LastWatchedSec\", nullable = false)\n    private int lastWatchedSec;\n\n    @Column(name = \"TotalBonus\", nullable = false)\n    private int totalBonus;\n\n    @Column(name = \"UpdatedAt\", nullable = false)\n    private LocalDateTime updatedAt;\n\n    @PrePersist @PreUpdate\n    protected void onUpdate() {\n        updatedAt = LocalDateTime.now();\n    }\n}");
        codeFiles.add(f2);

        Map<String, String> f3 = new LinkedHashMap<>();
        f3.put("id", "db-context");
        f3.put("name", "DBContext.java");
        f3.put("icon", "🗄️");
        f3.put("path", "org/flearn/dao/DBContext.java");
        f3.put("lang", "java");
        f3.put("code", "package org.flearn.dao;\n\nimport jakarta.persistence.*;\n\n/**\n * Singleton factory for JPA EntityManager.\n * Uses persistence unit from persistence.xml.\n */\npublic class DBContext {\n\n    private static final String PU = \n        \"flearn-persistence-unit\";\n    private static volatile EntityManagerFactory emf;\n\n    private DBContext() { }\n\n    public static EntityManagerFactory\n            getEntityManagerFactory() {\n        if (emf == null) {\n            synchronized (DBContext.class) {\n                if (emf == null) {\n                    emf = Persistence\n                        .createEntityManagerFactory(PU);\n                }\n            }\n        }\n        return emf;\n    }\n\n    public static EntityManager getEntityManager() {\n        return getEntityManagerFactory()\n                   .createEntityManager();\n    }\n\n    public static void shutdown() {\n        if (emf != null && emf.isOpen())\n            emf.close();\n    }\n}");
        codeFiles.add(f3);

        Map<String, String> f4 = new LinkedHashMap<>();
        f4.put("id", "learn-servlet");
        f4.put("name", "LearnServlet.java");
        f4.put("icon", "🎯");
        f4.put("path", "org/flearn/controller/LearnServlet.java");
        f4.put("lang", "java");
        f4.put("code", "package org.flearn.controller;\n\nimport jakarta.servlet.*;\nimport jakarta.servlet.annotation.WebServlet;\nimport jakarta.servlet.http.*;\nimport org.flearn.dao.*;\nimport org.flearn.model.*;\nimport org.flearn.util.AppConstants;\nimport java.io.IOException;\nimport java.util.List;\n\n@WebServlet(name = \"LearnServlet\",\n            urlPatterns = \"/learn/*\")\npublic class LearnServlet extends HttpServlet {\n\n    private final ClassDAO classDAO = new ClassDAO();\n    private final NodeDAO  nodeDAO  = new NodeDAO();\n\n    @Override\n    protected void doGet(HttpServletRequest req,\n                         HttpServletResponse res)\n            throws ServletException, IOException {\n\n        // Auth guard\n        HttpSession session = req.getSession(false);\n        User user = (session != null)\n            ? (User) session.getAttribute(\n                  AppConstants.SESSION_USER) : null;\n        if (user == null) {\n            res.sendRedirect(\n                req.getContextPath() + \"/login\");\n            return;\n        }\n\n        // Extract classId from /learn/{classId}\n        String path = req.getPathInfo();\n        int classId = Integer.parseInt(\n            path.replace(\"/\", \"\").trim());\n\n        // Load data\n        ClassRoom room = classDAO.findById(classId);\n        List<Node> nodes = nodeDAO.findByClass(classId);\n\n        req.setAttribute(\"classRoom\", room);\n        req.setAttribute(\"nodes\", nodes);\n        req.getRequestDispatcher(\n            AppConstants.VIEW_LEARN)\n            .forward(req, res);\n    }\n}");
        codeFiles.add(f4);

        Map<String, String> f5 = new LinkedHashMap<>();
        f5.put("id", "teacher-dashboard");
        f5.put("name", "TeacherDashboard.java");
        f5.put("icon", "📊");
        f5.put("path", "org/flearn/controller/TeacherDashboardServlet.java");
        f5.put("lang", "java");
        f5.put("code", "package org.flearn.controller;\n\nimport jakarta.servlet.*;\nimport jakarta.servlet.annotation.WebServlet;\nimport jakarta.servlet.http.*;\nimport org.flearn.dao.*;\nimport org.flearn.model.*;\nimport org.flearn.util.AppConstants;\nimport java.io.IOException;\nimport java.util.List;\n\n@WebServlet(name = \"TeacherDashboardServlet\",\n    urlPatterns = \"/teacher/dashboard\")\npublic class TeacherDashboardServlet\n        extends HttpServlet {\n\n    private final ClassDAO classDAO = new ClassDAO();\n    private final NodeDAO  nodeDAO  = new NodeDAO();\n\n    @Override\n    protected void doGet(HttpServletRequest req,\n                         HttpServletResponse res)\n            throws ServletException, IOException {\n\n        // Auth: must be Teacher\n        HttpSession session = req.getSession(false);\n        User user = (session != null)\n            ? (User) session.getAttribute(\n                  AppConstants.SESSION_USER) : null;\n\n        if (user == null || user.getRole()\n                != AppConstants.ROLE_TEACHER) {\n            res.sendRedirect(\n                req.getContextPath() + \"/login\");\n            return;\n        }\n\n        // Load teacher's classes\n        List<ClassRoom> myClasses =\n            classDAO.findByTeacher(user.getUserId());\n        req.setAttribute(\"myClasses\", myClasses);\n\n        // Selected class nodes\n        String cid = req.getParameter(\"classId\");\n        if (cid != null) {\n            int classId = Integer.parseInt(cid);\n            ClassRoom cls = classDAO.findById(classId);\n            if (cls != null) {\n                List<Node> nodes =\n                    nodeDAO.findByClass(classId);\n                req.setAttribute(\n                    \"selectedClass\", cls);\n                req.setAttribute(\"nodes\", nodes);\n            }\n        }\n\n        req.getRequestDispatcher(\n            AppConstants.VIEW_TEACHER_DASHBOARD)\n            .forward(req, res);\n    }\n}");
        codeFiles.add(f5);

        request.setAttribute("codeFiles", codeFiles);

        // Database tables for ERD display
        List<Map<String, Object>> dbTables = new ArrayList<>();

        // Users table
        Map<String, Object> t1 = new LinkedHashMap<>();
        t1.put("name", "Users");
        t1.put("icon", "fa-user");
        List<Map<String, String>> cols1 = new ArrayList<>();
        cols1.add(Map.of("name", "UserID", "type", "INT", "key", "PK"));
        cols1.add(Map.of("name", "Username", "type", "VARCHAR(50)", "key", ""));
        cols1.add(Map.of("name", "PasswordHash", "type", "VARCHAR(255)", "key", ""));
        cols1.add(Map.of("name", "FullName", "type", "NVARCHAR(100)", "key", ""));
        cols1.add(Map.of("name", "Role", "type", "TINYINT", "key", ""));
        t1.put("columns", cols1);
        dbTables.add(t1);

        // Classes table
        Map<String, Object> t2 = new LinkedHashMap<>();
        t2.put("name", "Classes");
        t2.put("icon", "fa-chalkboard");
        List<Map<String, String>> cols2 = new ArrayList<>();
        cols2.add(Map.of("name", "ClassID", "type", "INT", "key", "PK"));
        cols2.add(Map.of("name", "ClassName", "type", "NVARCHAR(100)", "key", ""));
        cols2.add(Map.of("name", "TeacherID", "type", "INT", "key", "FK"));
        cols2.add(Map.of("name", "InviteCode", "type", "VARCHAR(10)", "key", ""));
        t2.put("columns", cols2);
        dbTables.add(t2);

        // Nodes table
        Map<String, Object> t3 = new LinkedHashMap<>();
        t3.put("name", "Nodes");
        t3.put("icon", "fa-sitemap");
        List<Map<String, String>> cols3 = new ArrayList<>();
        cols3.add(Map.of("name", "NodeID", "type", "INT", "key", "PK"));
        cols3.add(Map.of("name", "ClassID", "type", "INT", "key", "FK"));
        cols3.add(Map.of("name", "Title", "type", "NVARCHAR(200)", "key", ""));
        cols3.add(Map.of("name", "NodeType", "type", "TINYINT", "key", ""));
        cols3.add(Map.of("name", "VideoURL", "type", "VARCHAR(500)", "key", ""));
        t3.put("columns", cols3);
        dbTables.add(t3);

        // StudentProgress table
        Map<String, Object> t4 = new LinkedHashMap<>();
        t4.put("name", "StudentProgress");
        t4.put("icon", "fa-chart-line");
        List<Map<String, String>> cols4 = new ArrayList<>();
        cols4.add(Map.of("name", "ProgressID", "type", "INT", "key", "PK"));
        cols4.add(Map.of("name", "StudentID", "type", "INT", "key", "FK"));
        cols4.add(Map.of("name", "NodeID", "type", "INT", "key", "FK"));
        cols4.add(Map.of("name", "IsCompleted", "type", "BIT", "key", ""));
        cols4.add(Map.of("name", "LastWatchedSec", "type", "INT", "key", ""));
        t4.put("columns", cols4);
        dbTables.add(t4);

        // Questions table
        Map<String, Object> t5 = new LinkedHashMap<>();
        t5.put("name", "Questions");
        t5.put("icon", "fa-question-circle");
        List<Map<String, String>> cols5 = new ArrayList<>();
        cols5.add(Map.of("name", "QuestionID", "type", "INT", "key", "PK"));
        cols5.add(Map.of("name", "NodeID", "type", "INT", "key", "FK"));
        cols5.add(Map.of("name", "QuestionText", "type", "NVARCHAR(MAX)", "key", ""));
        cols5.add(Map.of("name", "QuestionType", "type", "TINYINT", "key", ""));
        cols5.add(Map.of("name", "BonusPoint", "type", "INT", "key", ""));
        t5.put("columns", cols5);
        dbTables.add(t5);

        // LiveSessions table
        Map<String, Object> t6 = new LinkedHashMap<>();
        t6.put("name", "LiveSessions");
        t6.put("icon", "fa-broadcast-tower");
        List<Map<String, String>> cols6 = new ArrayList<>();
        cols6.add(Map.of("name", "SessionID", "type", "INT", "key", "PK"));
        cols6.add(Map.of("name", "ClassID", "type", "INT", "key", "FK"));
        cols6.add(Map.of("name", "TeacherID", "type", "INT", "key", "FK"));
        cols6.add(Map.of("name", "StartedAt", "type", "DATETIME", "key", ""));
        cols6.add(Map.of("name", "EndedAt", "type", "DATETIME", "key", ""));
        t6.put("columns", cols6);
        dbTables.add(t6);

        request.setAttribute("dbTables", dbTables);

        request.getRequestDispatcher("/WEB-INF/views/landing/solution.jsp")
               .forward(request, response);
    }
}
