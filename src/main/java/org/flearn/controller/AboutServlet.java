package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.flearn.util.AppConstants;

import java.io.IOException;

/**
 * Handles the About page request.
 * URL pattern: /about
 */
@WebServlet(name = "AboutServlet", urlPatterns = "/about")
public class AboutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Về chúng tôi - FLearn");
        request.setAttribute("activePage", "about");

        request.getRequestDispatcher(AppConstants.VIEW_ABOUT).forward(request, response);
    }
}
