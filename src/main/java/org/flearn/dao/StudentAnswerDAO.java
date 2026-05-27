package org.flearn.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.flearn.model.StudentAnswer;

import java.util.List;

public class StudentAnswerDAO {

    public StudentAnswer findFirstAnswer(int studentId, int questionId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<StudentAnswer> query = em.createQuery(
                    "SELECT sa FROM StudentAnswer sa WHERE sa.student.userId = :studentId AND sa.question.questionId = :questionId ORDER BY sa.createdAt ASC",
                    StudentAnswer.class);
            query.setParameter("studentId", studentId);
            query.setParameter("questionId", questionId);
            query.setMaxResults(1);
            List<StudentAnswer> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public boolean hasAnsweredCorrectly(int studentId, int questionId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(sa) FROM StudentAnswer sa WHERE sa.student.userId = :studentId AND sa.question.questionId = :questionId AND sa.isCorrect = true",
                    Long.class);
            query.setParameter("studentId", studentId);
            query.setParameter("questionId", questionId);
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }

    public void save(StudentAnswer answer) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(answer);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
