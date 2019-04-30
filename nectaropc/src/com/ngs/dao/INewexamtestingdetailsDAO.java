package com.ngs.dao;

import java.sql.Time;
import java.util.Date;
import java.util.List;

import com.ngs.entity.Newexamtestingdetails;

/**
 * Interface for NewexamtestingdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface INewexamtestingdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Newexamtestingdetails
	 * entity. All subsequent persist actions of this entity should use the
	 * #update() method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * INewexamtestingdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newexamtestingdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Newexamtestingdetails entity);

	/**
	 * Delete a persistent Newexamtestingdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * INewexamtestingdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Newexamtestingdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Newexamtestingdetails entity);

	/**
	 * Persist a previously saved Newexamtestingdetails entity and return it or
	 * a copy of it to the sender. A copy of the Newexamtestingdetails entity
	 * parameter is returned when the JPA persistence mechanism has not
	 * previously been tracking the updated entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently saved to the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#merge(Object)
	 * EntityManager#merge} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = INewexamtestingdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newexamtestingdetails entity to update
	 * @return Newexamtestingdetails the persisted Newexamtestingdetails entity
	 *         instance, may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Newexamtestingdetails update(Newexamtestingdetails entity);

	public Newexamtestingdetails findById(Integer id);

	/**
	 * Find all Newexamtestingdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Newexamtestingdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Newexamtestingdetails> found by query
	 */
	public List<Newexamtestingdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findBySectionId(Object sectionId,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByCodeId(Object codeId,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByCodeGroupId(Object codeGroupId,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByExamId(Object examId,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByCandidateId(Object candidateId,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByQuestionId(Object questionId,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByAnswer(Object answer,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByAnswerStatus(Object answerStatus,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByTimeTaken(Object timeTaken,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByAttemptNo(Object attemptNo,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findByBookMark(Object bookMark,
			int... rowStartIdxAndCount);

	public List<Newexamtestingdetails> findBySequenceNo(Object sequenceNo,
			int... rowStartIdxAndCount);

	/**
	 * Find all Newexamtestingdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Newexamtestingdetails> all Newexamtestingdetails entities
	 */
	public List<Newexamtestingdetails> findAll(int... rowStartIdxAndCount);
}