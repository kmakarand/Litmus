package com.ngs;

import javax.persistence.EntityManager;

import com.ngs.dao.CandidatemasterDAO;
import com.ngs.entity.Candidatemaster;

public class Testjp {

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
	        	Candidatemaster cm = cmDAO.findById(436);
			    System.out.println("Id:"+cm.getCandidateId());
				System.out.println(" First Name:"+cm.getFirstName());
				System.out.println(" UserID:"+cm.getUsername());
				System.out.println(" Password:"+cm.getPassword());
				EntityManagerHelper.commit();

			}catch(Exception e){
			System.out.println(e.getMessage());
			}
			finally{
			em.close();
			}

	}

}
