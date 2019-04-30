package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Codemaster;
import com.ngs.entity.CodemasterId;

/**
 * Interface for CodemasterDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface ICodemasterDAO {
	/**
	 * Perform an initial save of a previously unsaved Codemaster entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICodemasterDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Codemaster entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Codemaster entity);

	/**
	 * Delete a persistent Codemaster entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICodemasterDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Codemaster entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Codemaster entity);

	/**
	 * Persist a previously saved Codemaster entity and return it or a copy of
	 * it to the sender. A copy of the Codemaster entity parameter is returned
	 * when the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ICodemasterDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Codemaster entity to update
	 * @return Codemaster the persisted Codemaster entity instance, may not be
	 *         the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Codemaster update(Codemaster entity);

	public Codemaster findById(Integer id);

	/**
	 * Find all Codemaster entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Codemaster property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Codemaster> found by query
	 */
	public List<Codemaster> findByProperty(String propertyName, Object value,
			int... rowStartIdxAndCount);

	public List<Codemaster> findByDescription(Object description,
			int... rowStartIdxAndCount);

	/**
	 * Find all Codemaster entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Codemaster> all Codemaster entities
	 */
	public List<Codemaster> findAll(int... rowStartIdxAndCount);
}