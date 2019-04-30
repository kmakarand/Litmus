package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Productmaster;

/**
 * Interface for ProductmasterDAO.
 * @author MyEclipse Persistence Tools
 */

public interface IProductmasterDAO {
		/**
	 Perform an initial save of a previously unsaved Productmaster entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   IProductmasterDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Productmaster entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Productmaster entity);
    /**
	 Delete a persistent Productmaster entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   IProductmasterDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Productmaster entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Productmaster entity);
   /**
	 Persist a previously saved Productmaster entity and return it or a copy of it to the sender. 
	 A copy of the Productmaster entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = IProductmasterDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Productmaster entity to update
	 @return Productmaster the persisted Productmaster entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
	public Productmaster update(Productmaster entity);
	public Productmaster findById( Integer id);
	 /**
	 * Find all Productmaster entities with a specific property value.  
	 
	  @param propertyName the name of the Productmaster property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Productmaster> found by query
	 */
	public List<Productmaster> findByProperty(String propertyName, Object value
			, int...rowStartIdxAndCount
		);
	public List<Productmaster> findByProductDesc(Object productDesc
			, int...rowStartIdxAndCount
		);
	/**
	 * Find all Productmaster entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Productmaster> all Productmaster entities
	 */
	public List<Productmaster> findAll(
			int...rowStartIdxAndCount
		);	
}