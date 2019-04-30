package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Productdetails;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 	* A data access object (DAO) providing persistence and search support for Productdetails entities.
 	 		* Transaction control of the save(), update() and delete() operations must be handled externally by senders of these methods 
 		  or must be manually added to each of these methods for data to be persisted to the JPA datastore.	
 	 * @see com.ngs.entity.Productdetails
  * @author MyEclipse Persistence Tools 
 */

public class ProductdetailsDAO  implements IProductdetailsDAO{
	//property constants
	public static final String PM_ID = "pmId";
	public static final String PRODUCT_DESC = "productDesc";
	public static final String QUANTITY = "quantity";
	public static final String SCALE = "scale";
	public static final String UNIT_PRICE = "unitPrice";
	public static final String TOTAL_PRICE = "totalPrice";
	public static final String PURCHASE_COST = "purchaseCost";
	public static final String RENTAL_COST = "rentalCost";





	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}	
	
		/**
	 Perform an initial save of a previously unsaved Productdetails entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   ProductdetailsDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Productdetails entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Productdetails entity) {
    				EntityManagerHelper.log("saving Productdetails instance", Level.INFO, null);
	        try {
            getEntityManager().persist(entity);
            			EntityManagerHelper.log("save successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("save failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    /**
	 Delete a persistent Productdetails entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   ProductdetailsDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Productdetails entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Productdetails entity) {
    				EntityManagerHelper.log("deleting Productdetails instance", Level.INFO, null);
	        try {
        	entity = getEntityManager().getReference(Productdetails.class, entity.getPdId());
            getEntityManager().remove(entity);
            			EntityManagerHelper.log("delete successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("delete failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    /**
	 Persist a previously saved Productdetails entity and return it or a copy of it to the sender. 
	 A copy of the Productdetails entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = ProductdetailsDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Productdetails entity to update
	 @return Productdetails the persisted Productdetails entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
    public Productdetails update(Productdetails entity) {
    				EntityManagerHelper.log("updating Productdetails instance", Level.INFO, null);
	        try {
            Productdetails result = getEntityManager().merge(entity);
            			EntityManagerHelper.log("update successful", Level.INFO, null);
	            return result;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("update failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    public Productdetails findById( Integer id) {
    				EntityManagerHelper.log("finding Productdetails instance with id: " + id, Level.INFO, null);
	        try {
            Productdetails instance = getEntityManager().find(Productdetails.class, id);
            return instance;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("find failed", Level.SEVERE, re);
	            throw re;
        }
    }    
    

/**
	 * Find all Productdetails entities with a specific property value.  
	 
	  @param propertyName the name of the Productdetails property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum number of results to return.  
	  	  @return List<Productdetails> found by query
	 */
    @SuppressWarnings("unchecked")
    public List<Productdetails> findByProperty(String propertyName, final Object value
        , final int...rowStartIdxAndCount
        ) {
    				EntityManagerHelper.log("finding Productdetails instance with property: " + propertyName + ", value: " + value, Level.INFO, null);
			try {
			final String queryString = "select model from Productdetails model where model." 
			 						+ propertyName + "= :propertyValue";
								Query query = getEntityManager().createQuery(queryString);
					query.setParameter("propertyValue", value);
					if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {	
						int rowStartIdx = Math.max(0,rowStartIdxAndCount[0]);
						if (rowStartIdx > 0) {
							query.setFirstResult(rowStartIdx);
						}
		
						if (rowStartIdxAndCount.length > 1) {
					    	int rowCount = Math.max(0,rowStartIdxAndCount[1]);
					    	if (rowCount > 0) {
					    		query.setMaxResults(rowCount);    
					    	}
						}
					}										
					return query.getResultList();
		} catch (RuntimeException re) {
						EntityManagerHelper.log("find by property name failed", Level.SEVERE, re);
				throw re;
		}
	}			
	public List<Productdetails> findByPmId(Object pmId
	, int...rowStartIdxAndCount
	) {
		return findByProperty(PM_ID, pmId
	, rowStartIdxAndCount
		);
	}
	
	public List<Productdetails> findByProductDesc(Object productDesc
	, int...rowStartIdxAndCount
	) {
		return findByProperty(PRODUCT_DESC, productDesc
	, rowStartIdxAndCount
		);
	}
	
	public List<Productdetails> findByQuantity(Object quantity
	, int...rowStartIdxAndCount
	) {
		return findByProperty(QUANTITY, quantity
	, rowStartIdxAndCount
		);
	}
	
	public List<Productdetails> findByScale(Object scale
	, int...rowStartIdxAndCount
	) {
		return findByProperty(SCALE, scale
	, rowStartIdxAndCount
		);
	}
	
	public List<Productdetails> findByUnitPrice(Object unitPrice
	, int...rowStartIdxAndCount
	) {
		return findByProperty(UNIT_PRICE, unitPrice
	, rowStartIdxAndCount
		);
	}
	
	public List<Productdetails> findByTotalPrice(Object totalPrice
	, int...rowStartIdxAndCount
	) {
		return findByProperty(TOTAL_PRICE, totalPrice
	, rowStartIdxAndCount
		);
	}
	
	public List<Productdetails> findByPurchaseCost(Object purchaseCost
	, int...rowStartIdxAndCount
	) {
		return findByProperty(PURCHASE_COST, purchaseCost
	, rowStartIdxAndCount
		);
	}
	
	public List<Productdetails> findByRentalCost(Object rentalCost
	, int...rowStartIdxAndCount
	) {
		return findByProperty(RENTAL_COST, rentalCost
	, rowStartIdxAndCount
		);
	}
	
	
	/**
	 * Find all Productdetails entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Productdetails> all Productdetails entities
	 */
	@SuppressWarnings("unchecked")
	public List<Productdetails> findAll(
		final int...rowStartIdxAndCount
		) {
					EntityManagerHelper.log("finding all Productdetails instances", Level.INFO, null);
			try {
			final String queryString = "select model from Productdetails model";
								Query query = getEntityManager().createQuery(queryString);
					if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {	
						int rowStartIdx = Math.max(0,rowStartIdxAndCount[0]);
						if (rowStartIdx > 0) {
							query.setFirstResult(rowStartIdx);
						}
		
						if (rowStartIdxAndCount.length > 1) {
					    	int rowCount = Math.max(0,rowStartIdxAndCount[1]);
					    	if (rowCount > 0) {
					    		query.setMaxResults(rowCount);    
					    	}
						}
					}										
					return query.getResultList();
		} catch (RuntimeException re) {
						EntityManagerHelper.log("find all failed", Level.SEVERE, re);
				throw re;
		}
	}
	
}