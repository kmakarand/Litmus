package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Newexamdetails;


/**
 * Interface for NewexamdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface INewexamdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Newexamdetails entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * INewexamdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newexamdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public boolean save(Newexamdetails entity);

	/**
	 * Delete a persistent Newexamdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * INewexamdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Newexamdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Newexamdetails entity);

	/**
	 * Persist a previously saved Newexamdetails entity and return it or a copy
	 * of it to the sender. A copy of the Newexamdetails entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = INewexamdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newexamdetails entity to update
	 * @return Newexamdetails the persisted Newexamdetails entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Newexamdetails update(Newexamdetails entity);

	public Newexamdetails findById(Integer id);

	/**
	 * Find all Newexamdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Newexamdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Newexamdetails> found by query
	 */
	public List<Newexamdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	/**
	 * Find all Newexamdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Newexamdetails> all Newexamdetails entities
	 */
	public List<Newexamdetails> findAll(int... rowStartIdxAndCount);
}