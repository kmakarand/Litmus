package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Locationmaster;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Locationmaster entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Locationmaster
 * @author MyEclipse Persistence Tools
 */

public class LocationmasterDAO implements ILocationmasterDAO {
	// property constants
	public static final String COUNTRY_ID = "countryId";
	public static final String STATE_ID = "stateId";
	public static final String CITY_ID = "cityId";
	public static final String AREA_ID = "areaId";
	public static final String CODE = "code";
	public static final String LOCATION_NAME = "locationName";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Locationmaster entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * LocationmasterDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Locationmaster entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Locationmaster entity) {
		EntityManagerHelper.log("saving Locationmaster instance", Level.INFO,
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
	 * Delete a persistent Locationmaster entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * LocationmasterDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Locationmaster entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Locationmaster entity) {
		EntityManagerHelper.log("deleting Locationmaster instance", Level.INFO,
				null);
		try {
			entity = getEntityManager().getReference(Locationmaster.class,
					entity.getLocationId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Locationmaster entity and return it or a copy
	 * of it to the sender. A copy of the Locationmaster entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = LocationmasterDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Locationmaster entity to update
	 * @return Locationmaster the persisted Locationmaster entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Locationmaster update(Locationmaster entity) {
		EntityManagerHelper.log("updating Locationmaster instance", Level.INFO,
				null);
		try {
			Locationmaster result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Locationmaster findById(Integer id) {
		EntityManagerHelper.log("finding Locationmaster instance with id: "
				+ id, Level.INFO, null);
		try {
			Locationmaster instance = getEntityManager().find(
					Locationmaster.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Locationmaster entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Locationmaster property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            number of results to return.
	 * @return List<Locationmaster> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Locationmaster> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Locationmaster instance with property: "
						+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Locationmaster model where model."
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

	public List<Locationmaster> findByCountryId(Object countryId,
			int... rowStartIdxAndCount) {
		return findByProperty(COUNTRY_ID, countryId, rowStartIdxAndCount);
	}

	public List<Locationmaster> findByStateId(Object stateId,
			int... rowStartIdxAndCount) {
		return findByProperty(STATE_ID, stateId, rowStartIdxAndCount);
	}

	public List<Locationmaster> findByCityId(Object cityId,
			int... rowStartIdxAndCount) {
		return findByProperty(CITY_ID, cityId, rowStartIdxAndCount);
	}

	public List<Locationmaster> findByAreaId(Object areaId,
			int... rowStartIdxAndCount) {
		return findByProperty(AREA_ID, areaId, rowStartIdxAndCount);
	}

	public List<Locationmaster> findByCode(Object code,
			int... rowStartIdxAndCount) {
		return findByProperty(CODE, code, rowStartIdxAndCount);
	}

	public List<Locationmaster> findByLocationName(Object locationName,
			int... rowStartIdxAndCount) {
		return findByProperty(LOCATION_NAME, locationName, rowStartIdxAndCount);
	}

	/**
	 * Find all Locationmaster entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Locationmaster> all Locationmaster entities
	 */
	@SuppressWarnings("unchecked")
	public List<Locationmaster> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Locationmaster instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Locationmaster model";
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