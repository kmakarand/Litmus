package com.ngs;

import javax.persistence.EntityManager;

import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.ngs.dao.ChapterdetailsDAO;
import com.ngs.dao.ModuledetailsDAO;
import com.ngs.dao.UserdetailsDAO;
import com.ngs.entity.Chapterdetails;
import com.ngs.entity.Moduledetails;
import com.ngs.entity.Userdetails;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ChapterDetailsBean {
	
	UserdetailsDAO obUserdetailsDAO = new UserdetailsDAO();
	ChapterdetailsDAO objChapterdetailsDAO = new ChapterdetailsDAO();
	
	int chaptercount=0;
	int ch1cnt=0,ch2cnt=0,ch3cnt=0,ch4cnt=0,ch5cnt=0,ch6cnt=0,ch7cnt=0,ch8cnt=0;
	int basch1cnt=0,basch2cnt=0,basch3cnt=0,basch4cnt=0,basch5cnt=0,basch6cnt=0,basch7cnt=0,basch8cnt=0;
	int intch1cnt=0,intch2cnt=0,intch3cnt=0,intch4cnt=0,intch5cnt=0,intch6cnt=0,intch7cnt=0,intch8cnt=0;
	int advch1cnt=0,advch2cnt=0,advch3cnt=0,advch4cnt=0,advch5cnt=0,advch6cnt=0,advch7cnt=0,advch8cnt=0;
	
	//@Transactional(isolation=Isolation.READ_COMMITTED)
	public boolean setChapterCount(int cid, String modulename, int modulecount, Connection dbConnection) throws SQLException, ClassNotFoundException
	{
			
			boolean cntFlag=false;String chname="";
			Userdetails objUserdetails=obUserdetailsDAO.findById(cid);
			/*System.out.println("modulecount..............	:"+modulecount);
			System.out.println("candidateid :::::::"+cid);
			System.out.println("modulename :::::::"+modulename);*/
			
			Chapterdetails objChapterdetails = objChapterdetailsDAO.findById(cid);
			int totchaptercount = objChapterdetails.getCh1count()+objChapterdetails.getCh2count()+objChapterdetails.getCh3count()+objChapterdetails.getCh4count()+objChapterdetails.getCh5count()+objChapterdetails.getCh6count()+objChapterdetails.getCh7count()+objChapterdetails.getCh8count();
			System.out.println("totchaptercount :::::::"+totchaptercount);
			
			// JDBC driver name and database URL
		    /*String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		    String DB_URL = "jdbc:mysql://127.0.0.1:3306/nectar?autoReconnect=true";
		    String USER = "nectar";
		    String PASS = "nec76tar";
		    Connection dbConnection = null;*/
		    PreparedStatement preparedStatement = null;
		    PreparedStatement preparedStatement1 = null;
		    		  
	        //Class.forName("com.mysql.jdbc.Driver");
	        //dbConnection = DriverManager.getConnection(DB_URL,USER,PASS);
	        dbConnection.setAutoCommit(false);
	        
	        String TableSQL = "select * from ChapterDetails where candidateid=?";
			preparedStatement1 = dbConnection.prepareStatement(TableSQL);
			preparedStatement1.setInt(1,cid);
			ResultSet rs = preparedStatement1.executeQuery();
	    	if(rs.next())
	    	do
	    	{
	    		ch1cnt = rs.getInt("Ch1Count");
	    		ch2cnt = rs.getInt("Ch2Count");
	    		ch3cnt = rs.getInt("Ch3Count");
	    		ch4cnt = rs.getInt("Ch4Count");
	    		ch5cnt = rs.getInt("Ch5Count");
	    		ch6cnt = rs.getInt("Ch6Count");
	    		ch7cnt = rs.getInt("Ch7Count");
	    		ch8cnt = rs.getInt("Ch8Count");
	    		
	    	}while(rs.next());
	    	
			      
			if(modulename.equals("1lW1SyYq13jaczD5SAhQiJHPklQ7Ozw1u") || modulename.equals("1xumt36KpvK5Eo4YUnXHxeaG9Wq-sUncV") || modulename.equals("1-ey5pZE7AvNQ6gs49wqZ0QpxPAE5PMxG"))
		    {   
		    	//ch1cnt = objChapterdetails.getCh1count();
		    	System.out.println("chaptercount1 :"+ch1cnt);
			    System.out.println("modulename1 :"+modulename);
			    
			    if(ch1cnt>0)
		    	{
			    	chaptercount = ch1cnt - 1;
		    		String updateTableSQL = "UPDATE ChapterDetails SET ch1count = "+chaptercount+" WHERE candidateid = ?";
					preparedStatement = dbConnection.prepareStatement(updateTableSQL);
					preparedStatement.setInt(1,cid);
					preparedStatement.executeUpdate();
		    	  	cntFlag=true;
		    	}
		    	
			}
			
			else if(modulename.equals("1nTS_kH2B4AmB0N5U6te0ICzA2Ae9JvQD") || modulename.equals("1RJf31Ap3JJGhgVyyc_5dykRrH8NajjI7") || modulename.equals("12wmboj4fELkJyjqPV8_6ygpvSoiT2QIs"))
			{   
				//ch2cnt = objChapterdetails.getCh2count();
		    	System.out.println("chaptercount2 :"+ch2cnt);
			    System.out.println("modulename2 :"+modulename);
			    
			    if(ch2cnt>0)
		    	{
			    	chaptercount = ch2cnt - 1;
		    		String updateTableSQL = "UPDATE ChapterDetails SET ch2count = "+chaptercount+" WHERE candidateid = ?";
					preparedStatement = dbConnection.prepareStatement(updateTableSQL);
					preparedStatement.setInt(1,cid);
					preparedStatement.executeUpdate();
		    	  	cntFlag=true;
		    	}
		    	
		    }
		    
		    else if(modulename.equals("1xgm-e64UE5x7ll1T93mCoRXCdIKMtaoO") || modulename.equals("1TaIgKtpSZ_ITA9uqbxWVftop8RxGq831") || modulename.equals("1tNVfWbExsOfvRRNIetpbQ4aSswqXBKV2"))
			{   
		    	//ch3cnt = objChapterdetails.getCh3count();
		    	System.out.println("chaptercount3 :"+ch3cnt);
			    System.out.println("modulename3 :"+modulename);
			    
			    if(ch3cnt>0)
		    	{
			    	chaptercount = ch3cnt - 1;
		    		String updateTableSQL = "UPDATE ChapterDetails SET ch3count = "+chaptercount+" WHERE candidateid = ?";
					preparedStatement = dbConnection.prepareStatement(updateTableSQL);
					preparedStatement.setInt(1,cid);
					preparedStatement.executeUpdate();
		    	  	cntFlag=true;
		    	}
			}
			
		    else if(modulename.equals("1JGTSTINol_jx3v6wtWrPx3irN1EyDoma") || modulename.equals("1bmhyqezCsnwT3fJDJWL442MKbDL2Zlxt") || modulename.equals("1cszoHntSHW2cwnQERYrhHKt7jZjOA3Vg"))
			{   
		    	//ch4cnt = objChapterdetails.getCh4count();
		    	System.out.println("chaptercount4 :"+ch4cnt);
			    System.out.println("modulename4 :"+modulename);
			    
			    if(ch4cnt>0)
		    	{
			    	chaptercount = ch4cnt - 1;
			    	System.out.println("chaptercount4 inside:"+chaptercount);
		    		String updateTableSQL = "UPDATE ChapterDetails SET ch4count = "+chaptercount+" WHERE candidateid = ?";
		    		preparedStatement = dbConnection.prepareStatement(updateTableSQL);
		    		preparedStatement.setInt(1,cid);
		    		preparedStatement.executeUpdate();
		    		cntFlag=true;
		    	}
				
			}
			
		    else if(modulename.equals("15rOnofeL6isAwXiTJvK9qj2ln1iUvBBi") || modulename.equals("1KbdhXtXQzwIXpv_s3r6rQdgHS7WQcMov") || modulename.equals("1iCd-Wlqt2fztr9JneHdnbwaIKCDSVZ5K"))
			{   
		    	//ch5cnt = objChapterdetails.getCh5count();
		    	System.out.println("chaptercount5 :"+ch5cnt);
			    System.out.println("modulename5 :"+modulename);
			    
			    if(ch5cnt>0)
		    	{
			    	chaptercount = ch5cnt - 1;
		    		String updateTableSQL = "UPDATE ChapterDetails SET ch5count = "+chaptercount+" WHERE candidateid = ?";
					preparedStatement = dbConnection.prepareStatement(updateTableSQL);
					preparedStatement.setInt(1,cid);
					preparedStatement.executeUpdate();
		    	  	cntFlag=true;
		    	}
				
		    }
			
		    else if(modulename.equals("1e1Kna6BqWwAMNCUYU2VAGvBW0BGySzLz") || modulename.equals("1EY3ppCGGMaEWP0GU2Xy_7cm1q_KnP1fv") || modulename.equals("1uqIBzbxE9re7GHWVmUkISEFJV75c3FgQ"))
			{   
		    	//ch6cnt = objChapterdetails.getCh6count();
		    	System.out.println("chaptercount6 :"+ch6cnt);
			    System.out.println("modulename6 :"+modulename);
			    
			    if(ch6cnt>0)
		    	{
			    	chaptercount = ch6cnt - 1;
		    		String updateTableSQL = "UPDATE ChapterDetails SET ch6count = "+chaptercount+" WHERE candidateid = ?";
					preparedStatement = dbConnection.prepareStatement(updateTableSQL);
					preparedStatement.setInt(1,cid);
					preparedStatement.executeUpdate();
		    	  	cntFlag=true;
		    	}
				
		    }
			
		    else if(modulename.equals("1lW1SyYq13jaczD5SAhQiJHPklQ7Ozw1u") || modulename.equals("1y9B2VFpFBVNZ9-_DVBckQ0MD19aYC4bx") || modulename.equals("1Rb3i1chuPCNkev7oq9-J75qjtD9t_Xiu"))
			{   
		    	//ch7cnt = objChapterdetails.getCh7count();
		    	System.out.println("chaptercount7 :"+ch7cnt);
			    System.out.println("modulename7 :"+modulename);
			    
			    if(ch7cnt>0)
		    	{
			    	chaptercount = ch7cnt - 1;
		    		String updateTableSQL = "UPDATE ChapterDetails SET ch7count = "+chaptercount+" WHERE candidateid = ?";
					preparedStatement = dbConnection.prepareStatement(updateTableSQL);
					preparedStatement.setInt(1,cid);
					preparedStatement.executeUpdate();
		    	  	cntFlag=true;
		    	}
				
		    }
			
		    else if(modulename.equals("1oS_r7JQNOReVA_vi0TCIQqCcISHPuOQG") || modulename.equals("1HlgKrV7jfpBG7j3y67Uj9KeeuXgnqHPd") || modulename.equals("1K17s25dnQ91JCRs7HtGclxT21ebmwff_"))
			{   
		    	//ch7cnt = objChapterdetails.getCh7count();
		    	System.out.println("chaptercount8 :"+ch8cnt);
			    System.out.println("modulename8 :"+modulename);
			    
			    if(ch8cnt>0)
		    	{
			    	chaptercount = ch8cnt - 1;
		    		String updateTableSQL = "UPDATE ChapterDetails SET ch8count = "+chaptercount+" WHERE candidateid = ?";
					preparedStatement = dbConnection.prepareStatement(updateTableSQL);
					preparedStatement.setInt(1,cid);
					preparedStatement.executeUpdate();
		    	  	cntFlag=true;
		    	}
				
		    }
			
			if(cntFlag)
			{
				modulecount = modulecount-1;
				String updateTableSQL = "UPDATE UserDetails SET modulecount = "+modulecount+" WHERE candidateid = ?";
				preparedStatement = dbConnection.prepareStatement(updateTableSQL);
				preparedStatement.setInt(1,cid);
				preparedStatement.executeUpdate();
	    	  	cntFlag=true;
			}
			
			
		    /*int result = preparedStatement.executeUpdate();
		    if (result > 0) {
		     System.out.println("New price for all cars are calculated");
		    }*/
			dbConnection.commit();
		    if (preparedStatement != null) preparedStatement.close();
			if (dbConnection != null) dbConnection.close();
			System.out.println("Exit cntFlag :::::::"+cntFlag);
			return cntFlag;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
