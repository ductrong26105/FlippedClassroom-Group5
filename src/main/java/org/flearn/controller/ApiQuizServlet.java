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

@WebServlet(name = "ApiQuizServlet", urlPatterns = "/api/quiz/submit")
public class ApiQuizServlet extends HttpServlet {

    private final QuestionDAO questionDAO = new QuestionDAO();
    private final AnswerDAO answerDAO = new AnswerDAO();
    private final StudentAnswerDAO studentAnswerDAO = new StudentAnswerDAO();
    private final StudentProgressDAO progressDAO = new StudentProgressDAO();

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
            int questionId = Integer.parseInt(request.getParameter("questionId"));
            String answerIdParam = request.getParameter("answerId");
            int answerId = answerIdParam != null && !answerIdParam.isBlank() ? Integer.parseInt(answerIdParam) : 0;
            
            Question question = questionDAO.findById(questionId);
            if (question == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Question not found\"}");
                return;
            }

            // Check correctness
            boolean isCorrect = false;
            Answer selectedAnswer = null;
            if (answerId > 0) {
                selectedAnswer = answerDAO.findById(answerId);
                if (selectedAnswer != null && selectedAnswer.isCorrect()) {
                    isCorrect = true;
                }
            }

            int bonusEarned = 0;
            
            // Core Business Logic: Bonus Point on first try
            StudentAnswer firstAnswer = studentAnswerDAO.findFirstAnswer(loggedInUser.getUserId(), questionId);
            if (firstAnswer == null && isCorrect) {
                bonusEarned = question.getBonusPoint();
                
                // Add to StudentProgress if associated with a Node
                if (question.getNode() != null) {
                    StudentProgress progress = progressDAO.findByStudentAndNode(loggedInUser.getUserId(), question.getNode().getNodeId());
                    if (progress != null) {
                        progress.setTotalBonus(progress.getTotalBonus() + bonusEarned);
                        progressDAO.saveOrUpdate(progress);
                    }
                }
            }
            
            // Save StudentAnswer
            StudentAnswer sa = StudentAnswer.builder()
                .student(loggedInUser)
                .question(question)
                .selectedAnswer(selectedAnswer)
                .isCorrect(isCorrect)
                .context((byte)0) // 0 = self-paced
                .build();
            studentAnswerDAO.save(sa);
            
            out.print(String.format("{\"correct\": %b, \"bonusEarned\": %d}", isCorrect, bonusEarned));

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Invalid input or server error\"}");
        }
    }
}
