package com.ngs.dao;

import java.util.Date;
import java.util.List;

import com.ngs.entity.Candidatemaster;

/**
 * Interface for CandidatemasterDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface ICandidatemasterDAO {
	/**
	 * Perform an initial save of a previously unsaved Candidatemaster entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICandidatemasterDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Candidatemaster entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Candidatemaster entity);

	/**
	 * Delete a persistent Candidatemaster entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ICandidatemasterDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Candidatemaster entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Candidatemaster entity);

	/**
	 * Persist a previously saved Candidatemaster entity and return it or a copy
	 * of it to the sender. A copy of the Candidatemaster entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ICandidatemasterDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Candidatemaster entity to update
	 * @return Candidatemaster the persisted Candidatemaster entity instance,
	 *         may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Candidatemaster update(Candidatemaster entity);

	public Candidatemaster findById(Integer id);

	/**
	 * Find all Candidatemaster entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Candidatemaster property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Candidatemaster> found by query
	 */
	public List<Candidatemaster> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Candidatemaster> findByScheduleId(Object scheduleId,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByUsername(Object username,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByPassword(Object password,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByTypeOfUser(Object typeOfUser,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByFirstName(Object firstName,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByLastName(Object lastName,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findBySex(Object sex,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByDesignation(Object designation,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByClientId(Object clientId,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByEmail(Object email,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByExperience(Object experience,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByCentreOfRegistration(
			Object centreOfRegistration, int... rowStartIdxAndCount);

	public List<Candidatemaster> findByIsTableCreated(Object isTableCreated,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByHintQuestion(Object hintQuestion,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByHintAnswer(Object hintAnswer,
			int... rowStartIdxAndCount);

	public List<Candidatemaster> findByStatus(Object status,
			int... rowStartIdxAndCount);

	/**
	 * Find all Candidatemaster entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Candidatemaster> all Candidatemaster entities
	 */
	public List<Candidatemaster> findAll(int... rowStartIdxAndCount);
}