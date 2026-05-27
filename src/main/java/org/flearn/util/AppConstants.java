package org.flearn.util;

/**
 * Application-wide constants matching the database CHECK constraints.
 * Centralizes magic numbers used across the codebase.
 */
public final class AppConstants {

    private AppConstants() {
        // Utility class — prevent instantiation
    }

    // ==================== User Roles ====================
    public static final byte ROLE_ADMIN   = 0;
    public static final byte ROLE_TEACHER = 1;
    public static final byte ROLE_STUDENT = 2;

    // ==================== Node Types ====================
    public static final byte NODE_VIDEO     = 0;
    public static final byte NODE_QUIZ      = 1;
    public static final byte NODE_MILESTONE = 2;

    // ==================== Question Types ====================
    public static final byte QTYPE_MULTIPLE_CHOICE = 0;
    public static final byte QTYPE_TRUE_FALSE      = 1;
    public static final byte QTYPE_ESSAY           = 2;

    // ==================== Question Scope ====================
    public static final byte SCOPE_NODE    = 0;
    public static final byte SCOPE_CLASS   = 1;
    public static final byte SCOPE_SURVEY  = 2;

    // ==================== Student Answer Context ====================
    public static final byte CONTEXT_SELF_PACED = 0;
    public static final byte CONTEXT_LIVE       = 1;

    // ==================== Milestone Roles ====================
    public static final byte MILESTONE_MEMBER = 0;
    public static final byte MILESTONE_LEADER = 1;

    // ==================== Session Config ====================
    public static final String SESSION_USER = "loggedInUser";
    public static final int SESSION_TIMEOUT_MINUTES = 30;

    // ==================== JSP Paths — Public ====================
    public static final String VIEW_DIR         = "/WEB-INF/views/";
    public static final String VIEW_HOME        = VIEW_DIR + "home.jsp";
    public static final String VIEW_ABOUT       = VIEW_DIR + "about.jsp";
    public static final String VIEW_COURSES     = VIEW_DIR + "courses.jsp";
    public static final String VIEW_CONTACT     = VIEW_DIR + "contact.jsp";
    public static final String VIEW_TEAM        = VIEW_DIR + "team.jsp";
    public static final String VIEW_TESTIMONIAL = VIEW_DIR + "testimonial.jsp";
    public static final String VIEW_LOGIN       = VIEW_DIR + "login.jsp";
    public static final String VIEW_REGISTER    = VIEW_DIR + "register.jsp";
    public static final String VIEW_FORGOT_PASSWORD = VIEW_DIR + "forgot-password.jsp";
    public static final String VIEW_RESET_PASSWORD  = VIEW_DIR + "reset-password.jsp";
    public static final String VIEW_PROFILE     = VIEW_DIR + "profile.jsp";
    public static final String VIEW_404         = VIEW_DIR + "error/404.jsp";

    // ==================== SMTP Configurations ====================
    public static final String SMTP_HOST = "smtp.gmail.com";
    public static final String SMTP_PORT = "587";
    public static final String SMTP_USER = "flearn.management@gmail.com"; // Điền Gmail gửi mail khôi phục của bạn ở đây
    public static final String SMTP_PASS = "your-gmail-app-password";      // Điền Mật khẩu ứng dụng (App Password) ở đây

    // ==================== JSP Paths — Student ====================
    public static final String VIEW_LEARN       = VIEW_DIR + "learn.jsp";
    public static final String VIEW_MY_COURSES  = VIEW_DIR + "my-courses.jsp";
    public static final String VIEW_CERTIFICATES = VIEW_DIR + "certificates.jsp";

    // ==================== JSP Paths — Teacher ====================
    public static final String VIEW_TEACHER_DASHBOARD = VIEW_DIR + "teacher/dashboard.jsp";

    // ==================== JSP Paths — Admin ====================
    public static final String VIEW_ADMIN_PANEL = VIEW_DIR + "admin/panel.jsp";
}
    