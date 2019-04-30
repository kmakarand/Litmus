package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Postponeslotdetails;
import com.ngs.entity.PostponeslotdetailsId;

/**
 * Interface for PostponeslotdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IPostponeslotdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Postponeslotdetails
	 * entity. All subsequent persist actions of this entity should use the
	 * #update() method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IPostponeslotdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Postponeslotdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Postponeslotdetails entity);

	/**
	 * Delete a persistent Postponeslotdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IPostponeslotdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Postponeslotdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Postponeslotdetails entity);

	/**
	 * Persist a previously saved Postponeslotdetails entity and return it or a
	 * copy of it to the sender. A copy of the Postponeslotdetails entity
	 * parameter is returned when the JPA persistence mechanism has not
	 * previously been tracking the updated entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently saved to the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#merge(Object)
	 * EntityManager#merge} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IPostponeslotdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Postponeslotdetails entity to update
	 * @return Postponeslotdetails the persisted Postponeslotdetails entity
	 *         instance, may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Postponeslotdetails update(Postponeslotdetails entity);

	public Postponeslotdetails findById(Postponeslotdetails id);

	/**
	 * Find all Postponeslotdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Postponeslotdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Postponeslotdetails> found by query
	 */
	public List<Postponeslotdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	/**
	 * Find all Postponeslotdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Postponeslotdetails> all Postponeslotdetails entities
	 */
	public List<Postponeslotdetails> findAll(int... rowStartIdxAndCount);
}