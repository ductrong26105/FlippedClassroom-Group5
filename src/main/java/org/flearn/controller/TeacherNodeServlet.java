package org.flearn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.flearn.dao.NodeDAO;
import org.flearn.dao.ClassDAO;
import org.flearn.model.ClassRoom;
import org.flearn.model.Node;
import org.flearn.model.User;
import org.flearn.util.AppConstants;

import java.io.IOException;
import java.time.LocalDateTime;

/**
 * Handles Teacher Node (lesson) management.
 *
 * POST /teacher/nodes/create   → create a new Node in a class
 * POST /teacher/nodes/reorder  → update OrderIndex (called by SortableJS via fetch)
 * POST /teacher/nodes/delete   → soft-delete a Node
 */
@WebServlet(name = "TeacherNodeServlet", urlPatterns = "/teacher/nodes/*")
public class TeacherNodeServlet extends HttpServlet {

    private final NodeDAO  nodeDAO  = new NodeDAO();
    private final ClassDAO classDAO = new ClassDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Auth guard
        HttpSession session = request.getSession(false);
        User teacher = (session != null)
                ? (User) session.getAttribute(AppConstants.SESSION_USER)
                : null;

        if (teacher == null || teacher.getRole() != AppConstants.ROLE_TEACHER) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String path = request.getPathInfo(); // "/create" | "/reorder" | "/delete"

        if ("/create".equals(path)) {
            handleCreate(request, response, teacher);

        } else if ("/reorder".equals(path)) {
            // SortableJS sends JSON body — handled by JS fetch, just return OK
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"status\":\"ok\"}");

        } else if ("/delete".equals(path)) {
            handleDelete(request, response, teacher);

        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp, User teacher)
            throws IOException {

        String classIdParam = req.getParameter("classId");
        String title        = req.getParameter("title");
        String nodeTypeStr  = req.getParameter("nodeType");
        String videoUrl     = req.getParameter("videoUrl");
        String unlockAtStr  = req.getParameter("unlockAt");

        if (classIdParam == null || title == null || title.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/teacher/dashboard?error=invalid_node");
            return;
        }

        try {
            int classId  = Integer.parseInt(classIdParam);
            byte nodeType = (nodeTypeStr != null) ? Byte.parseByte(nodeTypeStr) : AppConstants.NODE_VIDEO;

            ClassRoom classRoom = classDAO.findById(classId);
            if (classRoom == null || classRoom.getTeacher().getUserId() != teacher.getUserId()) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            // Determine next order index
            int nextOrder = nodeDAO.findByClass(classId).size();

            Node.NodeBuilder builder = Node.builder()
                    .classRoom(classRoom)
                    .title(title.trim())
                    .nodeType(nodeType)
                    .orderIndex(nextOrder)
                    .videoUrl((videoUrl != null && !videoUrl.isBlank()) ? videoUrl.trim() : null);

            if (unlockAtStr != null && !unlockAtStr.isBlank()) {
                builder.unlockAt(LocalDateTime.parse(unlockAtStr));
            }

            nodeDAO.save(builder.build());
            resp.sendRedirect(req.getContextPath()
                    + "/teacher/dashboard?classId=" + classId + "&created_node=1");

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/teacher/dashboard?error=invalid_id");
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp, User teacher)
            throws IOException {

        String nodeIdParam = req.getParameter("nodeId");
        if (nodeIdParam == null) {
            resp.sendRedirect(req.getContextPath() + "/teacher/dashboard?error=missing_id");
            return;
        }

        try {
            int nodeId = Integer.parseInt(nodeIdParam);
            Node node  = nodeDAO.findById(nodeId);
            if (node == null
                    || node.getClassRoom().getTeacher().getUserId() != teacher.getUserId()) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            // Soft delete
            node.setActive(false);
            nodeDAO.update(node);
            resp.sendRedirect(req.getContextPath()
                    + "/teacher/dashboard?classId=" + node.getClassRoom().getClassId()
                    + "&deleted_node=1");

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/teacher/dashboard?error=invalid_id");
        }
    }
}
