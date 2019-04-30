package com.ngs.gbl;


import java.sql.*;
import java.util.*;


public class Answer
{

	public Answer() {}


	public String getStoredAnswer(String utemp,Connection con,int seq)
    {
		String answer = "0";
		try
		{
			PreparedStatement ps =  con.prepareStatement("Select ansg from "+utemp+" where SequenceNo=?");
			ResultSet rs = null;
			ps.setInt(1,seq);
			rs  = ps.executeQuery();
			while (rs.next()) answer = rs.getString("ansg");
		}
		catch (SQLException e)
		{
			//System.out.println("Exception caught in Bean Answer method getstoredanswer"+e.getMessage());
		}
		  return(answer);	
	}
	

	public int getTotalTempCount(String utemp,Connection con)
	{
		int count=0;
		try
		{
			PreparedStatement ps =  con.prepareStatement("Select Count(*) from "+utemp);
			ResultSet rs = null;
			rs  = ps.executeQuery();
			while (rs.next()) count = rs.getInt(1);
		}
		catch (SQLException e)
		{
			//System.out.println("Exception caught in Bean Answer method getTotalTempCount"+e.getMessage());
		}
		  return(count);	
	}

}
