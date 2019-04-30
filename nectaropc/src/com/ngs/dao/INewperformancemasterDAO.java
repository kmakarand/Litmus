package com.ngs.dao;

import java.sql.Time;
import java.util.Date;
import java.util.List;

import com.ngs.entity.Newperformancemaster;

/**
 * Interface for NewperformancemasterDAO.
 * @author MyEclipse Persistence Tools
 */

public interface INewperformancemasterDAO {
		/**
	 Perform an initial save of a previously unsaved Newperformancemaster entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   INewperformancemasterDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Newperformancemaster entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Newperformancemaster entity);
    /**
	 Delete a persistent Newperformancemaster entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   INewperformancemasterDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Newperformancemaster entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Newperformancemaster entity);
   /**
	 Persist a previously saved Newperformancemaster entity and return it or a copy of it to the sender. 
	 A copy of the Newperformancemaster entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = INewperformancemasterDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Newperformancemaster entity to update
	 @return Newperformancemaster the persisted Newperformancemaster entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
	public Newperformancemaster update(Newperformancemaster entity);
	public Newperformancemaster findById( Integer id);
	public Newperformancemaster findByCandidateId( Integer id);
	 /**
	 * Find all Newperformancemaster entities with a specific property value.  
	 
	  @param propertyName the name of the Newperformancemaster property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Newperformancemaster> found by query
	 */
	public List<Newperformancemaster> findByProperty(String propertyName, Object value
			, int...rowStartIdxAndCount
		);
	
	public List<Newperformancemaster> findBySectionId(Object sectionId
			, int...rowStartIdxAndCount
		);
	public List<Newperformancemaster> findByCodeGroupId(Object codeGroupId
			, int...rowStartIdxAndCount
		);
	public List<Newperformancemaster> findByExamId(Object examId
			, int...rowStartIdxAndCount
		);
	public List<Newperformancemaster> findByTotalQuestions(Object totalQuestions
			, int...rowStartIdxAndCount
		);
	public List<Newperformancemaster> findByNoOfWrong(Object noOfWrong
			, int...rowStartIdxAndCount
		);
	public List<Newperformancemaster> findByNoOfCorrect(Object noOfCorrect
			, int...rowStartIdxAndCount
		);
	public List<Newperformancemaster> findByScore(Object score
			, int...rowStartIdxAndCount
		);
	public List<Newperformancemaster> findByResult(Object result
			, int...rowStartIdxAndCount
		);
	public List<Newperformancemaster> findByAttemptNo(Object attemptNo
			, int...rowStartIdxAndCount
		);
	/**
	 * Find all Newperformancemaster entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Newperformancemaster> all Newperformancemaster entities
	 */
	public List<Newperformancemaster> findAll(
			int...rowStartIdxAndCount
		);	
}