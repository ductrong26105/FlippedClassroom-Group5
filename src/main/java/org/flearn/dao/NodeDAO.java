package org.flearn.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import org.flearn.model.Node;

import java.util.List;

/**
 * Data Access Object for the Node entity.
 */
public class NodeDAO {

    public Node findById(int id) {
        EntityManager em = DBContext.getEntityManager();
        try {
            return em.find(Node.class, id);
        } finally {
            em.close();
        }
    }

    public List<Node> findByClass(int classId) {
        EntityManager em = DBContext.getEntityManager();
        try {
            TypedQuery<Node> query = em.createQuery(
                    "SELECT n FROM Node n WHERE n.classRoom.classId = :classId AND n.isActive = true ORDER BY n.orderIndex",
                    Node.class);
            query.setParameter("classId", classId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void save(Node node) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(node);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Node node) {
        EntityManager em = DBContext.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(node);
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
            Node node = em.find(Node.class, id);
            if (node != null) {
                em.remove(node);
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
