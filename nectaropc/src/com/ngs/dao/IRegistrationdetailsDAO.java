package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Registrationdetails;

/**
 * Interface for RegistrationdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IRegistrationdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Registrationdetails
	 * entity. All subsequent persist actions of this entity should use the
	 * #update() method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IRegistrationdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Registrationdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Registrationdetails entity);

	/**
	 * Delete a persistent Registrationdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IRegistrationdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Registrationdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Registrationdetails entity);

	/**
	 * Persist a previously saved Registrationdetails entity and return it or a
	 * copy of it to the sender. A copy of the Registrationdetails entity
	 * parameter is returned when the JPA persistence mechanism has not
	 * previously been tracking the updated entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently saved to the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#merge(Object)
	 * EntityManager#merge} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IRegistrationdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Registrationdetails entity to update
	 * @return Registrationdetails the persisted Registrationdetails entity
	 *         instance, may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Registrationdetails update(Registrationdetails entity);

	public Registrationdetails findById(Integer id);

	/**
	 * Find all Registrationdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Registrationdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Registrationdetails> found by query
	 */
	public List<Registrationdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Registrationdetails> findByClientId(Object clientId,
			int... rowStartIdxAndCount);

	public List<Registrationdetails> findByLocationId(Object locationId,
			int... rowStartIdxAndCount);

	public List<Registrationdetails> findBySerialNo(Object serialNo,
			int... rowStartIdxAndCount);

	/**
	 * Find all Registrationdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Registrationdetails> all Registrationdetails entities
	 */
	public List<Registrationdetails> findAll(int... rowStartIdxAndCount);
}