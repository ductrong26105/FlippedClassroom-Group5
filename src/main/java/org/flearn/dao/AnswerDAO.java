package org.flearn.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.flearn.model.Answer;

import java.util.List;

public class AnswerDAO {

    public Answer findById(int id) {
        EntityManager em = DBContext.getEntityManager();
        try {
            return em.find(Answer.class, id);
        } finally {
            em.close();
        }
    }

    public List<Answer> findByQuestion(int questionId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<Answer> query = em.createQuery(
                    "SELECT a FROM Answer a WHERE a.question.questionId = :questionId ORDER BY a.answerId",
                    Answer.class);
            query.setParameter("questionId", questionId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
