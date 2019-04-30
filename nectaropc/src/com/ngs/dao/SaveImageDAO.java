package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.SaveImage;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * SaveImage entities. Transaction control of the save(), update() and delete()
 * operations must be handled externally by senders of these methods or must be
 * manually added to each of these methods for data to be persisted to the JPA
 * datastore.
 * 
 * @see com.ngs.entity.SaveImage
 * @author MyEclipse Persistence Tools
 */

public class SaveImageDAO implements ISaveImageDAO {
	// property constants
	public static final String NAME = "name";
	public static final String CITY = "city";
	public static final String IMAGE = "image";
	public static final String PHONE = "phone";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved SaveImage entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * SaveImageDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            SaveImage entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(SaveImage entity) {
		EntityManagerHelper.log("saving SaveImage instance", Level.INFO, null);
		try {
			getEntityManager().persist(entity);
			EntityManagerHelper.log("save successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("save failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Delete a persistent SaveImage entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * SaveImageDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            SaveImage entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(SaveImage entity) {
		EntityManagerHelper
				.log("deleting SaveImage instance", Level.INFO, null);
		try {
			entity = getEntityManager().getReference(SaveImage.class,
					entity.getId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved SaveImage entity and return it or a copy of it
	 * to the sender. A copy of the SaveImage entity parameter is returned when
	 * the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = SaveImageDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            SaveImage entity to update
	 * @return SaveImage the persisted SaveImage entity instance, may not be the
	 *         same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public SaveImage update(SaveImage entity) {
		EntityManagerHelper
				.log("updating SaveImage instance", Level.INFO, null);
		try {
			SaveImage result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public SaveImage findById(Integer id) {
		EntityManagerHelper.log("finding SaveImage instance with id: " + id,
				Level.INFO, null);
		try {
			SaveImage instance = getEntityManager().find(SaveImage.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all SaveImage entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the SaveImage property to query
	 * @param value
	 *            the property value to match
	 * @return List<SaveImage> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<SaveImage> findByProperty(String propertyName,
			final Object value) {
		EntityManagerHelper.log("finding SaveImage instance with property: "
				+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from SaveImage model where model."
					+ propertyName + "= :propertyValue";
			Query query = getEntityManager().createQuery(queryString);
			query.setParameter("propertyValue", value);
			return query.getResultList();
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find by property name failed",
					Level.SEVERE, re);
			throw re;
		}
	}

	public List<SaveImage> findByName(Object name) {
		return findByProperty(NAME, name);
	}

	public List<SaveImage> findByCity(Object city) {
		return findByProperty(CITY, city);
	}

	public List<SaveImage> findByImage(Object image) {
		return findByProperty(IMAGE, image);
	}

	public List<SaveImage> findByPhone(Object phone) {
		return findByProperty(PHONE, phone);
	}

	/**
	 * Find all SaveImage entities.
	 * 
	 * @return List<SaveImage> all SaveImage entities
	 */
	@SuppressWarnings("unchecked")
	public List<SaveImage> findAll() {
		EntityManagerHelper.log("finding all SaveImage instances", Level.INFO,
				null);
		try {
			final String queryString = "select model from SaveImage model";
			Query query = getEntityManager().createQuery(queryString);
			return query.getResultList();
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find all failed", Level.SEVERE, re);
			throw re;
		}
	}

}