package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Moduledetails;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Moduledetails entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Moduledetails
 * @author MyEclipse Persistence Tools
 */

public class ModuledetailsDAO implements IModuledetailsDAO {
	// property constants
	public static final String MODULE_NAME = "moduleName";
	public static final String CHAPTER_NAME = "chapterName";
	public static final String MODULE_COUNT = "moduleCount";
	public static final String CHAPTER_COUNT = "chapterCount";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Moduledetails entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ModuledetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Moduledetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Moduledetails entity) {
		EntityManagerHelper.log("saving Moduledetails instance", Level.INFO,
				null);
		try {
			getEntityManager().persist(entity);
			EntityManagerHelper.log("save successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("save failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Delete a persistent Moduledetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ModuledetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Moduledetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Moduledetails entity) {
		EntityManagerHelper.log("deleting Moduledetails instance", Level.INFO,
				null);
		try {
			entity = getEntityManager().getReference(Moduledetails.class,
					entity.getCandidateId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Moduledetails entity and return it or a copy
	 * of it to the sender. A copy of the Moduledetails entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ModuledetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Moduledetails entity to update
	 * @return Moduledetails the persisted Moduledetails entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Moduledetails update(Moduledetails entity) {
		EntityManagerHelper.log("updating Moduledetails instance", Level.INFO,
				null);
		try {
			Moduledetails result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Moduledetails findById(Integer id) {
		EntityManagerHelper.log(
				"finding Moduledetails instance with id: " + id, Level.INFO,
				null);
		try {
			Moduledetails instance = getEntityManager().find(
					Moduledetails.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Moduledetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Moduledetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            number of results to return.
	 * @return List<Moduledetails> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Moduledetails> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Moduledetails instance with property: " + propertyName
						+ ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Moduledetails model where model."
					+ propertyName + "= :propertyValue";
			Query query = getEntityManager().createQuery(queryString);
			query.setParameter("propertyValue", value);
			if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {
				int rowStartIdx = Math.max(0, rowStartIdxAndCount[0]);
				if (rowStartIdx > 0) {
					query.setFirstResult(rowStartIdx);
				}

				if (rowStartIdxAndCount.length > 1) {
					int rowCount = Math.max(0, rowStartIdxAndCount[1]);
					if (rowCount > 0) {
						query.setMaxResults(rowCount);
					}
				}
			}
			return query.getResultList();
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find by property name failed",
					Level.SEVERE, re);
			throw re;
		}
	}

	public List<Moduledetails> findByModuleName(Object moduleName,
			int... rowStartIdxAndCount) {
		return findByProperty(MODULE_NAME, moduleName, rowStartIdxAndCount);
	}

	public List<Moduledetails> findByChapterName(Object chapterName,
			int... rowStartIdxAndCount) {
		return findByProperty(CHAPTER_NAME, chapterName, rowStartIdxAndCount);
	}

	public List<Moduledetails> findByModuleCount(Object moduleCount,
			int... rowStartIdxAndCount) {
		return findByProperty(MODULE_COUNT, moduleCount, rowStartIdxAndCount);
	}

	public List<Moduledetails> findByChapterCount(Object chapterCount,
			int... rowStartIdxAndCount) {
		return findByProperty(CHAPTER_COUNT, chapterCount, rowStartIdxAndCount);
	}

	/**
	 * Find all Moduledetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Moduledetails> all Moduledetails entities
	 */
	@SuppressWarnings("unchecked")
	public List<Moduledetails> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Moduledetails instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Moduledetails model";
			Query query = getEntityManager().createQuery(queryString);
			if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {
				int rowStartIdx = Math.max(0, rowStartIdxAndCount[0]);
				if (rowStartIdx > 0) {
					query.setFirstResult(rowStartIdx);
				}

				if (rowStartIdxAndCount.length > 1) {
					int rowCount = Math.max(0, rowStartIdxAndCount[1]);
					if (rowCount > 0) {
						query.setMaxResults(rowCount);
					}
				}
			}
			return query.getResultList();
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find all failed", Level.SEVERE, re);
			throw re;
		}
	}

}