package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Nextvalues;

/**
 * Interface for NextvaluesDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface INextvaluesDAO {
	/**
	 * Perform an initial save of a previously unsaved Nextvalues entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * INextvaluesDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Nextvalues entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Nextvalues entity);

	/**
	 * Delete a persistent Nextvalues entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * INextvaluesDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Nextvalues entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Nextvalues entity);

	/**
	 * Persist a previously saved Nextvalues entity and return it or a copy of
	 * it to the sender. A copy of the Nextvalues entity parameter is returned
	 * when the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = INextvaluesDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Nextvalues entity to update
	 * @return Nextvalues the persisted Nextvalues entity instance, may not be
	 *         the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Nextvalues update(Nextvalues entity);

	public Nextvalues findById(Integer id);

	/**
	 * Find all Nextvalues entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Nextvalues property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Nextvalues> found by query
	 */
	public List<Nextvalues> findByProperty(String propertyName, Object value,
			int... rowStartIdxAndCount);

	/**
	 * Find all Nextvalues entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Nextvalues> all Nextvalues entities
	 */
	public List<Nextvalues> findAll(int... rowStartIdxAndCount);
}