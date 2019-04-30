package com.ngs.dao;

import java.util.List;

import com.ngs.entity.SaveImage;

/**
 * Interface for SaveImageDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface ISaveImageDAO {
	/**
	 * Perform an initial save of a previously unsaved SaveImage entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ISaveImageDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            SaveImage entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(SaveImage entity);

	/**
	 * Delete a persistent SaveImage entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * ISaveImageDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            SaveImage entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(SaveImage entity);

	/**
	 * Persist a previously saved SaveImage entity and return it or a copy of it
	 * to the sender. A copy of the SaveImage entity parameter is returned when
	 * the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = ISaveImageDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            SaveImage entity to update
	 * @return SaveImage the persisted SaveImage entity instance, may not be the
	 *         same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public SaveImage update(SaveImage entity);

	public SaveImage findById(Integer id);

	/**
	 * Find all SaveImage entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the SaveImage property to query
	 * @param value
	 *            the property value to match
	 * @return List<SaveImage> found by query
	 */
	public List<SaveImage> findByProperty(String propertyName, Object value);

	public List<SaveImage> findByName(Object name);

	public List<SaveImage> findByCity(Object city);

	public List<SaveImage> findByImage(Object image);

	public List<SaveImage> findByPhone(Object phone);

	/**
	 * Find all SaveImage entities.
	 * 
	 * @return List<SaveImage> all SaveImage entities
	 */
	public List<SaveImage> findAll();
}