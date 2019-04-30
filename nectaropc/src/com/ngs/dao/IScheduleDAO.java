package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Schedule;


/**
 * Interface for ScheduleDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IScheduleDAO {
	/**
	 * Perform an initial save of a previously unsaved Schedule entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IScheduleDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Schedule entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Schedule entity);

	/**
	 * Delete a persistent Schedule entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IScheduleDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Schedule entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Schedule entity);

	/**
	 * Persist a previously saved Schedule entity and return it or a copy of it
	 * to the sender. A copy of the Schedule entity parameter is returned when
	 * the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IScheduleDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Schedule entity to update
	 * @return Schedule the persisted Schedule entity instance, may not be the
	 *         same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Schedule update(Schedule entity);

	public Schedule findById(Integer id);

	/**
	 * Find all Schedule entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Schedule property to query
	 * @param value
	 *            the property value to match
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Schedule> found by query
	 */
	public List<Schedule> findByProperty(String propertyName, Object value,
			int... rowStartIdxAndCount);

	/**
	 * Find all Schedule entities.
	 * 
	 * @param rowStartIdxAndCount
	 *            Optional int varargs. rowStartIdxAndCount[0] specifies the the
	 *            row index in the query result-set to begin collecting the
	 *            results. rowStartIdxAndCount[1] specifies the the maximum
	 *            count of results to return.
	 * @return List<Schedule> all Schedule entities
	 */
	public List<Schedule> findAll(int... rowStartIdxAndCount);
}