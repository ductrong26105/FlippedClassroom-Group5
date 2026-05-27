package org.flearn.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;

/**
 * Authorization Filter.
 * Restricts access to path prefixes (/admin/*, /teacher/*, /student/*)
 * based on the user's role stored in the session.
 */
@WebFilter(urlPatterns = {"/admin/*", "/teacher/*", "/student/*"})
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute(AppConstants.SESSION_USER) : null;

        // Fallback: If not logged in, AuthenticationFilter should have redirected,
        // but as a fallback, we redirect to login here.
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String contextPath = request.getContextPath();
        String requestURI = request.getRequestURI();
        String path = requestURI.substring(contextPath.length());

        // Check path roles
        if (path.startsWith("/admin/")) {
            if (user.getRole() != AppConstants.ROLE_ADMIN) {
                response.sendRedirect(contextPath + "/403");
                return;
            }
        } else if (path.startsWith("/teacher/")) {
            if (user.getRole() != AppConstants.ROLE_TEACHER) {
                response.sendRedirect(contextPath + "/403");
                return;
            }
        } else if (path.startsWith("/student/")) {
            if (user.getRole() != AppConstants.ROLE_STUDENT) {
                response.sendRedirect(contextPath + "/403");
                return;
            }
        }

        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {
        // Destroy code if needed
    }
}
