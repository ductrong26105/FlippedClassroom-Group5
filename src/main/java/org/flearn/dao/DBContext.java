package org.flearn.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Singleton factory for JPA EntityManager instances.
 * Uses the persistence unit defined in META-INF/persistence.xml.
 */
public class DBContext {

    private static final String PERSISTENCE_UNIT = "flearn-persistence-unit";
    private static volatile EntityManagerFactory emf;

    private DBContext() {
        // Utility class — prevent instantiation
    }

    /**
     * Returns the shared EntityManagerFactory (lazy-initialized, thread-safe).
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        if (emf == null) {
            synchronized (DBContext.class) {
                if (emf == null) {
                    emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
                }
            }
        }
        return emf;
    }

    /**
     * Creates and returns a new EntityManager.
     * Caller is responsible for closing it.
     */
    public static EntityManager getEntityManager() {
        return getEntityManagerFactory().createEntityManager();
    }

    /**
     * Shuts down the EntityManagerFactory.
     * Should be called when the application is being destroyed (e.g., in a ServletContextListener).
     */
    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
