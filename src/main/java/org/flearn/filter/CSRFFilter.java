package org.flearn.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Set;

/**
 * Filter to protect against Cross-Site Request Forgery (CSRF).
 * Generates a CSRF token for the session and validates it on modifying requests.
 */
@WebFilter("/*")
public class CSRFFilter implements Filter {

    private static final String CSRF_TOKEN_NAME = "csrfToken";
    private static final Set<String> ALLOWED_METHODS = Set.of("GET", "HEAD", "TRACE", "OPTIONS");

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Skip static resources
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        if (path.startsWith("/assets/") || path.startsWith("/css/") || path.startsWith("/js/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(true);

        // 1. Generate CSRF token if it doesn't exist
        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_NAME);
        if (sessionToken == null) {
            byte[] randomBytes = new byte[32];
            new SecureRandom().nextBytes(randomBytes);
            sessionToken = Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
            session.setAttribute(CSRF_TOKEN_NAME, sessionToken);
        }

        // 2. Validate token on modifying requests
        if (!ALLOWED_METHODS.contains(httpRequest.getMethod())) {
            String requestToken = httpRequest.getParameter(CSRF_TOKEN_NAME);
            
            // Allow token to be passed in header as well for API calls
            if (requestToken == null) {
                requestToken = httpRequest.getHeader("X-CSRF-TOKEN");
            }

            if (requestToken == null || !requestToken.equals(sessionToken)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid or missing CSRF token");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup
    }
}
