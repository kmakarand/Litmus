package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Clientmaster;

/**
 * Interface for ClientmasterDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IClientmasterDAO {
	/**
	 * Perform an initial save of a previously unsaved Clientmaster entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IClientmasterDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Clientmaster entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public boolean save(Clientmaster entity);

	/**
	 * Delete a persistent Clientmaster entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IClientmasterDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Clientmaster entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public boolean delete(Clientmaster entity);

	/**
	 * Persist a previously saved Clientmaster entity and return it or a copy of
	 * it to the sender. A copy of the Clientmaster entity parameter is returned
	 * when the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IClientmasterDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Clientmaster entity to update
	 * @return Clientmaster the persisted Clientmaster entity instance, may not
	 *         be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Clientmaster update(Clientmaster entity);

	public Clientmaster findById(Integer id);

	/**
	 * Find all Clientmaster entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Clientmaster property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Clientmaster> found by query
	 */
	public List<Clientmaster> findByProperty(String propertyName, Object value,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByClientCode(Object clientCode,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByClientName(Object clientName,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByUsername(Object username,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByPassword(Object password,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByAddress(Object address,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByPincode(Object pincode,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByLocationId(Object locationId,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByPhone1(Object phone1,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByPhone2(Object phone2,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByFax(Object fax, int... rowStartIdxAndCount);

	public List<Clientmaster> findByEmail(Object email,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByUrl(Object url, int... rowStartIdxAndCount);

	public List<Clientmaster> findByAvailableSeats(Object availableSeats,
			int... rowStartIdxAndCount);

	public List<Clientmaster> findByClientType(Object clientType,
			int... rowStartIdxAndCount);

	/**
	 * Find all Clientmaster entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Clientmaster> all Clientmaster entities
	 */
	public List<Clientmaster> findAll(int... rowStartIdxAndCount);
}