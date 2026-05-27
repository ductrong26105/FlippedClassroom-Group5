package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.ClassDAO;
import org.flearn.dao.UserDAO;
import org.flearn.model.ClassRoom;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Handles the Admin Control Panel.
 * URL pattern: /admin/panel
 *
 * GET  → show dashboard with users, classes, analytics
 */
@WebServlet(name = "AdminPanelServlet", urlPatterns = "/admin/panel")
public class AdminPanelServlet extends HttpServlet {

    private final UserDAO  userDAO  = new UserDAO();
    private final ClassDAO classDAO = new ClassDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Auth guard: must be Admin ──────────────────────────────────
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null)
                ? (User) session.getAttribute(AppConstants.SESSION_USER)
                : null;

        if (loggedInUser == null || loggedInUser.getRole() != AppConstants.ROLE_ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── Load all users ─────────────────────────────────────────────
        List<User> users = userDAO.findAll();

        long totalAdmins   = users.stream().filter(u -> u.getRole() == AppConstants.ROLE_ADMIN).count();
        long totalTeachers = users.stream().filter(u -> u.getRole() == AppConstants.ROLE_TEACHER).count();
        long totalStudents = users.stream().filter(u -> u.getRole() == AppConstants.ROLE_STUDENT).count();

        // ── Load all classes ───────────────────────────────────────────
        List<ClassRoom> allClasses = classDAO.findAll();

        // ── Set attributes ─────────────────────────────────────────────
        request.setAttribute("users",          users);
        request.setAttribute("allClasses",     allClasses);
        request.setAttribute("totalUsers",     users.size());
        request.setAttribute("totalAdmins",    totalAdmins);
        request.setAttribute("totalTeachers",  totalTeachers);
        request.setAttribute("totalStudents",  totalStudents);
        request.setAttribute("totalClasses",   allClasses.size());

        request.setAttribute("pageTitle",      "Admin Panel - FLearn");
        request.setAttribute("activePage",     "admin");

        request.getRequestDispatcher(AppConstants.VIEW_ADMIN_PANEL)
               .forward(request, response);
    }
}
