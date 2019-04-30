import java.io.*;
import java.sql.*;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;
import com.ngs.gen.*;

public class AssignCentre extends HttpServlet
{
	ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null,stmt1 = null;
	ResultSet rs = null,rs1 = null;
	Utils myUtils = new Utils();

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
		HttpSession session = req.getSession(true);
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		String sql="";

		if (action == null || action == "")
		{
			out.println("<HTML><HEAD><TITLE>Centre Assignment</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			Details(req,res);
			out.println("</BODY>");
			out.println("</HTML>");
		}
		else
			doPost(req,res);
	}

	public void Details(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		try
		{
			res.setContentType("TEXT/HTML");
			con = pool.getConnection();
			out.println("<BR><BR><TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
			out.println("<TR><TH COLSPAN=4><B>Assign Centre</B></TH></TR>");
			out.println("<TR><TH>Sr. NO.</TH><TH>Centre Manager Name</TH><TH>Centre Assigned</TH><TH>Action</TH></TR>");
			String sql = "SELECT A.Username,A.FirstName,A.LastName,A.ClientID,A.CandidateID FROM CandidateMaster A,UserGroupXRef B WHERE A.Username=B.Username and B.GroupID=15 ORDER BY A.FirstName";
			int count=1;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				out.println("<TR><TD>" + count + "</TD><TD>" + rs.getString("FirstName") + " " + rs.getString("LastName") + "</TD>");
				int clientid = rs.getInt("ClientID");
				int cid = rs.getInt("CandidateID");
				if (clientid == 0)
				{
					out.println("<TD>NOT Assigned</TR>");
				}
				else
				{
					sql = "SELECT ClientName FROM ClientMaster WHERE ClientID=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,clientid);
					rs1 = pstmt.executeQuery();
					while (rs1.next())
					{
						out.println("<TD>" + rs1.getString("ClientName") + "</TD>");
					}
				}
				out.println("<TD><A HREF='"+req.getRequestURI()+"?action=doAssign&CandidateID="+cid+"'>Assign Centre</A></TD></TR>");
				count++;
			}
			out.println("</TABLE>");
		}
		catch(Exception e)
		{
			out.println("Error  here : " + e.getMessage());
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
		out.println("<HTML><HEAD><TITLE>Candidate Details</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		String action = req.getParameter("action");
		if (action.equalsIgnoreCase("doAssign"))
		{
			Assign(req,res);
		}
		else if (action.equalsIgnoreCase("doCentreUpdate"))
		{
			CentreUpdate(req,res);
		}
		out.println("</BODY>");
		out.println("</HTML>");
	}

	public void Assign(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		try
		{
			int cid=Integer.parseInt(req.getParameter("CandidateID"));
			res.setContentType("TEXT/HTML");
			con = pool.getConnection();
			out.println("<BR><BR><FORM NAME=frmAssign METHOD=POST action="+req.getRequestURI()+">");//
			out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
			out.println("<TR><TH COLSPAN=2><B>Select Centre</B></TH></TR>");
			out.println("<TR><TD ALIGN=RIGHT>Centre Name :</TD><TD><SELECT NAME=ClientID>");
			String sql = "SELECT ClientID,ClientName FROM ClientMaster ORDER BY ClientName";
			int count=1;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				out.println("<OPTION VALUE="+rs.getInt("ClientID")+">"+rs.getString("ClientName")+"</OPTION>");
			}
			out.println("<OPTION VALUE=0>No Centre</OPTION></SELECT></TD></TR>");
			out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Submit><INPUT TYPE=HIDDEN NAME=action VALUE=doCentreUpdate><INPUT TYPE=HIDDEN NAME=CandidateID VALUE="+cid+"></TH></TR>");
			out.println("</TABLE>");
			out.println("</FORM>");
		}
		catch(Exception e)
		{
			out.println("Error  here : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}

	public void CentreUpdate(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		try
		{
			int cid=Integer.parseInt(req.getParameter("CandidateID"));
			int clientid=Integer.parseInt(req.getParameter("ClientID"));
			res.setContentType("TEXT/HTML");
			con = pool.getConnection();
			boolean check = false;
			String sql = "";

			if (clientid != 0)
			{
				sql = "SELECT A.Username,A.FirstName,A.LastName,A.ClientID,A.CandidateID FROM CandidateMaster A,UserGroupXRef B WHERE A.Username=B.Username and B.GroupID=15 ORDER BY A.FirstName";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					int tempclientid = rs.getInt("ClientID");
					if ( tempclientid == clientid )
					{
						check = true;
						break;
					}
				}
			}
			if (check == true)
			{
				out.println("<BR><B>Centre has already been assigned !!</B>");
				out.println("<FORM NAME=back METHOD=GET action="+req.getRequestURI()+">");
				out.println("<INPUT TYPE=SUBMIT VALUE='Go BACK'>");
				out.println("</FORM>");
			}
			else
			{
				sql = "UPDATE CandidateMaster SET ClientID=? WHERE CandidateID=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,clientid);
				pstmt.setInt(2,cid);
				int confirm = pstmt.executeUpdate(sql);
				if (confirm > 0)
				{
					res.sendRedirect(req.getRequestURI());
				}
				else
					out.println("Problem in Modification !!");
			}

		}
		catch(Exception e)
		{
			out.println("Error  here : " + e.getMessage());
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
