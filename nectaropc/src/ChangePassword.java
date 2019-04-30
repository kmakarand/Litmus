import java.io.*;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.security.Encrypter;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class ChangePassword extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs1 =null;

	public void init() {
		try{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		}catch(Exception e){
			//System.out.println("Connection Error : " + e.getMessage());
		}
	}

	public void doGet(HttpServletRequest req,HttpServletResponse res)
		throws ServletException,IOException{
		PrintWriter out = res.getWriter();
		HttpSession session=req.getSession(true);
		String sql="";
		String ClientID = (String)session.getAttribute("ClientID");
		int clientid=0;

		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="" || ClientID.equals("0")){
			BseDisplay(req,res);
		}
		else
		{
			clientid = Integer.parseInt(ClientID);
			DisplayClient(req,res);
		}


	}

	public void doPost(HttpServletRequest req,HttpServletResponse res)
		throws ServletException,IOException{

		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		out.println("<HTML><HEAD><TITLE>Registration Confirmation</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		String action = req.getParameter("action");
		if (action.equalsIgnoreCase("doSaveClient"))
		{
			try {
				SaveClient(req,res);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (GeneralSecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if (action.equalsIgnoreCase("doSaveBse"))
		{
			SaveBse(req,res);
		}
	}

	public void DisplayClient(HttpServletRequest req,HttpServletResponse res)
		throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		res.setContentType("text/html");
		HttpSession session=req.getSession(true);
		String ClientID = (String)session.getAttribute("ClientID");
		int clientid=0;

		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID==""){
			session.invalidate();
			res.sendRedirect("../jsp/Login.jsp");
			return;
		}
		else
			clientid = Integer.parseInt(ClientID);
		try{
			con=pool.getConnection();
			res.setContentType("text/html");
		}catch(Exception e){
			out.println("<!-- Error :"+e.getMessage() + " -->");
		}

		out.println("<HTML><HEAD><script language='javascript' src='../js/validatefunction.js'></script><TITLE>Change Password</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		out.println("<FORM NAME=form1 METHOD=POST action=\"\">");
		out.println("<H4>You Can Change Your Password Here<HR SIZE=1></H4>");
		out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
		out.println("<TR><TH COLSPAN=2>Please Provide The Informations</TH></TR>");
		String sql = "SELECT ClientName FROM ClientMaster WHERE ClientID=" + clientid;
		try{
			pstmt = con.prepareStatement(sql);
			rs1 = pstmt.executeQuery();
			while(rs1.next()){
				out.println("<TR><TD  ALIGN=RIGHT> Client Name :</TD><TD  ALIGN=LEFT>"+rs1.getString("ClientName")+"</TD></TR>");
				out.println("<TR><TD  ALIGN=RIGHT> Old Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=oldPassword></TD></TR>");
				out.println("<TR><TD  ALIGN=RIGHT> New Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=newPassword></TD></TR>");
				out.println("<TR><TD ALIGN=RIGHT> Confirm Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=conPassword></TD></TR>");
			}
			out.println("<TR><TH colspan=2><input type=submit  value=Submit><input type=HIdden name=action value=doSaveClient></TH></TR>");
			out.println("</table>");
			out.println("</FORM></BODY></HTML>");

		}catch(Exception e){
			out.print(e.getMessage());
		}finally {
			if(con!=null)
				pool.releaseConnection(con);
		}
	}

	public void BseDisplay(HttpServletRequest req,HttpServletResponse res)
		throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		res.setContentType("text/html");
		HttpSession session=req.getSession(true);
		Integer CandidateID = (Integer) session.getAttribute("CandidateID");
		int cid= CandidateID.intValue();

		try{
			con=pool.getConnection();
			res.setContentType("text/html");
		}catch(Exception e){
			out.println("<!-- Error :"+e.getMessage() + " -->");
		}

		out.println("<HTML><HEAD><script language='javascript' src='../js/validatefunction.js'></script><TITLE>Change Password</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		out.println("<FORM NAME=form1 METHOD=POST action=\"\">");
		out.println("<H4>You Can Change Your Password Here<HR SIZE=1></H4>");
		out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
		out.println("<TR><TH COLSPAN=2>Please Provide The Informations</TH></TR>");
		String sql = "SELECT FirstName,LastName FROM CandidateMaster WHERE CandidateID=" + cid;
		try{
			pstmt = con.prepareStatement(sql);
			rs1 = pstmt.executeQuery();
			while(rs1.next()){
				out.println("<TR><TD  ALIGN=RIGHT> Client Name :</TD><TD  ALIGN=LEFT>"+rs1.getString("FirstName") + " " + rs1.getString("LastName") +"</TD></TR>");
				out.println("<TR><TD  ALIGN=RIGHT> Old Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=oldPassword></TD></TR>");
				out.println("<TR><TD  ALIGN=RIGHT> New Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=newPassword></TD></TR>");
				out.println("<TR><TD ALIGN=RIGHT> Confirm Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=conPassword></TD></TR>");
			}
			out.println("<TR><TH colspan=2><input type=submit name=submit value=Submit><input type=hidden name=action value=doSaveBse></TH></TR>");
			out.println("</table>");
			out.println("</FORM></BODY></HTML>");

		}catch(Exception e){
			out.print(e.getMessage());
		}finally {
			if(con!=null)
				pool.releaseConnection(con);
		}
	}

	public void SaveClient(HttpServletRequest req,HttpServletResponse res)
		throws ServletException,IOException, GeneralSecurityException
	{
		PrintWriter out = res.getWriter();
		res.setContentType("text/html");
		HttpSession session=req.getSession(true);
		String sql1="",sql2="";
		String oldP= (String) req.getParameter("oldPassword");
		String newP= (String) req.getParameter("newPassword");
		String conP= (String) req.getParameter("conPassword");
//		String ClientID =(String) req.getParameter("ClientID");
		String ClientID = (String)session.getAttribute("ClientID");
		int clientid=0;
		newP = Encrypter.encrypt(newP);
		conP = Encrypter.encrypt(conP);

		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID==""){
			//clientid =0;
			session.invalidate();
			res.sendRedirect("../jsp/Login.jsp");
			return;
		}else{
			clientid = Integer.parseInt(ClientID);
		}

		out.println("<HTML><HEAD><TITLE>Changed Password</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");

		if(!newP.equals(conP)){
			out.println("New Password does not match with Confirm Password!!");
			out.println("<BR><form><Input type=button value=\"Go Back\" onclick=\"javascript:history.back()\">");
		}else {
			try{
				con = pool.getConnection();
				Statement stmt2 = con.createStatement();
				sql1 = "SELECT ClientName,Username,Password  FROM ClientMaster "+
					" WHERE  ClientID=" + clientid;
				try{
					pstmt = con.prepareStatement(sql1);
					rs1 = pstmt.executeQuery();
				}catch(Exception e){
					out.print(e.getMessage());
				}

				if(rs1.next()){
					if(!Encrypter.decrypt(rs1.getString("Password")).trim().equals(oldP)){
						out.println("Invalid Old Password!!");
						out.println("<BR><form><Input type=button value=\"Go Back\" onclick=\"javascript:history.back()\">");
					}else{
						sql2="UPDATE ClientMaster SET Password ='"+newP+"' "+
							"WHERE ClientID="+ clientid;
						pstmt = con.prepareStatement(sql2);
						int i=pstmt.executeUpdate();
						out.println("<FORM NAME=form1>");
						out.println("<H4>You Have Succefully Changed The Password <HR SIZE=1></H4>");
						out.println("</FORM>");
					}
				}
			}catch(Exception e){
				out.println("Error :"+e.getMessage());
			}finally {
				if(con!=null)
					pool.releaseConnection(con);
			}
		}
		out.println("</BODY></HTML>");
	}

	public void SaveBse(HttpServletRequest req,HttpServletResponse res)
		throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		res.setContentType("text/html");
		HttpSession session=req.getSession(true);
		String sql1="",sql2="";
		String oldP= (String) req.getParameter("oldPassword");
		String newP= (String) req.getParameter("newPassword");
		String conP= (String) req.getParameter("conPassword");

		Integer CandidateID = (Integer) session.getAttribute("CandidateID");
		int cid= CandidateID.intValue();

		out.println("<HTML><HEAD><TITLE>Changed Password</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");

		if(!newP.equals(conP)){
			out.println("New Password does not match with Confirm Password!!");
			out.println("<BR><form><Input type=button value=\"Go Back\" onclick=\"javascript:history.back()\">");
		}else {
			try{
				con = pool.getConnection();
				sql1 = "SELECT FirstName,Username,Password  FROM CandidateMaster "+
					" WHERE  CandidateID=" + cid;
				try{
					pstmt = con.prepareStatement(sql1);
					rs1 = pstmt.executeQuery();
				}catch(Exception e){
					out.print(e.getMessage());
				}

				if(rs1.next()){
					if(!rs1.getString("Password").equals(oldP)){
						out.println("Invalid Old Password!!");
						out.println("<BR><form><Input type=button value=\"Go Back\" onclick=\"javascript:history.back()\">");
					}else{
						sql2="UPDATE CandidateMaster SET Password ='"+newP+"' "+
							"WHERE CandidateID="+ cid;
						pstmt = con.prepareStatement(sql2);
						int i=pstmt.executeUpdate();
						out.println("<FORM NAME=form1>");
						out.println("<H4>You Have Succefully Changed The Password <HR SIZE=1></H4>");
						out.println("</FORM>");
					}
				}
			}catch(Exception e){
				out.println("Error :"+e.getMessage());
			}finally {
				if(con!=null)
					pool.releaseConnection(con);
			}
		}
		out.println("</BODY></HTML>");
	}
}
