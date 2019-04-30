package com.ngs.dao;

import com.ngs.EntityManagerHelper;
import com.ngs.entity.Candidatemaster;
import com.ngs.entity.Clientmaster;


import java.util.List;
import java.util.logging.Level;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * A data access object (DAO) providing persistence and search support for
 * Clientmaster entities. Transaction control of the save(), update() and
 * delete() operations must be handled externally by senders of these methods or
 * must be manually added to each of these methods for data to be persisted to
 * the JPA datastore.
 * 
 * @see com.ngs.entity.Clientmaster
 * @author MyEclipse Persistence Tools
 */

public class ClientmasterDAO implements IClientmasterDAO {
	// property constants
	public static final String CLIENT_CODE = "clientCode";
	public static final String CLIENT_NAME = "clientName";
	public static final String USERNAME = "username";
	public static final String PASSWORD = "password";
	public static final String ADDRESS = "address";
	public static final String PINCODE = "pincode";
	public static final String LOCATION_ID = "locationId";
	public static final String PHONE1 = "phone1";
	public static final String PHONE2 = "phone2";
	public static final String FAX = "fax";
	public static final String EMAIL = "email";
	public static final String URL = "url";
	public static final String AVAILABLE_SEATS = "availableSeats";
	public static final String CLIENT_TYPE = "clientType";

	private EntityManager getEntityManager() {
		return EntityManagerHelper.getEntityManager();
	}

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
	 * ClientmasterDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Clientmaster entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public boolean save(Clientmaster entity) {
		EntityManagerHelper.log("saving Clientmaster instance", Level.INFO,
				null);
		try {
			getEntityManager().persist(entity);
			EntityManagerHelper.log("save successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("save failed", Level.SEVERE, re);
			throw re;
		}
		return true;
	}

	/**
	 * Delete a persistent Clientmaster entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ClientmasterDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Clientmaster entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public boolean delete(Clientmaster entity) {
		EntityManagerHelper.log("deleting Clientmaster instance", Level.INFO,
				null);
		try {
			entity = getEntityManager().getReference(Clientmaster.class,
					entity.getClientId());
			getEntityManager().remove(entity);
			EntityManagerHelper.log("delete successful", Level.INFO, null);
		} catch (RuntimeException re) {
			EntityManagerHelper.log("delete failed", Level.SEVERE, re);
			throw re;
		}
		return true;
	}

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
	 * entity = ClientmasterDAO.update(entity);
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
	public Clientmaster update(Clientmaster entity) {
		EntityManagerHelper.log("updating Clientmaster instance", Level.INFO,
				null);
		try {
			Clientmaster result = getEntityManager().merge(entity);
			EntityManagerHelper.log("update successful", Level.INFO, null);
			return result;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("update failed", Level.SEVERE, re);
			throw re;
		}
	}

	public Clientmaster findById(Integer id) {
		EntityManagerHelper.log("finding Clientmaster instance with id: " + id,
				Level.INFO, null);
		try {
			Clientmaster instance = getEntityManager().find(Clientmaster.class,
					id);
			return instance;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}

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
	 *            number of results to return.
	 * @return List<Clientmaster> found by query
	 */
	@SuppressWarnings("unchecked")
	public List<Clientmaster> findByProperty(String propertyName,
			final Object value, final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding Clientmaster instance with property: "
				+ propertyName + ", value: " + value, Level.INFO, null);
		try {
			final String queryString = "select model from Clientmaster model where model."
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

	public List<Clientmaster> findByClientCode(Object clientCode,
			int... rowStartIdxAndCount) {
		return findByProperty(CLIENT_CODE, clientCode, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByClientName(Object clientName,
			int... rowStartIdxAndCount) {
		return findByProperty(CLIENT_NAME, clientName, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByUsername(Object username,
			int... rowStartIdxAndCount) {
		return findByProperty(USERNAME, username, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByPassword(Object password,
			int... rowStartIdxAndCount) {
		return findByProperty(PASSWORD, password, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByAddress(Object address,
			int... rowStartIdxAndCount) {
		return findByProperty(ADDRESS, address, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByPincode(Object pincode,
			int... rowStartIdxAndCount) {
		return findByProperty(PINCODE, pincode, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByLocationId(Object locationId,
			int... rowStartIdxAndCount) {
		return findByProperty(LOCATION_ID, locationId, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByPhone1(Object phone1,
			int... rowStartIdxAndCount) {
		return findByProperty(PHONE1, phone1, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByPhone2(Object phone2,
			int... rowStartIdxAndCount) {
		return findByProperty(PHONE2, phone2, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByFax(Object fax, int... rowStartIdxAndCount) {
		return findByProperty(FAX, fax, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByEmail(Object email,
			int... rowStartIdxAndCount) {
		return findByProperty(EMAIL, email, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByUrl(Object url, int... rowStartIdxAndCount) {
		return findByProperty(URL, url, rowStartIdxAndCount);
	}

	public List<Clientmaster> findByAvailableSeats(Object availableSeats,
			int... rowStartIdxAndCount) {
		return findByProperty(AVAILABLE_SEATS, availableSeats,
				rowStartIdxAndCount);
	}

	public List<Clientmaster> findByClientType(Object clientType,
			int... rowStartIdxAndCount) {
		return findByProperty(CLIENT_TYPE, clientType, rowStartIdxAndCount);
	}

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
	@SuppressWarnings("unchecked")
	public List<Clientmaster> findAll(final int... rowStartIdxAndCount) {
		EntityManagerHelper.log("finding all Clientmaster instances",
				Level.INFO, null);
		try {
			final String queryString = "select model from Clientmaster model";
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
	
	
	public List<Clientmaster> scListfindByNativeQuery(String sql) {
		EntityManagerHelper.log("Listing Native Query Results"+sql,Level.INFO, null);
		try {
				EntityManager em = EntityManagerHelper.getEntityManager();
                List<Clientmaster> cmList=em.createNativeQuery(sql).getResultList();
                return cmList;
               	
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}
	
	public Clientmaster scfindByNativeQuery(String sql) {
		EntityManagerHelper.log("Listing Native Query Results"+sql,Level.INFO, null);
		try {
				EntityManager em = EntityManagerHelper.getEntityManager();
				Clientmaster sc=(Clientmaster) em.createNativeQuery(sql).getResultList();
                return sc;
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}
	
	
	public List<Clientmaster> scListfindByNativeQueryPredicate(String predicate) {
		EntityManagerHelper.log("Listing Native Query Results"+predicate,Level.INFO, null);
		try {
				EntityManager em = EntityManagerHelper.getEntityManager();
                List<Clientmaster> cmList=em.createNativeQuery("Select * from Clientmaster where "+predicate).getResultList();
                return cmList;
               	
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}
	
	public Clientmaster scfindByNativeQueryPredicate(String predicate) {
		EntityManagerHelper.log("Listing Native Query Results"+predicate,Level.INFO, null);
		try {
				EntityManager em = EntityManagerHelper.getEntityManager();
				Clientmaster sc=(Clientmaster) em.createNativeQuery("Select * from Clientmaster where "+predicate);
                return sc;
               	
		} catch (RuntimeException re) {
			EntityManagerHelper.log("find failed", Level.SEVERE, re);
			throw re;
		}
	}
	
	public List<Clientmaster> findAllClientsWithPaging(int pagenumber,int pageSize) {
		EntityManager entityManager;
	    entityManager = EntityManagerHelper.getEntityManager();
	    Query newquery= entityManager.createQuery("Select cm from Clientmaster cm");
	    //entityManager.getTransaction().begin();
	    //System.out.println("pagenumber	:"+pagenumber);
	    //System.out.println("pageSize	:"+pageSize);
	    if(pagenumber<=1)
	    newquery.setFirstResult(0);
	    else
	    newquery.setFirstResult((pagenumber-1)*pageSize);
	    //newquery.setMaxResults(pageSize);
	    List<Clientmaster> listClients  = newquery.getResultList();
	    //entityManager.getTransaction().commit();
	    //entityManager.close();
	    return listClients;
	    }

}