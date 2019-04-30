package com.ngs.gen;


import java.sql.*;
import java.util.*;


public class InsertUpdateC
{

	public InsertUpdateC() {}


	public boolean checkTranscation(String query,Connection con)
       	{
			Statement s1 = null;
			ResultSet rs1= null;
			boolean flag= false;
			int count=0;

			

			try
			{
				s1 = con.createStatement();
				rs1=s1.executeQuery(query);
				while(rs1.next())
					{ 
						count = rs1.getInt(1);
						if(count==1) flag=true;
					}
			}catch (SQLException e)
			{
				//System.out.println("Error in Class InsertUpdateC module checkMode"+e.getMessage());
			}
			
			return(flag);
		}


}
