package com.ngs;

import com.ngs.dao.CandidatemasterDAO;
import com.ngs.entity.*;
import javax.persistence.EntityManager;

public class jpatest{

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		

	   	EntityManager em = EntityManagerHelper.getEntityManager();
	   	EntityManagerHelper.beginTransaction();
	   	CandidatemasterDAO cmDAO = new CandidatemasterDAO();
	    //Select all the record from student table
	    try{
	        	Candidatemaster cm = cmDAO.findById(1);
			    System.out.print("Id:"+cm.getCandidateId());
				System.out.print(" First Name:"+cm.getFirstName());
				System.out.println(" UserID:"+cm.getUsername());
				System.out.println(" UserID:"+cm.getUsername());
				EntityManagerHelper.commit();

			}catch(Exception e){
			System.out.println(e.getMessage());
			}
			finally{
			em.close();
			}


	}

}
