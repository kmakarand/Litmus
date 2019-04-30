package com.ngs.dao;

import java.util.Date;
import java.util.List;

import com.ngs.entity.Exammaster;

/**
 * Interface for ExammasterDAO.
 * @author MyEclipse Persistence Tools
 */

public interface IExammasterDAO {
		/**
	 Perform an initial save of a previously unsaved Exammaster entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   IExammasterDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Exammaster entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public boolean save(Exammaster entity);
    /**
	 Delete a persistent Exammaster entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   IExammasterDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Exammaster entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Exammaster entity);
   /**
	 Persist a previously saved Exammaster entity and return it or a copy of it to the sender. 
	 A copy of the Exammaster entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = IExammasterDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Exammaster entity to update
	 @return Exammaster the persisted Exammaster entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
	public Exammaster update(Exammaster entity);
	public Exammaster findById( Integer id);
	 /**
	 * Find all Exammaster entities with a specific property value.  
	 
	  @param propertyName the name of the Exammaster property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Exammaster> found by query
	 */
	public List<Exammaster> findByProperty(String propertyName, Object value
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByModeratorId(Object moderatorId
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByExam(Object exam
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByExamMode(Object examMode
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByConductedBy(Object conductedBy
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByCentre(Object centre
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByCountry(Object country
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByFrequency(Object frequency
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByShowResults(Object showResults
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByDisplayTests(Object displayTests
			, int...rowStartIdxAndCount
		);
	public List<Exammaster> findByRegistrationFee(Object registrationFee
			, int...rowStartIdxAndCount
		);
	/**
	 * Find all Exammaster entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Exammaster> all Exammaster entities
	 */
	public List<Exammaster> findAll(
			int...rowStartIdxAndCount
		);	
}