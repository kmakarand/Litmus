package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Imageinfo;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Imageinfo entities. Transaction control of the save(), update() and delete()
 * operations must be handled externally by senders of these methods or must be
 * manually added to each of these methods for data to be persisted to the JPA
 * datastore.
 * 
 * @see com.ngs.entity.Imageinfo
 * @author MyEclipse Persistence Tools
 */

public class ImageinfoDAO implements IImageinfoDAO {
	// property constants
	public static final String QUESTION_ID = "questionId";
	public static final String OPTION_NO = "optionNo";
	public static final String IMAGE = "image";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Imageinfo entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ImageinfoDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Imageinfo entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Imageinfo entity) {
		EntityManagerHelper.log("saving Imageinfo instance", Level.INFO, null);
		try {
			getEntityManager().persist(entity);
			EntityManagerHelper.log("save successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("save failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Delete a persistent Imageinfo entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ImageinfoDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Imageinfo entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Imageinfo entity) {
		EntityManagerHelper
				.log("deleting Imageinfo instance", Level.INFO, null);
		try {
			entity = getEntityManager().getReference(Imageinfo.class,
					entity.getId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Imageinfo entity and return it or a copy of it
	 * to the sender. A copy of the Imageinfo entity parameter is returned when
	 * the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ImageinfoDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Imageinfo entity to update
	 * @return Imageinfo the persisted Imageinfo entity instance, may not be the
	 *         same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Imageinfo update(Imageinfo entity) {
		EntityManagerHelper
				.log("updating Imageinfo instance", Level.INFO, null);
		try {
			Imageinfo result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Imageinfo findById(Integer id) {
		EntityManagerHelper.log("finding Imageinfo instance with id: " + id,
				Level.INFO, null);
		try {
			Imageinfo instance = getEntityManager().find(Imageinfo.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Imageinfo entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Imageinfo property to query
	 * @param value
	 *            the property value to match
	 * @return List<Imageinfo> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Imageinfo> findByProperty(String propertyName,
			final Object value) {
		EntityManagerHelper.log("finding Imageinfo instance with property: "
				+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Imageinfo model where model."
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

	public List<Imageinfo> findByQuestionId(Object questionId) {
		return findByProperty(QUESTION_ID, questionId);
	}

	public List<Imageinfo> findByOptionNo(Object optionNo) {
		return findByProperty(OPTION_NO, optionNo);
	}

	public List<Imageinfo> findByImage(Object image) {
		return findByProperty(IMAGE, image);
	}

	/**
	 * Find all Imageinfo entities.
	 * 
	 * @return List<Imageinfo> all Imageinfo entities
	 */
	@SuppressWarnings("unchecked")
	public List<Imageinfo> findAll() {
		EntityManagerHelper.log("finding all Imageinfo instances", Level.INFO,
				null);
		try {
			final String queryString = "select model from Imageinfo model";
			Query query = getEntityManager().createQuery(queryString);
			return query.getResultList();
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find all failed", Level.SEVERE, re);
			throw re;
		}
	}

}