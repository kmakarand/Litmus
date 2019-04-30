import java.io.*;
import java.sql.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Vector;
import java.util.Calendar;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.log4j.Logger;

import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;
import com.ngs.gen.*;

public class NewScheduleManager extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null,stmt1 = null,stmt2=null;
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
			if (action.equals("doDisplay"))
			{
				Display(req,res);
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
			try
			{
			String sql = "",passVar="";
			log.debug("Display");
			Date newDate=null;
			int ClientID=0;
			String ScheduleDate = req.getParameter("ScheduleDate");
			ClientID = Integer.parseInt(req.getParameter("ClientID"));
			log.info("ClientID  :"+req.getParameter("ClientID"));
			if(!ScheduleDate.equals("pass"))
			{
			SimpleDateFormat sdfSource =new SimpleDateFormat("yyyy-MMM-dd");
			newDate = (Date)sdfSource.parse(ScheduleDate);
			SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
			ScheduleDate = sdfDest.format(newDate);
			}
			log.info("ScheduleDate  :"+ScheduleDate);
			log.info("Month  :"+req.getParameter("month"));
		
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			Calendar today = Calendar.getInstance();
			int month = Integer.parseInt(req.getParameter("month"));//today.get(Calendar.MONTH);
			month++;
			log.warn(" month :"+month);
			String mth = "";
			if (month<10)
			{
				mth = "0" + month;
			}
			else
				mth = "" + month;
			int year = today.get(Calendar.YEAR);
			String startdt = year + "-" + mth + "-" + 1 ;
			String enddt = year + "-" + (mth+1) + "-" + 1 ;
			
			if (ClientID != 0)
			{
				sql = "SELECT * FROM Schedule s, exammaster e WHERE s.ScheduleDate"+
				" and ClientID = ? and e.examid=s.examid ORDER BY e.ExamID,s.ScheduleDate,s.SectionID";
				 pstmt = con.prepareStatement(sql);
				 pstmt.setInt(1,ClientID);
			}
			if(!ScheduleDate.equals("pass"))
			{
				if (ClientID != 0)
				{
					sql = "SELECT * FROM Schedule s, exammaster e WHERE"+
					" ScheduleDate>=? and  ScheduleDate<? and ClientID = ? and e.examid=s.examid ORDER BY e.ExamID,s.ScheduleDate,s.SectionID";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,startdt);
					pstmt.setString(2,enddt);
					pstmt.setInt(3,ClientID);
				}
				else
				{
					sql = "SELECT * FROM Schedule s, exammaster e WHERE"+
					" ScheduleDate>=? and  ScheduleDate<? and e.examid=s.examid ORDER BY e.ExamID,s.ScheduleDate,s.SectionID";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,startdt);
					pstmt.setString(2,enddt);
				}
				
			}
			else
			{
				if (ClientID != 0)
				{
					sql = "SELECT * FROM Schedule s, exammaster e WHERE"+
					" ScheduleDate>=? and  ScheduleDate<? and ClientID = ? and e.examid=s.examid ORDER BY e.ExamID,s.ScheduleDate,s.SectionID";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,startdt);
					pstmt.setString(2,enddt);
					pstmt.setInt(3,ClientID);
				}
				else
				{
					sql = "SELECT * FROM Schedule s, exammaster e WHERE"+
					" ScheduleDate>=? and  ScheduleDate<? and e.examid=s.examid ORDER BY e.ExamID,s.ScheduleDate,s.SectionID";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,startdt);
					pstmt.setString(2,enddt);
				}
			}
			
			log.warn("sql :"+sql);
			rs = pstmt.executeQuery();
			int count=1;
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<BR></BR>");
			out.println("<TR><TH COLSPAN=7>SCHEDULE FOR TRAINING PROGRAME</TH></TR>");
			out.println("<TR><TH>Sr. No.</TH><TH>Client Name</TH><TH>Exam Name</TH><TH>Schedule Date</TH><TH>From Time</TH><TH>To Time</TH><TH>Number of Seats Available</TH></TR>");

			while (rs.next())
			{
				sql = "SELECT ClientName FROM ClientMaster WHERE ClientID=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,rs.getInt("ClientID"));
				rs1 = pstmt.executeQuery();
				out.println("<TR><TD>"+count+"</TD><TD>");
				while (rs1.next())
				{
					out.println(rs1.getString("ClientName") );
				}
			    out.println("</TD><TD>");
				out.println(rs.getString("Exam"));
				//out.println("</TD><TD>");
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
			out.println("<BR></BR><BR></BR>");
			out.println("<TR><TH COLSPAN=2>View Schedule Exam</TH></TR>");
			out.println("<TR><TD ALIGN=RIGHT>Client Name :</TD><TD ALIGN=LEFT><SELECT NAME=ClientID>");
			sql = "select distinct(clientname),c.clientid from clientmaster c,schedule s"+ 
							  " where c.clientid=s.clientid and c.clientid in"+
							  " (SELECT distinct(clientid) FROM nectar.Schedule"+
							  " where ScheduleDate>= CURRENT_DATE ORDER BY ScheduleDate)";
//			  out.println(sql);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			String ClientName="";
			int ClientID=0;
			while (rs.next())
			{
				ClientName=rs.getString("clientname");
				ClientID=rs.getInt("ClientID");
				//log.info("ClientName :"+ClientName);
				//log.info("ClientID :"+ClientID);
				out.println("<OPTION VALUE="+ClientID+">"+ClientName+"</OPTION>");
			}
			out.println("<option value="+0+" SELECTED>Please Select Client</option>");
			out.println("</SELECT></TD></TR>");
			
			out.println("<TR><TD ALIGN=RIGHT>Schedule Date :</TD><TD ALIGN=LEFT><SELECT NAME=ScheduleDate>");
			sql = "SELECT distinct(ScheduleDate) FROM nectar.Schedule where ScheduleDate>= CURRENT_DATE ORDER BY ScheduleDate";
//			  out.println(sql);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			DateFormat formatter=null; 
			String rsDate="";
			while (rs.next())
			{				
 				formatter = new SimpleDateFormat("yyyy-MMM-dd");
 				rsDate = formatter.format(rs.getDate("ScheduleDate"));
 				//log.info("Schedule Date :"+rsDate);
				out.println("<OPTION VALUE="+rsDate+">"+rsDate+"</OPTION>");
			
			}
			out.println("<option value=pass SELECTED>Please Select Schedule Date</option>");
			out.println("</SELECT></TD></TR>");
				
			Calendar mycal = Calendar.getInstance();
			int month = mycal.get(Calendar.MONTH);
			month++;
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
			out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Submit><INPUT TYPE=HIDDEN NAME=action VALUE='doDisplay'><INPUT TYPE=HIDDEN NAME=examid VALUE="+examid+"></TH></TR>");
			out.println("</TABLE>");
			out.println("</FORM>");
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
