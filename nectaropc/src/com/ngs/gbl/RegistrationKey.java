package com.ngs.gbl;
import java.io.*;
import java.sql.*;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.ngs.EntityManagerHelper;
import com.ngs.dao.CandidatemasterDAO;
import com.ngs.dao.ClientmasterDAO;
import com.ngs.dao.LocationmasterDAO;
import com.ngs.dao.RegistrationdetailsDAO;
import com.ngs.entity.Candidatemaster;
import com.ngs.entity.Clientmaster;
import com.ngs.entity.Locationmaster;
import com.ngs.entity.Registrationdetails;

public class RegistrationKey
{
	String clientcd = "NEC";
	String citycd = null;
	String areacd = null;
	String returnkey = null;
	int cid = 0,max = 0;
	

	Connection con	=	null;
	PreparedStatement pstmt	=	null;
	ResultSet rs	=	null , rs1 = null, rs2 = null, rs3 = null;
	String sql		=	null;
	boolean check = false;
	EntityManager em = EntityManagerHelper.getEntityManager();
	RegistrationdetailsDAO regDAO = new RegistrationdetailsDAO();
	CandidatemasterDAO cndDAO = new CandidatemasterDAO();
	ClientmasterDAO clmDAO = new ClientmasterDAO();
	LocationmasterDAO lmDAO = new LocationmasterDAO();
	Registrationdetails regDet = null;
	Candidatemaster cm = null;
	Clientmaster clm = null;
	Locationmaster lm = null;
	Query query=null;
	Logger log = Logger.getLogger(RegistrationKey.class);

	public RegistrationKey(int _cid)
	{
		this.cid = _cid;
	}

	public synchronized String KeyCode()
	{
		try
		{
			int clientid=0,lid=0,cityid=0,areaid=0,countryid=0;
			String clientcode="",citycode="",areacode="";
			regDet = regDAO.findById(cid);
			if (regDet != null)
			{
				returnkey = "Registration Key already issued for this Candidate" ;
			}
			else
			{
				   	query = em.createNamedQuery("RegistrationKey-Registrationdetails.sql1");
					Number result = (Number) query.getSingleResult();
					max = result.intValue();
					max = max+1;
					//log.info("RegistrationKey: max -"+max);
					//log.info("RegistrationKey: cid -"+cid);
					query = em.createNamedQuery("RegistrationKey-Candidatemaster.sql2");
					query.setParameter("cid", cid);
					cm = (Candidatemaster) query.getSingleResult();
					clientid = cm.getClientId();
					//log.info("RegistrationKey: clientid -"+clientid);
					query = em.createNamedQuery("RegistrationKey-Clientmaster.sql3");
					query.setParameter("clientid", clientid);
					clm = (Clientmaster) query.getSingleResult();
					lid = clm.getLocationId();
					query = em.createNamedQuery("RegistrationKey-Locationmaster.sql4");
					query.setParameter("lid", lid);
					lm = (Locationmaster) query.getSingleResult();
					cityid=lm.getCityId();
					areaid=lm.getAreaId();
					countryid=lm.getCountryId();
					query = em.createNamedQuery("RegistrationKey-Locationmaster.sql5");
					query.setParameter(1, lid);
					query.setParameter(2, areaid);
					lm = (Locationmaster) query.getSingleResult();
					areacode = lm.getCode();
					query = em.createNamedQuery("RegistrationKey-Locationmaster.sql6");
					query.setParameter(1, countryid);
					query.setParameter(2, cityid);
					lm = (Locationmaster) query.getSingleResult();
					citycode = lm.getCode();
					//log.info("RegistrationKey: citycode -"+citycode);
		    	}
			
				regDet = new Registrationdetails();
				regDet.setCandidateId(cid);
				regDet.setClientId(clientid);
				regDet.setLocationId(lid);
				regDet.setSerialNo(max);
				try{
				EntityManagerHelper.beginTransaction();
				regDAO.save(regDet);
				EntityManagerHelper.commit();
				}catch(Exception e){System.out.println("Problem in RegistrationDetails !!");}
				String srl = "";
				if (max<10)
				{
					srl = "000" + max;
				}
				else if (max<100)
				{
					srl = "00" + max;
				}
				else if (max<1000)
				{
					srl = "0" + max;
				}
				else
					srl = "" + max;

				returnkey = "" + clientcd + "-" + citycode + "-"   + srl;	//+ "-" areacode
			
		}
		catch(Exception e)
		{
			System.out.println("key Error 1: " + e.getMessage());
		}
		finally
		{
			try
			{
			}
			catch(Exception e)
			{
				System.out.println("Finally Exception : " + e.getMessage());
			}
		}
		return returnkey;
	}

	@SuppressWarnings("unchecked")
	public String getKeyCode()
	{
		//log.info("RegistrationKey: getKeyCode start");
		try
		{
			int clientid=0,lid=0,cityid=0,areaid=0,countryid=0,stateid=0;
			String clientcode="",citycode="",areacode="";
			//query = em.createNamedQuery("RegistrationKey-Candidatemaster.sql7");
			/*query = em.createQuery("SELECT cm.candidateId FROM Candidatemaster cm WHERE cm.candidateId=?1");
			query.setParameter(1, cid);
			List<String> arr_cust_name = query.getResultList(); 
			Iterator i = arr_cust_name.iterator();
			while (i.hasNext()) {
			cid = (Integer) i.next();
			}*/
			/*cid = (Integer)em.createQuery("SELECT cm.candidateId FROM Candidatemaster cm WHERE cm.candidateId=:cid")
             .setParameter("cid",cid)
             .getSingleResult(); 
			max = cid;*/
			query = em.createNamedQuery("RegistrationKey-Candidatemaster.sql7");
			query.setParameter("cid",cid);
			cid = (Integer) query.getSingleResult();
			max = cid;
			//log.info("RegistrationKey: max -"+max);
			query = em.createNamedQuery("RegistrationKey-Candidatemaster.sql8");
			query.setParameter("cid",cid);
			clientid = (Integer) query.getSingleResult();
			//log.info("RegistrationKey: clientid -"+clientid);
			clm = clmDAO.findById(clientid);
			clientcode = clm.getClientCode();
		    //log.info("RegistrationKey: clientcode -"+clientcode);
			lid = clm.getLocationId();
			//log.info("RegistrationKey: lid -"+lid);
			lm = lmDAO.findById(lid);
			cityid=lm.getCityId();
			areaid=lm.getAreaId();
			stateid=lm.getStateId();
			countryid=lm.getCountryId();
			//log.info("RegistrationKey: cityid -"+cityid+areaid+stateid+countryid);
			query = em.createNamedQuery("RegistrationKey-Locationmaster.sql11");
			query.setParameter(1, lid);
			query.setParameter(2, areaid);
			areacode = (String) query.getSingleResult();
			//log.info("RegistrationKey: areacode -"+areacode);
			query = em.createNamedQuery("RegistrationKey-Locationmaster.sql12");
			query.setParameter(1, countryid);
			query.setParameter(2, cityid);
			query.setParameter(3, stateid);
			List<Object[]> result5 = query.getResultList();
			for (Object[] row: result5) {    
				citycode = (String) row[0];
				//System.out.println("code: " + citycode);     
			} 
			//lm = (Locationmaster) query.getSingleResult();	
			//citycode = lm.getCode();
			//log.info("RegistrationKey: citycode -"+citycode);
						
			String srl = "";
			if (max<10)
			{
				srl = "000" + max;
			}
			else if (max<100)
			{
				srl = "00" + max;
			}
			else if (max<1000)
			{
				srl = "0" + max;
			}
			else
				srl = "" + max;

			returnkey = "" + clientcd + "-" + citycode + "-"  + srl; //+ areacode + "-"
			//log.info("RegistrationKey: returnkey -"+returnkey);
		}
		catch(Exception e)
		{
			System.out.println("key Error 2: " + e.getMessage());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception e)
			{
				System.out.println("Finally Exception : " + e.getMessage());
			}
		}
		return returnkey;
	}
	
}
