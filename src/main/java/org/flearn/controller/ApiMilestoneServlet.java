package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.*;
import org.flearn.model.*;
import org.flearn.util.AppConstants;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;

@WebServlet(name = "ApiMilestoneServlet", urlPatterns = "/api/milestone/review")
public class ApiMilestoneServlet extends HttpServlet {

    private final MilestoneAssignmentDAO milestoneDAO = new MilestoneAssignmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute(AppConstants.SESSION_USER) : null;
        if (loggedInUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"error\":\"Unauthorized\"}");
            return;
        }

        try {
            int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
            double score = Double.parseDouble(request.getParameter("score"));
            String feedback = request.getParameter("feedback");

            MilestoneAssignment assignment = milestoneDAO.findById(assignmentId);
            if (assignment == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Assignment not found\"}");
                return;
            }

            // Rule 1: Student cannot self-review
            if (assignment.getStudent().getUserId() == loggedInUser.getUserId()) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                out.print("{\"error\":\"You cannot review your own assignment!\"}");
                return;
            }

            // Update assignment
            assignment.setScore(score);
            assignment.setFeedback(feedback);
            assignment.setUpdatedAt(LocalDateTime.now());
            
            // Rule 2: Mark as completed if score is given
            if (score >= 0) {
                assignment.setCompleted(true);
            }

            milestoneDAO.update(assignment);
            out.print("{\"success\":true}");

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Invalid input\"}");
        }
    }
}
