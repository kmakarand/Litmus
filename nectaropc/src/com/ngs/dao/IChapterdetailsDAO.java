package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Chapterdetails;

/**
 * Interface for ChapterdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IChapterdetailsDAO {
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
	 * IChapterdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Chapterdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Chapterdetails entity);

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
	 * IChapterdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Chapterdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Chapterdetails entity);

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
	 * entity = IChapterdetailsDAO.update(entity);
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
	public Chapterdetails update(Chapterdetails entity);

	public Chapterdetails findById(Integer id);

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
	 *            count of results to return.
	 * @return List<Chapterdetails> found by query
	 */
	public List<Chapterdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Chapterdetails> findByModuleName(Object moduleName,
			int... rowStartIdxAndCount);

	public List<Chapterdetails> findByCh1count(Object ch1count,
			int... rowStartIdxAndCount);

	public List<Chapterdetails> findByCh2count(Object ch2count,
			int... rowStartIdxAndCount);

	public List<Chapterdetails> findByCh3count(Object ch3count,
			int... rowStartIdxAndCount);

	public List<Chapterdetails> findByCh4count(Object ch4count,
			int... rowStartIdxAndCount);

	public List<Chapterdetails> findByCh5count(Object ch5count,
			int... rowStartIdxAndCount);

	public List<Chapterdetails> findByCh6count(Object ch6count,
			int... rowStartIdxAndCount);

	public List<Chapterdetails> findByCh7count(Object ch7count,
			int... rowStartIdxAndCount);
	
	public List<Chapterdetails> findByCh8count(Object ch8count,
			int... rowStartIdxAndCount);

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
	public List<Chapterdetails> findAll(int... rowStartIdxAndCount);
}