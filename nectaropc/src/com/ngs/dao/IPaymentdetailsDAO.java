package com.ngs.dao;

import java.util.Date;
import java.util.List;

import com.ngs.entity.Paymentdetails;

/**
 * Interface for PaymentdetailsDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IPaymentdetailsDAO {
	/**
	 * Perform an initial save of a previously unsaved Paymentdetails entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IPaymentdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Paymentdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Paymentdetails entity);

	/**
	 * Delete a persistent Paymentdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IPaymentdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Paymentdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Paymentdetails entity);

	/**
	 * Persist a previously saved Paymentdetails entity and return it or a copy
	 * of it to the sender. A copy of the Paymentdetails entity parameter is
	 * returned when the JPA persistence mechanism has not previously been
	 * tracking the updated entity. This operation must be performed within the
	 * a database transaction context for the entity's data to be permanently
	 * saved to the persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IPaymentdetailsDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Paymentdetails entity to update
	 * @return Paymentdetails the persisted Paymentdetails entity instance, may
	 *         not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Paymentdetails update(Paymentdetails entity);

	public Paymentdetails findById(Integer id);

	/**
	 * Find all Paymentdetails entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Paymentdetails property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Paymentdetails> found by query
	 */
	public List<Paymentdetails> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Paymentdetails> findByAmount(Object amount,
			int... rowStartIdxAndCount);

	public List<Paymentdetails> findByCurrency(Object currency,
			int... rowStartIdxAndCount);

	public List<Paymentdetails> findByModeOfPayment(Object modeOfPayment,
			int... rowStartIdxAndCount);

	public List<Paymentdetails> findByBank(Object bank,
			int... rowStartIdxAndCount);

	public List<Paymentdetails> findByBranch(Object branch,
			int... rowStartIdxAndCount);

	public List<Paymentdetails> findByChequeNo(Object chequeNo,
			int... rowStartIdxAndCount);

	public List<Paymentdetails> findByIsPaymentRealized(
			Object isPaymentRealized, int... rowStartIdxAndCount);

	public List<Paymentdetails> findByIsChequeBounced(Object isChequeBounced,
			int... rowStartIdxAndCount);

	/**
	 * Find all Paymentdetails entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Paymentdetails> all Paymentdetails entities
	 */
	public List<Paymentdetails> findAll(int... rowStartIdxAndCount);
}