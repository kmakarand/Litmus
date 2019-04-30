import java.io.*;
import java.sql.*;
import java.util.Vector;
import java.text.Format;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;
import com.ngs.gen.*;

public class ScheduleTime extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null,rs1 = null;

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
		HttpSession session = req.getSession(true);
		String action = req.getParameter("action");
		String sql="";
		String CandidateID = req.getParameter("CandidateID");
		//String ExamID = (String) session.getAttribute("ExamID");
		String ClientID = (String) session.getAttribute("ClientID");
		int cid = 0,lid=0,examid=0,clientid=0;
		if (CandidateID == null || CandidateID.equals("") || CandidateID.equals(null) || CandidateID=="")
		{
			//cid = 1;
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			cid = Integer.parseInt(CandidateID);

		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);

		try{
//			DateFormat dt ;
			if (action == null || action == ""){
				con = pool.getConnection();
				out.println("<HTML><HEAD><TITLE>Exam Time</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				sql = "SELECT * FROM Schedule "+
					"WHERE ClientID="+clientid+
					" and ScheduleDate >= CURRENT_DATE " +
					" ORDER BY  ScheduleDate,TimeFrom,TimeTo";
out.println(sql);
				out.println("<FORM METHOD=POST NAME=form1>");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=2>Select Exam Date and Time </TH></TR>");
				out.println("<TR><TD>Select</TD><TD><SELECT NAME=scheduleid>");
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
//				String timefrom
				while (rs.next())
				{
					String timefrom = rs.getString("TimeFrom");
					timefrom = timefrom.substring(0,5);
					String timeto = rs.getString("TimeTo");
					timeto = timeto.substring(0,5);
					String date = rs.getString("ScheduleDate");
					Utils myUtil = new Utils();
					date = myUtil.getDate(date);
					//Date date = rs.getDate("ScheduleDate");
out.println("Date : " + date);
					//String scdate = dt.format(date);
//out.println(scdate);
					out.println("<OPTION VALUE="+rs.getInt("ScheduleID")+">"+date+"  "+ timefrom +"-"+timeto+"</OPTION>");
				}
				out.println("</SELECT></TD></TR>");
				out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Details><INPUT TYPE=HIDDEN NAME=action Value=doAdd><INPUT TYPE=HIDDEN NAME=examid Value="+examid+"><INPUT TYPE=HIDDEN NAME=ClientID Value="+clientid+"><INPUT TYPE=HIDDEN NAME=cid Value="+cid+"></TH></TR>");
				out.println("</TABLE>");
				out.println("</BODY></HTML>");
			}
			else
				doPost(req,res);
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
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
		out.println("<HTML><HEAD><TITLE>Payment Confirmation</TITLE>");
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

	public void Add(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null;
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);

			int cid = Integer.parseInt(req.getParameter("cid"));
			int clientid = Integer.parseInt(req.getParameter("ClientID"));
			int examid = Integer.parseInt(req.getParameter("examid"));
			int scheduleid = Integer.parseInt(req.getParameter("scheduleid"));

			sql = "UPDATE CandidateMaster SET ScheduleID=" + scheduleid + " WHERE CandidateID=" + cid;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
			int confirm = pstmt.executeUpdate();
			if (confirm>0)
			{
				sql = "SELECT * FROM  SlotRegisteration WHERE ScheduleID=" + scheduleid + " and CandidateID=" + cid ;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (!rs.next())
				{
					sql = "INSERT INTO SlotRegisteration (ScheduleID,CandidateID,Attended) VALUES (" + scheduleid + "," + cid + "," + "0)";
//out.println(sql);
					pstmt = con.prepareStatement(sql);
					confirm = pstmt.executeUpdate();
					if (confirm>0)
					{
						sql = "UPDATE CandidateMaster SET ScheduleID=" + scheduleid + " WHERE CandidateID="+ cid;
						pstmt = con.prepareStatement(sql);
						confirm = pstmt.executeUpdate();
						if (confirm >0)
						{
							sql = "SELECT * from CandidateMaster WHERE CandidateID=" + cid;
//out.println(sql);
							out.println("<BR><TABLE BORDER=0>");
							out.println("<TR><TH>Reg. No.</TH><TH>First Name</TH><TH>Last Name</TH><TH>Username Name</TH></TR>");
							pstmt = con.prepareStatement(sql);
							rs = pstmt.executeQuery();
							while (rs.next())
							{
								RegistrationKey regkey = new RegistrationKey (cid);
								String tpkey = regkey.KeyCode();
								out.println("<TR><TD>" + regkey.getKeyCode() +  "</TD><TD>" + rs.getString("FirstName") + "</TD><TD>" + rs.getString("LastName") + "</TD><TD>" + rs.getString("Username") + "</TD></TR>");
							}
							out.println("</TABLE>");

							out.println("Candidate Sucessfully Registered here !!");
							con.commit();
							con.setAutoCommit(true);
						}
					}
				}
				else
					out.println("Candidate Already Registered for this Schedule !!");
			}
			else
				out.println("Schedule Registration Problem !!");

//			out.println("<BR><BR><INPUT TYPE=BUTTON VALUE=Close onclick='javascript:window.close();'>");
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
