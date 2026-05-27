package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.ClassDAO;
import org.flearn.dao.UserDAO;
import org.flearn.model.ClassMember;
import org.flearn.model.ClassRoom;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;

/**
 * Handles joining a class by ClassID or InviteCode.
 *
 * POST /courses/join           → join by classId (from course card button)
 * POST /courses/join-by-code   → join by inviteCode (from search bar)
 */
@WebServlet(name = "JoinCourseServlet", urlPatterns = {
        "/courses/join",
        "/courses/join-by-code"
})
public class JoinCourseServlet extends HttpServlet {

    private final ClassDAO classDAO = new ClassDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Auth guard ─────────────────────────────────────────────────
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null)
                ? (User) session.getAttribute(AppConstants.SESSION_USER)
                : null;

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Students only (teachers create classes, not join them)
        if (loggedInUser.getRole() == AppConstants.ROLE_ADMIN) {
            response.sendRedirect(request.getContextPath() + "/courses?error=admin_cannot_join");
            return;
        }

        ClassRoom targetClass = null;
        String path = request.getServletPath();

        if ("/courses/join-by-code".equals(path)) {
            // Join by invite code
            String code = request.getParameter("inviteCode");
            if (code != null && !code.isBlank()) {
                targetClass = classDAO.findByInviteCode(code.trim().toUpperCase());
            }
        } else {
            // Join by classId
            String classIdParam = request.getParameter("classId");
            if (classIdParam != null) {
                try {
                    int classId = Integer.parseInt(classIdParam);
                    targetClass = classDAO.findById(classId);
                } catch (NumberFormatException ignored) { }
            }
        }

        if (targetClass == null) {
            response.sendRedirect(request.getContextPath() + "/courses?error=class_not_found");
            return;
        }

        // Business Rule: Check if class is active
        if (!targetClass.isActive()) {
            response.sendRedirect(request.getContextPath() + "/courses?error=class_inactive");
            return;
        }

        // Business Rule: Check if user is already a member
        if (classDAO.isMember(targetClass.getClassId(), loggedInUser.getUserId())) {
            response.sendRedirect(request.getContextPath() + "/courses?error=already_joined");
            return;
        }

        // Save the membership in database if not already a member
        classDAO.addMember(targetClass, loggedInUser);

        // Redirect to learning workspace upon success
        response.sendRedirect(request.getContextPath()
                + "/learn/" + targetClass.getClassId()
                + "?joined=1");
    }
}
