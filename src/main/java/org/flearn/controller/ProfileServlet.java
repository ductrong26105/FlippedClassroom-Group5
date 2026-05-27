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
import org.flearn.util.PasswordUtil;

import java.io.IOException;
import java.time.format.DateTimeFormatter;

/**
 * Handles Student, Teacher, and Admin unified Profile and Profile Editing flows.
 * URL patterns: /profile, /profile/edit
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile", "/profile/edit"})
public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute(AppConstants.SESSION_USER) : null;

        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch fresh copy from database to ensure up-to-date data
        User user = userDAO.findById(sessionUser.getUserId());
        if (user == null) {
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String joinedDate = "N/A";
        if (user.getCreatedAt() != null) {
            joinedDate = user.getCreatedAt().format(DATE_FORMATTER);
        }

        // Handle active tab routing
        String requestURI = request.getRequestURI();
        String activeTab = "overview";
        if (requestURI.endsWith("/profile/edit")) {
            activeTab = "edit-info";
        }

        request.setAttribute("user", user);
        request.setAttribute("joinedDate", joinedDate);
        request.setAttribute("activeTab", activeTab);
        request.setAttribute("pageTitle", "Trang cá nhân - FLearn");
        request.getRequestDispatcher(AppConstants.VIEW_PROFILE).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute(AppConstants.SESSION_USER) : null;

        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = userDAO.findById(sessionUser.getUserId());
        if (user == null) {
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String joinedDate = "N/A";
        if (user.getCreatedAt() != null) {
            joinedDate = user.getCreatedAt().format(DATE_FORMATTER);
        }

        if ("updateInfo".equals(action)) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");

            if (fullName == null || fullName.trim().isEmpty()
                    || email == null || email.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Họ tên và Email không được để trống!");
                request.setAttribute("user", user);
                request.setAttribute("joinedDate", joinedDate);
                request.setAttribute("activeTab", "edit-info");
                request.setAttribute("pageTitle", "Trang cá nhân - FLearn");
                request.getRequestDispatcher(AppConstants.VIEW_PROFILE).forward(request, response);
                return;
            }

            fullName = fullName.trim();
            email = email.trim().toLowerCase();

            try {
                // Check if email is used by another user
                User existingUser = userDAO.findByEmail(email);
                if (existingUser != null && existingUser.getUserId() != user.getUserId()) {
                    request.setAttribute("errorMessage", "Địa chỉ Email này đã được sử dụng bởi một tài khoản khác!");
                    request.setAttribute("user", user);
                    request.setAttribute("joinedDate", joinedDate);
                    request.setAttribute("activeTab", "edit-info");
                    request.setAttribute("pageTitle", "Trang cá nhân - FLearn");
                    request.getRequestDispatcher(AppConstants.VIEW_PROFILE).forward(request, response);
                    return;
                }

                // Update info
                user.setFullName(fullName);
                user.setEmail(email);
                userDAO.update(user);

                // Update session state
                session.setAttribute(AppConstants.SESSION_USER, user);

                response.sendRedirect(request.getContextPath() + "/profile?success=true");
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Lỗi khi cập nhật thông tin: " + e.getMessage());
                request.setAttribute("user", user);
                request.setAttribute("joinedDate", joinedDate);
                request.setAttribute("activeTab", "edit-info");
                request.setAttribute("pageTitle", "Trang cá nhân - FLearn");
                request.getRequestDispatcher(AppConstants.VIEW_PROFILE).forward(request, response);
            }

        } else if ("changePassword".equals(action)) {
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (oldPassword == null || oldPassword.isEmpty()
                    || newPassword == null || newPassword.isEmpty()
                    || confirmPassword == null || confirmPassword.isEmpty()) {

                request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin mật khẩu!");
                request.setAttribute("user", user);
                request.setAttribute("joinedDate", joinedDate);
                request.setAttribute("activeTab", "change-password");
                request.setAttribute("pageTitle", "Trang cá nhân - FLearn");
                request.getRequestDispatcher(AppConstants.VIEW_PROFILE).forward(request, response);
                return;
            }

            if (newPassword.length() < 6) {
                request.setAttribute("errorMessage", "Mật khẩu mới phải có ít nhất 6 ký tự!");
                request.setAttribute("user", user);
                request.setAttribute("joinedDate", joinedDate);
                request.setAttribute("activeTab", "change-password");
                request.setAttribute("pageTitle", "Trang cá nhân - FLearn");
                request.getRequestDispatcher(AppConstants.VIEW_PROFILE).forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu xác nhận không trùng khớp!");
                request.setAttribute("user", user);
                request.setAttribute("joinedDate", joinedDate);
                request.setAttribute("activeTab", "change-password");
                request.setAttribute("pageTitle", "Trang cá nhân - FLearn");
                request.getRequestDispatcher(AppConstants.VIEW_PROFILE).forward(request, response);
                return;
            }

            // Verify old password using PasswordUtil
            if (!PasswordUtil.verifyPassword(oldPassword, user.getPasswordHash())) {
                request.setAttribute("errorMessage", "Mật khẩu cũ không chính xác!");
                request.setAttribute("user", user);
                request.setAttribute("joinedDate", joinedDate);
                request.setAttribute("activeTab", "change-password");
                request.setAttribute("pageTitle", "Trang cá nhân - FLearn");
                request.getRequestDispatcher(AppConstants.VIEW_PROFILE).forward(request, response);
                return;
            }

            try {
                // Update password (hash it with BCrypt)
                user.setPasswordHash(PasswordUtil.hashPassword(newPassword));
                userDAO.update(user);

                // Update session state
                session.setAttribute(AppConstants.SESSION_USER, user);

                response.sendRedirect(request.getContextPath() + "/profile?pwdSuccess=true");
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Lỗi hệ thống khi cập nhật mật khẩu: " + e.getMessage());
                request.setAttribute("user", user);
                request.setAttribute("joinedDate", joinedDate);
                request.setAttribute("activeTab", "change-password");
                request.setAttribute("pageTitle", "Trang cá nhân - FLearn");
                request.getRequestDispatcher(AppConstants.VIEW_PROFILE).forward(request, response);
            }
        }
    }
}
