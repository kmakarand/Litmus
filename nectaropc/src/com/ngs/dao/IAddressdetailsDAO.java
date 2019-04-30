package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Addressdetails;

/**
 * Interface for AddressdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IAddressdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Addressdetails entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IAddressdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Addressdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Addressdetails entity);

	/**
	 * Delete a persistent Addressdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IAddressdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Addressdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Addressdetails entity);

	/**
	 * Persist a previously saved Addressdetails entity and return it or a copy
	 * of it to the sender. A copy of the Addressdetails entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IAddressdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Addressdetails entity to update
	 * @return Addressdetails the persisted Addressdetails entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Addressdetails update(Addressdetails entity);

	public Addressdetails findById(Integer id);

	/**
	 * Find all Addressdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Addressdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Addressdetails> found by query
	 */
	public List<Addressdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Addressdetails> findByMailAddress(Object mailAddress,
			int... rowStartIdxAndCount);

	public List<Addressdetails> findByAddress(Object address,
			int... rowStartIdxAndCount);

	public List<Addressdetails> findByStateId(Object stateId,
			int... rowStartIdxAndCount);

	public List<Addressdetails> findByCountryId(Object countryId,
			int... rowStartIdxAndCount);

	public List<Addressdetails> findByPincode(Object pincode,
			int... rowStartIdxAndCount);

	public List<Addressdetails> findByPhone(Object phone,
			int... rowStartIdxAndCount);

	public List<Addressdetails> findByFax(Object fax,
			int... rowStartIdxAndCount);

	public List<Addressdetails> findByMobileNo(Object mobileNo,
			int... rowStartIdxAndCount);

	/**
	 * Find all Addressdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Addressdetails> all Addressdetails entities
	 */
	public List<Addressdetails> findAll(int... rowStartIdxAndCount);
}