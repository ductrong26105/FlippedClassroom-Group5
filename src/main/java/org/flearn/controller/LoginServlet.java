package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.UserDAO;
import org.flearn.model.User;
import org.flearn.util.AppConstants;
import org.flearn.util.PasswordUtil;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

/**
 * Handles user authentication (Login / Logout redirection).
 * URL pattern: /login
 */
@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check for logout action
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        // If already logged in, redirect to home/dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute(AppConstants.SESSION_USER) != null) {
            User user = (User) session.getAttribute(AppConstants.SESSION_USER);
            redirectToRolePage(request, response, user);
            return;
        }

        request.setAttribute("pageTitle", "Đăng nhập - FLearn");
        request.setAttribute("activePage", "login");
        request.getRequestDispatcher(AppConstants.VIEW_LOGIN).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Server-side validation
        if (usernameOrEmail == null || usernameOrEmail.trim().isEmpty()
                || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Tên đăng nhập và mật khẩu không được để trống!");
            request.setAttribute("pageTitle", "Đăng nhập - FLearn");
            request.setAttribute("activePage", "login");
            request.getRequestDispatcher(AppConstants.VIEW_LOGIN).forward(request, response);
            return;
        }

        // Fetch user by username or email
        User user = userDAO.findByUsername(usernameOrEmail);
        if (user == null) {
            user = userDAO.findByEmail(usernameOrEmail);
        }

        if (user != null) {
            // Check if user is locked (isActive = false)
            if (!user.isActive()) {
                request.setAttribute("errorMessage", "Tài khoản của bạn đã bị khóa! Vui lòng liên hệ Quản trị viên.");
                request.setAttribute("pageTitle", "Đăng nhập - FLearn");
                request.setAttribute("activePage", "login");
                request.getRequestDispatcher(AppConstants.VIEW_LOGIN).forward(request, response);
                return;
            }

            // Verify password using PasswordUtil
            if (PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
                
                // Session Fixation Protection: Invalidate old session and create a new one
                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }
                HttpSession session = request.getSession(true);
                session.setAttribute(AppConstants.SESSION_USER, user);
                
                // Save role string for easy JSP c:if checks
                String roleStr = "STUDENT";
                if (user.getRole() == AppConstants.ROLE_ADMIN) {
                    roleStr = "ADMIN";
                } else if (user.getRole() == AppConstants.ROLE_TEACHER) {
                    roleStr = "TEACHER";
                }
                session.setAttribute("role", roleStr);
                session.setMaxInactiveInterval(AppConstants.SESSION_TIMEOUT_MINUTES * 60);

                // Remember Me Cookie
                if ("true".equals(rememberMe)) {
                    String signature = PasswordUtil.generateCookieSignature(user.getEmail());
                    String rawCookieValue = user.getEmail() + "|" + signature;
                    String encodedValue = Base64.getEncoder().encodeToString(rawCookieValue.getBytes(StandardCharsets.UTF_8));
                    
                    Cookie cookie = new Cookie("rememberMe", URLEncoder.encode(encodedValue, StandardCharsets.UTF_8));
                    cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                    String contextPath = request.getContextPath();
                    cookie.setPath(contextPath.isEmpty() ? "/" : contextPath);
                    response.addCookie(cookie);
                }

                // Redirect to user workspace
                redirectToRolePage(request, response, user);
                return;
            }
        }

        // Generic auth failure
        request.setAttribute("errorMessage", "Tên đăng nhập/Email hoặc mật khẩu không đúng!");
        request.setAttribute("pageTitle", "Đăng nhập - FLearn");
        request.setAttribute("activePage", "login");
        request.getRequestDispatcher(AppConstants.VIEW_LOGIN).forward(request, response);
    }

    private void redirectToRolePage(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        if (user.getRole() == AppConstants.ROLE_ADMIN) {
            response.sendRedirect(request.getContextPath() + "/admin/panel");
        } else if (user.getRole() == AppConstants.ROLE_TEACHER) {
            response.sendRedirect(request.getContextPath() + "/teacher/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
