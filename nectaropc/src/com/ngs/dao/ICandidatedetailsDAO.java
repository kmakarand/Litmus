package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Candidatedetails;
import com.ngs.entity.CandidatedetailsId;

/**
 * Interface for CandidatedetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface ICandidatedetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Candidatedetails entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICandidatedetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Candidatedetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Candidatedetails entity);

	/**
	 * Delete a persistent Candidatedetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICandidatedetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Candidatedetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Candidatedetails entity);

	/**
	 * Persist a previously saved Candidatedetails entity and return it or a
	 * copy of it to the sender. A copy of the Candidatedetails entity parameter
	 * is returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ICandidatedetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Candidatedetails entity to update
	 * @return Candidatedetails the persisted Candidatedetails entity instance,
	 *         may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Candidatedetails update(Candidatedetails entity);

	public Candidatedetails findById(Integer id);

	/**
	 * Find all Candidatedetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Candidatedetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Candidatedetails> found by query
	 */
	public List<Candidatedetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Candidatedetails> findByQuestions(Object questions,
			int... rowStartIdxAndCount);

	/**
	 * Find all Candidatedetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Candidatedetails> all Candidatedetails entities
	 */
	public List<Candidatedetails> findAll(int... rowStartIdxAndCount);
}