package com.ngs.gen;

import java.io.PrintStream;
import java.sql.*;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.ngs.EntityManagerHelper;
import com.ngs.dao.NextvaluesDAO;
import com.ngs.entity.Nextvalues;

public class NextValues
{

    public int currentValue;
    private int nextValue;
    private String table;
    private String field;
    Query query=null;
    EntityManager em = EntityManagerHelper.getEntityManager();
    Nextvalues nv =null;
    Nextvalues nvid = null;
    Logger log = Logger.getLogger(NextValues.class);


    public NextValues(String table, String field)
    {
        currentValue = 1;
        nextValue = 1;
        this.table = table;
        this.field = field;
	}

    public synchronized int getNextValue()
    {
        try
        {
            try
            {
            	query = em.createNamedQuery("NextValues-NextvaluesId.sql1");
            	query.setParameter(1, table);
            	query.setParameter(2, field);
            	nv = (Nextvalues) query.getSingleResult();
            	            
                if(nv!=null)
                {
                   	//System.out.println("NextValues:getNextValue  1:nextValue:"+nextValue);
					nextValue = nv.getNextValue();
                    //System.out.println("NextValues:getNextValue  2:nextValue::"+nextValue);
                    currentValue = nextValue;
                } else
                {
                    ////System.err.println("NextValue for (" + table + ", " + field + ") not Found.");
                    byte byte0 = -1;
                    return byte0;
                }
				//System.out.println("NextValues:getNextValue  3:nextValue:"+nextValue);
                int i = nextValue;
				//System.out.println("NextValues:getNextValue  4:i:"+nextValue);
                return i;
            }
            catch(Exception exception1)
            {
                //System.err.println("ERROR : " + exception1.toString());
            }
            byte byte1 = -1;
            return byte1;
        }
        finally
        {
        }
    }
    
    public synchronized int getWithSetNextValue()
    {
    	boolean flag=false;
    	int genNextValue=0;
    	NextvaluesDAO nvDAO = new NextvaluesDAO();
    	//Nextvalues nv  = null;
        try
        {
            try
            {
                nextValue = getNextValue();
                //nv  = nvDAO.findById(nextValue);
                genNextValue = nextValue + 1;
               	//System.err.println("NextValues:getNextValue  6:nextValue:"+nextValue);
				//System.err.println("NextValues:getNextValue  6:table:"+table);
				//System.err.println("NextValues:getNextValue  6:field:"+field);
                EntityManagerHelper.beginTransaction();
                nv.setNextValue(genNextValue);
            	nv.setTableName(table);
            	nv.setFieldName(field);
               	nv = nvDAO.update(nv);
            	EntityManagerHelper.commit();
            	
            	
                if(nv!=null)
                {
                    //System.err.println("NextValue for (" + table + ", " + field + ") is successfully Updated."+nextValue);
                    flag = true;
                   
                }
                else
                {
                	 //System.err.println("Error in Updating NextValue for (" + table + ", " + field + ").");
                     flag = false;
                	
                }
               
                
            }
            catch(Exception exception1)
            {
                System.err.println("ERROR : " + exception1.toString());
            }
           if(flag)
        	   log.info("NextValue genereated successfully :"+flag);
           else
        	   log.info("NextValue genereated failed :"+flag);
           
           log.info("NextValue genereated :"+nv.getNextValue());
           return genNextValue;
           
        }
        finally
        {
 
        }
    }
    
    /*public boolean checkNextValue(int varNextValue)
    {
    	boolean flag = false;
    	int curNextValue = getNextValue();
    	if (varNextValue == (curNextValue+1))
    	{
    		flag=true;
    	}
    	else
    	{
    		flag=false;
    	}
    	
    	return flag;
    }*/

    public synchronized boolean setNextValue()
    {
        try
        {
            try
            {
                
                nextValue = nextValue + 1;
                NextvaluesDAO nvDAO = new NextvaluesDAO();
            	Nextvalues nv  = new Nextvalues();
				//System.err.println("NextValues:getNextValue  6:nextValue:"+nextValue);
				//System.err.println("NextValues:getNextValue  6:table:"+table);
				//System.err.println("NextValues:getNextValue  6:field:"+field);
                EntityManagerHelper.beginTransaction();
                query = em.createNamedQuery("NextValues-NextvaluesId.sql2");
                
                //query = em.createQuery("UPDATE Nextvalues nv SET nv.nextValue=?1 WHERE nv.tableName=?2 AND nv.fieldName=?3");
                query.setParameter(1, nextValue);
                query.setParameter(2, table);
            	query.setParameter(3, field);
            
            	nv.setNextValue(nextValue);
            	nv.setTableName(table);
            	nv.setFieldName(field);
               	nvDAO.update(nv);
            	EntityManagerHelper.commit();
            	
            	boolean flag=false;
                if(nv!=null)
                {
                    //System.err.println("NextValue for (" + table + ", " + field + ") is successfully Updated."+nextValue);
                    flag = true;
                    return flag;
                }
                else
                {
                	 //System.err.println("Error in Updating NextValue for (" + table + ", " + field + ").");
                     flag = false;
                	
                }
               
                return flag;
            }
            catch(Exception exception1)
            {
                System.err.println("ERROR : " + exception1.toString());
            }
            boolean flag2 = false;
            return flag2;
        }
        finally
        {
 
        }
    }
    
    /*public void ResetNextValues()
    {
		//System.out.println("ResetNextValues :");

		try{

				sql = "SELECT max(candidateid) AS CandidateID FROM candidatemaster";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int CandidateID=0,ExamID=0,NewExamID=0,ClientID=0,ScheduleID=0;
				while(rs.next())
				{
					CandidateID = rs.getInt("CandidateID");
					//System.out.println("CandidateID :"+CandidateID);
				}
				sql = "SELECT max(ExamID) AS ExamID FROM ExamMaster";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					ExamID = rs.getInt("ExamID");
					//System.out.println("ExamID :"+ExamID);
				}
				sql = "SELECT max(ExamID) AS ExamID FROM NewExamDetails";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					NewExamID = rs.getInt("ExamID");
					//System.out.println("NewExamID :"+NewExamID);
				}
				sql = "SELECT max(ClientID) AS ClientID FROM ClientMaster";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					ClientID = rs.getInt("ClientID");
					//System.out.println("ClientID :"+ClientID);
				}
				sql = "SELECT max(ScheduleID) AS ScheduleID FROM Schedule";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					ScheduleID = rs.getInt("ScheduleID");
					//System.out.println("ScheduleID :"+ScheduleID);
				}
				int i=0;
				sql = "UPDATE NextValues SET NextValue="+CandidateID+" where tableName='CandidateMaster'";
				pstmt = con.prepareStatement(sql);
				i = pstmt.executeUpdate(sql);
				sql = "UPDATE NextValues SET NextValue="+ExamID+" where tableName='ExamMaster'";
				pstmt = con.prepareStatement(sql);
				i = pstmt.executeUpdate(sql);
				sql = "UPDATE NextValues SET NextValue="+NewExamID+" where tableName='NewExamDetails'";
				pstmt = con.prepareStatement(sql);
				i = pstmt.executeUpdate(sql);
				sql = "UPDATE NextValues SET NextValue="+ClientID+" where tableName='ClientMaster'";
				pstmt = con.prepareStatement(sql);
				i = pstmt.executeUpdate(sql);
				sql = "UPDATE NextValues SET NextValue="+ScheduleID+" where tableName='Schedule'";
				pstmt = con.prepareStatement(sql);
				i = pstmt.executeUpdate(sql);
				}catch(Exception e){
				System.out.println("Error :"+e.getMessage());
			}
    }*/

}
