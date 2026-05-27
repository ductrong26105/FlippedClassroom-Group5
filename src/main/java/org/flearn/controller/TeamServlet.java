package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.flearn.dao.UserDAO;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;
import java.util.List;

/**
 * Handles the Team / Instructors page.
 * URL pattern: /team
 */
@WebServlet(name = "TeamServlet", urlPatterns = "/team")
public class TeamServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Đội ngũ giảng viên - FLearn");
        request.setAttribute("activePage", "team");

        // Fetch teachers (role = 1)
        List<User> teachers = userDAO.findByRole(AppConstants.ROLE_TEACHER);
        request.setAttribute("teachers", teachers);

        request.getRequestDispatcher(AppConstants.VIEW_TEAM).forward(request, response);
    }
}
