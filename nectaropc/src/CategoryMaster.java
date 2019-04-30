import java.io.*;
import java.sql.*;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;
import com.ngs.gen.*;

public class CategoryMaster extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
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
		
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{	
				HttpSession session = req.getSession(true);
				PrintWriter out = res.getWriter();
				String action = req.getParameter("action");
				String sql="";

				if (action == null || action == "")
				{
					out.println("<HTML><HEAD><TITLE>Category Master</TITLE>");
					out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
					out.println("<BODY><CENTER>");
					
				try
				{
					res.setContentType("TEXT/HTML");
					con = pool.getConnection();
					out.println("<BR><BR><TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
					out.println("<TR><TH COLSPAN=3><B>Category Master</B></TH></TR>");
					out.println("<TR><TH>Sr. NO.</TH><TH>CategoryID</TH><TH>Category</TH></TR>");
					sql = "SELECT * from CategoryMaster";
					int count=1;
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next())
					{
						out.println("<TR><TD align=center>" + count + "</TD><TD align=center>" + rs.getString("CategoryID") + "</TD><TD>" + " " + rs.getString("Category") + "</TD></TR>");
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
			
								out.println("</BODY>");
								out.println("</HTML>");
							}
					
				}

			public void destroy()
			{
			}

}
