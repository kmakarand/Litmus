package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Qualificationmaster;
import com.ngs.entity.QualificationmasterId;

/**
 * Interface for QualificationmasterDAO.
 * @author MyEclipse Persistence Tools
 */

public interface IQualificationmasterDAO {
		/**
	 Perform an initial save of a previously unsaved Qualificationmaster entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   IQualificationmasterDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Qualificationmaster entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Qualificationmaster entity);
    /**
	 Delete a persistent Qualificationmaster entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   IQualificationmasterDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Qualificationmaster entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Qualificationmaster entity);
   /**
	 Persist a previously saved Qualificationmaster entity and return it or a copy of it to the sender. 
	 A copy of the Qualificationmaster entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = IQualificationmasterDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Qualificationmaster entity to update
	 @return Qualificationmaster the persisted Qualificationmaster entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
	public Qualificationmaster update(Qualificationmaster entity);
	public Qualificationmaster findById( QualificationmasterId id);
	 /**
	 * Find all Qualificationmaster entities with a specific property value.  
	 
	  @param propertyName the name of the Qualificationmaster property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Qualificationmaster> found by query
	 */
	public List<Qualificationmaster> findByProperty(String propertyName, Object value
			, int...rowStartIdxAndCount
		);
	/**
	 * Find all Qualificationmaster entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Qualificationmaster> all Qualificationmaster entities
	 */
	public List<Qualificationmaster> findAll(
			int...rowStartIdxAndCount
		);	
}