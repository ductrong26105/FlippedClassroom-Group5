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
import java.util.ArrayList;
import java.util.List;

/**
 * Controller handling gamified course certificates and learning accomplishments.
 * URL pattern: /certificates
 */
@WebServlet(name = "CertificatesServlet", urlPatterns = "/certificates")
public class CertificatesServlet extends HttpServlet {

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

        List<ClassRoom> joinedCourses = classDAO.findJoinedClasses(loggedInUser.getUserId());
        List<CourseProgressDTO> progressList = new ArrayList<>();

        for (ClassRoom course : joinedCourses) {
            long totalNodes = classDAO.countActiveNodes(course.getClassId());
            long completedNodes = classDAO.countCompletedNodes(course.getClassId(), loggedInUser.getUserId());
            
            int progressPercent = 0;
            if (totalNodes > 0) {
                progressPercent = (int) ((completedNodes * 100) / totalNodes);
            }

            boolean completed = (totalNodes > 0 && completedNodes >= totalNodes);

            progressList.add(new CourseProgressDTO(
                    course,
                    progressPercent,
                    completed,
                    totalNodes,
                    completedNodes
            ));
        }

        request.setAttribute("progressList", progressList);
        request.setAttribute("pageTitle", "Kho chứng chỉ - FLearn");
        request.setAttribute("activePage", "certificates");
        request.getRequestDispatcher(AppConstants.VIEW_CERTIFICATES).forward(request, response);
    }

    /**
     * DTO containing course completion details for student gamified certificate check.
     */
    public static class CourseProgressDTO {
        private final ClassRoom classRoom;
        private final int progressPercent;
        private final boolean completed;
        private final long totalNodes;
        private final long completedNodes;

        public CourseProgressDTO(ClassRoom classRoom, int progressPercent, boolean completed, long totalNodes, long completedNodes) {
            this.classRoom = classRoom;
            this.progressPercent = progressPercent;
            this.completed = completed;
            this.totalNodes = totalNodes;
            this.completedNodes = completedNodes;
        }

        public ClassRoom getClassRoom() {
            return classRoom;
        }

        public int getProgressPercent() {
            return progressPercent;
        }

        public boolean isCompleted() {
            return completed;
        }

        public long getTotalNodes() {
            return totalNodes;
        }

        public long getCompletedNodes() {
            return completedNodes;
        }
    }
}
