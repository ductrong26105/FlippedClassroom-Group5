package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.flearn.util.AppConstants;

import java.io.IOException;

/**
 * Handles the Contact page.
 * URL pattern: /contact
 */
@WebServlet(name = "ContactServlet", urlPatterns = "/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Liên hệ - FLearn");
        request.setAttribute("activePage", "contact");

        request.getRequestDispatcher(AppConstants.VIEW_CONTACT).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Process contact form submission
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // TODO: Save contact message or send email
        request.setAttribute("successMessage", "Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi sớm nhất.");
        request.setAttribute("pageTitle", "Liên hệ - FLearn");
        request.setAttribute("activePage", "contact");

        request.getRequestDispatcher(AppConstants.VIEW_CONTACT).forward(request, response);
    }
}
