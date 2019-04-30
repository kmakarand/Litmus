package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Newteststatusdetails;

import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Newteststatusdetails entities. Transaction control of the save(), update()
 * and delete() operations must be handled externally by senders of these
 * methods or must be manually added to each of these methods for data to be
 * persisted to the JPA datastore.
 * 
 * @see com.ngs.entity.Newteststatusdetails
 * @author MyEclipse Persistence Tools
 */

public class NewteststatusdetailsDAO implements INewteststatusdetailsDAO {
	// property constants
	public static final String SECTION_ID = "sectionId";
	public static final String TEST_MODE = "testMode";
	public static final String STATUS = "status";
	public static final String SEQUENCE_ID = "sequenceId";
	public static final String ATTEMPT_NO = "attemptNo";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Newteststatusdetails
	 * entity. All subsequent persist actions of this entity should use the
	 * #update() method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * NewteststatusdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newteststatusdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Newteststatusdetails entity) {
		EntityManagerHelper.log("saving Newteststatusdetails instance",
				Level.INFO, null);
		try {
			getEntityManager().persist(entity);
			EntityManagerHelper.log("save successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("save failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Delete a persistent Newteststatusdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * NewteststatusdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Newteststatusdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Newteststatusdetails entity) {
		EntityManagerHelper.log("deleting Newteststatusdetails instance",
				Level.INFO, null);
		try {
			entity = getEntityManager().getReference(
					Newteststatusdetails.class, entity.getCandidateId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Newteststatusdetails entity and return it or a
	 * copy of it to the sender. A copy of the Newteststatusdetails entity
	 * parameter is returned when the JPA persistence mechanism has not
	 * previously been tracking the updated entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently saved to the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#merge(Object)
	 * EntityManager#merge} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = NewteststatusdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newteststatusdetails entity to update
	 * @return Newteststatusdetails the persisted Newteststatusdetails entity
	 *         instance, may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Newteststatusdetails update(Newteststatusdetails entity) {
		EntityManagerHelper.log("updating Newteststatusdetails instance",
				Level.INFO, null);
		try {
			Newteststatusdetails result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Newteststatusdetails findById(Integer id) {
		EntityManagerHelper.log(
				"finding Newteststatusdetails instance with id: " + id,
				Level.INFO, null);
		try {
			Newteststatusdetails instance = getEntityManager().find(
					Newteststatusdetails.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Newteststatusdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Newteststatusdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            number of results to return.
	 * @return List<Newteststatusdetails> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Newteststatusdetails> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Newteststatusdetails instance with property: "
						+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Newteststatusdetails model where model."
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

	public List<Newteststatusdetails> findBySectionId(Object sectionId,
			int... rowStartIdxAndCount) {
		return findByProperty(SECTION_ID, sectionId, rowStartIdxAndCount);
	}

	public List<Newteststatusdetails> findByTestMode(Object testMode,
			int... rowStartIdxAndCount) {
		return findByProperty(TEST_MODE, testMode, rowStartIdxAndCount);
	}

	public List<Newteststatusdetails> findByStatus(Object status,
			int... rowStartIdxAndCount) {
		return findByProperty(STATUS, status, rowStartIdxAndCount);
	}

	public List<Newteststatusdetails> findBySequenceId(Object sequenceId,
			int... rowStartIdxAndCount) {
		return findByProperty(SEQUENCE_ID, sequenceId, rowStartIdxAndCount);
	}

	public List<Newteststatusdetails> findByAttemptNo(Object attemptNo,
			int... rowStartIdxAndCount) {
		return findByProperty(ATTEMPT_NO, attemptNo, rowStartIdxAndCount);
	}

	/**
	 * Find all Newteststatusdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Newteststatusdetails> all Newteststatusdetails entities
	 */
	@SuppressWarnings("unchecked")
	public List<Newteststatusdetails> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Newteststatusdetails instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Newteststatusdetails model";
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