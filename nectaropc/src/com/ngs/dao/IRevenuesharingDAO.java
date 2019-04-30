package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Revenuesharing;

/**
 * Interface for RevenuesharingDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IRevenuesharingDAO {
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
	 * IRevenuesharingDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Revenuesharing entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Revenuesharing entity);

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
	 * IRevenuesharingDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Revenuesharing entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Revenuesharing entity);

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
	 * entity = IRevenuesharingDAO.update(entity);
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
	public Revenuesharing update(Revenuesharing entity);

	public Revenuesharing findById(Integer id);

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
	 *            count of results to return.
	 * @return List<Revenuesharing> found by query
	 */
	public List<Revenuesharing> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Revenuesharing> findByClient(Object client,
			int... rowStartIdxAndCount);

	public List<Revenuesharing> findByCriteria(Object criteria,
			int... rowStartIdxAndCount);

	public List<Revenuesharing> findByAmount(Object amount,
			int... rowStartIdxAndCount);

	public List<Revenuesharing> findByZilsShare(Object zilsShare,
			int... rowStartIdxAndCount);

	public List<Revenuesharing> findByClientShare(Object clientShare,
			int... rowStartIdxAndCount);

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
	public List<Revenuesharing> findAll(int... rowStartIdxAndCount);
}