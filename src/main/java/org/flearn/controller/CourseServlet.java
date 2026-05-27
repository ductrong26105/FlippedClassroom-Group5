package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.flearn.dao.ClassDAO;
import org.flearn.model.ClassRoom;
import org.flearn.util.AppConstants;

import java.io.IOException;
import java.util.List;

/**
 * Handles the Courses listing page.
 * URL pattern: /courses
 */
@WebServlet(name = "CourseServlet", urlPatterns = "/courses")
public class CourseServlet extends HttpServlet {

    private final ClassDAO classDAO = new ClassDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Khóa học - FLearn");
        request.setAttribute("activePage", "courses");

        // Fetch active classes to display as courses
        List<ClassRoom> courses = classDAO.findAll();
        request.setAttribute("courses", courses);

        request.getRequestDispatcher(AppConstants.VIEW_COURSES).forward(request, response);
    }
}
