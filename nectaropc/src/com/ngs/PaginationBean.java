package com.ngs;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import com.ngs.entity.Candidatemaster;

/**
 * @author codemiles.
 */
public class PaginationBean {
    private EntityManager entityManager;
    private int pageSize;
    
    public PaginationBean()
    {
    }

    public List<Object> findAllPersons(String Id,String query) {
    entityManager = EntityManagerHelper.getEntityManager();
    Query newquery= entityManager.createQuery(query);
    entityManager.getTransaction().begin();
    List<Object> listPersons = entityManager.createQuery(query).getResultList();
    entityManager.getTransaction().commit();
    entityManager.close();
    if (listPersons == null) {
        System.out.println("No persons found . ");
    } else {
        for (Object person : listPersons) {
        /*System.out.print("Person name= " + person.getName()
                + ", gender" + person.getGender() + ", birthday="
                + person.getBirthday());*/
        }
    }

    return listPersons;
    }

    public List<Candidatemaster> findAllPersonsWithPaging(int pagenumber) {
    pageSize=20;
    entityManager = EntityManagerHelper.getEntityManager();
    Query newquery= entityManager.createQuery("Select cm from Candidatemaster cm");
    //entityManager.getTransaction().begin();
    if(pagenumber<=1)
    newquery.setFirstResult(0);
    else
    newquery.setFirstResult((pagenumber-1)*pageSize);
    newquery.setMaxResults(pageSize);
    List<Candidatemaster> listPersons  = newquery.getResultList();
    //entityManager.getTransaction().commit();
    entityManager.close();
    return listPersons;
    }
    
    public List<Object[]> findAllByObjectWithPaging(int pagenumber,int pageSize,Query newquery) {
        entityManager = EntityManagerHelper.getEntityManager();
        //Query newquery= entityManager.createQuery(query);
        //entityManager.getTransaction().begin();
        newquery.setFirstResult((pagenumber-1) * pageSize); 
        newquery.setMaxResults(pageSize);
        List<Object[]> listPersons  = newquery.getResultList();
        //entityManager.getTransaction().commit();
        //entityManager.close();
        //System.out.println("pageSize:::::::::"+pageSize);
        return listPersons;
        }

    public void setPageSize(int pageSize) {
    this.pageSize = pageSize;
    }

    public int getPageSize() {
    return pageSize;
    }

}
