package com.ngs.gen;

import java.io.PrintStream;
import java.sql.*;

public class RegistrationInfo
{
    Connection con;
    Statement stmt;
    ResultSet rs;
    String sql;
	public int clinetid=0,examid =0,cid=0,mailadd = 0,offstateID = 0,offcountryID = 0,homestateID = 0,homecountryID = 0,experience = 0,bdate = 0,byear = 0,sex = 0,bmonth = 0,tempsecid =0,tempcgid =0,ddno = 0,dddate = 0,ddmonth = 0,ddyear = 0,scheduleid = 0,totalseats = 0,seatsreserved =0;


	public String offadd = "",offcityID = "",offpin = "",offphone = "",offfax = "",homeadd = "",
	homecityID = "",homepin = "",homephone = "",homefax = "",cell = "",pager = "",email = "",exp = "",firstname = "",lastname = "",dt = "",mt= "",dob = "",username = "",password = "",qualification = "",passyr = "",percent = "",university = "",paymode = "",currency = "",ddnum = "",chdate = "",drawnbank = "",branchname = "",shdate = "";

    public RegistrationInfo()
    {
    }

    public synchronized void getNextValue()
    {
        try
        {
        }
		catch(Exception exception1)
        {
			System.err.println("Get ERROR : " + exception1.toString());
        }
        finally
        {
        }
    }

    public static synchronized void setNextValue()
    {
		try
        {
			
        }
		catch(Exception exception1)
        {
			System.err.println("Set ERROR : " + exception1.toString());
        }
        finally
        {
        }
    }
}
