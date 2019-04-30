package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Usergroupxref;

/**
 * Interface for UsergroupxrefDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IUsergroupxrefDAO {
	/**
	 * Perform an initial save of a previously unsaved Usergroupxref entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IUsergroupxrefDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Usergroupxref entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public boolean save(Usergroupxref entity);

	/**
	 * Delete a persistent Usergroupxref entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IUsergroupxrefDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Usergroupxref entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public boolean delete(Usergroupxref entity);

	/**
	 * Persist a previously saved Usergroupxref entity and return it or a copy
	 * of it to the sender. A copy of the Usergroupxref entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IUsergroupxrefDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Usergroupxref entity to update
	 * @return Usergroupxref the persisted Usergroupxref entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Usergroupxref update(Usergroupxref entity);

	public Usergroupxref findByUsername(String username);

	/**
	 * Find all Usergroupxref entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Usergroupxref property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Usergroupxref> found by query
	 */
	public List<Usergroupxref> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	/**
	 * Find all Usergroupxref entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Usergroupxref> all Usergroupxref entities
	 */
	public List<Usergroupxref> findAll(int... rowStartIdxAndCount);
}