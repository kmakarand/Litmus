package com.ngs;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;

import com.ngs.entity.Newexamtestingdetails;
/**
 * @author MyEclipse Persistence Tools
 */
public class EntityManagerHelper {
	
	private static final EntityManagerFactory emf; 
	private static final ThreadLocal<EntityManager> threadLocal;
	private static final Logger logger;
	
	static {
		emf = Persistence.createEntityManagerFactory("NectargsPU"); 		
		threadLocal = new ThreadLocal<EntityManager>();
		logger = Logger.getLogger("NectargsPU");
		logger.setLevel(Level.ALL);
	}
		
	public static EntityManager getEntityManager() {
		EntityManager manager = threadLocal.get();		
		if (manager == null || !manager.isOpen()) {
			manager = emf.createEntityManager();
			threadLocal.set(manager);
		}
		return manager;
	}
	
	 public static void closeEntityManager() {
        EntityManager em = threadLocal.get();
        threadLocal.set(null);
        if (em != null) em.close();
    }
    
    public static void beginTransaction() {
    	getEntityManager().getTransaction().begin();
    }
    
    public static void commit() {
    	getEntityManager().getTransaction().commit();
    }  
    
    public static void rollback() {
    	getEntityManager().getTransaction().rollback();
    } 
    
    public static Query createQuery(String query) {
		return getEntityManager().createQuery(query);
	}
	
	public static void log(String info, Level level, Throwable ex) {
    	logger.log(level, info, ex);
    }
	
	  public static Object getSingleResult(Query query){
		    boolean flag=false;Object obj=null;
		 try{
			 obj = query.getSingleResult();
			}catch(NoResultException e){flag=true;System.out.println("No entities found for query");}
			if(flag){
				obj=null;
			}
		  return obj;
	  }
	  
	  @SuppressWarnings("unchecked")
	public static List<Object> getResultList(Query query){
		    boolean flag=false;List<Object> objList=null;
		 try{
			 objList = query.getResultList();
			}catch(NoResultException e){flag=true;System.out.println("No entities found for query");}
			if(flag){
				objList=null;
			}
		  return objList;
	  }
    
}
