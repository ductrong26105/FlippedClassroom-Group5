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

        String[] targetFiles = {
            "user-model,User.java,☕,org/flearn/model/User.java",
            "student-progress,StudentProgress.java,☕,org/flearn/model/StudentProgress.java",
            "db-context,DBContext.java,🗄️,org/flearn/dao/DBContext.java",
            "learn-servlet,LearnServlet.java,🎯,org/flearn/controller/LearnServlet.java",
            "teacher-dashboard,TeacherDashboardServlet.java,📊,org/flearn/controller/TeacherDashboardServlet.java"
        };

        for (String fileInfo : targetFiles) {
            String[] parts = fileInfo.split(",");
            Map<String, String> map = new LinkedHashMap<>();
            map.put("id", parts[0]);
            map.put("name", parts[1]);
            map.put("icon", parts[2]);
            map.put("path", parts[3]);
            map.put("lang", "java");
            
            // Read actual file from repo
            java.nio.file.Path path = java.nio.file.Paths.get("src/main/java", parts[3]);
            String code = "";
            if (java.nio.file.Files.exists(path)) {
                try {
                    code = java.nio.file.Files.readString(path);
                } catch (Exception e) {
                    code = "// Lỗi khi đọc file: " + e.getMessage();
                }
            } else {
                code = "// Lỗi: Không tìm thấy source code thật tại " + path.toAbsolutePath().toString() + "\n// Thay vì dùng placeholder, hệ thống báo rõ không đọc được repo theo đúng yêu cầu.";
            }
            map.put("code", code);
            codeFiles.add(map);
        }

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
