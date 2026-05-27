package org.flearn.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.UserDAO;
import org.flearn.model.User;
import org.flearn.util.AppConstants;
import org.flearn.util.PasswordUtil;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Set;

/**
 * Authentication Filter.
 * Checks if the user is logged in, processes "Remember Me" cookie,
 * and ensures access is restricted to authenticated users for protected paths.
 */
@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    private final UserDAO userDAO = new UserDAO();

    // Paths that do not require authentication
    private static final Set<String> PUBLIC_PATHS = Set.of(
            "/login", "/register", "/forgot-password", "/reset-password",
            "/landing", "/home", "/about", "/contact", "/team", "/testimonial", "/courses", "/", "/test-seeder.jsp"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String contextPath = request.getContextPath();
        String requestURI = request.getRequestURI();
        String path = requestURI.substring(contextPath.length());

        // 1. Always allow: static assets & WEB-INF paths
        if (path.startsWith("/assets/")
                || path.startsWith("/WEB-INF/")
                || path.equals("/")
                || path.isEmpty()) {
            chain.doFilter(req, res);
            return;
        }

        // 2. Check current session
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute(AppConstants.SESSION_USER) : null;

        // 3. Process "Remember Me" if not logged in
        if (user == null) {
            user = processRememberMe(request, response);
        }

        // 4. Determine if the path is public
        String basePath = path.contains("?") ? path.substring(0, path.indexOf('?')) : path;
        boolean isPublic = false;
        for (String pub : PUBLIC_PATHS) {
            if (basePath.equals(pub) || basePath.startsWith(pub + "/")) {
                isPublic = true;
                break;
            }
        }

        // 5. Enforce Authentication Guard
        if (!isPublic && user == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        chain.doFilter(req, res);
    }

    /**
     * Process Remember Me cookie to auto-login.
     */
    private User processRememberMe(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return null;
        }

        for (Cookie cookie : cookies) {
            if ("rememberMe".equals(cookie.getName())) {
                try {
                    String rawValue = URLDecoder.decode(cookie.getValue(), StandardCharsets.UTF_8);
                    byte[] decodedBytes = Base64.getDecoder().decode(rawValue);
                    String decoded = new String(decodedBytes, StandardCharsets.UTF_8);
                    
                    String[] parts = decoded.split("\\|");
                    if (parts.length == 2) {
                        String email = parts[0];
                        String signature = parts[1];

                        if (PasswordUtil.verifyCookieSignature(email, signature)) {
                            User user = userDAO.findByEmail(email);
                            if (user != null && user.isActive()) {
                                // Auto-login: create session & prevent session fixation
                                HttpSession oldSession = request.getSession(false);
                                if (oldSession != null) {
                                    oldSession.invalidate();
                                }
                                HttpSession newSession = request.getSession(true);
                                newSession.setAttribute(AppConstants.SESSION_USER, user);
                                
                                String roleStr = "STUDENT";
                                if (user.getRole() == AppConstants.ROLE_ADMIN) {
                                    roleStr = "ADMIN";
                                } else if (user.getRole() == AppConstants.ROLE_TEACHER) {
                                    roleStr = "TEACHER";
                                }
                                newSession.setAttribute("role", roleStr);
                                newSession.setMaxInactiveInterval(AppConstants.SESSION_TIMEOUT_MINUTES * 60);
                                return user;
                            }
                        }
                    }
                } catch (Exception e) {
                    // Fail-silent, delete cookie
                    deleteRememberMeCookie(response, request.getContextPath());
                }
                break;
            }
        }
        return null;
    }

    private void deleteRememberMeCookie(HttpServletResponse response, String contextPath) {
        Cookie cookie = new Cookie("rememberMe", "");
        cookie.setMaxAge(0);
        cookie.setPath(contextPath.isEmpty() ? "/" : contextPath);
        response.addCookie(cookie);
    }

    @Override
    public void destroy() {
        // Destroy code if needed
    }
}
