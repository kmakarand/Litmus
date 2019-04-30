package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Questionmaster;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 	* A data access object (DAO) providing persistence and search support for Questionmaster entities.
 	 		* Transaction control of the save(), update() and delete() operations must be handled externally by senders of these methods 
 		  or must be manually added to each of these methods for data to be persisted to the JPA datastore.	
 	 * @see com.ngs.entity.Questionmaster
  * @author MyEclipse Persistence Tools 
 */

public class QuestionmasterDAO  implements IQuestionmasterDAO{
	//property constants
	public static final String CODE_ID = "codeId";
	public static final String PARTY_ID = "partyId";
	public static final String QUESTION = "question";
	public static final String EXAM_TYPE = "examType";
	public static final String NO_OF_OPTIONS = "noOfOptions";
	public static final String OPTION1 = "option1";
	public static final String OPTION2 = "option2";
	public static final String OPTION3 = "option3";
	public static final String OPTION4 = "option4";
	public static final String OPTION5 = "option5";
	public static final String ANSWER = "answer";
	public static final String NEW_ANSWER = "newAnswer";
	public static final String EXPLANATION = "explanation";
	public static final String LEVEL_ID = "levelId";
	public static final String EXAM_ID = "examId";
	public static final String STATUS = "status";
	public static final String IMAGE = "image";
	public static final String RESONABLE_TIME = "resonableTime";
	public static final String MARKS = "marks";
	public static final String RRN = "rrn";





	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}	
	
		/**
	 Perform an initial save of a previously unsaved Questionmaster entity. 
	 All subsequent persist actions of this entity should use the #update() method.
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#persist(Object) EntityManager#persist} operation.
	 	 
	 * <pre> 
	 *   EntityManagerHelper.beginTransaction();
	 *   QuestionmasterDAO.save(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Questionmaster entity to persist
	  @throws RuntimeException when the operation fails
	 */
    public void save(Questionmaster entity) {
    				EntityManagerHelper.log("saving Questionmaster instance", Level.INFO, null);
	        try {
            getEntityManager().persist(entity);
            			EntityManagerHelper.log("save successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("save failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    /**
	 Delete a persistent Questionmaster entity.
	  This operation must be performed 
	 within the a database transaction context for the entity's data to be
	 permanently deleted from the persistence store, i.e., database. 
	 This method uses the {@link javax.persistence.EntityManager#remove(Object) EntityManager#delete} operation.
	 	  
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   QuestionmasterDAO.delete(entity);
	 *   EntityManagerHelper.commit();
	 *   entity = null;
	 * </pre>
	   @param entity Questionmaster entity to delete
	 @throws RuntimeException when the operation fails
	 */
    public void delete(Questionmaster entity) {
    				EntityManagerHelper.log("deleting Questionmaster instance", Level.INFO, null);
	        try {
        	entity = getEntityManager().getReference(Questionmaster.class, entity.getQuestionId());
            getEntityManager().remove(entity);
            			EntityManagerHelper.log("delete successful", Level.INFO, null);
	        } catch (RuntimeException re) {
        				EntityManagerHelper.log("delete failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    /**
	 Persist a previously saved Questionmaster entity and return it or a copy of it to the sender. 
	 A copy of the Questionmaster entity parameter is returned when the JPA persistence mechanism has not previously been tracking the updated entity. 
	 This operation must be performed within the a database transaction context for the entity's data to be permanently saved to the persistence
	 store, i.e., database. This method uses the {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge} operation.
	 	 
	 * <pre>
	 *   EntityManagerHelper.beginTransaction();
	 *   entity = QuestionmasterDAO.update(entity);
	 *   EntityManagerHelper.commit();
	 * </pre>
	   @param entity Questionmaster entity to update
	 @return Questionmaster the persisted Questionmaster entity instance, may not be the same
	 @throws RuntimeException if the operation fails
	 */
    public Questionmaster update(Questionmaster entity) {
    				EntityManagerHelper.log("updating Questionmaster instance", Level.INFO, null);
	        try {
            Questionmaster result = getEntityManager().merge(entity);
            			EntityManagerHelper.log("update successful", Level.INFO, null);
	            return result;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("update failed", Level.SEVERE, re);
	            throw re;
        }
    }
    
    public Questionmaster findById( Integer id) {
    				EntityManagerHelper.log("finding Questionmaster instance with id: " + id, Level.INFO, null);
	        try {
            Questionmaster instance = getEntityManager().find(Questionmaster.class, id);
            return instance;
        } catch (RuntimeException re) {
        				EntityManagerHelper.log("find failed", Level.SEVERE, re);
	            throw re;
        }
    }    
    

/**
	 * Find all Questionmaster entities with a specific property value.  
	 
	  @param propertyName the name of the Questionmaster property to query
	  @param value the property value to match
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum number of results to return.  
	  	  @return List<Questionmaster> found by query
	 */
    @SuppressWarnings("unchecked")
    public List<Questionmaster> findByProperty(String propertyName, final Object value
        , final int...rowStartIdxAndCount
        ) {
    				EntityManagerHelper.log("finding Questionmaster instance with property: " + propertyName + ", value: " + value, Level.INFO, null);
			try {
			final String queryString = "select model from Questionmaster model where model." 
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
	public List<Questionmaster> findByCodeId(Object codeId
	, int...rowStartIdxAndCount
	) {
		return findByProperty(CODE_ID, codeId
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByPartyId(Object partyId
	, int...rowStartIdxAndCount
	) {
		return findByProperty(PARTY_ID, partyId
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByQuestion(Object question
	, int...rowStartIdxAndCount
	) {
		return findByProperty(QUESTION, question
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByExamType(Object examType
	, int...rowStartIdxAndCount
	) {
		return findByProperty(EXAM_TYPE, examType
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByNoOfOptions(Object noOfOptions
	, int...rowStartIdxAndCount
	) {
		return findByProperty(NO_OF_OPTIONS, noOfOptions
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByOption1(Object option1
	, int...rowStartIdxAndCount
	) {
		return findByProperty(OPTION1, option1
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByOption2(Object option2
	, int...rowStartIdxAndCount
	) {
		return findByProperty(OPTION2, option2
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByOption3(Object option3
	, int...rowStartIdxAndCount
	) {
		return findByProperty(OPTION3, option3
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByOption4(Object option4
	, int...rowStartIdxAndCount
	) {
		return findByProperty(OPTION4, option4
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByOption5(Object option5
	, int...rowStartIdxAndCount
	) {
		return findByProperty(OPTION5, option5
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByAnswer(Object answer
	, int...rowStartIdxAndCount
	) {
		return findByProperty(ANSWER, answer
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByNewAnswer(Object newAnswer
	, int...rowStartIdxAndCount
	) {
		return findByProperty(NEW_ANSWER, newAnswer
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByExplanation(Object explanation
	, int...rowStartIdxAndCount
	) {
		return findByProperty(EXPLANATION, explanation
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByLevelId(Object levelId
	, int...rowStartIdxAndCount
	) {
		return findByProperty(LEVEL_ID, levelId
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByExamId(Object examId
	, int...rowStartIdxAndCount
	) {
		return findByProperty(EXAM_ID, examId
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByStatus(Object status
	, int...rowStartIdxAndCount
	) {
		return findByProperty(STATUS, status
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByImage(Object image
	, int...rowStartIdxAndCount
	) {
		return findByProperty(IMAGE, image
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByResonableTime(Object resonableTime
	, int...rowStartIdxAndCount
	) {
		return findByProperty(RESONABLE_TIME, resonableTime
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByMarks(Object marks
	, int...rowStartIdxAndCount
	) {
		return findByProperty(MARKS, marks
	, rowStartIdxAndCount
		);
	}
	
	public List<Questionmaster> findByRrn(Object rrn
	, int...rowStartIdxAndCount
	) {
		return findByProperty(RRN, rrn
	, rowStartIdxAndCount
		);
	}
	
	
	/**
	 * Find all Questionmaster entities.
	  	  @param rowStartIdxAndCount Optional int varargs. rowStartIdxAndCount[0] specifies the  the row index in the query result-set to begin collecting the results. rowStartIdxAndCount[1] specifies the the maximum count of results to return.  
	  	  @return List<Questionmaster> all Questionmaster entities
	 */
	@SuppressWarnings("unchecked")
	public List<Questionmaster> findAll(
		final int...rowStartIdxAndCount
		) {
					EntityManagerHelper.log("finding all Questionmaster instances", Level.INFO, null);
			try {
			final String queryString = "select model from Questionmaster model";
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