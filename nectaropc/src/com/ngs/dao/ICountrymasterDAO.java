package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Countrymaster;

/**
 * Interface for CountrymasterDAO.
 * @author MyEclipse Persistence Tools
 */

public interface ICountrymasterDAO {
		/**
	 Perform an initial save of a previously unsaved Countrymaster entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   ICountrymasterDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Countrymaster entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Countrymaster entity);
    /**
	 Delete a persistent Countrymaster entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   ICountrymasterDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Countrymaster entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Countrymaster entity);
   /**
	 Persist a previously saved Countrymaster entity and return it or a copy of it to the sender. 
	 A copy of the Countrymaster entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = ICountrymasterDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Countrymaster entity to update
	 @return Countrymaster the persisted Countrymaster entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
	public Countrymaster update(Countrymaster entity);
	public Countrymaster findById( String id);
	 /**
	 * Find all Countrymaster entities with a specific property value.  
	 
	  @param propertyName the name of the Countrymaster property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Countrymaster> found by query
	 */
	public List<Countrymaster> findByProperty(String propertyName, Object value
			, int...rowStartIdxAndCount
		);
	public List<Countrymaster> findByName(Object name
			, int...rowStartIdxAndCount
		);
	/**
	 * Find all Countrymaster entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Countrymaster> all Countrymaster entities
	 */
	public List<Countrymaster> findAll(
			int...rowStartIdxAndCount
		);	
}