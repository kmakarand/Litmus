package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Registrationdetails;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Registrationdetails entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Registrationdetails
 * @author MyEclipse Persistence Tools
 */

public class RegistrationdetailsDAO implements IRegistrationdetailsDAO {
	// property constants
	public static final String CLIENT_ID = "clientId";
	public static final String LOCATION_ID = "locationId";
	public static final String SERIAL_NO = "serialNo";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Registrationdetails
	 * entity. All subsequent persist actions of this entity should use the
	 * #update() method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * RegistrationdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Registrationdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Registrationdetails entity) {
		EntityManagerHelper.log("saving Registrationdetails instance",
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
	 * Delete a persistent Registrationdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * RegistrationdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Registrationdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Registrationdetails entity) {
		EntityManagerHelper.log("deleting Registrationdetails instance",
				Level.INFO, null);
		try {
			entity = getEntityManager().getReference(Registrationdetails.class,
					entity.getCandidateId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Registrationdetails entity and return it or a
	 * copy of it to the sender. A copy of the Registrationdetails entity
	 * parameter is returned when the JPA persistence mechanism has not
	 * previously been tracking the updated entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently saved to the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#merge(Object)
	 * EntityManager#merge} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = RegistrationdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Registrationdetails entity to update
	 * @return Registrationdetails the persisted Registrationdetails entity
	 *         instance, may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Registrationdetails update(Registrationdetails entity) {
		EntityManagerHelper.log("updating Registrationdetails instance",
				Level.INFO, null);
		try {
			Registrationdetails result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Registrationdetails findById(Integer id) {
		EntityManagerHelper.log(
				"finding Registrationdetails instance with id: " + id,
				Level.INFO, null);
		try {
			Registrationdetails instance = getEntityManager().find(
					Registrationdetails.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Registrationdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Registrationdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            number of results to return.
	 * @return List<Registrationdetails> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Registrationdetails> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Registrationdetails instance with property: "
						+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Registrationdetails model where model."
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

	public List<Registrationdetails> findByClientId(Object clientId,
			int... rowStartIdxAndCount) {
		return findByProperty(CLIENT_ID, clientId, rowStartIdxAndCount);
	}

	public List<Registrationdetails> findByLocationId(Object locationId,
			int... rowStartIdxAndCount) {
		return findByProperty(LOCATION_ID, locationId, rowStartIdxAndCount);
	}

	public List<Registrationdetails> findBySerialNo(Object serialNo,
			int... rowStartIdxAndCount) {
		return findByProperty(SERIAL_NO, serialNo, rowStartIdxAndCount);
	}

	/**
	 * Find all Registrationdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Registrationdetails> all Registrationdetails entities
	 */
	@SuppressWarnings("unchecked")
	public List<Registrationdetails> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Registrationdetails instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Registrationdetails model";
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