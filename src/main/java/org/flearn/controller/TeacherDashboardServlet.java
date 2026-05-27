package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.ClassDAO;
import org.flearn.dao.NodeDAO;
import org.flearn.model.ClassRoom;
import org.flearn.model.Node;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;
import java.util.List;

/**
 * Handles the Teacher Studio Dashboard.
 * URL pattern: /teacher/dashboard
 *
 * GET  → show dashboard with teacher's classes, nodes, quiz, grading, live sections
 */
@WebServlet(name = "TeacherDashboardServlet", urlPatterns = "/teacher/dashboard")
public class TeacherDashboardServlet extends HttpServlet {

    private final ClassDAO classDAO = new ClassDAO();
    private final NodeDAO  nodeDAO  = new NodeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Auth guard: must be logged in as Teacher ───────────────────
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null)
                ? (User) session.getAttribute(AppConstants.SESSION_USER)
                : null;

        if (loggedInUser == null || loggedInUser.getRole() != AppConstants.ROLE_TEACHER) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── Load teacher's classes ────────────────────────────────────
        List<ClassRoom> myClasses = classDAO.findByTeacher(loggedInUser.getUserId());
        request.setAttribute("myClasses", myClasses);

        // ── If a classId is selected (optional query param), load nodes ─
        String classIdParam = request.getParameter("classId");
        if (classIdParam != null) {
            try {
                int classId = Integer.parseInt(classIdParam);
                ClassRoom selectedClass = classDAO.findById(classId);
                if (selectedClass != null
                        && selectedClass.getTeacher().getUserId() == loggedInUser.getUserId()) {
                    List<Node> nodes = nodeDAO.findByClass(classId);
                    request.setAttribute("selectedClass", selectedClass);
                    request.setAttribute("nodes", nodes);
                }
            } catch (NumberFormatException ignored) { }
        }

        request.setAttribute("pageTitle",  "Teacher Studio - FLearn");
        request.setAttribute("activePage", "teacher");

        request.getRequestDispatcher(AppConstants.VIEW_TEACHER_DASHBOARD)
               .forward(request, response);
    }
}
