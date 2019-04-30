package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Userdetails;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Userdetails entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Userdetails
 * @author MyEclipse Persistence Tools
 */

public class UserdetailsDAO implements IUserdetailsDAO {
	// property constants
	public static final String EXAM_ID = "examId";
	public static final String LEVEL_ID = "levelId";
	public static final String MODULE_COUNT = "moduleCount";
	public static final String LANGUAGE = "language";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Userdetails entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * UserdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Userdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Userdetails entity) {
		EntityManagerHelper
				.log("saving Userdetails instance", Level.INFO, null);
		try {
			getEntityManager().persist(entity);
			EntityManagerHelper.log("save successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("save failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Delete a persistent Userdetails entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * UserdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Userdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Userdetails entity) {
		EntityManagerHelper.log("deleting Userdetails instance", Level.INFO,
				null);
		try {
			entity = getEntityManager().getReference(Userdetails.class,
					entity.getCandidateId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Userdetails entity and return it or a copy of
	 * it to the sender. A copy of the Userdetails entity parameter is returned
	 * when the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = UserdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Userdetails entity to update
	 * @return Userdetails the persisted Userdetails entity instance, may not be
	 *         the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Userdetails update(Userdetails entity) {
		EntityManagerHelper.log("updating Userdetails instance", Level.INFO,
				null);
		try {
			Userdetails result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Userdetails findById(Integer id) {
		EntityManagerHelper.log("finding Userdetails instance with id: " + id,
				Level.INFO, null);
		try {
			Userdetails instance = getEntityManager().find(Userdetails.class,
					id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Userdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Userdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            number of results to return.
	 * @return List<Userdetails> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Userdetails> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding Userdetails instance with property: "
				+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Userdetails model where model."
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

	public List<Userdetails> findByExamId(Object examId,
			int... rowStartIdxAndCount) {
		return findByProperty(EXAM_ID, examId, rowStartIdxAndCount);
	}

	public List<Userdetails> findByLevelId(Object levelId,
			int... rowStartIdxAndCount) {
		return findByProperty(LEVEL_ID, levelId, rowStartIdxAndCount);
	}

	public List<Userdetails> findByModuleCount(Object moduleCount,
			int... rowStartIdxAndCount) {
		return findByProperty(MODULE_COUNT, moduleCount, rowStartIdxAndCount);
	}

	public List<Userdetails> findByLanguage(Object language,
			int... rowStartIdxAndCount) {
		return findByProperty(LANGUAGE, language, rowStartIdxAndCount);
	}

	/**
	 * Find all Userdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Userdetails> all Userdetails entities
	 */
	@SuppressWarnings("unchecked")
	public List<Userdetails> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Userdetails instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Userdetails model";
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