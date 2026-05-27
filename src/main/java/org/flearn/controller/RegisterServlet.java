package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.flearn.dao.UserDAO;
import org.flearn.model.User;
import org.flearn.util.AppConstants;
import org.flearn.util.PasswordUtil;

import java.io.IOException;

/**
 * Handles student registration.
 * URL pattern: /register
 */
@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("pageTitle", "Đăng ký tài khoản - FLearn");
        request.setAttribute("activePage", "register");
        request.getRequestDispatcher(AppConstants.VIEW_REGISTER).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Server-side validation
        if (fullName == null || fullName.trim().isEmpty()
                || username == null || username.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ tất cả các trường!");
            request.setAttribute("pageTitle", "Đăng ký tài khoản - FLearn");
            request.getRequestDispatcher(AppConstants.VIEW_REGISTER).forward(request, response);
            return;
        }

        fullName = fullName.trim();
        username = username.trim().toLowerCase();
        email = email.trim().toLowerCase();

        try {
            // Check if username already exists
            if (userDAO.findByUsername(username) != null) {
                request.setAttribute("errorMessage", "Tên đăng nhập này đã tồn tại! Vui lòng chọn tên khác.");
                request.setAttribute("pageTitle", "Đăng ký tài khoản - FLearn");
                request.getRequestDispatcher(AppConstants.VIEW_REGISTER).forward(request, response);
                return;
            }

            // Check if email already exists
            if (userDAO.findByEmail(email) != null) {
                request.setAttribute("errorMessage", "Địa chỉ Email này đã được sử dụng! Vui lòng chọn email khác.");
                request.setAttribute("pageTitle", "Đăng ký tài khoản - FLearn");
                request.getRequestDispatcher(AppConstants.VIEW_REGISTER).forward(request, response);
                return;
            }

            // Create new User entity (default role is Student = 2)
            User newUser = User.builder()
                    .username(username)
                    .passwordHash(PasswordUtil.hashPassword(password)) // Hash password using BCrypt
                    .fullName(fullName)
                    .email(email)
                    .role(AppConstants.ROLE_STUDENT)
                    .isActive(true)
                    .build();

            userDAO.save(newUser);
            response.sendRedirect(request.getContextPath() + "/login?registered=true");

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống khi đăng ký! Vui lòng thử lại sau.");
            request.setAttribute("pageTitle", "Đăng ký tài khoản - FLearn");
            request.getRequestDispatcher(AppConstants.VIEW_REGISTER).forward(request, response);
        }
    }
}
