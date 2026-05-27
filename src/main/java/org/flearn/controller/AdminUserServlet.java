package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.UserDAO;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;

/**
 * Handles Admin user management actions.
 *
 * POST /admin/users/role    → change a user's Role
 * POST /admin/users/status  → toggle IsActive
 * POST /admin/users/delete  → delete a user
 */
@WebServlet(name = "AdminUserServlet", urlPatterns = "/admin/users/*")
public class AdminUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Auth guard — Admin only
        HttpSession session = request.getSession(false);
        User admin = (session != null)
                ? (User) session.getAttribute(AppConstants.SESSION_USER)
                : null;

        if (admin == null || admin.getRole() != AppConstants.ROLE_ADMIN) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String path = request.getPathInfo(); // "/role" | "/status" | "/delete"

        if ("/role".equals(path)) {
            handleChangeRole(request, response, admin);

        } else if ("/status".equals(path)) {
            handleToggleStatus(request, response, admin);

        } else if ("/delete".equals(path)) {
            handleDelete(request, response, admin);

        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // ── Change Role ────────────────────────────────────────────────────
    private void handleChangeRole(HttpServletRequest req, HttpServletResponse resp, User admin)
            throws IOException {

        String userIdParam = req.getParameter("userId");
        String roleParam   = req.getParameter("role");

        resp.setContentType("application/json;charset=UTF-8");

        try {
            int  targetId = Integer.parseInt(userIdParam);
            byte newRole  = Byte.parseByte(roleParam);

            if (newRole < 0 || newRole > 2) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"error\":\"invalid role\"}");
                return;
            }

            // Prevent admin from demoting themselves
            if (targetId == admin.getUserId()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"error\":\"cannot change own role\"}");
                return;
            }

            User target = userDAO.findById(targetId);
            if (target == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("{\"error\":\"user not found\"}");
                return;
            }

            target.setRole(newRole);
            userDAO.update(target);
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("{\"status\":\"ok\"}");

        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\":\"invalid id\"}");
        }
    }

    // ── Toggle IsActive ────────────────────────────────────────────────
    private void handleToggleStatus(HttpServletRequest req, HttpServletResponse resp, User admin)
            throws IOException {

        String userIdParam   = req.getParameter("userId");
        String isActiveParam = req.getParameter("isActive");

        resp.setContentType("application/json;charset=UTF-8");

        try {
            int     targetId   = Integer.parseInt(userIdParam);
            boolean isActive   = Boolean.parseBoolean(isActiveParam);

            // Prevent self-lock
            if (targetId == admin.getUserId()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"error\":\"cannot lock own account\"}");
                return;
            }

            User target = userDAO.findById(targetId);
            if (target == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("{\"error\":\"user not found\"}");
                return;
            }

            target.setActive(isActive);
            userDAO.update(target);
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("{\"status\":\"ok\",\"isActive\":" + isActive + "}");

        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\":\"invalid id\"}");
        }
    }

    // ── Delete User ────────────────────────────────────────────────────
    private void handleDelete(HttpServletRequest req, HttpServletResponse resp, User admin)
            throws IOException {

        String userIdParam = req.getParameter("userId");

        resp.setContentType("application/json;charset=UTF-8");

        try {
            int targetId = Integer.parseInt(userIdParam);

            if (targetId == admin.getUserId()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"error\":\"cannot delete own account\"}");
                return;
            }

            userDAO.delete(targetId);
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("{\"status\":\"ok\"}");

        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\":\"invalid id\"}");
        }
    }
}
