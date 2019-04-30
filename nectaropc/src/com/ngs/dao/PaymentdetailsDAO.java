package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Paymentdetails;

import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Paymentdetails entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Paymentdetails
 * @author MyEclipse Persistence Tools
 */

public class PaymentdetailsDAO implements IPaymentdetailsDAO {
	// property constants
	public static final String AMOUNT = "amount";
	public static final String CURRENCY = "currency";
	public static final String MODE_OF_PAYMENT = "modeOfPayment";
	public static final String BANK = "bank";
	public static final String BRANCH = "branch";
	public static final String CHEQUE_NO = "chequeNo";
	public static final String IS_PAYMENT_REALIZED = "isPaymentRealized";
	public static final String IS_CHEQUE_BOUNCED = "isChequeBounced";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

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
	 * PaymentdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Paymentdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Paymentdetails entity) {
		EntityManagerHelper.log("saving Paymentdetails instance", Level.INFO,
				null);
		try {
			getEntityManager().persist(entity);
			EntityManagerHelper.log("save successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("save failed", Level.SEVERE, re);
			throw re;
		}
	}

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
	 * PaymentdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Paymentdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Paymentdetails entity) {
		EntityManagerHelper.log("deleting Paymentdetails instance", Level.INFO,
				null);
		try {
			entity = getEntityManager().getReference(Paymentdetails.class,
					entity.getCandidateId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

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
	 * entity = PaymentdetailsDAO.update(entity);
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
	public Paymentdetails update(Paymentdetails entity) {
		EntityManagerHelper.log("updating Paymentdetails instance", Level.INFO,
				null);
		try {
			Paymentdetails result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Paymentdetails findById(Integer id) {
		EntityManagerHelper.log("finding Paymentdetails instance with id: "
				+ id, Level.INFO, null);
		try {
			Paymentdetails instance = getEntityManager().find(
					Paymentdetails.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

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
	 *            number of results to return.
	 * @return List<Paymentdetails> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Paymentdetails> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Paymentdetails instance with property: "
						+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Paymentdetails model where model."
					+ propertyName + "= :propertyValue";
			Query query = getEntityManager().createQuery(queryString);
			query.setParameter("propertyValue", value);
			if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {
				int rowStartIdx = Math.max(0, rowStartIdxAndCount[0]);
				if (rowStartIdx > 0) {
					query.setFirstResult(rowStartIdx);
				}

				if (rowStartIdxAndCount.length > 1) {
					int rowCount = Math.max(0, rowStartIdxAndCount[1]);
					if (rowCount > 0) {
						query.setMaxResults(rowCount);
					}
				}
			}
			return query.getResultList();
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find by property name failed",
					Level.SEVERE, re);
			throw re;
		}
	}

	public List<Paymentdetails> findByAmount(Object amount,
			int... rowStartIdxAndCount) {
		return findByProperty(AMOUNT, amount, rowStartIdxAndCount);
	}

	public List<Paymentdetails> findByCurrency(Object currency,
			int... rowStartIdxAndCount) {
		return findByProperty(CURRENCY, currency, rowStartIdxAndCount);
	}

	public List<Paymentdetails> findByModeOfPayment(Object modeOfPayment,
			int... rowStartIdxAndCount) {
		return findByProperty(MODE_OF_PAYMENT, modeOfPayment,
				rowStartIdxAndCount);
	}

	public List<Paymentdetails> findByBank(Object bank,
			int... rowStartIdxAndCount) {
		return findByProperty(BANK, bank, rowStartIdxAndCount);
	}

	public List<Paymentdetails> findByBranch(Object branch,
			int... rowStartIdxAndCount) {
		return findByProperty(BRANCH, branch, rowStartIdxAndCount);
	}

	public List<Paymentdetails> findByChequeNo(Object chequeNo,
			int... rowStartIdxAndCount) {
		return findByProperty(CHEQUE_NO, chequeNo, rowStartIdxAndCount);
	}

	public List<Paymentdetails> findByIsPaymentRealized(
			Object isPaymentRealized, int... rowStartIdxAndCount) {
		return findByProperty(IS_PAYMENT_REALIZED, isPaymentRealized,
				rowStartIdxAndCount);
	}

	public List<Paymentdetails> findByIsChequeBounced(Object isChequeBounced,
			int... rowStartIdxAndCount) {
		return findByProperty(IS_CHEQUE_BOUNCED, isChequeBounced,
				rowStartIdxAndCount);
	}

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
	@SuppressWarnings("unchecked")
	public List<Paymentdetails> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Paymentdetails instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Paymentdetails model";
			Query query = getEntityManager().createQuery(queryString);
			if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {
				int rowStartIdx = Math.max(0, rowStartIdxAndCount[0]);
				if (rowStartIdx > 0) {
					query.setFirstResult(rowStartIdx);
				}

				if (rowStartIdxAndCount.length > 1) {
					int rowCount = Math.max(0, rowStartIdxAndCount[1]);
					if (rowCount > 0) {
						query.setMaxResults(rowCount);
					}
				}
			}
			return query.getResultList();
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find all failed", Level.SEVERE, re);
			throw re;
		}
	}

}