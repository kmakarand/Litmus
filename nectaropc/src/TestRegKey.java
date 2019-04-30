import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.RegistrationKey;
import java.text.NumberFormat;


public class TestRegKey extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String driver = null;

	public void init()
	{
		try
		{
			ServletContext context = getServletContext();
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPool");
		}
		catch(Exception e)
		{
			//System.out.println("Connection Error : " + e.getMessage());
		}
	}

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		String citycd = "MUM",areacd="AND",rKey=null;
//		int cid=10;
		int cid = 0;
		String CandidateID = req.getParameter("CandidateID");
		if (CandidateID == null || CandidateID.equals("") || CandidateID.equals(null) || CandidateID=="")
		{
			cid = 2;
		}
		else
			cid = Integer.parseInt(CandidateID);

		if (action == null || action == "")
		{
			res.setContentType("text/html");
			out.println("<html><head><title>Average Performance</title>");
			out.println("<BODY bgcolor='#fef9e2'><CENTER>");

			String sql = "SELECT Exam,ExamID FROM ExamMaster ORDER BY Exam" ;
			int storeid=0;
			try
			{
				RegistrationKey regkey = new RegistrationKey (cid);
				rKey = regkey.KeyCode();
				out.println("Key : " + rKey);
				out.println("<br>Candidate Key : " + regkey.getKeyCode());
			}
			catch(Exception e)
			{
				out.println("doGet Error : " + e.getMessage());
			}
			finally
			{
				if (con != null)
					pool.releaseConnection(con);
				else
					out.println("ERROR: Error while Realsing Connection to Database.");
			}
		}
		else
		{
			doPost(req,res);
		}
	}


	public void destroy(){}
}
