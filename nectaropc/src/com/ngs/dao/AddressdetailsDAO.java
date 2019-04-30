package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Addressdetails;
import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Addressdetails entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Addressdetails
 * @author MyEclipse Persistence Tools
 */

public class AddressdetailsDAO implements IAddressdetailsDAO {
	// property constants
	public static final String MAIL_ADDRESS = "mailAddress";
	public static final String ADDRESS = "address";
	public static final String STATE_ID = "stateId";
	public static final String COUNTRY_ID = "countryId";
	public static final String PINCODE = "pincode";
	public static final String PHONE = "phone";
	public static final String FAX = "fax";
	public static final String MOBILE_NO = "mobileNo";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

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
	 * AddressdetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Addressdetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Addressdetails entity) {
		EntityManagerHelper.log("saving Addressdetails instance", Level.INFO,
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
	 * Delete a persistent Addressdetails entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * AddressdetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Addressdetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Addressdetails entity) {
		EntityManagerHelper.log("deleting Addressdetails instance", Level.INFO,
				null);
		try {
			entity = getEntityManager().getReference(Addressdetails.class,
					entity.getCandidateId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

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
	 * entity = AddressdetailsDAO.update(entity);
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
	public Addressdetails update(Addressdetails entity) {
		EntityManagerHelper.log("updating Addressdetails instance", Level.INFO,
				null);
		try {
			Addressdetails result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Addressdetails findById(Integer id) {
		EntityManagerHelper.log("finding Addressdetails instance with id: "
				+ id, Level.INFO, null);
		try {
			Addressdetails instance = getEntityManager().find(
					Addressdetails.class, id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

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
	 *            number of results to return.
	 * @return List<Addressdetails> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Addressdetails> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log(
				"finding Addressdetails instance with property: "
						+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Addressdetails model where model."
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

	public List<Addressdetails> findByMailAddress(Object mailAddress,
			int... rowStartIdxAndCount) {
		return findByProperty(MAIL_ADDRESS, mailAddress, rowStartIdxAndCount);
	}

	public List<Addressdetails> findByAddress(Object address,
			int... rowStartIdxAndCount) {
		return findByProperty(ADDRESS, address, rowStartIdxAndCount);
	}

	public List<Addressdetails> findByStateId(Object stateId,
			int... rowStartIdxAndCount) {
		return findByProperty(STATE_ID, stateId, rowStartIdxAndCount);
	}

	public List<Addressdetails> findByCountryId(Object countryId,
			int... rowStartIdxAndCount) {
		return findByProperty(COUNTRY_ID, countryId, rowStartIdxAndCount);
	}

	public List<Addressdetails> findByPincode(Object pincode,
			int... rowStartIdxAndCount) {
		return findByProperty(PINCODE, pincode, rowStartIdxAndCount);
	}

	public List<Addressdetails> findByPhone(Object phone,
			int... rowStartIdxAndCount) {
		return findByProperty(PHONE, phone, rowStartIdxAndCount);
	}

	public List<Addressdetails> findByFax(Object fax,
			int... rowStartIdxAndCount) {
		return findByProperty(FAX, fax, rowStartIdxAndCount);
	}

	public List<Addressdetails> findByMobileNo(Object mobileNo,
			int... rowStartIdxAndCount) {
		return findByProperty(MOBILE_NO, mobileNo, rowStartIdxAndCount);
	}

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
	@SuppressWarnings("unchecked")
	public List<Addressdetails> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Addressdetails instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Addressdetails model";
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