//package com.ngs.gbl;
import java.io.*;
import java.sql.*;

import javax.persistence.EntityManager;
import javax.persistence.Query;

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
					query = em.createNamedQuery("RegistrationKey-Candidatemaster.sql2");
					query.setParameter(cid, cid);
					cm = (Candidatemaster) query.getSingleResult();
					clientid = cm.getClientId();
					query = em.createNamedQuery("RegistrationKey-Clientmaster.sql3");
					query.setParameter(clientid, clientid);
					clm = (Clientmaster) query.getSingleResult();
					lid = clm.getLocationId();
					query = em.createNamedQuery("RegistrationKey-Locationmaster.sql4");
					query.setParameter(lid, lid);
					lm = (Locationmaster) query.getSingleResult();
					cityid=lm.getCityId();
					areaid=lm.getAreaId();
					countryid=lm.getCountryId();
					query = em.createNamedQuery("RegistrationKey-Locationmaster.sql5");
					query.setParameter(lid, lid);
					query.setParameter(areaid, areaid);
					lm = (Locationmaster) query.getSingleResult();
					areacode = lm.getCode();
					query = em.createNamedQuery("RegistrationKey-Locationmaster.sql6");
					query.setParameter(countryid, countryid);
					query.setParameter(cityid, cityid);
					lm = (Locationmaster) query.getSingleResult();
					citycode = lm.getCode();
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
			System.out.println("key Error : " + e.getMessage());
		}
		finally
		{
			try
			{
				em.close();
			}
			catch(Exception e)
			{
				System.out.println("Finally Exception : " + e.getMessage());
			}
		}
		return returnkey;
	}

	public String getKeyCode()
	{
		try
		{
			int clientid=0,lid=0,cityid=0,areaid=0,countryid=0,stateid=0;
			String clientcode="",citycode="",areacode="";
			query = em.createNamedQuery("RegistrationKey-Candidatemaster.sql7");
			query.setParameter(cid, cid);
			cm = (Candidatemaster) query.getSingleResult();
			max = cm.getCandidateId();
			query = em.createNamedQuery("RegistrationKey-Candidatemaster.sql8");
			query.setParameter(cid, cid);
			cm = (Candidatemaster) query.getSingleResult();
			clientid = cm.getClientId();
			query = em.createNamedQuery("RegistrationKey-Clientmaster.sql9");
			query.setParameter(clientid, clientid);
			clm = (Clientmaster) query.getSingleResult();
		    clientcode = clm.getClientCode();
			lid = clm.getLocationId();
			query = em.createNamedQuery("RegistrationKey-Locationmaster.sql10");
			query.setParameter(lid, lid);
			lm = (Locationmaster) query.getSingleResult();
			cityid=lm.getCityId();
			areaid=lm.getAreaId();
			stateid=lm.getStateId();
			countryid=lm.getCountryId();
			query = em.createNamedQuery("RegistrationKey-Locationmaster.sql11");
			query.setParameter(lid, lid);
			query.setParameter(areaid, areaid);
			lm = (Locationmaster) query.getSingleResult();	
			areacode = lm.getCode();
			query = em.createNamedQuery("RegistrationKey-Locationmaster.sql12");
			query.setParameter(countryid, countryid);
			query.setParameter(cityid, cityid);
			query.setParameter(stateid, stateid);
			lm = (Locationmaster) query.getSingleResult();	
			citycode = lm.getCode();
						
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
		}
		catch(Exception e)
		{
			//System.out.println("key Error : " + e.getMessage());
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
