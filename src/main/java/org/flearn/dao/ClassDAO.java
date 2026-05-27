package org.flearn.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.flearn.model.ClassRoom;

import java.util.List;
import org.flearn.model.User;

/**
 * Data Access Object for the ClassRoom entity.
 */
public class ClassDAO {

    public ClassRoom findById(int id) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<ClassRoom> query = em.createQuery(
                    "SELECT c FROM ClassRoom c JOIN FETCH c.teacher WHERE c.classId = :id",
                    ClassRoom.class);
            query.setParameter("id", id);
            List<ClassRoom> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public List<ClassRoom> findAll() {
        EntityManager em = DBContext.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT c FROM ClassRoom c JOIN FETCH c.teacher WHERE c.isActive = true ORDER BY c.createdAt DESC",
                    ClassRoom.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<ClassRoom> findByTeacher(int teacherId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<ClassRoom> query = em.createQuery(
                    "SELECT c FROM ClassRoom c JOIN FETCH c.teacher WHERE c.teacher.userId = :teacherId AND c.isActive = true ORDER BY c.createdAt DESC",
                    ClassRoom.class);
            query.setParameter("teacherId", teacherId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public ClassRoom findByInviteCode(String code) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<ClassRoom> query = em.createQuery(
                    "SELECT c FROM ClassRoom c WHERE c.inviteCode = :code", ClassRoom.class);
            query.setParameter("code", code);
            List<ClassRoom> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public void save(ClassRoom classRoom) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(classRoom);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(ClassRoom classRoom) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(classRoom);
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
            ClassRoom classRoom = em.find(ClassRoom.class, id);
            if (classRoom != null) {
                em.remove(classRoom);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public List<ClassRoom> findJoinedClasses(int studentId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<ClassRoom> query = em.createQuery(
                    "SELECT cm.classRoom FROM ClassMember cm JOIN FETCH cm.classRoom.teacher WHERE cm.student.userId = :studentId AND cm.classRoom.isActive = true ORDER BY cm.joinedAt DESC",
                    ClassRoom.class);
            query.setParameter("studentId", studentId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public long countActiveNodes(int classId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(n) FROM Node n WHERE n.classRoom.classId = :classId AND n.isActive = true",
                    Long.class);
            query.setParameter("classId", classId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countCompletedNodes(int classId, int studentId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(sp) FROM StudentProgress sp WHERE sp.student.userId = :studentId AND sp.node.classRoom.classId = :classId AND sp.isCompleted = true",
                    Long.class);
            query.setParameter("classId", classId);
            query.setParameter("studentId", studentId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public boolean isMember(int classId, int studentId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(cm) FROM ClassMember cm WHERE cm.student.userId = :studentId AND cm.classRoom.classId = :classId",
                    Long.class);
            query.setParameter("classId", classId);
            query.setParameter("studentId", studentId);
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }

    public void addMember(ClassRoom classRoom, User student) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(cm) FROM ClassMember cm WHERE cm.student.userId = :studentId AND cm.classRoom.classId = :classId",
                    Long.class);
            query.setParameter("classId", classRoom.getClassId());
            query.setParameter("studentId", student.getUserId());
            if (query.getSingleResult() == 0) {
                org.flearn.model.ClassMember cm = org.flearn.model.ClassMember.builder()
                        .classRoom(classRoom)
                        .student(student)
                        .build();
                em.persist(cm);
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
