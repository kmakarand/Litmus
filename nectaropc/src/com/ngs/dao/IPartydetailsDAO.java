package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Partydetails;

/**
 * Interface for PartydetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IPartydetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Partydetails entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IPartydetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Partydetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Partydetails entity);

	/**
	 * Delete a persistent Partydetails entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IPartydetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Partydetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Partydetails entity);

	/**
	 * Persist a previously saved Partydetails entity and return it or a copy of
	 * it to the sender. A copy of the Partydetails entity parameter is returned
	 * when the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IPartydetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Partydetails entity to update
	 * @return Partydetails the persisted Partydetails entity instance, may not
	 *         be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Partydetails update(Partydetails entity);

	public Partydetails findById(Integer id);

	/**
	 * Find all Partydetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Partydetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Partydetails> found by query
	 */
	public List<Partydetails> findByProperty(String propertyName, Object value,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByParty(Object party,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByContact(Object contact,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByAddress(Object address,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByStreet(Object street,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByArea(Object area,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByCity(Object city,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByPincode(Object pincode,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByState(Object state,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByCountry(Object country,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByPhone1(Object phone1,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByPhone2(Object phone2,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByFax(Object fax, int... rowStartIdxAndCount);

	public List<Partydetails> findByEmail(Object email,
			int... rowStartIdxAndCount);

	public List<Partydetails> findByUrl(Object url, int... rowStartIdxAndCount);

	/**
	 * Find all Partydetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Partydetails> all Partydetails entities
	 */
	public List<Partydetails> findAll(int... rowStartIdxAndCount);
}