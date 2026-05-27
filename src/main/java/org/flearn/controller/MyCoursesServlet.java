package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.ClassDAO;
import org.flearn.model.ClassRoom;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;
import java.util.List;

/**
 * Controller handling the student/teacher courses list.
 * URL pattern: /my-courses
 */
@WebServlet(name = "MyCoursesServlet", urlPatterns = "/my-courses")
public class MyCoursesServlet extends HttpServlet {

    private final ClassDAO classDAO = new ClassDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute(AppConstants.SESSION_USER) : null;

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<ClassRoom> courses;
        if (loggedInUser.getRole() == AppConstants.ROLE_TEACHER) {
            // If Teacher, show their created/taught classes
            courses = classDAO.findByTeacher(loggedInUser.getUserId());
        } else if (loggedInUser.getRole() == AppConstants.ROLE_ADMIN) {
            // If Admin, show all active classes in the system
            courses = classDAO.findAll();
        } else {
            // If Student, show their enrolled classes
            courses = classDAO.findJoinedClasses(loggedInUser.getUserId());
        }

        request.setAttribute("courses", courses);
        request.setAttribute("pageTitle", "Khóa học của tôi - FLearn");
        request.setAttribute("activePage", "my-courses");
        request.getRequestDispatcher(AppConstants.VIEW_MY_COURSES).forward(request, response);
    }
}
