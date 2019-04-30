package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Partydetails;

import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Partydetails entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Partydetails
 * @author MyEclipse Persistence Tools
 */

public class PartydetailsDAO implements IPartydetailsDAO {
	// property constants
	public static final String PARTY = "party";
	public static final String CONTACT = "contact";
	public static final String ADDRESS = "address";
	public static final String STREET = "street";
	public static final String AREA = "area";
	public static final String CITY = "city";
	public static final String PINCODE = "pincode";
	public static final String STATE = "state";
	public static final String COUNTRY = "country";
	public static final String PHONE1 = "phone1";
	public static final String PHONE2 = "phone2";
	public static final String FAX = "fax";
	public static final String EMAIL = "email";
	public static final String URL = "url";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

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
	 * PartydetailsDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Partydetails entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Partydetails entity) {
		EntityManagerHelper.log("saving Partydetails instance", Level.INFO,
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
	 * Delete a persistent Partydetails entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * PartydetailsDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Partydetails entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Partydetails entity) {
		EntityManagerHelper.log("deleting Partydetails instance", Level.INFO,
				null);
		try {
			entity = getEntityManager().getReference(Partydetails.class,
					entity.getPartyId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
	}

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
	 * entity = PartydetailsDAO.update(entity);
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
	public Partydetails update(Partydetails entity) {
		EntityManagerHelper.log("updating Partydetails instance", Level.INFO,
				null);
		try {
			Partydetails result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Partydetails findById(Integer id) {
		EntityManagerHelper.log("finding Partydetails instance with id: " + id,
				Level.INFO, null);
		try {
			Partydetails instance = getEntityManager().find(Partydetails.class,
					id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

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
	 *            number of results to return.
	 * @return List<Partydetails> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Partydetails> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding Partydetails instance with property: "
				+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Partydetails model where model."
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

	public List<Partydetails> findByParty(Object party,
			int... rowStartIdxAndCount) {
		return findByProperty(PARTY, party, rowStartIdxAndCount);
	}

	public List<Partydetails> findByContact(Object contact,
			int... rowStartIdxAndCount) {
		return findByProperty(CONTACT, contact, rowStartIdxAndCount);
	}

	public List<Partydetails> findByAddress(Object address,
			int... rowStartIdxAndCount) {
		return findByProperty(ADDRESS, address, rowStartIdxAndCount);
	}

	public List<Partydetails> findByStreet(Object street,
			int... rowStartIdxAndCount) {
		return findByProperty(STREET, street, rowStartIdxAndCount);
	}

	public List<Partydetails> findByArea(Object area,
			int... rowStartIdxAndCount) {
		return findByProperty(AREA, area, rowStartIdxAndCount);
	}

	public List<Partydetails> findByCity(Object city,
			int... rowStartIdxAndCount) {
		return findByProperty(CITY, city, rowStartIdxAndCount);
	}

	public List<Partydetails> findByPincode(Object pincode,
			int... rowStartIdxAndCount) {
		return findByProperty(PINCODE, pincode, rowStartIdxAndCount);
	}

	public List<Partydetails> findByState(Object state,
			int... rowStartIdxAndCount) {
		return findByProperty(STATE, state, rowStartIdxAndCount);
	}

	public List<Partydetails> findByCountry(Object country,
			int... rowStartIdxAndCount) {
		return findByProperty(COUNTRY, country, rowStartIdxAndCount);
	}

	public List<Partydetails> findByPhone1(Object phone1,
			int... rowStartIdxAndCount) {
		return findByProperty(PHONE1, phone1, rowStartIdxAndCount);
	}

	public List<Partydetails> findByPhone2(Object phone2,
			int... rowStartIdxAndCount) {
		return findByProperty(PHONE2, phone2, rowStartIdxAndCount);
	}

	public List<Partydetails> findByFax(Object fax, int... rowStartIdxAndCount) {
		return findByProperty(FAX, fax, rowStartIdxAndCount);
	}

	public List<Partydetails> findByEmail(Object email,
			int... rowStartIdxAndCount) {
		return findByProperty(EMAIL, email, rowStartIdxAndCount);
	}

	public List<Partydetails> findByUrl(Object url, int... rowStartIdxAndCount) {
		return findByProperty(URL, url, rowStartIdxAndCount);
	}

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
	@SuppressWarnings("unchecked")
	public List<Partydetails> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Partydetails instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Partydetails model";
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