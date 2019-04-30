package com.ngs.dao;

import java.util.List;

import com.ngs.entity.Imageinfo;

/**
 * Interface for ImageinfoDAO.
 * 
 * @author MyEclipse Persistence Tools
 */

public interface IImageinfoDAO {
	/**
	 * Perform an initial save of a previously unsaved Imageinfo entity. All
	 * subsequent persist actions of this entity should use the #update()
	 * method. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#persist(Object)
	 * EntityManager#persist} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IImageinfoDAO.save(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Imageinfo entity to persist
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void save(Imageinfo entity);

	/**
	 * Delete a persistent Imageinfo entity. This operation must be performed
	 * within the a database transaction context for the entity's data to be
	 * permanently deleted from the persistence store, i.e., database. This
	 * method uses the {@link javax.persistence.EntityManager#remove(Object)
	 * EntityManager#delete} operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * IImageinfoDAO.delete(entity);
	 * EntityManagerHelper.commit();
	 * entity = null;
	 * </pre>
	 * 
	 * @param entity
	 *            Imageinfo entity to delete
	 * @throws RuntimeException
	 *             when the operation fails
	 */
	public void delete(Imageinfo entity);

	/**
	 * Persist a previously saved Imageinfo entity and return it or a copy of it
	 * to the sender. A copy of the Imageinfo entity parameter is returned when
	 * the JPA persistence mechanism has not previously been tracking the
	 * updated entity. This operation must be performed within the a database
	 * transaction context for the entity's data to be permanently saved to the
	 * persistence store, i.e., database. This method uses the
	 * {@link javax.persistence.EntityManager#merge(Object) EntityManager#merge}
	 * operation.
	 * 
	 * <pre>
	 * EntityManagerHelper.beginTransaction();
	 * entity = IImageinfoDAO.update(entity);
	 * EntityManagerHelper.commit();
	 * </pre>
	 * 
	 * @param entity
	 *            Imageinfo entity to update
	 * @return Imageinfo the persisted Imageinfo entity instance, may not be the
	 *         same
	 * @throws RuntimeException
	 *             if the operation fails
	 */
	public Imageinfo update(Imageinfo entity);

	public Imageinfo findById(Integer id);

	/**
	 * Find all Imageinfo entities with a specific property value.
	 * 
	 * @param propertyName
	 *            the name of the Imageinfo property to query
	 * @param value
	 *            the property value to match
	 * @return List<Imageinfo> found by query
	 */
	public List<Imageinfo> findByProperty(String propertyName, Object value);

	public List<Imageinfo> findByQuestionId(Object questionId);

	public List<Imageinfo> findByOptionNo(Object optionNo);

	public List<Imageinfo> findByImage(Object image);

	/**
	 * Find all Imageinfo entities.
	 * 
	 * @return List<Imageinfo> all Imageinfo entities
	 */
	public List<Imageinfo> findAll();
}