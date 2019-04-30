package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Chapterdetails;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Chapterdetails entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Chapterdetails
 * @author MyEclipse Persistence Tools
 */

public class ChapterdetailsDAO implements IChapterdetailsDAO {
	// property constants
	public static final String MODULE_NAME = "moduleName";
	public static final String CH1COUNT = "ch1count";
	public static final String CH2COUNT = "ch2count";
	public static final String CH3COUNT = "ch3count";
	public static final String CH4COUNT = "ch4count";
	public static final String CH5COUNT = "ch5count";
	public static final String CH6COUNT = "ch6count";
	public static final String CH7COUNT = "ch7count";
	public static final String CH8COUNT = "ch8count";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

	/**
	 * Perform an initial save of a previously unsaved Chapterdetails entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ChapterdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Chapterdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Chapterdetails entity) {
		EntityManagerHelper.log("saving Chapterdetails instance", Level.INFO,
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
	 * Delete a persistent Chapterdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ChapterdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Chapterdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Chapterdetails entity) {
		EntityManagerHelper.log("deleting Chapterdetails instance", Level.INFO,
				null);
		try {
			entity = getEntityManager().getReference(Chapterdetails.class,
					entity.getCandidateId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Persist a previously saved Chapterdetails entity and return it or a copy
	 * of it to the sender. A copy of the Chapterdetails entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ChapterdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Chapterdetails entity to update
	 * @return Chapterdetails the persisted Chapterdetails entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Chapterdetails update(Chapterdetails entity) {
		EntityManagerHelper.log("updating Chapterdetails instance", Level.INFO,
				null);
		try {
			Chapterdetails result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Chapterdetails findById(Integer id) {
		EntityManagerHelper.log("finding Chapterdetails instance with id: "
				+ id, Level.INFO, null);
		try {
			Chapterdetails instance = getEntityManager().find(
					Chapterdetails.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

	/**
	 * Find all Chapterdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Chapterdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            number of results to return.
	 * @return List<Chapterdetails> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Chapterdetails> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Chapterdetails instance with property: "
						+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Chapterdetails model where model."
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

	public List<Chapterdetails> findByModuleName(Object moduleName,
			int... rowStartIdxAndCount) {
		return findByProperty(MODULE_NAME, moduleName, rowStartIdxAndCount);
	}

	public List<Chapterdetails> findByCh1count(Object ch1count,
			int... rowStartIdxAndCount) {
		return findByProperty(CH1COUNT, ch1count, rowStartIdxAndCount);
	}

	public List<Chapterdetails> findByCh2count(Object ch2count,
			int... rowStartIdxAndCount) {
		return findByProperty(CH2COUNT, ch2count, rowStartIdxAndCount);
	}

	public List<Chapterdetails> findByCh3count(Object ch3count,
			int... rowStartIdxAndCount) {
		return findByProperty(CH3COUNT, ch3count, rowStartIdxAndCount);
	}

	public List<Chapterdetails> findByCh4count(Object ch4count,
			int... rowStartIdxAndCount) {
		return findByProperty(CH4COUNT, ch4count, rowStartIdxAndCount);
	}

	public List<Chapterdetails> findByCh5count(Object ch5count,
			int... rowStartIdxAndCount) {
		return findByProperty(CH5COUNT, ch5count, rowStartIdxAndCount);
	}

	public List<Chapterdetails> findByCh6count(Object ch6count,
			int... rowStartIdxAndCount) {
		return findByProperty(CH6COUNT, ch6count, rowStartIdxAndCount);
	}

	public List<Chapterdetails> findByCh7count(Object ch7count,
			int... rowStartIdxAndCount) {
		return findByProperty(CH7COUNT, ch7count, rowStartIdxAndCount);
	}
	
	public List<Chapterdetails> findByCh8count(Object ch8count,
			int... rowStartIdxAndCount) {
		return findByProperty(CH7COUNT, ch8count, rowStartIdxAndCount);
	}

	/**
	 * Find all Chapterdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Chapterdetails> all Chapterdetails entities
	 */
	@SuppressWarnings("unchecked")
	public List<Chapterdetails> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Chapterdetails instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Chapterdetails model";
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