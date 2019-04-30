package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Newperformancemaster;

import java.sql.Time;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 	* A data access object (DAO) providing persistence and search support for Newperformancemaster entities.
 	 		* Transaction control of the save(), update() and delete() operations must be handled externally by senders of these methods 
 		  or must be manually added to each of these methods for data to be persisted to the JPA datastore.	
 	 * @see com.ngs.entity.Newperformancemaster
  * @author MyEclipse Persistence Tools 
 */

public class NewperformancemasterDAO  implements INewperformancemasterDAO{
	//property constants
	public static final String CANDIDATE_ID = "candidateId";
	public static final String SECTION_ID = "sectionId";
	public static final String CODE_GROUP_ID = "codeGroupId";
	public static final String EXAM_ID = "examId";
	public static final String TOTAL_QUESTIONS = "totalQuestions";
	public static final String NO_OF_WRONG = "noOfWrong";
	public static final String NO_OF_CORRECT = "noOfCorrect";
	public static final String SCORE = "score";
	public static final String RESULT = "result";
	public static final String ATTEMPT_NO = "attemptNo";





	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}	
	
		/**
	 Perform an initial save of a previously unsaved Newperformancemaster entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   NewperformancemasterDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Newperformancemaster entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Newperformancemaster entity) {
    				EntityManagerHelper.log("saving Newperformancemaster instance", Level.INFO, null);
	        try {
            getEntityManager().persist(entity);
            			EntityManagerHelper.log("save successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("save failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    /**
	 Delete a persistent Newperformancemaster entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   NewperformancemasterDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Newperformancemaster entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Newperformancemaster entity) {
    				EntityManagerHelper.log("deleting Newperformancemaster instance", Level.INFO, null);
	        try {
        	entity = getEntityManager().getReference(Newperformancemaster.class, entity.getHistoryId());
            getEntityManager().remove(entity);
            			EntityManagerHelper.log("delete successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("delete failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    /**
	 Persist a previously saved Newperformancemaster entity and return it or a copy of it to the sender. 
	 A copy of the Newperformancemaster entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = NewperformancemasterDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Newperformancemaster entity to update
	 @return Newperformancemaster the persisted Newperformancemaster entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
    public Newperformancemaster update(Newperformancemaster entity) {
    				EntityManagerHelper.log("updating Newperformancemaster instance", Level.INFO, null);
	        try {
            Newperformancemaster result = getEntityManager().merge(entity);
            			EntityManagerHelper.log("update successful", Level.INFO, null);
	            return result;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("update failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    public Newperformancemaster findById( Integer id) {
    				EntityManagerHelper.log("finding Newperformancemaster instance with id: " + id, Level.INFO, null);
	        try {
            Newperformancemaster instance = getEntityManager().find(Newperformancemaster.class, id);
            return instance;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("find failed", Level.SEVERE, re);
	            throw re;
        }
    }    
    
    public Newperformancemaster findByCandidateId( Integer candidateId) {
		EntityManagerHelper.log("finding Newperformancemaster instance with id: " + candidateId, Level.INFO, null);
		try {
			Newperformancemaster instance = getEntityManager().find(Newperformancemaster.class, candidateId);
		return instance;
		} catch (RuntimeException re) {
					EntityManagerHelper.log("find failed", Level.SEVERE, re);
		    throw re;
		}
		}    

/**
	 * Find all Newperformancemaster entities with a specific property value.  
	 
	  @param propertyName the name of the Newperformancemaster property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum number of results to return.  
	  	  @return List<Newperformancemaster> found by query
	 */
    @SuppressWarnings("unchecked")
    public List<Newperformancemaster> findByProperty(String propertyName, final Object value
        , final int...rowStartIdxAndCount
        ) {
    				EntityManagerHelper.log("finding Newperformancemaster instance with property: " + propertyName + ", value: " + value, Level.INFO, null);
			try {
			final String queryString = "select model from Newperformancemaster model where model." 
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
		
	public List<Newperformancemaster> findBySectionId(Object sectionId
	, int...rowStartIdxAndCount
	) {
		return findByProperty(SECTION_ID, sectionId
	, rowStartIdxAndCount
		);
	}
	
	public List<Newperformancemaster> findByCodeGroupId(Object codeGroupId
	, int...rowStartIdxAndCount
	) {
		return findByProperty(CODE_GROUP_ID, codeGroupId
	, rowStartIdxAndCount
		);
	}
	
	public List<Newperformancemaster> findByExamId(Object examId
	, int...rowStartIdxAndCount
	) {
		return findByProperty(EXAM_ID, examId
	, rowStartIdxAndCount
		);
	}
	
	public List<Newperformancemaster> findByTotalQuestions(Object totalQuestions
	, int...rowStartIdxAndCount
	) {
		return findByProperty(TOTAL_QUESTIONS, totalQuestions
	, rowStartIdxAndCount
		);
	}
	
	public List<Newperformancemaster> findByNoOfWrong(Object noOfWrong
	, int...rowStartIdxAndCount
	) {
		return findByProperty(NO_OF_WRONG, noOfWrong
	, rowStartIdxAndCount
		);
	}
	
	public List<Newperformancemaster> findByNoOfCorrect(Object noOfCorrect
	, int...rowStartIdxAndCount
	) {
		return findByProperty(NO_OF_CORRECT, noOfCorrect
	, rowStartIdxAndCount
		);
	}
	
	public List<Newperformancemaster> findByScore(Object score
	, int...rowStartIdxAndCount
	) {
		return findByProperty(SCORE, score
	, rowStartIdxAndCount
		);
	}
	
	public List<Newperformancemaster> findByResult(Object result
	, int...rowStartIdxAndCount
	) {
		return findByProperty(RESULT, result
	, rowStartIdxAndCount
		);
	}
	
	public List<Newperformancemaster> findByAttemptNo(Object attemptNo
	, int...rowStartIdxAndCount
	) {
		return findByProperty(ATTEMPT_NO, attemptNo
	, rowStartIdxAndCount
		);
	}
	
	
	/**
	 * Find all Newperformancemaster entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Newperformancemaster> all Newperformancemaster entities
	 */
	@SuppressWarnings("unchecked")
	public List<Newperformancemaster> findAll(
		final int...rowStartIdxAndCount
		) {
					EntityManagerHelper.log("finding all Newperformancemaster instances", Level.INFO, null);
			try {
			final String queryString = "select model from Newperformancemaster model";
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