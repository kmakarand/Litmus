package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Exammaster;

import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 	* A data access object (DAO) providing persistence and search support for Exammaster entities.
 	 		* Transaction control of the save(), update() and delete() operations must be handled externally by senders of these methods 
 		  or must be manually added to each of these methods for data to be persisted to the JPA datastore.	
 	 * @see com.ngs.entity.Exammaster
  * @author MyEclipse Persistence Tools 
 */

public class ExammasterDAO  implements IExammasterDAO{
	//property constants
	public static final String MODERATOR_ID = "moderatorId";
	public static final String EXAM = "exam";
	public static final String EXAM_MODE = "examMode";
	public static final String CONDUCTED_BY = "conductedBy";
	public static final String CENTRE = "centre";
	public static final String COUNTRY = "country";
	public static final String FREQUENCY = "frequency";
	public static final String SHOW_RESULTS = "showResults";
	public static final String DISPLAY_TESTS = "displayTests";
	public static final String REGISTRATION_FEE = "registrationFee";





	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}	
	
		/**
	 Perform an initial save of a previously unsaved Exammaster entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   ExammasterDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Exammaster entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public boolean save(Exammaster entity) {
    				EntityManagerHelper.log("saving Exammaster instance", Level.INFO, null);
	        try {
            getEntityManager().persist(entity);
            			EntityManagerHelper.log("save successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("save failed", Level.SEVERE, re);
	            throw re;
        }
	    
	   return true;
    }
    
    /**
	 Delete a persistent Exammaster entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   ExammasterDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Exammaster entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Exammaster entity) {
    				EntityManagerHelper.log("deleting Exammaster instance", Level.INFO, null);
	        try {
        	entity = getEntityManager().getReference(Exammaster.class, entity.getExamId());
            getEntityManager().remove(entity);
            			EntityManagerHelper.log("delete successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("delete failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    /**
	 Persist a previously saved Exammaster entity and return it or a copy of it to the sender. 
	 A copy of the Exammaster entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = ExammasterDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Exammaster entity to update
	 @return Exammaster the persisted Exammaster entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
    public Exammaster update(Exammaster entity) {
    				EntityManagerHelper.log("updating Exammaster instance", Level.INFO, null);
	        try {
            Exammaster result = getEntityManager().merge(entity);
            			EntityManagerHelper.log("update successful", Level.INFO, null);
	            return result;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("update failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    public Exammaster findById( Integer id) {
    				EntityManagerHelper.log("finding Exammaster instance with id: " + id, Level.INFO, null);
	        try {
            Exammaster instance = getEntityManager().find(Exammaster.class, id);
            return instance;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("find failed", Level.SEVERE, re);
	            throw re;
        }
    }    
    

/**
	 * Find all Exammaster entities with a specific property value.  
	 
	  @param propertyName the name of the Exammaster property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum number of results to return.  
	  	  @return List<Exammaster> found by query
	 */
    @SuppressWarnings("unchecked")
    public List<Exammaster> findByProperty(String propertyName, final Object value
        , final int...rowStartIdxAndCount
        ) {
    				EntityManagerHelper.log("finding Exammaster instance with property: " + propertyName + ", value: " + value, Level.INFO, null);
			try {
			final String queryString = "select model from Exammaster model where model." 
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
	public List<Exammaster> findByModeratorId(Object moderatorId
	, int...rowStartIdxAndCount
	) {
		return findByProperty(MODERATOR_ID, moderatorId
	, rowStartIdxAndCount
		);
	}
	
	public List<Exammaster> findByExam(Object exam
	, int...rowStartIdxAndCount
	) {
		return findByProperty(EXAM, exam
	, rowStartIdxAndCount
		);
	}
	
	public List<Exammaster> findByExamMode(Object examMode
	, int...rowStartIdxAndCount
	) {
		return findByProperty(EXAM_MODE, examMode
	, rowStartIdxAndCount
		);
	}
	
	public List<Exammaster> findByConductedBy(Object conductedBy
	, int...rowStartIdxAndCount
	) {
		return findByProperty(CONDUCTED_BY, conductedBy
	, rowStartIdxAndCount
		);
	}
	
	public List<Exammaster> findByCentre(Object centre
	, int...rowStartIdxAndCount
	) {
		return findByProperty(CENTRE, centre
	, rowStartIdxAndCount
		);
	}
	
	public List<Exammaster> findByCountry(Object country
	, int...rowStartIdxAndCount
	) {
		return findByProperty(COUNTRY, country
	, rowStartIdxAndCount
		);
	}
	
	public List<Exammaster> findByFrequency(Object frequency
	, int...rowStartIdxAndCount
	) {
		return findByProperty(FREQUENCY, frequency
	, rowStartIdxAndCount
		);
	}
	
	public List<Exammaster> findByShowResults(Object showResults
	, int...rowStartIdxAndCount
	) {
		return findByProperty(SHOW_RESULTS, showResults
	, rowStartIdxAndCount
		);
	}
	
	public List<Exammaster> findByDisplayTests(Object displayTests
	, int...rowStartIdxAndCount
	) {
		return findByProperty(DISPLAY_TESTS, displayTests
	, rowStartIdxAndCount
		);
	}
	
	public List<Exammaster> findByRegistrationFee(Object registrationFee
	, int...rowStartIdxAndCount
	) {
		return findByProperty(REGISTRATION_FEE, registrationFee
	, rowStartIdxAndCount
		);
	}
	
	
	/**
	 * Find all Exammaster entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Exammaster> all Exammaster entities
	 */
	@SuppressWarnings("unchecked")
	public List<Exammaster> findAll(
		final int...rowStartIdxAndCount
		) {
					EntityManagerHelper.log("finding all Exammaster instances", Level.INFO, null);
			try {
			final String queryString = "select model from Exammaster model";
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