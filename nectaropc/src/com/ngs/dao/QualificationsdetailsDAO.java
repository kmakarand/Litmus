package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Qualificationsdetails;
import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 	* A data access object (DAO) providing persistence and search support for Qualificationsdetails entities.
 	 		* Transaction control of the save(), update() and delete() operations must be handled externally by senders of these methods 
 		  or must be manually added to each of these methods for data to be persisted to the JPA datastore.	
 	 * @see com.ngs.entity.Qualificationsdetails
  * @author MyEclipse Persistence Tools 
 */

public class QualificationsdetailsDAO  implements IQualificationsdetailsDAO{
	//property constants





	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}	
	
		/**
	 Perform an initial save of a previously unsaved Qualificationsdetails entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   QualificationsdetailsDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Qualificationsdetails entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Qualificationsdetails entity) {
    				EntityManagerHelper.log("saving Qualificationsdetails instance", Level.INFO, null);
	        try {
            getEntityManager().persist(entity);
            			EntityManagerHelper.log("save successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("save failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    /**
	 Delete a persistent Qualificationsdetails entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   QualificationsdetailsDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Qualificationsdetails entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Qualificationsdetails entity) {
    				EntityManagerHelper.log("deleting Qualificationsdetails instance", Level.INFO, null);
	        try {
        	entity = getEntityManager().getReference(Qualificationsdetails.class, entity.getQualificationId());
            getEntityManager().remove(entity);
            			EntityManagerHelper.log("delete successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("delete failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    /**
	 Persist a previously saved Qualificationsdetails entity and return it or a copy of it to the sender. 
	 A copy of the Qualificationsdetails entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = QualificationsdetailsDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Qualificationsdetails entity to update
	 @return Qualificationsdetails the persisted Qualificationsdetails entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
    public Qualificationsdetails update(Qualificationsdetails entity) {
    				EntityManagerHelper.log("updating Qualificationsdetails instance", Level.INFO, null);
	        try {
            Qualificationsdetails result = getEntityManager().merge(entity);
            			EntityManagerHelper.log("update successful", Level.INFO, null);
	            return result;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("update failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    public Qualificationsdetails findById( Integer id) {
    				EntityManagerHelper.log("finding Qualificationsdetails instance with id: " + id, Level.INFO, null);
	        try {
            Qualificationsdetails instance = getEntityManager().find(Qualificationsdetails.class, id);
            return instance;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("find failed", Level.SEVERE, re);
	            throw re;
        }
    }    
    

/**
	 * Find all Qualificationsdetails entities with a specific property value.  
	 
	  @param propertyName the name of the Qualificationsdetails property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum number of results to return.  
	  	  @return List<Qualificationsdetails> found by query
	 */
    @SuppressWarnings("unchecked")
    public List<Qualificationsdetails> findByProperty(String propertyName, final Object value
        , final int...rowStartIdxAndCount
        ) {
    				EntityManagerHelper.log("finding Qualificationsdetails instance with property: " + propertyName + ", value: " + value, Level.INFO, null);
			try {
			final String queryString = "select model from Qualificationsdetails model where model." 
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
	
	/**
	 * Find all Qualificationsdetails entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Qualificationsdetails> all Qualificationsdetails entities
	 */
	@SuppressWarnings("unchecked")
	public List<Qualificationsdetails> findAll(
		final int...rowStartIdxAndCount
		) {
					EntityManagerHelper.log("finding all Qualificationsdetails instances", Level.INFO, null);
			try {
			final String queryString = "select model from Qualificationsdetails model";
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