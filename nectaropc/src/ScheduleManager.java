import java.io.*;
import java.sql.*;
import java.util.Vector;
import java.util.Calendar;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.log4j.Logger;

import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;
import com.ngs.gen.*;

public class ScheduleManager extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null,rs1 = null,rs2 = null;
	Vector vlocationid = new Vector();
	static Logger log = Logger.getLogger(ScheduleManager.class);

	public void init()
	{
		try
		{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		}
		catch(Exception e)
		{
			//System.out.println("Connection Error : " + e.getMessage());
		}
	}

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		res.setContentType("TEXT/HTML");
		out.println("<HTML><HEAD><TITLE>Schedule Manager</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		String action = req.getParameter("action");
		HttpSession session=req.getSession(true);
		try
		{
			if (action == null || action == "")
			{
				View(req,res);
			}
			else
			{
				doPost(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		out.println("<HTML><HEAD><TITLE>Schedule Manager</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		try
		{
			String action = req.getParameter("action");
			if (action.equalsIgnoreCase("doAdd"))
			{
				Add(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}

	public void Display(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null;
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			Calendar today = Calendar.getInstance();
			int month = today.get(Calendar.MONTH);
			month++;
			String mth ="";
			if (month<10)
			{
				mth = "0" + month;
			}
			else
				mth = "" + month;
			int year = today.get(Calendar.YEAR);
			String dt = year + "-" + mth ;
			sql = "SELECT * FROM Schedule WHERE ScheduleDate like '"+dt+"%' ORDER BY ExamID,ScheduleDate,SectionID";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int count=1;
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH>Sr. No.</TH><TH>Client Name</TH><TH>Schedule Date</TH><TH>From Time</TH><TH>To Time</TH><TH>Number of Seats Available</TH></TR>");

			while (rs.next())
			{
				sql = "SELECT ClientName FROM ClientMaster WHERE ClientID=" + rs.getInt("ClientID");
				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				out.println("<TR><TD>"+count+"</TD><TD>");
				while (rs1.next())
				{
					out.println(rs1.getString("ClientName") );
				}
				String date = rs.getString("ScheduleDate");
				date = Utils.getFullDate(date);
				String timefrom = rs.getString("TimeFrom");
				timefrom = timefrom.substring(0,5);
				String timeto = rs.getString("TimeTo");
				timeto = timeto.substring(0,5);
				out.println("</TD><TD>" + date + "</TD><TD>" + timefrom + "</TD><TD>" + timeto + "</TD><TD>" + rs.getInt("NoOfSeats") + "</TD></TR>");
				count++;
			}
			out.println("</TABLE>");
			out.println("</BODY>");
			out.println("</HTML>");
		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
			else
				out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}
/////*************************************************/////date calculation
	public int  getDateForDay(int firstday,int day)
	{
		int tdate=0;

		if(firstday<day)
		{
			//tdate = (7-firstday) ; //nov - sat
			if (day == 7)
			{
				tdate = (7-firstday)+1 ;
////System.out.println("if(firstday<day) (7-firstday)+1 ");
			}
			else
			{
				tdate = (7-firstday)-1 ;
////System.out.println("if(firstday<day) (7-firstday)-1 ");
			}
////System.out.println(" < firstday : " + firstday +" day : " + day );

		}
		else if (firstday > day)
		{
			tdate = (7 - firstday) + (day) +1 ;
////System.out.println(" > firstday : " + firstday + " day : " + day );
////System.out.println("else if (firstday > day)   (7 - firstday) + (day) +1");
		}
		else if (firstday==day)
		{
			tdate =1;
		}
//out.println("tdate : " + tdate);
		return tdate;

	}

	public void Add(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null;
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			int clientid = 0 ;
			int month = Integer.parseInt(req.getParameter("month"));
			int examid = Integer.parseInt(req.getParameter("examid"));
			int sectionid = Integer.parseInt(req.getParameter("sectionid"));
//out.println("sid : " + sectionid);

			int day = Integer.parseInt(req.getParameter("day")); //day serial number of required date eg: thursday's serial no -> 5

			int year = Integer.parseInt(req.getParameter("year"));
			String fromhrs = req.getParameter("fromhrs");
			String frommin = req.getParameter("frommin");
			String tohrs = req.getParameter("tohrs");
			String tomin = req.getParameter("tomin");

			Calendar today = Calendar.getInstance();
			today.set(year, month, 1);

			int dayofweek = today.get(Calendar.DAY_OF_WEEK); //firstday on whhich 1 date falls

//out.println("dow : "+dayofweek);
			int newdate = getDateForDay(dayofweek,day);
//out.println("newdate : " + newdate);

			int weekcount = 0;
			int count = newdate;
			int maxdays = today.getMaximum(Calendar.DATE);

			while (count <= maxdays)
			{
				weekcount++;
				count = count + 7;
			}
//delete from Schedule where Scheduledate >='2002-03-04'
			month++;  // after calculation of date for verification check month is incremented because month starts from 0-11.

			int tempmonth = month;
			count = newdate;
			String checkdate = "" + year + "-" + month + "-" +count;
			sql = "SELECT ScheduleID FROM Schedule WHERE ScheduleDate='" + checkdate +"'";
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
	  		rs2 = pstmt.executeQuery();
			if (!rs2.next())
			{
				sql = "SELECT ClientID FROM ClientMaster WHERE ClientType=1";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					clientid = rs.getInt("ClientID");
					int i = 1;
					count = newdate;
					while (i <= weekcount)
					{
						String scdate = "" + year + "-" + tempmonth + "-" +count;
//out.println("<br>date : " + scdate);//delete from Schedule where ScheduleId>5
						int seats = 0;
						String tempfrom = ""+fromhrs + ":" + frommin +":00";
						String tempto = ""+tohrs + ":" + tomin + ":00";
						com.ngs.gen.NextValues scheduleID    =   new com.ngs.gen.NextValues("Schedule", "ScheduleID");
						int nextscheduleID    =    scheduleID.getNextValue();
						boolean val    =    scheduleID.setNextValue();
						sql = "SELECT AvailableSeats FROM ClientMaster WHERE ClientID=" + clientid;
	//out.println("<BR>"+sql);
						pstmt = con.prepareStatement(sql);
						rs1 = pstmt.executeQuery();
						while (rs1.next())
						{
							seats = rs1.getInt("AvailableSeats");
						}
						String testname = "";
						sql = "SELECT TestName FROM NewExamDetails WHERE ExamID=" + examid + " and SectionID=" + sectionid;
	//out.println("<BR>"+sql);
						pstmt = con.prepareStatement(sql);
						rs1 = pstmt.executeQuery();
						while (rs1.next())
						{
							testname = rs1.getString("TestName");
						}

						sql = "INSERT INTO Schedule (ScheduleID,ClientID,ExamID,SectionID,ScheduleDate,TimeFrom,TimeTo,NoOfSeats) VALUES (" + nextscheduleID + "," + clientid + "," + examid + "," + sectionid + ",'" + scdate + "','" + tempfrom + "','" + tempto + "'," + seats +")";//
	//out.println("<BR>"+sql);
						pstmt = con.prepareStatement(sql);
						int confirm = pstmt.executeUpdate();
						if (confirm <= 0)
						{
							out.println("Problem in Inserting in Schedule !!");

						}
						count = count + 7;
						i++;
					}
				}
				res.sendRedirect(req.getRequestURI());
			}
			else
			{
				out.println("Schedule Already present for the selected month <B>"+checkdate+"</b> !!");
				out.println("<BR><INPUT TYPE=BUTTON VALUE=BACK onclick='javascript:history.back();'>");
			}
		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
			else
				out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}



	public void View(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		out.println("<HTML><HEAD><TITLE>Schedule Manager</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		String sql = null,errorstr="";
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);

			String CandidateID = req.getParameter("CandidateID");//session
			int candidateid=0,examid=0;
			if (CandidateID == null || CandidateID == "" || CandidateID.equals(null) || CandidateID.equals("")){
				candidateid = 1;}
			else
				candidateid = Integer.parseInt(CandidateID);

			out.println("<FORM NAME=frmAdd METHOD=POST ACTION="+req.getRequestURI()+">");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=2>Schedule Exam</TH></TR>");
			out.println("<TR><TD ALIGN=RIGHT>Exam Name :</TD><TD ALIGN=LEFT><SELECT NAME=sectionid>");

			sql = "SELECT ExamID FROM ExamMaster WHERE ModeratorID=" + candidateid;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				examid = rs.getInt("ExamID");
				String pql = "SELECT DISTINCT(SectionID),TestName FROM NewExamDetails WHERE ExamID=" + examid;
//out.println(pql);
  				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				while (rs1.next())
				{
					out.println("<OPTION VALUE="+rs1.getInt("SectionID")+">"+rs1.getString("TestName")+"</OPTION>");
				}
			}
			out.println("</SELECT></TD></TR>");
			out.println("<TR><TD ALIGN=RIGHT>Year :</TD><TD ALIGN=LEFT><SELECT NAME=year><OPTION VALUE=2012 SELECTED>2012</OPTION><OPTION VALUE=2013>2013</OPTION></SELECT></TD></TR>");

			Calendar mycal = Calendar.getInstance();
			int month = mycal.get(Calendar.MONTH);
			month++;
//out.println("Month: " + month );
//println("DATE: " +mycal.get(Calendar.DATE) );
//out.println("Month: " +mycal.get(Calendar.MONTH) );
//out.println("YEAR: " +mycal.get(Calendar.YEAR) );

			out.println("<TR><TD ALIGN=RIGHT>Month :</TD><TD ALIGN=LEFT><SELECT NAME=month>");
			switch (month)
			{
				case 1:
					out.println("<OPTION VALUE=0 SELECTED>January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 2:
					out.println("<OPTION VALUE=0>January</OPTION><OPTION VALUE=1 SELECTED>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 3:
					out.println("<OPTION VALUE=0>January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2 SELECTED>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 4:
					out.println("<OPTION VALUE=0>January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3 SELECTED>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 5:
					out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4 SELECTED>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 6:
					out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 SELECTED>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 7:
					out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6 SELECTED>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 8:
					out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7 SELECTED>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 9:
					out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8 SELECTED>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 10:
					out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9 SELECTED>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 11:
					out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10 SELECTED>November</OPTION><OPTION VALUE=11>December</OPTION>");
					break;
				case 12:
					out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11 SELECTED>December</OPTION>");
					break;
			}
			out.println("</SELECT></TD></TR>");


			out.println("<TR><TD ALIGN=RIGHT>Day :</TD><TD ALIGN=LEFT><SELECT NAME=day><OPTION VALUE=1>Sunday</OPTION><OPTION VALUE=2>Monday</OPTION><OPTION VALUE=3>Tuesday</OPTION><OPTION VALUE=4>Wednesday</OPTION><OPTION VALUE=5 SELECTED>Thursday</OPTION><OPTION VALUE=6>Friday</OPTION><OPTION VALUE=7>Saturday</OPTION></SELECT></TD></TR>");

			out.println("<TR><TD ALIGN=RIGHT>From Time :</TD><TD ALIGN=LEFT><SELECT NAME=fromhrs>");
			for (int i=1;i<25 ; i++)
			{
				if (i==13)
				{
					out.println("<OPTION VALUE="+i+" SELECTED>"+i+"</OPTION>");
				}
				else
					out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT>hr &nbsp <SELECT NAME=frommin><OPTION VALUE=0>00</OPTION>");
			for (int i=15;i<=60 ; i=i+15)
			{
				out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT>min</TD></TR>");

			out.println("<TR><TD ALIGN=RIGHT>To Time :</TD><TD ALIGN=LEFT><SELECT NAME=tohrs>");
			for (int i=1;i<25 ; i++)
			{
				if (i==16)
				{
					out.println("<OPTION VALUE="+i+" SELECTED>"+i+"</OPTION>");
				}
				else
					out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT>hr &nbsp <SELECT NAME=tomin><OPTION VALUE=0>00</OPTION>");
			for (int i=15;i<=60 ; i=i+15)
			{
				out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT>min</TD></TR>");

			out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Submit><INPUT TYPE=HIDDEN NAME=action VALUE='doAdd'><INPUT TYPE=HIDDEN NAME=examid VALUE="+examid+"></TH></TR>");
			out.println("</TABLE>");
			out.println("</FORM>");
			out.println("<BR><HR SIZE=1>");
			Display(req,res);
			out.println("</BODY>");
			out.println("</HTML>");
		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
			else
				out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}
	public void destroy()
	{
	}
}
