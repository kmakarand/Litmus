package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Imagedetails;
import com.ngs.entity.ImagedetailsId;

/**
 * Interface for ImagedetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IImagedetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Imagedetails entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IImagedetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Imagedetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Imagedetails entity);

	/**
	 * Delete a persistent Imagedetails entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IImagedetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Imagedetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Imagedetails entity);

	/**
	 * Persist a previously saved Imagedetails entity and return it or a copy of
	 * it to the sender. A copy of the Imagedetails entity parameter is returned
	 * when the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IImagedetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Imagedetails entity to update
	 * @return Imagedetails the persisted Imagedetails entity instance, may not
	 *         be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Imagedetails update(Imagedetails entity);

	public Imagedetails findById(ImagedetailsId id);

	/**
	 * Find all Imagedetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Imagedetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Imagedetails> found by query
	 */
	public List<Imagedetails> findByProperty(String propertyName, Object value,
			int... rowStartIdxAndCount);

	/**
	 * Find all Imagedetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Imagedetails> all Imagedetails entities
	 */
	public List<Imagedetails> findAll(int... rowStartIdxAndCount);
}