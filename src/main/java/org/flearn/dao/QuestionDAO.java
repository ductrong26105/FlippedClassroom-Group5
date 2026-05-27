package org.flearn.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.flearn.model.Question;

import java.util.List;

/**
 * Data Access Object for the Question entity.
 */
public class QuestionDAO {

    public Question findById(int id) {
        EntityManager em = DBContext.getEntityManager();
        try {
            return em.find(Question.class, id);
        } finally {
            em.close();
        }
    }

    public List<Question> findByNode(int nodeId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<Question> query = em.createQuery(
                    "SELECT q FROM Question q WHERE q.node.nodeId = :nodeId AND q.isActive = true ORDER BY q.questionId",
                    Question.class);
            query.setParameter("nodeId", nodeId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Question> findByClass(int classId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<Question> query = em.createQuery(
                    "SELECT q FROM Question q WHERE q.classRoom.classId = :classId AND q.isActive = true ORDER BY q.questionId",
                    Question.class);
            query.setParameter("classId", classId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void save(Question question) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(question);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Question question) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(question);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Question q = em.find(Question.class, id);
            if (q != null) {
                em.remove(q);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
