package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Contactpersonsdetails;

/**
 * Interface for ContactpersonsdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IContactpersonsdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Contactpersonsdetails
	 * entity. All subsequent persist actions of this entity should use the
	 * #update() method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IContactpersonsdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Contactpersonsdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Contactpersonsdetails entity);

	/**
	 * Delete a persistent Contactpersonsdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IContactpersonsdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Contactpersonsdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Contactpersonsdetails entity);

	/**
	 * Persist a previously saved Contactpersonsdetails entity and return it or
	 * a copy of it to the sender. A copy of the Contactpersonsdetails entity
	 * parameter is returned when the JPA persistence mechanism has not
	 * previously been tracking the updated entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently saved to the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#merge(Object)
	 * EntityManager#merge} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IContactpersonsdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Contactpersonsdetails entity to update
	 * @return Contactpersonsdetails the persisted Contactpersonsdetails entity
	 *         instance, may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Contactpersonsdetails update(Contactpersonsdetails entity);

	public Contactpersonsdetails findById(Integer id);

	/**
	 * Find all Contactpersonsdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Contactpersonsdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Contactpersonsdetails> found by query
	 */
	public List<Contactpersonsdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	/**
	 * Find all Contactpersonsdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Contactpersonsdetails> all Contactpersonsdetails entities
	 */
	public List<Contactpersonsdetails> findAll(int... rowStartIdxAndCount);
}