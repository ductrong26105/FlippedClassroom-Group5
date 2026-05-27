package org.flearn.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Filter to add common security headers to every HTTP response.
 */
@WebFilter("/*")
public class SecurityHeadersFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        if (response instanceof HttpServletResponse) {
            HttpServletResponse httpResponse = (HttpServletResponse) response;

            // Prevent Clickjacking
            httpResponse.setHeader("X-Frame-Options", "DENY");

            // Prevent MIME type sniffing
            httpResponse.setHeader("X-Content-Type-Options", "nosniff");

            // Enable XSS filtering in the browser (for legacy browsers that still support it)
            httpResponse.setHeader("X-XSS-Protection", "1; mode=block");

            // HTTP Strict Transport Security (HSTS)
            // (Assuming HTTPS is used in production, this tells the browser to strictly use HTTPS for 1 year)
            httpResponse.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");

            // Basic Content Security Policy (Optional, uncomment and configure for stricter protection)
            // httpResponse.setHeader("Content-Security-Policy", "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://kit.fontawesome.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com https://kit.fontawesome.com;");
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
