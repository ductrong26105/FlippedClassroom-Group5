package org.flearn.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.flearn.model.LiveSession;

import java.util.List;

public class LiveSessionDAO {

    public LiveSession findActiveSession(int classId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<LiveSession> query = em.createQuery(
                    "SELECT ls FROM LiveSession ls WHERE ls.classRoom.classId = :classId AND ls.endedAt IS NULL",
                    LiveSession.class);
            query.setParameter("classId", classId);
            List<LiveSession> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public LiveSession findById(int sessionId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            return em.find(LiveSession.class, sessionId);
        } finally {
            em.close();
        }
    }

    public void save(LiveSession session) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(session);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(LiveSession session) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(session);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
