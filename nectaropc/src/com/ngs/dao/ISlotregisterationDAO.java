package com.ngs.dao;
// default package


import java.util.List;

import com.ngs.entity.Slotregisteration;

/**
 * Interface for SlotregisterationDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface ISlotregisterationDAO {
	/**
	 * Perform an initial save of a previously unsaved Slotregisteration entity.
	 * All subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ISlotregisterationDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Slotregisteration entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Slotregisteration entity);

	/**
	 * Delete a persistent Slotregisteration entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently deleted from the persistence store, i.e., database.
	 * This method uses the
	 * {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ISlotregisterationDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Slotregisteration entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Slotregisteration entity);

	/**
	 * Persist a previously saved Slotregisteration entity and return it or a
	 * copy of it to the sender. A copy of the Slotregisteration entity
	 * parameter is returned when the JPA persistence mechanism has not
	 * previously been tracking the updated entity. This operation must be
	 * performed within the a database transaction context for the entity's data
	 * to be permanently saved to the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#merge(Object)
	 * EntityManager#merge} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ISlotregisterationDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Slotregisteration entity to update
	 * @return Slotregisteration the persisted Slotregisteration entity
	 *         instance, may not be the same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Slotregisteration update(Slotregisteration entity);

	public Slotregisteration findById(Integer id);

	/**
	 * Find all Slotregisteration entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Slotregisteration property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Slotregisteration> found by query
	 */
	public List<Slotregisteration> findByProperty(String propertyName,
			Object value, int... rowStartIdxAndCount);

	public List<Slotregisteration> findByAttended(Object attended,
			int... rowStartIdxAndCount);

	/**
	 * Find all Slotregisteration entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Slotregisteration> all Slotregisteration entities
	 */
	public List<Slotregisteration> findAll(int... rowStartIdxAndCount);
}