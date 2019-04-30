package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Codegroupdetails;

/**
 * Interface for CodegroupdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface ICodegroupdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Codegroupdetails entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICodegroupdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Codegroupdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Codegroupdetails entity);

	/**
	 * Delete a persistent Codegroupdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICodegroupdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Codegroupdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Codegroupdetails entity);

	/**
	 * Persist a previously saved Codegroupdetails entity and return it or a
	 * copy of it to the sender. A copy of the Codegroupdetails entity parameter
	 * is returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ICodegroupdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Codegroupdetails entity to update
	 * @return Codegroupdetails the persisted Codegroupdetails entity instance,
	 *         may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Codegroupdetails update(Codegroupdetails entity);

	public Codegroupdetails findById(Integer id);

	/**
	 * Find all Codegroupdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Codegroupdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Codegroupdetails> found by query
	 */
	public List<Codegroupdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Codegroupdetails> findByNoOfQuestions(Object noOfQuestions,
			int... rowStartIdxAndCount);

	/**
	 * Find all Codegroupdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Codegroupdetails> all Codegroupdetails entities
	 */
	public List<Codegroupdetails> findAll(int... rowStartIdxAndCount);
}