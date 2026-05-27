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
import java.util.UUID;

/**
 * Handles Teacher class management actions.
 * URL: /teacher/classes/create  → POST: create a new ClassRoom
 */
@WebServlet(name = "TeacherClassServlet", urlPatterns = "/teacher/classes/*")
public class TeacherClassServlet extends HttpServlet {

    private final ClassDAO classDAO = new ClassDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Auth guard
        HttpSession session = request.getSession(false);
        User teacher = (session != null)
                ? (User) session.getAttribute(AppConstants.SESSION_USER)
                : null;

        if (teacher == null || teacher.getRole() != AppConstants.ROLE_TEACHER) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String path = request.getPathInfo(); // "/create"

        if ("/create".equals(path)) {
            String className  = request.getParameter("className");
            String inviteCode = request.getParameter("inviteCode");

            if (className == null || className.isBlank()) {
                response.sendRedirect(request.getContextPath()
                        + "/teacher/dashboard?error=empty_name");
                return;
            }

            // Fallback: generate code if blank
            if (inviteCode == null || inviteCode.isBlank()) {
                inviteCode = generateCode();
            }

            ClassRoom newClass = ClassRoom.builder()
                    .className(className.trim())
                    .teacher(teacher)
                    .inviteCode(inviteCode.trim().toUpperCase())
                    .build();

            try {
                classDAO.save(newClass);
                response.sendRedirect(request.getContextPath()
                        + "/teacher/dashboard?created=1&classId=" + newClass.getClassId());
            } catch (Exception e) {
                // Possible duplicate invite code
                response.sendRedirect(request.getContextPath()
                        + "/teacher/dashboard?error=duplicate_code");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private String generateCode() {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        StringBuilder sb = new StringBuilder(8);
        for (int i = 0; i < 8; i++) {
            sb.append(chars.charAt((int) (Math.random() * chars.length())));
        }
        return sb.toString();
    }
}
