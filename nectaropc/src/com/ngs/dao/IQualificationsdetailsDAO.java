package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Qualificationsdetails;

/**
 * Interface for QualificationsdetailsDAO.
 * @author MyEclipse Persistence Tools
 */

public interface IQualificationsdetailsDAO {
		/**
	 Perform an initial save of a previously unsaved Qualificationsdetails entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   IQualificationsdetailsDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Qualificationsdetails entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Qualificationsdetails entity);
    /**
	 Delete a persistent Qualificationsdetails entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   IQualificationsdetailsDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Qualificationsdetails entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Qualificationsdetails entity);
   /**
	 Persist a previously saved Qualificationsdetails entity and return it or a copy of it to the sender. 
	 A copy of the Qualificationsdetails entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = IQualificationsdetailsDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Qualificationsdetails entity to update
	 @return Qualificationsdetails the persisted Qualificationsdetails entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
	public Qualificationsdetails update(Qualificationsdetails entity);
	public Qualificationsdetails findById( Integer id);
	 /**
	 * Find all Qualificationsdetails entities with a specific property value.  
	 
	  @param propertyName the name of the Qualificationsdetails property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Qualificationsdetails> found by query
	 */
	public List<Qualificationsdetails> findByProperty(String propertyName, Object value
			, int...rowStartIdxAndCount
		);
	/**
	 * Find all Qualificationsdetails entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Qualificationsdetails> all Qualificationsdetails entities
	 */
	public List<Qualificationsdetails> findAll(
			int...rowStartIdxAndCount
		);	
}