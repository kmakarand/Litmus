package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Revenuesharing;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Revenuesharing entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Revenuesharing
 * @author MyEclipse Persistence Tools
 */

public class RevenuesharingDAO implements IRevenuesharingDAO {
	// property constants
	public static final String CLIENT = "client";
	public static final String CRITERIA = "criteria";
	public static final String AMOUNT = "amount";
	public static final String ZILS_SHARE = "zilsShare";
	public static final String CLIENT_SHARE = "clientShare";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Revenuesharing entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * RevenuesharingDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Revenuesharing entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Revenuesharing entity) {
		EntityManagerHelper.log("saving Revenuesharing instance", Level.INFO,
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
	 * Delete a persistent Revenuesharing entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * RevenuesharingDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Revenuesharing entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Revenuesharing entity) {
		EntityManagerHelper.log("deleting Revenuesharing instance", Level.INFO,
				null);
		try {
			entity = getEntityManager().getReference(Revenuesharing.class,
					entity.getShareId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Revenuesharing entity and return it or a copy
	 * of it to the sender. A copy of the Revenuesharing entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = RevenuesharingDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Revenuesharing entity to update
	 * @return Revenuesharing the persisted Revenuesharing entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Revenuesharing update(Revenuesharing entity) {
		EntityManagerHelper.log("updating Revenuesharing instance", Level.INFO,
				null);
		try {
			Revenuesharing result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Revenuesharing findById(Integer id) {
		EntityManagerHelper.log("finding Revenuesharing instance with id: "
				+ id, Level.INFO, null);
		try {
			Revenuesharing instance = getEntityManager().find(
					Revenuesharing.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Revenuesharing entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Revenuesharing property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            number of results to return.
	 * @return List<Revenuesharing> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Revenuesharing> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Revenuesharing instance with property: "
						+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Revenuesharing model where model."
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

	public List<Revenuesharing> findByClient(Object client,
			int... rowStartIdxAndCount) {
		return findByProperty(CLIENT, client, rowStartIdxAndCount);
	}

	public List<Revenuesharing> findByCriteria(Object criteria,
			int... rowStartIdxAndCount) {
		return findByProperty(CRITERIA, criteria, rowStartIdxAndCount);
	}

	public List<Revenuesharing> findByAmount(Object amount,
			int... rowStartIdxAndCount) {
		return findByProperty(AMOUNT, amount, rowStartIdxAndCount);
	}

	public List<Revenuesharing> findByZilsShare(Object zilsShare,
			int... rowStartIdxAndCount) {
		return findByProperty(ZILS_SHARE, zilsShare, rowStartIdxAndCount);
	}

	public List<Revenuesharing> findByClientShare(Object clientShare,
			int... rowStartIdxAndCount) {
		return findByProperty(CLIENT_SHARE, clientShare, rowStartIdxAndCount);
	}

	/**
	 * Find all Revenuesharing entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Revenuesharing> all Revenuesharing entities
	 */
	@SuppressWarnings("unchecked")
	public List<Revenuesharing> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Revenuesharing instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Revenuesharing model";
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