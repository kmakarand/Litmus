package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Newexamtestingdetails;

import java.sql.Time;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Newexamtestingdetails entities. Transaction control of the save(), update()
 * and delete() operations must be handled externally by senders of these
 * methods or must be manually added to each of these methods for data to be
 * persisted to the JPA datastore.
 * 
 * @see com.ngs.entity.Newexamtestingdetails
 * @author MyEclipse Persistence Tools
 */

public class NewexamtestingdetailsDAO implements INewexamtestingdetailsDAO {
	// property constants
	public static final String SECTION_ID = "sectionId";
	public static final String CODE_ID = "codeId";
	public static final String CODE_GROUP_ID = "codeGroupId";
	public static final String EXAM_ID = "examId";
	public static final String CANDIDATE_ID = "candidateId";
	public static final String QUESTION_ID = "questionId";
	public static final String ANSWER = "answer";
	public static final String ANSWER_STATUS = "answerStatus";
	public static final String TIME_TAKEN = "timeTaken";
	public static final String ATTEMPT_NO = "attemptNo";
	public static final String BOOK_MARK = "bookMark";
	public static final String SEQUENCE_NO = "sequenceNo";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Newexamtestingdetails
	 * entity. All subsequent persist actions of this entity should use the
	 * #update() method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * NewexamtestingdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newexamtestingdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Newexamtestingdetails entity) {
		EntityManagerHelper.log("saving Newexamtestingdetails instance",
				Level.INFO, null);
		try {
			getEntityManager().persist(entity);
			EntityManagerHelper.log("save successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("save failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Delete a persistent Newexamtestingdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * NewexamtestingdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Newexamtestingdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Newexamtestingdetails entity) {
		EntityManagerHelper.log("deleting Newexamtestingdetails instance",
				Level.INFO, null);
		try {
			entity = getEntityManager().getReference(
					Newexamtestingdetails.class, entity.getId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Newexamtestingdetails entity and return it or
	 * a copy of it to the sender. A copy of the Newexamtestingdetails entity
	 * parameter is returned when the JPA persistence mechanism has not
	 * previously been tracking the updated entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently saved to the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#merge(Object)
	 * EntityManager#merge} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = NewexamtestingdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Newexamtestingdetails entity to update
	 * @return Newexamtestingdetails the persisted Newexamtestingdetails entity
	 *         instance, may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Newexamtestingdetails update(Newexamtestingdetails entity) {
		EntityManagerHelper.log("updating Newexamtestingdetails instance",
				Level.INFO, null);
		try {
			Newexamtestingdetails result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Newexamtestingdetails findById(Integer id) {
		EntityManagerHelper.log(
				"finding Newexamtestingdetails instance with id: " + id,
				Level.INFO, null);
		try {
			Newexamtestingdetails instance = getEntityManager().find(
					Newexamtestingdetails.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Newexamtestingdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Newexamtestingdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            number of results to return.
	 * @return List<Newexamtestingdetails> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Newexamtestingdetails> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Newexamtestingdetails instance with property: "
						+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Newexamtestingdetails model where model."
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

	public List<Newexamtestingdetails> findBySectionId(Object sectionId,
			int... rowStartIdxAndCount) {
		return findByProperty(SECTION_ID, sectionId, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByCodeId(Object codeId,
			int... rowStartIdxAndCount) {
		return findByProperty(CODE_ID, codeId, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByCodeGroupId(Object codeGroupId,
			int... rowStartIdxAndCount) {
		return findByProperty(CODE_GROUP_ID, codeGroupId, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByExamId(Object examId,
			int... rowStartIdxAndCount) {
		return findByProperty(EXAM_ID, examId, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByCandidateId(Object candidateId,
			int... rowStartIdxAndCount) {
		return findByProperty(CANDIDATE_ID, candidateId, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByQuestionId(Object questionId,
			int... rowStartIdxAndCount) {
		return findByProperty(QUESTION_ID, questionId, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByAnswer(Object answer,
			int... rowStartIdxAndCount) {
		return findByProperty(ANSWER, answer, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByAnswerStatus(Object answerStatus,
			int... rowStartIdxAndCount) {
		return findByProperty(ANSWER_STATUS, answerStatus, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByTimeTaken(Object timeTaken,
			int... rowStartIdxAndCount) {
		return findByProperty(TIME_TAKEN, timeTaken, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByAttemptNo(Object attemptNo,
			int... rowStartIdxAndCount) {
		return findByProperty(ATTEMPT_NO, attemptNo, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findByBookMark(Object bookMark,
			int... rowStartIdxAndCount) {
		return findByProperty(BOOK_MARK, bookMark, rowStartIdxAndCount);
	}

	public List<Newexamtestingdetails> findBySequenceNo(Object sequenceNo,
			int... rowStartIdxAndCount) {
		return findByProperty(SEQUENCE_NO, sequenceNo, rowStartIdxAndCount);
	}

	/**
	 * Find all Newexamtestingdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Newexamtestingdetails> all Newexamtestingdetails entities
	 */
	@SuppressWarnings("unchecked")
	public List<Newexamtestingdetails> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Newexamtestingdetails instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Newexamtestingdetails model";
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

}