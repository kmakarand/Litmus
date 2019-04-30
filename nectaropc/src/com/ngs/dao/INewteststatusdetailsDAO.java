package com.ngs.dao;

import java.util.Date;
import java.util.List;

import com.ngs.entity.Newteststatusdetails;

/**
 * Interface for NewteststatusdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface INewteststatusdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Newteststatusdetails
	 * entity. All subsequent persist actions of this entity should use the
	 * #update() method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * INewteststatusdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newteststatusdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Newteststatusdetails entity);

	/**
	 * Delete a persistent Newteststatusdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * INewteststatusdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Newteststatusdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Newteststatusdetails entity);

	/**
	 * Persist a previously saved Newteststatusdetails entity and return it or a
	 * copy of it to the sender. A copy of the Newteststatusdetails entity
	 * parameter is returned when the JPA persistence mechanism has not
	 * previously been tracking the updated entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently saved to the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#merge(Object)
	 * EntityManager#merge} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = INewteststatusdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newteststatusdetails entity to update
	 * @return Newteststatusdetails the persisted Newteststatusdetails entity
	 *         instance, may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Newteststatusdetails update(Newteststatusdetails entity);

	public Newteststatusdetails findById(Integer id);

	/**
	 * Find all Newteststatusdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Newteststatusdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Newteststatusdetails> found by query
	 */
	public List<Newteststatusdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Newteststatusdetails> findBySectionId(Object sectionId,
			int... rowStartIdxAndCount);

	public List<Newteststatusdetails> findByTestMode(Object testMode,
			int... rowStartIdxAndCount);

	public List<Newteststatusdetails> findByStatus(Object status,
			int... rowStartIdxAndCount);

	public List<Newteststatusdetails> findBySequenceId(Object sequenceId,
			int... rowStartIdxAndCount);

	public List<Newteststatusdetails> findByAttemptNo(Object attemptNo,
			int... rowStartIdxAndCount);

	/**
	 * Find all Newteststatusdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Newteststatusdetails> all Newteststatusdetails entities
	 */
	public List<Newteststatusdetails> findAll(int... rowStartIdxAndCount);
}