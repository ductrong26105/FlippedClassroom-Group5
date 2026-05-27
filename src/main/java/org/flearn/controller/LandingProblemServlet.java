package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * Landing Problem Page — Chi tiết 3 vấn đề giáo dục
 */
@WebServlet(name = "LandingProblemServlet", urlPatterns = "/landing/problem")
public class LandingProblemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "Vấn đề hiện tại — FLearn");
        request.setAttribute("activePage", "landing-problem");

        // Problem 1 — Time constraint
        Map<String, Object> prob1 = new LinkedHashMap<>();
        prob1.put("number", "01");
        prob1.put("title", "Thời gian học trên lớp có hạn");
        prob1.put("desc", "Buổi học truyền thống dành phần lớn thời gian cho giảng lý thuyết. Sinh viên ngồi nghe thụ động, không có cơ hội vận dụng kiến thức vào bài tập thực tế. Kỹ năng phát triển phần mềm đòi hỏi thực hành liên tục, nhưng thời gian trên lớp lại bị lãng phí cho các nội dung có thể tự học ở nhà.");
        prob1.put("iconClass", "icon-red");
        prob1.put("evidenceClass", "ev-red");
        List<String> ev1 = Arrays.asList(
            "80% thời gian buổi học dành cho giảng lý thuyết",
            "Sinh viên chỉ thực hành trung bình 12 phút / buổi 90 phút",
            "65% sinh viên cảm thấy buổi học không hiệu quả (khảo sát)",
            "Tỷ lệ hoàn thành bài tập thực hành chỉ đạt 42%"
        );
        prob1.put("evidence", ev1);
        request.setAttribute("prob1", prob1);

        // Problem 2 — Lecturer can't assess understanding
        Map<String, Object> prob2 = new LinkedHashMap<>();
        prob2.put("number", "02");
        prob2.put("title", "Giảng viên không nắm được mức độ hiểu bài");
        prob2.put("desc", "Trong lớp học truyền thống, giảng viên không có công cụ để đánh giá từng sinh viên đã hiểu bài ở mức nào. Kết quả là nhiều sinh viên bị bỏ lại phía sau mà không ai biết, cho đến khi thi cuối kỳ mới phát hiện lỗ hổng kiến thức nghiêm trọng.");
        prob2.put("iconClass", "icon-amber");
        prob2.put("evidenceClass", "ev-amber");
        List<String> ev2 = Arrays.asList(
            "Tỷ lệ giảng viên / sinh viên: 1 : 40-60",
            "Chỉ 20% sinh viên yếu được phát hiện trước kỳ thi",
            "Không có hệ thống tracking tiến trình học tập",
            "Phản hồi chỉ đến từ bài kiểm tra giữa kỳ & cuối kỳ"
        );
        prob2.put("evidence", ev2);
        request.setAttribute("prob2", prob2);

        // Problem 3 — Limited interaction
        Map<String, Object> prob3 = new LinkedHashMap<>();
        prob3.put("number", "03");
        prob3.put("title", "Hạn chế tương tác giữa các bên");
        prob3.put("desc", "Sinh viên ngại đặt câu hỏi trước lớp đông. Thiếu kênh trao đổi hiệu quả giữa sinh viên với giảng viên và giữa sinh viên với nhau. Nhóm học tập không được tổ chức bài bản, dẫn đến việc sinh viên yếu không nhận được hỗ trợ kịp thời.");
        prob3.put("iconClass", "icon-blue");
        prob3.put("evidenceClass", "ev-blue");
        List<String> ev3 = Arrays.asList(
            "Dưới 15% sinh viên tự tin đặt câu hỏi tại lớp",
            "70% thắc mắc không được giải đáp kịp thời",
            "Thiếu hệ thống hỗ trợ peer-to-peer",
            "Email/Zalo không phù hợp cho Q&A theo chủ đề"
        );
        prob3.put("evidence", ev3);
        request.setAttribute("prob3", prob3);

        // Impact stats
        request.setAttribute("dropoutRate", 35);
        request.setAttribute("avgScore", 5.8);
        request.setAttribute("retakeRate", 28);
        request.setAttribute("satisfactionOld", 45);

        request.getRequestDispatcher("/WEB-INF/views/landing/problem.jsp")
               .forward(request, response);
    }
}
