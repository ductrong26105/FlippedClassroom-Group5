package org.flearn.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.flearn.model.MilestoneAssignment;

public class MilestoneAssignmentDAO {

    public MilestoneAssignment findById(int id) {
        EntityManager em = DBContext.getEntityManager();
        try {
            return em.find(MilestoneAssignment.class, id);
        } finally {
            em.close();
        }
    }

    public void update(MilestoneAssignment assignment) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(assignment);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
