package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Levelmaster;

/**
 * Interface for LevelmasterDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface ILevelmasterDAO {
	/**
	 * Perform an initial save of a previously unsaved Levelmaster entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ILevelmasterDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Levelmaster entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Levelmaster entity);

	/**
	 * Delete a persistent Levelmaster entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ILevelmasterDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Levelmaster entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Levelmaster entity);

	/**
	 * Persist a previously saved Levelmaster entity and return it or a copy of
	 * it to the sender. A copy of the Levelmaster entity parameter is returned
	 * when the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ILevelmasterDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Levelmaster entity to update
	 * @return Levelmaster the persisted Levelmaster entity instance, may not be
	 *         the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Levelmaster update(Levelmaster entity);

	public List<Levelmaster> findById(Integer id);

	/**
	 * Find all Levelmaster entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Levelmaster property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Levelmaster> found by query
	 */
	public List<Levelmaster> findByProperty(String propertyName, Object value,
			int... rowStartIdxAndCount);

	/**
	 * Find all Levelmaster entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Levelmaster> all Levelmaster entities
	 */
	public List<Levelmaster> findAll(int... rowStartIdxAndCount);
}