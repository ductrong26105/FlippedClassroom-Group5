package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.flearn.util.AppConstants;

import java.io.IOException;

/**
 * Handles the Testimonial page.
 * URL pattern: /testimonial
 */
@WebServlet(name = "TestimonialServlet", urlPatterns = "/testimonial")
public class TestimonialServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Đánh giá - FLearn");
        request.setAttribute("activePage", "testimonial");

        request.getRequestDispatcher(AppConstants.VIEW_TESTIMONIAL).forward(request, response);
    }
}
