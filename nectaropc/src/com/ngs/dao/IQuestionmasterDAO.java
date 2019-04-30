package com.ngs.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.ngs.entity.Questionmaster;

/**
 * Interface for QuestionmasterDAO.
 * @author MyEclipse Persistence Tools
 */

public interface IQuestionmasterDAO {
		/**
	 Perform an initial save of a previously unsaved Questionmaster entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   IQuestionmasterDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Questionmaster entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Questionmaster entity);
    /**
	 Delete a persistent Questionmaster entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   IQuestionmasterDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Questionmaster entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Questionmaster entity);
   /**
	 Persist a previously saved Questionmaster entity and return it or a copy of it to the sender. 
	 A copy of the Questionmaster entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = IQuestionmasterDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Questionmaster entity to update
	 @return Questionmaster the persisted Questionmaster entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
	public Questionmaster update(Questionmaster entity);
	public Questionmaster findById( Integer id);
	 /**
	 * Find all Questionmaster entities with a specific property value.  
	 
	  @param propertyName the name of the Questionmaster property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Questionmaster> found by query
	 */
	public List<Questionmaster> findByProperty(String propertyName, Object value
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByCodeId(Object codeId
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByPartyId(Object partyId
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByQuestion(Object question
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByExamType(Object examType
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByNoOfOptions(Object noOfOptions
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByOption1(Object option1
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByOption2(Object option2
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByOption3(Object option3
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByOption4(Object option4
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByOption5(Object option5
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByAnswer(Object answer
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByNewAnswer(Object newAnswer
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByExplanation(Object explanation
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByLevelId(Object levelId
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByExamId(Object examId
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByStatus(Object status
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByImage(Object image
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByResonableTime(Object resonableTime
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByMarks(Object marks
			, int...rowStartIdxAndCount
		);
	public List<Questionmaster> findByRrn(Object rrn
			, int...rowStartIdxAndCount
		);
	/**
	 * Find all Questionmaster entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Questionmaster> all Questionmaster entities
	 */
	public List<Questionmaster> findAll(
			int...rowStartIdxAndCount
		);	
}