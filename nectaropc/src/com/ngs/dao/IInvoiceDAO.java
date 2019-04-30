package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Invoice;

/**
 * Interface for InvoiceDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IInvoiceDAO {
	/**
	 * Perform an initial save of a previously unsaved Invoice entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IInvoiceDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Invoice entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Invoice entity);

	/**
	 * Delete a persistent Invoice entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IInvoiceDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Invoice entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Invoice entity);

	/**
	 * Persist a previously saved Invoice entity and return it or a copy of it
	 * to the sender. A copy of the Invoice entity parameter is returned when
	 * the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IInvoiceDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Invoice entity to update
	 * @return Invoice the persisted Invoice entity instance, may not be the
	 *         same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Invoice update(Invoice entity);

	public Invoice findById(Integer id);

	/**
	 * Find all Invoice entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Invoice property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Invoice> found by query
	 */
	public List<Invoice> findByProperty(String propertyName, Object value,
			int... rowStartIdxAndCount);

	public List<Invoice> findByClientId(Object clientId,
			int... rowStartIdxAndCount);

	public List<Invoice> findByPmId(Object pmId, int... rowStartIdxAndCount);

	public List<Invoice> findByPdId(Object pdId, int... rowStartIdxAndCount);

	/**
	 * Find all Invoice entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Invoice> all Invoice entities
	 */
	public List<Invoice> findAll(int... rowStartIdxAndCount);
}