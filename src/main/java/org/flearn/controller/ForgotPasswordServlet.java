package org.flearn.controller;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.flearn.dao.UserDAO;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Properties;
import java.util.UUID;

/**
 * Handles password recovery requests.
 * URL pattern: /forgot-password
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = "/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("pageTitle", "Quên mật khẩu - FLearn");
        request.getRequestDispatcher(AppConstants.VIEW_FORGOT_PASSWORD).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập địa chỉ Email!");
            request.setAttribute("pageTitle", "Quên mật khẩu - FLearn");
            request.getRequestDispatcher(AppConstants.VIEW_FORGOT_PASSWORD).forward(request, response);
            return;
        }

        email = email.trim().toLowerCase();
        User user = userDAO.findByEmail(email);

        if (user == null) {
            request.setAttribute("errorMessage", "Địa chỉ Email này không tồn tại trong hệ thống!");
            request.setAttribute("pageTitle", "Quên mật khẩu - FLearn");
            request.getRequestDispatcher(AppConstants.VIEW_FORGOT_PASSWORD).forward(request, response);
            return;
        }

        // Generate token and expiry
        String token = UUID.randomUUID().toString();
        user.setResetToken(token);
        user.setResetTokenExpiry(LocalDateTime.now().plusMinutes(15));

        try {
            userDAO.update(user);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống! Vui lòng thử lại sau.");
            request.setAttribute("pageTitle", "Quên mật khẩu - FLearn");
            request.getRequestDispatcher(AppConstants.VIEW_FORGOT_PASSWORD).forward(request, response);
            return;
        }

        // Prepare SMTP configs
        Properties prop = new Properties();
        prop.put("mail.smtp.host", AppConstants.SMTP_HOST);
        prop.put("mail.smtp.port", AppConstants.SMTP_PORT);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(AppConstants.SMTP_USER, AppConstants.SMTP_PASS);
            }
        });

        // Background mail sending logic
        final String recipient = email;
        final String fullName = user.getFullName();
        final String resetLink = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() 
                + request.getContextPath() + "/reset-password?token=" + token;

        new Thread(() -> {
            try {
                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress(AppConstants.SMTP_USER, "FLearn Management"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
                message.setSubject("[FLearn] Yeu cau khoi phuc mat khau tai khoan");

                String htmlContent = "<div style='font-family: Arial, sans-serif; max-width: 550px; margin: 0 auto; padding: 20px; border: 1px solid #e2e8f0; border-radius: 8px;'>"
                        + "<h2 style='color: #4f46e5; margin-bottom: 20px;'>Yêu cầu khôi phục mật khẩu</h2>"
                        + "<p>Xin chào <strong>" + fullName + "</strong>,</p>"
                        + "<p>Chúng tôi đã nhận được yêu cầu khôi phục mật khẩu cho tài khoản FLearn của bạn.</p>"
                        + "<p>Vui lòng click vào nút bên dưới để tiến hành đặt lại mật khẩu mới (Liên kết này có hiệu lực trong 15 phút):</p>"
                        + "<div style='text-align: center; margin: 30px 0;'>"
                        + "  <a href='" + resetLink + "' style='background-color: #4f46e5; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; font-weight: bold; display: inline-block;'>Đặt lại mật khẩu</a>"
                        + "</div>"
                        + "<p style='color: #64748b; font-size: 13px;'>Nếu nút trên không hoạt động, bạn có thể sao chép liên kết dưới đây và dán vào trình duyệt:</p>"
                        + "<p style='color: #64748b; font-size: 12px; word-break: break-all;'>" + resetLink + "</p>"
                        + "<hr style='border: none; border-top: 1px solid #f1f5f9; margin: 20px 0;'>"
                        + "<p style='color: #94a3b8; font-size: 11px; text-align: center;'>Email này được tự động gửi từ hệ thống học tập FLearn. Vui lòng không phản hồi lại email này.</p>"
                        + "</div>";

                message.setContent(htmlContent, "text/html;charset=UTF-8");
                Transport.send(message);
                System.out.println(">>> [FLearn SMTP] Reset link sent successfully to: " + recipient);
                System.out.println(">>> [FLearn SMTP Dev Link]: " + resetLink); // In link ra console NetBeans để dễ test local
            } catch (Exception e) {
                System.err.println(">>> [FLearn SMTP ERROR] Failed to send email to: " + recipient);
                System.err.println(">>> [FLearn SMTP Dev Link on Error]: " + resetLink); // Vẫn in link ra để đề phòng SMTP lỗi
                e.printStackTrace();
            }
        }).start();

        request.setAttribute("successMessage", "Chúng tôi đã gửi một email chứa liên kết bảo mật khôi phục mật khẩu đến hòm thư " + email + ". Vui lòng kiểm tra hộp thư của bạn (và thư mục Spam/Quảng cáo nếu không thấy).");
        request.setAttribute("pageTitle", "Đã gửi yêu cầu - FLearn");
        request.getRequestDispatcher(AppConstants.VIEW_FORGOT_PASSWORD).forward(request, response);
    }
}
