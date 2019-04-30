package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Categorymaster;

/**
 * Interface for CategorymasterDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface ICategorymasterDAO {
	/**
	 * Perform an initial save of a previously unsaved Categorymaster entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICategorymasterDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Categorymaster entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Categorymaster entity);

	/**
	 * Delete a persistent Categorymaster entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICategorymasterDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Categorymaster entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Categorymaster entity);

	/**
	 * Persist a previously saved Categorymaster entity and return it or a copy
	 * of it to the sender. A copy of the Categorymaster entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ICategorymasterDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Categorymaster entity to update
	 * @return Categorymaster the persisted Categorymaster entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Categorymaster update(Categorymaster entity);

	public Categorymaster findById(String id);

	/**
	 * Find all Categorymaster entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Categorymaster property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Categorymaster> found by query
	 */
	public List<Categorymaster> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Categorymaster> findByCategory(Object category,
			int... rowStartIdxAndCount);

	/**
	 * Find all Categorymaster entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Categorymaster> all Categorymaster entities
	 */
	public List<Categorymaster> findAll(int... rowStartIdxAndCount);
}