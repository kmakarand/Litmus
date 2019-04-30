package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Locationmaster;

/**
 * Interface for LocationmasterDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface ILocationmasterDAO {
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
	 * ILocationmasterDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Locationmaster entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Locationmaster entity);

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
	 * ILocationmasterDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Locationmaster entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Locationmaster entity);

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
	 * entity = ILocationmasterDAO.update(entity);
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
	public Locationmaster update(Locationmaster entity);

	public Locationmaster findById(Integer id);

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
	 *            count of results to return.
	 * @return List<Locationmaster> found by query
	 */
	public List<Locationmaster> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Locationmaster> findByCountryId(Object countryId,
			int... rowStartIdxAndCount);

	public List<Locationmaster> findByStateId(Object stateId,
			int... rowStartIdxAndCount);

	public List<Locationmaster> findByCityId(Object cityId,
			int... rowStartIdxAndCount);

	public List<Locationmaster> findByAreaId(Object areaId,
			int... rowStartIdxAndCount);

	public List<Locationmaster> findByCode(Object code,
			int... rowStartIdxAndCount);

	public List<Locationmaster> findByLocationName(Object locationName,
			int... rowStartIdxAndCount);

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
	public List<Locationmaster> findAll(int... rowStartIdxAndCount);
}