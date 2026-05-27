package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * Landing Home Page — Giới thiệu dự án FLearn
 */
@WebServlet(name = "LandingHomeServlet", urlPatterns = "/landing")
public class LandingHomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "FLearn — Hệ thống Học tập Chủ động");
        request.setAttribute("activePage", "landing-home");

        // Hero stats
        request.setAttribute("totalStudents", 500);
        request.setAttribute("totalCourses", 25);
        request.setAttribute("completionRate", 87);
        request.setAttribute("satisfactionRate", 95);

        // Problems summary for home page cards
        List<Map<String, String>> problems = new ArrayList<>();

        Map<String, String> p1 = new LinkedHashMap<>();
        p1.put("icon", "fa-clock");
        p1.put("iconClass", "icon-red");
        p1.put("title", "Thời gian lớp học hạn chế");
        p1.put("desc", "80% thời gian trên lớp dành cho giảng lý thuyết, sinh viên không có cơ hội tương tác và thực hành kỹ năng.");
        p1.put("stat", "80% thời gian = lý thuyết");
        problems.add(p1);

        Map<String, String> p2 = new LinkedHashMap<>();
        p2.put("icon", "fa-eye-slash");
        p2.put("iconClass", "icon-amber");
        p2.put("title", "Không nắm được mức độ hiểu bài");
        p2.put("desc", "Giảng viên khó đánh giá từng sinh viên đã hiểu bài ở mức nào, dẫn đến dạy không sát thực tế.");
        p2.put("stat", "1 giảng viên : 40+ sinh viên");
        problems.add(p2);

        Map<String, String> p3 = new LinkedHashMap<>();
        p3.put("icon", "fa-users-slash");
        p3.put("iconClass", "icon-blue");
        p3.put("title", "Hạn chế tương tác");
        p3.put("desc", "Sinh viên ngại hỏi trên lớp, thiếu kênh trao đổi hiệu quả giữa sinh viên và giảng viên.");
        p3.put("stat", "< 15% sinh viên đặt câu hỏi");
        problems.add(p3);

        request.setAttribute("problems", problems);

        request.getRequestDispatcher("/WEB-INF/views/landing/home.jsp")
               .forward(request, response);
    }
}
