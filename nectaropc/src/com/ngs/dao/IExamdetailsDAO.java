package com.ngs.dao;

import java.util.Date;
import java.util.List;

import com.ngs.entity.Examdetails;

/**
 * Interface for ExamdetailsDAO.
 * @author MyEclipse Persistence Tools
 */

public interface IExamdetailsDAO {
		/**
	 Perform an initial save of a previously unsaved Examdetails entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   IExamdetailsDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Examdetails entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Examdetails entity);
    /**
	 Delete a persistent Examdetails entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   IExamdetailsDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Examdetails entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Examdetails entity);
   /**
	 Persist a previously saved Examdetails entity and return it or a copy of it to the sender. 
	 A copy of the Examdetails entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = IExamdetailsDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Examdetails entity to update
	 @return Examdetails the persisted Examdetails entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
	public Examdetails update(Examdetails entity);
	public Examdetails findById( Integer id);
	 /**
	 * Find all Examdetails entities with a specific property value.  
	 
	  @param propertyName the name of the Examdetails property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Examdetails> found by query
	 */
	public List<Examdetails> findByProperty(String propertyName, Object value
			, int...rowStartIdxAndCount
		);
	public List<Examdetails> findByClientId(Object clientId
			, int...rowStartIdxAndCount
		);
	/**
	 * Find all Examdetails entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Examdetails> all Examdetails entities
	 */
	public List<Examdetails> findAll(
			int...rowStartIdxAndCount
		);	
}