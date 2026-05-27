package org.flearn.controller;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.flearn.dao.DBContext;
import org.flearn.dao.UserDAO;
import org.flearn.model.User;
import org.flearn.util.AppConstants;
import org.flearn.util.PasswordUtil;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Handles password reset actions.
 * URL pattern: /reset-password
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = "/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }

        token = token.trim();
        User user = findByResetToken(token);

        if (user == null || user.getResetTokenExpiry() == null 
                || user.getResetTokenExpiry().isBefore(LocalDateTime.now())) {
            
            request.setAttribute("errorMessage", "Liên kết khôi phục mật khẩu không hợp lệ hoặc đã hết hạn!");
            request.setAttribute("pageTitle", "Lỗi khôi phục - FLearn");
            request.getRequestDispatcher(AppConstants.VIEW_FORGOT_PASSWORD).forward(request, response);
            return;
        }

        request.setAttribute("token", token);
        request.setAttribute("pageTitle", "Đặt lại mật khẩu - FLearn");
        request.getRequestDispatcher(AppConstants.VIEW_RESET_PASSWORD).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String password = request.getParameter("password");

        if (token == null || token.trim().isEmpty() 
                || password == null || password.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Yêu cầu không hợp lệ!");
            request.setAttribute("pageTitle", "Lỗi khôi phục - FLearn");
            request.getRequestDispatcher(AppConstants.VIEW_FORGOT_PASSWORD).forward(request, response);
            return;
        }

        token = token.trim();
        User user = findByResetToken(token);

        if (user == null || user.getResetTokenExpiry() == null 
                || user.getResetTokenExpiry().isBefore(LocalDateTime.now())) {
            
            request.setAttribute("errorMessage", "Yêu cầu khôi phục đã hết hạn! Vui lòng thử lại.");
            request.setAttribute("pageTitle", "Lỗi khôi phục - FLearn");
            request.getRequestDispatcher(AppConstants.VIEW_FORGOT_PASSWORD).forward(request, response);
            return;
        }

        // Update password with BCrypt hash and clear token
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        user.setResetToken(null);
        user.setResetTokenExpiry(null);

        try {
            userDAO.update(user);
            response.sendRedirect(request.getContextPath() + "/login?resetSuccess=true");
        } catch (Exception e) {
            request.setAttribute("token", token);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống! Vui lòng thử lại sau.");
            request.setAttribute("pageTitle", "Đặt lại mật khẩu - FLearn");
            request.getRequestDispatcher(AppConstants.VIEW_RESET_PASSWORD).forward(request, response);
        }
    }

    /**
     * Helper to find a user by their active reset token.
     */
    private User findByResetToken(String token) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.resetToken = :token AND u.isActive = true", User.class);
            query.setParameter("token", token);
            List<User> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
}
