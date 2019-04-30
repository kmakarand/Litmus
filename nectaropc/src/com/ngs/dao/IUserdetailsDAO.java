package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Userdetails;

/**
 * Interface for UserdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IUserdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Userdetails entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IUserdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Userdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Userdetails entity);

	/**
	 * Delete a persistent Userdetails entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IUserdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Userdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Userdetails entity);

	/**
	 * Persist a previously saved Userdetails entity and return it or a copy of
	 * it to the sender. A copy of the Userdetails entity parameter is returned
	 * when the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IUserdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Userdetails entity to update
	 * @return Userdetails the persisted Userdetails entity instance, may not be
	 *         the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Userdetails update(Userdetails entity);

	public Userdetails findById(Integer id);

	/**
	 * Find all Userdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Userdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Userdetails> found by query
	 */
	public List<Userdetails> findByProperty(String propertyName, Object value,
			int... rowStartIdxAndCount);

	public List<Userdetails> findByExamId(Object examId,
			int... rowStartIdxAndCount);

	public List<Userdetails> findByLevelId(Object levelId,
			int... rowStartIdxAndCount);

	public List<Userdetails> findByModuleCount(Object moduleCount,
			int... rowStartIdxAndCount);

	public List<Userdetails> findByLanguage(Object language,
			int... rowStartIdxAndCount);

	/**
	 * Find all Userdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Userdetails> all Userdetails entities
	 */
	public List<Userdetails> findAll(int... rowStartIdxAndCount);
}