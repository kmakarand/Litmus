import java.io.*;
import java.sql.*;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gen.*;
import java.util.Calendar;


public class PostponementRequest extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null,rs1 = null,rs2 = null;

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
		HttpSession session=req.getSession(true);
		String action = req.getParameter("action");
		int clientid=0;
//		String sql="";
		String ClientID = (String) session.getAttribute("ClientID");
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
			clientid =1;
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);

		try
		{
			if (action == null || action == ""){
				res.setContentType("text/html");
				out.println("<HTML><HEAD><TITLE>Postponement Request</TITLE>");
				out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				out.println("<H4>Postponement Request</H4><HR SIZE=1>");
				getCanID(req,res);
			}else {
				doPost(req,res);
			}
		}catch(Exception e){
			out.println("Error : " + e.getMessage());
		}finally{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}
	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		out.println("<HTML><HEAD><TITLE>Postponement List</TITLE>");
		out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		try
		{
			String action = req.getParameter("action");
			if (action.equalsIgnoreCase("doModify"))
			{
				Modify(req,res);
			}
			else if (action.equalsIgnoreCase("doDetails"))
			{
				Details(req,res);
			}
			else if (action.equalsIgnoreCase("doDisplayError"))
			{
				DisplayError(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}

	public void DisplayError(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		HttpSession session=req.getSession(true);
		String ClientID = (String) session.getAttribute("ClientID");
		String sql = null,testname ="";
		int clientid=0,examid=0,scheduleid=0;
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
//			clientid =1;
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);
		out.println("<BR><B>Sorry your time is up for Posponement !!</B>");
		out.println("<FORM NAME=back METHOD=GET action="+req.getRequestURI()+">");
		out.println("<INPUT TYPE=SUBMIT VALUE='Go Back'>");
		out.println("</FORM>");
	}

	public void Details(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		HttpSession session=req.getSession(true);
		String ClientID = (String) session.getAttribute("ClientID");
		String sql = null,testname ="";
		int clientid=0,examid=0,scheduleid=0;
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
//			clientid =1;
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);
		
			int cid = Integer.parseInt(req.getParameter("cid"));
			//System.out.println("cid :"+cid);

		try
		{
			con = pool.getConnection();
			sql = "SELECT ExamID FROM CandidateDetails WHERE CandidateID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,cid);
			rs1 = pstmt.executeQuery();
			while (rs1.next())
			{
				examid = rs1.getInt("ExamID");
			}
			sql = "SELECT TestName FROM NewExamDetails WHERE ExamID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,examid);
			rs1 = pstmt.executeQuery();
			while (rs1.next())
			{
				testname = rs1.getString("TestName");
			}


			sql = "SELECT ScheduleID FROM SlotRegisteration WHERE CandidateID=?";
//out.println("<br>"+sql);
  			pstmt = con.prepareStatement(sql);
  			pstmt.setInt(1,cid);
  			//System.out.println("ScheduleID FROM SlotRegisteration :"+pstmt);
  			rs1 = pstmt.executeQuery();
			while (rs1.next())
			{
				scheduleid = rs1.getInt("ScheduleID");
				//System.out.println("scheduleid :"+scheduleid);
			}
			out.println("<FORM METHOD=POST NAME=form1>");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=2>Select Test Centre</TH></TR>");
			out.println("<TR><TD ALIGN=RIGHT>Test Name :</TD><TD ALIGN=LEFt>"+testname+"</TD></TR>");

			sql = "SELECT ScheduleDate,TimeFrom,TimeTo FROM Schedule WHERE ScheduleID=? and ExamID=?";
//out.println("<br>"+sql);
			String olddate="",oldtimefrom="",oldtimeto="";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,scheduleid);
			pstmt.setInt(2,examid);
			//System.out.println("pstmt :"+pstmt);
			rs1 = pstmt.executeQuery();
			while (rs.next())
			{
				String chshdate = rs.getString("ScheduleDate");
				int date = Integer.parseInt(chshdate.substring(8,10));
				int month = Integer.parseInt(chshdate.substring(5,7));
				int year = Integer.parseInt(chshdate.substring(0,4));
				Calendar today = Calendar.getInstance();
				Calendar syscal = Calendar.getInstance();
				syscal.add(Calendar.DATE, 3);	// specified by -> BSE 3 days before Exam

				Calendar examcal = Calendar.getInstance();
				examcal.set(year, month-1, date);	// mont starts from 0 . keep this in mind !!!

				if (today.after(examcal) || syscal.after(examcal) )
				{
					out.println("Sorry you are late for postponement !!!");
					String link = req.getRequestURI()+"?action=doDisplayError";
					res.sendRedirect(link);
					break;
				}

				olddate = Utils.getDate(chshdate);
				oldtimefrom = rs.getString("TimeFrom");
				oldtimefrom = oldtimefrom.substring(0,5);
				oldtimeto = rs.getString("TimeTo");
				oldtimeto = oldtimeto.substring(0,5);
				out.println("<TR><TD ALIGN=RIGHT>Schedule Test Date :</TD><TD ALIGN=LEFt>"+olddate+"</TD></TR>");
				out.println("<TR><TD ALIGN=RIGHT>Schedule Test Time :</TD><TD ALIGN=LEFt>"+oldtimefrom +"-" + oldtimeto +"</TD></TR>");
			}

			out.println("<TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>");
			out.println("<TR><TD ALIGN=RIGHT>New Test Date :</TD><TD><SELECT NAME=ScIDdate>");

			sql = "SELECT ScheduleID,ScheduleDate, TimeFrom,TimeTo FROM Schedule "+
					" WHERE ClientID=? AND ScheduleDate > CURRENT_DATE ORDER BY ScheduleDate";
//out.println("<br>"+sql);
  			pstmt = con.prepareStatement(sql);
  			pstmt.setInt(1,clientid);
  			//System.out.println("pstmt :"+pstmt);
  			rs1 = pstmt.executeQuery();
			int counter=1;		// max 4 scheddule to be displayed to Center Mager for Postponement
			while (rs1.next()){
				String date = Utils.getDate(rs1.getString("ScheduleDate"));
				//System.out.println("date :"+date);
				String timefrom = rs1.getString("TimeFrom");
				timefrom = timefrom.substring(0,5);
				String timeto = rs1.getString("TimeTo");
				timeto = timeto.substring(0,5);
				//System.out.println("timefrom :"+timefrom);
				//System.out.println("timeto :"+timeto);


				out.println("<OPTION VALUE=\""+rs1.getString("ScheduleID")+"\">"+date + " | " +
					timefrom + "-" + timeto + "</OPTION>");
				if (counter>4)
				{
					break;
				}
				counter++;
			}
			out.println("</TD></SELECT></TR>");

//			out.println("<TR><TD ALIGN=RIGHT>New Test Time :</TD><TD><SELECT NAME=ScIDtimefrom>");
//			sql = "SELECT ScheduleID,TimeFrom,TimeTo FROM Schedule WHERE ClientID="+clientid + " ORDER BY ScheduleDate";

//			rs = stmt.executeQuery(sql);
//			while (rs.next())
//			{
//				String timefrom = rs.getString("TimeFrom");
//				timefrom = timefrom.substring(0,5);
//				String timeto = rs.getString("TimeTo");
//				timeto = timeto.substring(0,5);
//				out.println("<OPTION VALUE="+rs.getString("ScheduleID")+">"+timefrom + "-" + timeto +"</OPTION>");
//			}
//			out.println("</TD></SELECT></TR>");
			out.println("<TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>");
			out.println("<TR><TH COLSPAN=2><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'>&nbsp;<INPUT TYPE=SUBMIT VALUE=Submit></TH></TR>");
			out.println("<INPUT TYPE=HIDDEN NAME=action VALUE=doModify><INPUT TYPE=HIDDEN NAME=olddate VALUE='"+olddate+"'><INPUT TYPE=HIDDEN NAME=oldtimefrom VALUE='"+oldtimefrom+"'><INPUT TYPE=HIDDEN NAME=oldtimeto VALUE='"+oldtimeto+"'><INPUT TYPE=HIDDEN NAME=testname VALUE="+testname+"><INPUT TYPE=HIDDEN NAME=clientid VALUE="+clientid+"><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"><INPUT TYPE=HIDDEN NAME=examid VALUE="+examid+"><INPUT TYPE=HIDDEN NAME=scheduleid VALUE="+scheduleid+">");
			out.println("</TABLE>");
			out.println("</FORM>");
		}catch(Exception e){
			out.println("Mod Error : " + e.getMessage());
			//System.out.println("Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}
	}

	public void Modify(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null;
		try
		{
			con = pool.getConnection();
			
			HttpSession session=req.getSession(true);
			int clientid = Integer.parseInt(req.getParameter("clientid"));
			int cid = Integer.parseInt(req.getParameter("cid"));
			int examid = Integer.parseInt(req.getParameter("examid"));
			int scheduleid = Integer.parseInt(req.getParameter("scheduleid"));
			int ScIDdate = Integer.parseInt(req.getParameter("ScIDdate"));
//			int ScIDtimefrom = Integer.parseInt(req.getParameter("ScIDtimefrom"));
			String olddate = req.getParameter("olddate");
			String oldtimefrom = req.getParameter("oldtimefrom");
			String oldtimeto = req.getParameter("oldtimeto");
			String testname = req.getParameter("testname");

			out.println("<H4>Test Postponement Request</H4><HR SIZE=1>");
			sql = "SELECT ScheduleID FROM SlotRegisteration WHERE CandidateID=" + cid ;
//out.println("<br>"+sql);
  			pstmt = con.prepareStatement(sql);
  			rs1 = pstmt.executeQuery();
			while (rs.next()){
				scheduleid = rs.getInt("ScheduleID");
			}

			int seatsfilled =0,totalseats=0;
			sql = "SELECT count(*) FROM SlotRegisteration WHERE ScheduleID=?";
//out.println("<br>"+sql);
  			pstmt = con.prepareStatement(sql);
  			pstmt.setInt(1,scheduleid);
  			rs1 = pstmt.executeQuery();
			while (rs.next()){
				seatsfilled = rs.getInt(1);
			}
			sql = "SELECT NoOfSeats FROM Schedule WHERE ScheduleID=?";
//out.println("<br>"+sql);
  			pstmt = con.prepareStatement(sql);
  			pstmt.setInt(1,scheduleid);
  			rs1 = pstmt.executeQuery();
			while (rs.next()){
				totalseats = rs.getInt("NoOfSeats");
			}
			int seatsaval = totalseats - seatsfilled;
//out.println("<br>totseats : " +totalseats + " seats filled : " +seatsfilled);
			if (seatsaval>0){
//out.println("<BR>"+ScIDdate + " " + ScIDtimefrom);
//			if (ScIDdate==ScIDtimefrom)
//			{
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDDING=1>");
				out.println("<TR><TH COLSPAN=2>Postponement Details</TH></TR>");

				sql = "UPDATE SlotRegisteration SET ScheduleID=" + ScIDdate + ",CandidateID=" + cid +
							" WHERE ScheduleID=" + scheduleid + " and CandidateID=" + cid;
//out.println("<BR>"+sql);
				String newdate ="";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,ScIDdate);
				pstmt.setInt(2,cid);
				pstmt.setInt(3,scheduleid);
				pstmt.setInt(4,cid);
				int confirm = pstmt.executeUpdate(sql);
				if (confirm > 0){
					sql = "UPDATE CandidateMaster SET ScheduleID=? WHERE CandidateID=?";
//out.println("<BR>"+sql);
  				pstmt = con.prepareStatement(sql);
  				pstmt.setInt(1,ScIDdate);
				pstmt.setInt(2,cid);
				confirm = pstmt.executeUpdate(sql);
					sql = "SELECT ScheduleDate FROM Schedule WHERE ScheduleID=?";
//out.println("<BR>"+sql);
  					pstmt = con.prepareStatement(sql);
  					pstmt.setInt(1,ScIDdate);
					rs = pstmt.executeQuery(sql);
					while (rs.next()){
						newdate = rs.getString("ScheduleDate");
					}
					sql = "INSERT INTO PostponeSlotDetails (CandidateID,AllotedScheduleID,RequestedScheduleID,PostponeRequestDate,isApproved) VALUES (?,?,?,CURRENT_DATE,1)";
//out.println("<BR>"+sql);
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,cid);
					pstmt.setInt(2,ScIDdate);
					pstmt.setInt(3,scheduleid);
					confirm = pstmt.executeUpdate(sql);
					if (confirm<=0){
						out.println("Problem in PostponeSlotDetails insertion !!");
					}

					out.println("<TR><TD ALIGN=RIGHT>Test Name :</TD><TD ALIGN=LEFT>"+testname+"</TD></TR>");
					out.println("<TR><TD ALIGN=RIGHT>Previous Date :</TD><TD ALIGN=LEFT>"+olddate+"</TD></TR>");
					out.println("<TR><TD ALIGN=RIGHT>Previous Timae :</TD><TD ALIGN=LEFT>"+oldtimefrom +"-"+oldtimeto+"</TD></TR>");
					out.println("<TR><TD COLSPAN=2>&nbsp;</TD></TR>");

					out.println("<TR><TD ALIGN=RIGHT>New Date :</TD><TD>"+Utils.getDate(newdate)+"</TD></TR>");
					sql = "SELECT TimeFrom,TimeTo FROM Schedule WHERE ScheduleID=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,ScIDdate);
					rs = pstmt.executeQuery(sql);
					while (rs.next())
					{
						String timefr=rs.getString("TimeFrom");
						timefr = timefr.substring(0,5);
						String timeto=rs.getString("TimeTo");
						timeto = timeto.substring(0,5);
						out.println("<TR><TD ALIGN=RIGHT>New Time :</TD><TD>"+timefr +" - "+timeto+"</TD></TR>");
					}
				}
				out.println("</TABLE>");
			}
			else
			{
				out.println("All Seats are booked for this Schedule !!");
			}

			out.println("</BODY>");
			out.println("</HTML>");

		}
		catch(Exception e)
		{
			out.println("Mod Error : " + e.getMessage());
			//System.out.println("Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}
	}

	public void getCanID(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		HttpSession session=req.getSession(true);
		String ClientID = (String) session.getAttribute("ClientID");
		String sql = null;
		int clientid=0;
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
//			clientid =1;
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);
		try
		{
			con = pool.getConnection();
			out.println("<FORM NAME=frmname METHOD=POST >");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=2>Select Name for Postponement</TH></TR>");
			out.println("<TR><TD>Name :</TD><TD><SELECT NAME=cid>");
			sql = "Select * from CandidateMaster WHERE ClientID=? ORDER BY FirstName,CandidateID";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,clientid);
			//System.out.println(" pstmt:"+pstmt);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int cid =  rs.getInt("CandidateID");
				//System.out.println(" cid:"+cid);
				if(cid>0)
				{
				RegistrationKey regkey = new RegistrationKey (cid);
				String tpkey = regkey.getKeyCode();
				//System.out.println(" tpkey:"+tpkey);
				out.println("<OPTION VALUE="+cid+">"+rs.getString("FirstName")+ " "  + rs.getString("LastName") + " [" + tpkey + "]" +"</OPTION>");
				}else
				{
					out.println("<OPTION VALUE="+cid+">"+rs.getString("FirstName")+ " "  + rs.getString("LastName")+"</OPTION>");
				}
			}
			out.println("</SELECT></TD></TR>");
			out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=submit><INPUT TYPE=HIDDEN NAME=action VALUE=doDetails></TH></TR></TABLE>");
			out.println("</FORM>");
		}
		catch(Exception e)
		{
			out.println("Mod Error : " + e.getMessage());
			//System.out.println("Error : " + e.getMessage());
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
