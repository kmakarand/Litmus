package com.ngs;

import java.sql.*;
import com.ngs.gbl.*;

public class ConnectionDB
{
	
   public static ConnectionPool pool=null;
   
   public ConnectionDB()
	{
	   try
		{
		 pool = new ConnectionPool();
		 pool.setSize(10);
		 pool.setDriver("com.mysql.jdbc.Driver");
		 pool.setURL("jdbc:mysql://localhost/nectar?autoReconnect=true");
		 pool.setUsername("nectar");
		 pool.setPassword("nec76tar");
         pool.initializePool();
		 }catch(Exception e){System.out.println("Exception raised ConnectionDB");
		                    }

     }
}

