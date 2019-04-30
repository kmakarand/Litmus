package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Candidatemaster;

import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Candidatemaster entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Candidatemaster
 * @author MyEclipse Persistence Tools
 */

public class CandidatemasterDAO implements ICandidatemasterDAO {
	// property constants
	public static final String SCHEDULE_ID = "scheduleId";
	public static final String USERNAME = "username";
	public static final String PASSWORD = "password";
	public static final String TYPE_OF_USER = "typeOfUser";
	public static final String FIRST_NAME = "firstName";
	public static final String LAST_NAME = "lastName";
	public static final String SEX = "sex";
	public static final String DESIGNATION = "designation";
	public static final String CLIENT_ID = "clientId";
	public static final String EMAIL = "email";
	public static final String EXPERIENCE = "experience";
	public static final String CENTRE_OF_REGISTRATION = "centreOfRegistration";
	public static final String IS_TABLE_CREATED = "isTableCreated";
	public static final String HINT_QUESTION = "hintQuestion";
	public static final String HINT_ANSWER = "hintAnswer";
	public static final String STATUS = "status";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Candidatemaster entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * CandidatemasterDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Candidatemaster entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Candidatemaster entity) {
		EntityManagerHelper.log("saving Candidatemaster instance", Level.INFO,
				null);
		try {
			getEntityManager().persist(entity);
			EntityManagerHelper.log("save successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("save failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Delete a persistent Candidatemaster entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * CandidatemasterDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Candidatemaster entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Candidatemaster entity) {
		EntityManagerHelper.log("deleting Candidatemaster instance",
				Level.INFO, null);
		try {
			entity = getEntityManager().getReference(Candidatemaster.class,
					entity.getCandidateId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Candidatemaster entity and return it or a copy
	 * of it to the sender. A copy of the Candidatemaster entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = CandidatemasterDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Candidatemaster entity to update
	 * @return Candidatemaster the persisted Candidatemaster entity instance,
	 *         may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Candidatemaster update(Candidatemaster entity) {
		EntityManagerHelper.log("updating Candidatemaster instance",
				Level.INFO, null);
		try {
			Candidatemaster result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Candidatemaster findById(Integer id) {
		EntityManagerHelper.log("finding Candidatemaster instance with id: "
				+ id, Level.INFO, null);
		try {
			Candidatemaster instance = getEntityManager().find(
					Candidatemaster.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Candidatemaster entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Candidatemaster property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            number of results to return.
	 * @return List<Candidatemaster> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Candidatemaster> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Candidatemaster instance with property: "
						+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Candidatemaster model where model."
					+ propertyName + "= :propertyValue";
			Query query = getEntityManager().createQuery(queryString);
			query.setParameter("propertyValue", value);
			if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {
				int rowStartIdx = Math.max(0, rowStartIdxAndCount[0]);
				if (rowStartIdx > 0) {
					query.setFirstResult(rowStartIdx);
				}

				if (rowStartIdxAndCount.length > 1) {
					int rowCount = Math.max(0, rowStartIdxAndCount[1]);
					if (rowCount > 0) {
						query.setMaxResults(rowCount);
					}
				}
			}
			return query.getResultList();
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find by property name failed",
					Level.SEVERE, re);
			throw re;
		}
	}

	public List<Candidatemaster> findByScheduleId(Object scheduleId,
			int... rowStartIdxAndCount) {
		return findByProperty(SCHEDULE_ID, scheduleId, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByUsername(Object username,
			int... rowStartIdxAndCount) {
		return findByProperty(USERNAME, username, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByPassword(Object password,
			int... rowStartIdxAndCount) {
		return findByProperty(PASSWORD, password, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByTypeOfUser(Object typeOfUser,
			int... rowStartIdxAndCount) {
		return findByProperty(TYPE_OF_USER, typeOfUser, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByFirstName(Object firstName,
			int... rowStartIdxAndCount) {
		return findByProperty(FIRST_NAME, firstName, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByLastName(Object lastName,
			int... rowStartIdxAndCount) {
		return findByProperty(LAST_NAME, lastName, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findBySex(Object sex,
			int... rowStartIdxAndCount) {
		return findByProperty(SEX, sex, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByDesignation(Object designation,
			int... rowStartIdxAndCount) {
		return findByProperty(DESIGNATION, designation, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByClientId(Object clientId,
			int... rowStartIdxAndCount) {
		return findByProperty(CLIENT_ID, clientId, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByEmail(Object email,
			int... rowStartIdxAndCount) {
		return findByProperty(EMAIL, email, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByExperience(Object experience,
			int... rowStartIdxAndCount) {
		return findByProperty(EXPERIENCE, experience, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByCentreOfRegistration(
			Object centreOfRegistration, int... rowStartIdxAndCount) {
		return findByProperty(CENTRE_OF_REGISTRATION, centreOfRegistration,
				rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByIsTableCreated(Object isTableCreated,
			int... rowStartIdxAndCount) {
		return findByProperty(IS_TABLE_CREATED, isTableCreated,
				rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByHintQuestion(Object hintQuestion,
			int... rowStartIdxAndCount) {
		return findByProperty(HINT_QUESTION, hintQuestion, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByHintAnswer(Object hintAnswer,
			int... rowStartIdxAndCount) {
		return findByProperty(HINT_ANSWER, hintAnswer, rowStartIdxAndCount);
	}

	public List<Candidatemaster> findByStatus(Object status,
			int... rowStartIdxAndCount) {
		return findByProperty(STATUS, status, rowStartIdxAndCount);
	}

	/**
	 * Find all Candidatemaster entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Candidatemaster> all Candidatemaster entities
	 */
	@SuppressWarnings("unchecked")
	public List<Candidatemaster> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Candidatemaster instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Candidatemaster model";
			Query query = getEntityManager().createQuery(queryString);
			if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {
				int rowStartIdx = Math.max(0, rowStartIdxAndCount[0]);
				if (rowStartIdx > 0) {
					query.setFirstResult(rowStartIdx);
				}

				if (rowStartIdxAndCount.length > 1) {
					int rowCount = Math.max(0, rowStartIdxAndCount[1]);
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
	
	public List<Candidatemaster> findAllCandidatesWithPaging(int pagenumber,int pageSize) {
	   
	    EntityManager entityManager = EntityManagerHelper.getEntityManager();
	    Query newquery= entityManager.createQuery("Select cm from Candidatemaster cm");
	    //entityManager.getTransaction().begin();
	    if(pagenumber<=1)
	    newquery.setFirstResult(0);
	    else
	    newquery.setFirstResult((pagenumber-1)*pageSize);
	    newquery.setMaxResults(pageSize);
	    List<Candidatemaster> listPersons  = newquery.getResultList();
	    //entityManager.getTransaction().commit();
	    entityManager.close();
	    return listPersons;
	    }

}