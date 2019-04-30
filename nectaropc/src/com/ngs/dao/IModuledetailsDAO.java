package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Moduledetails;

/**
 * Interface for ModuledetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IModuledetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Moduledetails entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IModuledetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Moduledetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Moduledetails entity);

	/**
	 * Delete a persistent Moduledetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IModuledetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Moduledetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Moduledetails entity);

	/**
	 * Persist a previously saved Moduledetails entity and return it or a copy
	 * of it to the sender. A copy of the Moduledetails entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IModuledetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Moduledetails entity to update
	 * @return Moduledetails the persisted Moduledetails entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Moduledetails update(Moduledetails entity);

	public Moduledetails findById(Integer id);

	/**
	 * Find all Moduledetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Moduledetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Moduledetails> found by query
	 */
	public List<Moduledetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Moduledetails> findByModuleName(Object moduleName,
			int... rowStartIdxAndCount);

	public List<Moduledetails> findByChapterName(Object chapterName,
			int... rowStartIdxAndCount);

	public List<Moduledetails> findByModuleCount(Object moduleCount,
			int... rowStartIdxAndCount);

	public List<Moduledetails> findByChapterCount(Object chapterCount,
			int... rowStartIdxAndCount);

	/**
	 * Find all Moduledetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Moduledetails> all Moduledetails entities
	 */
	public List<Moduledetails> findAll(int... rowStartIdxAndCount);
}