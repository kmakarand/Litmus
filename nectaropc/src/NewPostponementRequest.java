import java.io.*;
import java.sql.*;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;

public class NewPostponementRequest extends HttpServlet
{
	//com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	Statement stmt1 = null,stmt2 = null,stmt3=null;
	ResultSet rs1 = null,rs2 = null,rs3 = null;
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		HttpSession session=req.getSession(true);
		String sql="";
		String ClientID = req.getParameter("ClientID");
		int clientid=0;
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID==""){
			clientid =1;
		}else{
			clientid = Integer.parseInt(ClientID);
		}

		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nectar","root","nec76tar");
			stmt1 = con.createStatement();
			res.setContentType("text/html");
			out.println("<HTML><HEAD><TITLE>Postponement Request</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<H4>Test Postponement Request</H4><HR SIZE=1>");
//			String testname="";
//			int scheduleid=0;
			sql = "SELECT ScheduleID,ScheduleDate,TimeFrom,TimeTo FROM Schedule WHERE ClientID =" + clientid+"AND NoOfSeats>0";
			rs1 = stmt1.executeQuery(sql);
			out.print("<select name='schedule'>");
			int count=0;
			while (rs1.next())
			{
				count++;
				out.print("<option value="+count+">"+rs1.getString(1)+" "+rs1.getString(2)+" "+rs1.getString(3));
			}



/*			sql = "SELECT ScheduleID FROM SlotRegisteration WHERE CandidateID=" + cid ;
			//out.println("<br>"+sql);
				rs = stmt.executeQuery(sql);
				while (rs.next())
				{
					scheduleid = rs.getInt("ScheduleID");
				}

				int seatsfilled =0,totalseats=0;
				sql = "SELECT count(*) FROM SlotRegisteration WHERE ScheduleID=" + scheduleid ;
				rs = stmt.executeQuery(sql);
				while (rs.next())
				{
					seatsfilled = rs.getInt(1);
				}
				sql = "SELECT NoOfSeats FROM Schedule WHERE ScheduleID=" + scheduleid;
				rs = stmt.executeQuery(sql);
				while (rs.next())
				{
					totalseats = rs.getInt("NoOfSeats");
				}
				int seatsaval = totalseats - seatsfilled;
				if (seatsaval>0)
				{
					out.println("<FORM METHOD=POST NAME=form1>");
					out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
					out.println("<TR><TH COLSPAN=2>Select Test Centre</TH></TR>");

					out.println("<TR><TD ALIGN=RIGHT>Test Name :</TD><TD ALIGN=LEFt>"+testname+"</TD></TR>");

					sql = "SELECT ScheduleDate,TimeFrom,TimeTo FROM Schedule WHERE ScheduleID=" + scheduleid + " and ExamID=" + examid;
					//out.println("<br>"+sql);
					String olddate="",oldtimefrom="",oldtimeto="";
					rs = stmt.executeQuery(sql);
					while (rs.next())
					{
						olddate = rs.getString("ScheduleDate");
						String day = olddate.substring(8,10);
						String mth = olddate.substring(5,7);
						String yr = olddate.substring(0,4);
						olddate = day + "-" + mth + "-" + yr;
						oldtimefrom = rs.getString("TimeFrom");
						oldtimefrom = oldtimefrom.substring(0,5);
						oldtimeto = rs.getString("TimeTo");
						oldtimeto = oldtimeto.substring(0,5);
						out.println("<TR><TD ALIGN=RIGHT>Schedule Test Date :</TD><TD ALIGN=LEFt>"+olddate+"</TD></TR>");
						out.println("<TR><TD ALIGN=RIGHT>Schedule Test Time :</TD><TD ALIGN=LEFt>"+oldtimefrom +"-" + oldtimeto +"</TD></TR>");
					}

					out.println("<TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>");

					out.println("<TR><TD ALIGN=RIGHT>New Test Date :</TD><TD><SELECT NAME=ScIDdate>");

					sql = "SELECT ScheduleID,ScheduleDate FROM Schedule WHERE ClientID="+clientid + " ORDER BY ScheduleDate";
					//out.println("<br>"+sql);
					rs = stmt.executeQuery(sql);
					while (rs.next())
					{
						String date = rs.getString("ScheduleDate");
						String day = date.substring(8,10);
						String mth = date.substring(5,7);
						String yr = date.substring(0,4);
						date = day + "-" + mth + "-" + yr;
						out.println("<OPTION VALUE="+rs.getString("ScheduleID")+">"+date+"</OPTION>");
					}
					out.println("</TD></SELECT></TR>");

					out.println("<TR><TD ALIGN=RIGHT>New Test Time :</TD><TD><SELECT NAME=ScIDtimefrom>");
					sql = "SELECT ScheduleID,TimeFrom,TimeTo FROM Schedule WHERE ClientID="+clientid + " ORDER BY ScheduleDate";
					//out.println("<br>"+sql);
					rs = stmt.executeQuery(sql);
					while (rs.next())
					{
						String timefrom = rs.getString("TimeFrom");
						timefrom = timefrom.substring(0,5);
						String timeto = rs.getString("TimeTo");
						timeto = timeto.substring(0,5);
						out.println("<OPTION VALUE="+rs.getString("ScheduleID")+">"+timefrom + "-" + timeto +"</OPTION>");
					}
					out.println("</TD></SELECT></TR>");

					out.println("<TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>");

					out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Submit></TH></TR>");
					out.println("<INPUT TYPE=HIDDEN NAME=action VALUE=doModify><INPUT TYPE=HIDDEN NAME=olddate VALUE='"+olddate+"'><INPUT TYPE=HIDDEN NAME=oldtimefrom VALUE='"+oldtimefrom+"'><INPUT TYPE=HIDDEN NAME=oldtimeto VALUE='"+oldtimeto+"'><INPUT TYPE=HIDDEN NAME=testname VALUE="+testname+"><INPUT TYPE=HIDDEN NAME=clientid VALUE="+clientid+"><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"><INPUT TYPE=HIDDEN NAME=examid VALUE="+examid+"><INPUT TYPE=HIDDEN NAME=scheduleid VALUE="+scheduleid+">");
					out.println("</TABLE>");
					out.println("</FORM>");
				}
				else
				{
					out.println("All Seats are booked for this Schedule !!");
				}
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
		out.println("<HTML><HEAD><TITLE>Postponement List</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		try
		{
			String action = req.getParameter("action");
			if (action.equalsIgnoreCase("doModify"))
			{
				Modify(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
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
			stmt = con.createStatement();
			stmt1 = con.createStatement();

			HttpSession session=req.getSession(true);
			int clientid = Integer.parseInt(req.getParameter("clientid"));
			int cid = Integer.parseInt(req.getParameter("cid"));
			int examid = Integer.parseInt(req.getParameter("examid"));
			int scheduleid = Integer.parseInt(req.getParameter("scheduleid"));
			int ScIDdate = Integer.parseInt(req.getParameter("ScIDdate"));
			int ScIDtimefrom = Integer.parseInt(req.getParameter("ScIDtimefrom"));
			String olddate = req.getParameter("olddate");
			String oldtimefrom = req.getParameter("oldtimefrom");
			String oldtimeto = req.getParameter("oldtimeto");
			String testname = req.getParameter("testname");

			out.println("<H4>Test Postponement Request</H4><HR SIZE=1>");
//out.println("<BR>"+ScIDdate + " " + ScIDtimefrom);
			if (ScIDdate==ScIDtimefrom)
			{
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDDING=1>");
				out.println("<TR><TH COLSPAN=2>Postponement Details</TH></TR>");

				sql = "UPDATE SlotRegisteration SET ScheduleID=" + ScIDdate + ",CandidateID=" + cid +" WHERE ScheduleID=" + scheduleid + " and CandidateID=" + cid;
//out.println("<BR>"+sql);
				String newdate ="";
				int confirm = stmt.executeUpdate(sql);
				if (confirm > 0)
				{
					sql = "SELECT ScheduleDate FROM Schedule WHERE ScheduleID=" + ScIDdate;
					rs = stmt.executeQuery(sql);
					while (rs.next())
					{
						newdate = rs.getString("ScheduleDate");
					}

					sql = "SELECT CandidateID FROM PostponeSlotDetails WHERE CandidateID=" + cid;
					rs = stmt.executeQuery(sql);
					if (rs.next())
					{
						sql = "INSERT INTO PostponeSlotDetails (CandidateID,AllotedScheduleID,RequestedScheduleID,PostponeRequestDate,isApproved) VALUES(" + cid + "," + ScIDdate + "," + ScIDdate + ",'" + newdate + "',1)" ;
//out.println("<BR>"+sql);
						confirm = stmt.executeUpdate(sql);
						if (confirm >0)
						{
							out.println("<TR><TD ALIGN=RIGHT>Test Name :</TD><TD ALIGN=LEFT>"+testname+"</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Previous Date :</TD><TD ALIGN=LEFT>"+olddate+"</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Previous Timae :</TD><TD ALIGN=LEFT>"+oldtimefrom +"-"+oldtimeto+"</TD></TR>");
							out.println("<TR><TD COLSPAN=2>&nbsp;</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>New Date :</TD><TD>"+newdate+"</TD></TR>");
							sql = "SELECT TimeFrom,TImeTo FROM Schedule WHERE ScheduleID=" + ScIDdate;
							rs=stmt.executeQuery(sql);
							while (rs.next())
							{
								String timefr=rs.getString("TimeFrom");
								timefr = timefr.substring(0,5);
								String timeto=rs.getString("TimeTo");
								timeto = timeto.substring(0,5);
								out.println("<TR><TD ALIGN=RIGHT>New Time :</TD><TD>"+timefr +" - "+timeto+"</TD></TR>");
							}
						}
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
			*/

		}
			catch(Exception e)
			{
				out.println("Mod Error : " + e.getMessage());
				//System.out.println("Error : " + e.getMessage());
			}
			finally
			{
				//if (con != null)
					//pool.releaseConnection(con);
		        //else
			        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
			}

	}
	public void destroy()
	{
	}
}
