package org.flearn.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.flearn.model.StudentProgress;

import java.util.List;

public class StudentProgressDAO {

    public StudentProgress findByStudentAndNode(int studentId, int nodeId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<StudentProgress> query = em.createQuery(
                    "SELECT sp FROM StudentProgress sp WHERE sp.student.userId = :studentId AND sp.node.nodeId = :nodeId",
                    StudentProgress.class);
            query.setParameter("studentId", studentId);
            query.setParameter("nodeId", nodeId);
            List<StudentProgress> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public List<StudentProgress> findByStudentAndClass(int studentId, int classId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<StudentProgress> query = em.createQuery(
                    "SELECT sp FROM StudentProgress sp JOIN FETCH sp.node WHERE sp.student.userId = :studentId AND sp.node.classRoom.classId = :classId",
                    StudentProgress.class);
            query.setParameter("studentId", studentId);
            query.setParameter("classId", classId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void saveOrUpdate(StudentProgress progress) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            if (progress.getProgressId() == 0) {
                em.persist(progress);
            } else {
                em.merge(progress);
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
