package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Productdetails;

/**
 * Interface for ProductdetailsDAO.
 * @author MyEclipse Persistence Tools
 */

public interface IProductdetailsDAO {
		/**
	 Perform an initial save of a previously unsaved Productdetails entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   IProductdetailsDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Productdetails entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Productdetails entity);
    /**
	 Delete a persistent Productdetails entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   IProductdetailsDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Productdetails entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Productdetails entity);
   /**
	 Persist a previously saved Productdetails entity and return it or a copy of it to the sender. 
	 A copy of the Productdetails entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = IProductdetailsDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Productdetails entity to update
	 @return Productdetails the persisted Productdetails entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
	public Productdetails update(Productdetails entity);
	public Productdetails findById( Integer id);
	 /**
	 * Find all Productdetails entities with a specific property value.  
	 
	  @param propertyName the name of the Productdetails property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Productdetails> found by query
	 */
	public List<Productdetails> findByProperty(String propertyName, Object value
			, int...rowStartIdxAndCount
		);
	public List<Productdetails> findByPmId(Object pmId
			, int...rowStartIdxAndCount
		);
	public List<Productdetails> findByProductDesc(Object productDesc
			, int...rowStartIdxAndCount
		);
	public List<Productdetails> findByQuantity(Object quantity
			, int...rowStartIdxAndCount
		);
	public List<Productdetails> findByScale(Object scale
			, int...rowStartIdxAndCount
		);
	public List<Productdetails> findByUnitPrice(Object unitPrice
			, int...rowStartIdxAndCount
		);
	public List<Productdetails> findByTotalPrice(Object totalPrice
			, int...rowStartIdxAndCount
		);
	public List<Productdetails> findByPurchaseCost(Object purchaseCost
			, int...rowStartIdxAndCount
		);
	public List<Productdetails> findByRentalCost(Object rentalCost
			, int...rowStartIdxAndCount
		);
	/**
	 * Find all Productdetails entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Productdetails> all Productdetails entities
	 */
	public List<Productdetails> findAll(
			int...rowStartIdxAndCount
		);	
}