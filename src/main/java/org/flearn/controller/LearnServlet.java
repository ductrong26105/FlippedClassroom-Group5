package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.ClassDAO;
import org.flearn.dao.NodeDAO;
import org.flearn.model.ClassRoom;
import org.flearn.model.Node;
import org.flearn.model.StudentProgress;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Handles the Learning Workspace page for a specific class.
 * URL pattern: /learn/{classId}
 *
 * GET  /learn/{classId}  → show video player + syllabus for that class
 */
@WebServlet(name = "LearnServlet", urlPatterns = "/learn/*")
public class LearnServlet extends HttpServlet {

    private final ClassDAO classDAO = new ClassDAO();
    private final NodeDAO  nodeDAO  = new NodeDAO();
    private final org.flearn.dao.StudentProgressDAO progressDAO = new org.flearn.dao.StudentProgressDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Auth guard: must be logged in ──────────────────────────────
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null)
                ? (User) session.getAttribute(AppConstants.SESSION_USER)
                : null;

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── Extract classId from path: /learn/{classId} ───────────────
        String pathInfo = request.getPathInfo(); // e.g. "/12"
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/courses");
            return;
        }

        int classId;
        try {
            classId = Integer.parseInt(pathInfo.replace("/", "").trim());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // ── Load ClassRoom ─────────────────────────────────────────────
        ClassRoom classRoom = classDAO.findById(classId);
        if (classRoom == null || !classRoom.isActive()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // ── Load Nodes (ordered by OrderIndex) ─────────────────────────
        List<Node> nodes = nodeDAO.findByClass(classId);

        // ── Load Student Progress ──────────────────────────────────────
        List<StudentProgress> progresses = progressDAO.findByStudentAndClass(loggedInUser.getUserId(), classId);
        Set<Integer> completedNodeIds = progresses.stream()
                .filter(StudentProgress::isCompleted)
                .map(p -> p.getNode().getNodeId())
                .collect(Collectors.toSet());

        Set<Integer> lockedNodeIds = new HashSet<>();
        for (Node node : nodes) {
            if (node.getPrerequisiteNode() != null) {
                if (!completedNodeIds.contains(node.getPrerequisiteNode().getNodeId())) {
                    lockedNodeIds.add(node.getNodeId());
                }
            }
        }
        
        int totalBonus = progresses.stream().mapToInt(StudentProgress::getTotalBonus).sum();

        // ── Set attributes ─────────────────────────────────────────────
        request.setAttribute("classRoom",  classRoom);
        request.setAttribute("nodes",      nodes);
        request.setAttribute("completedNodeIds", completedNodeIds);
        request.setAttribute("lockedNodeIds", lockedNodeIds);
        request.setAttribute("totalBonus", totalBonus);
        request.setAttribute("pageTitle",  classRoom.getClassName() + " - FLearn");
        request.setAttribute("activePage", "courses");

        request.getRequestDispatcher(AppConstants.VIEW_LEARN)
               .forward(request, response);
    }
}
