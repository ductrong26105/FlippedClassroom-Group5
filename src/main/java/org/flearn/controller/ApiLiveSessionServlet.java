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

@WebServlet(name = "ApiLiveSessionServlet", urlPatterns = {"/api/live/start", "/api/live/join", "/api/live/end"})
public class ApiLiveSessionServlet extends HttpServlet {

    private final ClassDAO classDAO = new ClassDAO();
    private final LiveSessionDAO liveSessionDAO = new LiveSessionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String path = request.getServletPath();

        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute(AppConstants.SESSION_USER) : null;
        if (loggedInUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"error\":\"Unauthorized\"}");
            return;
        }

        try {
            int classId = Integer.parseInt(request.getParameter("classId"));
            ClassRoom classRoom = classDAO.findById(classId);
            
            if (classRoom == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Class not found\"}");
                return;
            }

            if ("/api/live/start".equals(path)) {
                // Only Teacher can start
                if (loggedInUser.getRole() != AppConstants.ROLE_TEACHER || classRoom.getTeacher().getUserId() != loggedInUser.getUserId()) {
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    out.print("{\"error\":\"Only the teacher of this class can start a session\"}");
                    return;
                }
                
                // Rule: Only ONE active session allowed
                LiveSession activeSession = liveSessionDAO.findActiveSession(classId);
                if (activeSession != null) {
                    response.setStatus(HttpServletResponse.SC_CONFLICT);
                    out.print("{\"error\":\"A live session is already running for this class!\"}");
                    return;
                }
                
                LiveSession newSession = LiveSession.builder()
                        .classRoom(classRoom)
                        .teacher(loggedInUser)
                        .startedAt(LocalDateTime.now())
                        .build();
                liveSessionDAO.save(newSession);
                
                out.print(String.format("{\"success\":true, \"sessionId\":%d}", newSession.getSessionId()));
                
            } else if ("/api/live/join".equals(path)) {
                // Rule: Only class members can join
                if (loggedInUser.getRole() == AppConstants.ROLE_STUDENT && !classDAO.isMember(classId, loggedInUser.getUserId())) {
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    out.print("{\"error\":\"You must be a member of this class to join the live session\"}");
                    return;
                }
                
                LiveSession activeSession = liveSessionDAO.findActiveSession(classId);
                if (activeSession == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.print("{\"error\":\"No active live session found for this class\"}");
                    return;
                }
                
                out.print(String.format("{\"success\":true, \"sessionId\":%d}", activeSession.getSessionId()));
                
            } else if ("/api/live/end".equals(path)) {
                // End session
                if (loggedInUser.getRole() != AppConstants.ROLE_TEACHER || classRoom.getTeacher().getUserId() != loggedInUser.getUserId()) {
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    out.print("{\"error\":\"Only the teacher can end the session\"}");
                    return;
                }
                
                LiveSession activeSession = liveSessionDAO.findActiveSession(classId);
                if (activeSession != null) {
                    activeSession.setEndedAt(LocalDateTime.now());
                    liveSessionDAO.update(activeSession);
                }
                out.print("{\"success\":true}");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Invalid input\"}");
        }
    }
}
