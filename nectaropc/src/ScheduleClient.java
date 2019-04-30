import java.io.*;
import java.sql.*;
import java.util.Vector;
import java.util.Calendar;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;

public class ScheduleClient extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null,rs1 = null,rs2 = null;
	Vector vlocationid = new Vector();

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
				Assign(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}

	public void Assign(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null;
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);

			int clientid = Integer.parseInt(req.getParameter("clientid")) ;
			String clientname = "" ;
			int noseats = 0;
//out.println("clid : " + clientid);
			sql = "select ClientName,AvailableSeats from ClientMaster WHERE ClientID=" + clientid;
			pstmt =con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				clientname = rs.getString("ClientName");
				noseats = rs.getInt("AvailableSeats");
			}

			sql = "SELECT ScheduleID FROM Schedule WHERE ClientID=" + clientid;
//out.println(sql);
		  	pstmt =con.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
			if (!rs.next())
			{
				boolean check =false;
				sql = "SELECT * FROM Schedule WHERE ScheduleDate >= CURRENT_DATE GROUP BY ScheduleDate,TimeFrom,TimeTo ORDER BY ScheduleDate";
//out.println("<br>"+sql);
				pstmt =con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					String schdate = rs.getString("ScheduleDate");
					String timefrom = rs.getString("TimeFrom");
					String timeto = rs.getString("TimeTo");
					com.ngs.gen.NextValues scheduleID    =   new com.ngs.gen.NextValues("Schedule", "ScheduleID");
					int nextscheduleID    =    scheduleID.getNextValue();
					boolean val    =    scheduleID.setNextValue();

					sql = "INSERT INTO Schedule (ScheduleID,ClientID,ExamID,SectionID,ScheduleDate,TimeFrom,TimeTo,NoOfSeats) VALUES (" + nextscheduleID + "," + clientid + ",31,1,'" + schdate + "','" + timefrom + "','" + timeto + "'," + noseats +")";
//out.println("<br>"+sql);
  					pstmt =con.prepareStatement(sql);
					int confirm = pstmt.executeUpdate();
					if (confirm <= 0)
					{
						out.println("Problem in Inserting in Schedule !!");
					}
					else
					{
						check = true;
					}
				}
				if (check == true)
				{
					out.println("" + clientname + " properly registered and scheduled !!");
				}
			}
			else
			{
				out.println("Schedule Already present for the selected Client <B>"+clientname+"</b> !!");
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

	public void destroy()
	{
	}
}
