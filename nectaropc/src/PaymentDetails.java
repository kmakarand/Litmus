import java.io.*;
import java.sql.*;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;

public class PaymentDetails extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null,stmt1 = null;
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
//		String CandidateID = req.getParameter("CandidateID");
		String ClientID = (String) session.getAttribute("ClientID");
		int cid = 0,lid=0,examid=0,clientid=0;

/*		if (CandidateID == null || CandidateID.equals("") || CandidateID.equals(null) || CandidateID=="")
		{
			cid = 2;
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			cid = Integer.parseInt(CandidateID);
*/
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
			clientid =1;
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);

		try
		{
			if (action == null || action == "")
			{

				con = pool.getConnection();
				out.println("<HTML><HEAD><TITLE>Payment Confirmation</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				sql = "SELECT CandidateID,FirstName,LastName FROM CandidateMaster WHERE ClientID="+clientid+" ORDER BY FirstName";
				out.println("<FORM METHOD=POST NAME=form1>");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=2>Select Candidate name</TH></TR>");
				out.println("<TR><TD>Select</TD><TD><SELECT NAME=cid>");
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					out.println("<OPTION VALUE="+rs.getInt("CandidateID")+">"+rs.getString("FirstName")+" "+ rs.getString("LastName")+"</OPTION>");
				}
				out.println("</SELECT></TD></TR>");
				out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Details><INPUT TYPE=HIDDEN NAME=action Value=doDisplay><INPUT TYPE=HIDDEN NAME=examid Value="+examid+"><INPUT TYPE=HIDDEN NAME=ClientID Value="+clientid+"></TH></TR>");
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
			if (action.equalsIgnoreCase("doDisplay"))
			{
				Display(req,res);
			}
			else if (action.equalsIgnoreCase("doAdd"))
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
		String action = req.getParameter("action");
		int cid = Integer.parseInt(req.getParameter("cid"));
		int examid = Integer.parseInt(req.getParameter("examid"));
		int clientid = Integer.parseInt(req.getParameter("ClientID"));
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			res.setContentType("text/html");
			out.println("<HTML><HEAD><TITLE>Payment Details Form</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
			out.println("<script language=javascript>");
			out.println("function checkVal(){");
			out.println("var a='document.form1.amount';");
			out.println("var b='document.form1.ddno';");
			out.println("var c='document.form1.drawnbank';");
			out.println("var d='document.form1.branchname';");
//			out.println("var paymode = 'document.form1.paymode';");

			out.println("var chequedate =self.document.form1.dddate.options[self.document.form1.dddate.selectedIndex].value+self.document.form1.ddmonth.options[self.document.form1.ddmonth.selectedIndex].value+self.document.form1.ddyear.options[self.document.form1.ddyear.selectedIndex].value;");

			out.println("if (!isnulls(a)){");
			out.println("	alert('Amount Field cannot be Empty !!');");
			out.println("	eval(a).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if (eval(a).value<=100){");
			out.println("	alert('Check amount !!');");
			out.println("	eval(a).focus();");
			out.println("	return false;}");
			out.println("else if (!checkNumeric(eval(a),'Amount is a Numeric Field')){");
			out.println("	eval(a).value='';");
			out.println("	eval(a).focus();");
			out.println("	return false;}");
			out.println("else if (!isnulls(b)){");
			out.println("	alert('Cheque/DD No. Field cannot be Empty !!');");
			out.println("	eval(b).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if (!checkNumeric(eval(b),'Cheque/DD No. is a Numeric Field')){");
			out.println("	eval(b).value='';");
			out.println("	eval(b).focus();");
			out.println("	return false;}");
			out.println("else if (!isnulls(c)){");
			out.println("	alert('Drawn on Bank Field cannot be Empty !!');");
			out.println("	eval(c).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if (!isnulls(d)){");
			out.println("	alert('Branch name Field cannot be Empty !!');");
			out.println("	eval(d).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if ( !checkDate(chequedate) ) ");
			out.println("	{");
			out.println("	self.document.form1.bmonth.focus();");
			out.println("	return false; }");
//				out.println("else if (eval(c).value.length>7){");
//				out.println("	alert('Telephone Number should be atlest 7 digits !!');");
//				out.println("	eval(c).focus();");
//				out.println("	return false;");
//				out.println("}");
			out.println("else");
			out.println("	document.form1.submit();");
			out.println("}");
			out.println("</script>");

			String firstname = "" , lastname ="",sql="";

			sql = "SELECT FirstName,LastName FROM CandidateMaster WHERE CandidateID=" + cid;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
	  		rs = pstmt.executeQuery();
			while (rs.next())
			{
				firstname = rs.getString("FirstName");
				lastname = rs.getString("LastName");
			}

				out.println("<FORM METHOD=POST NAME=form1 action="+req.getRequestURI()+">");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=2>Payment Details : " + firstname + " " +lastname+"</TH></TR>");
				out.println("<TR><TD align=right>Mode of Payment :</TD><TD><SELECT NAME=paymode>");
				out.println("<OPTION VALUE=Cash>Cash</OPTION><OPTION VALUE=Cheque>Cheque</OPTION><OPTION VALUE='DDt'>Demand Draft</OPTION></SELECT></TD></TR>");

				out.println("<TR><TD align=right>Amount :</TD><TD><INPUT TYPE=TEXT NAME=amount VALUE=600 align=right><SELECT NAME=currency><OPTION VALUE=Rs>Rs</OPTION><OPTION VALUE=$>$</OPTION></SELECT></TD></TR>");

				out.println("<TR><TD align=right>Cheque/DD No. :</TD><TD><INPUT TYPE=TEXT NAME=ddno align=right></TD></TR>");

				out.println("<TR><TD align=right>Cheque/DD Date :</TD><TD><SELECT NAME=dddate>");
				for (int i=1;i<=31 ;i++ )
				{
					if (i<10)
					{
						out.println("<OPTION VALUE=0"+i+">"+i+"</OPTION>");
					}
					else
					out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
				}
				out.println("</SELECT>-<SELECT NAME=ddmonth>");
				out.println("<OPTION VALUE=01>Jan</OPTION>");
				out.println("<OPTION VALUE=02>Feb</OPTION>");
				out.println("<OPTION VALUE=03>Mar</OPTION>");
				out.println("<OPTION VALUE=04>Apr</OPTION>");
				out.println("<OPTION VALUE=05>May</OPTION>");
				out.println("<OPTION VALUE=06>Jun</OPTION>");
				out.println("<OPTION VALUE=07>Jul</OPTION>");
				out.println("<OPTION VALUE=08>Aug</OPTION>");
				out.println("<OPTION VALUE=09>Sep</OPTION>");
				out.println("<OPTION VALUE=10>Oct</OPTION>");
				out.println("<OPTION VALUE=11>Nov</OPTION>");
				out.println("<OPTION VALUE=12>Dec</OPTION>");
				out.println("</SELECT>-<SELECT NAME=ddyear>");
				out.println("<OPTION VALUE=2012>2012</OPTION></SELECT></TD></TR>");

				out.println("<TR><TD align=right>Drawn on Bank :</TD><TD><INPUT TYPE=TEXT NAME=drawnbank></TD></TR>");

				out.println("<TR><TD align=right>Branch Name :</TD><TD><INPUT TYPE=TEXT NAME=branchname></TD></TR>");

				out.println("<TH COLSPAN=2><INPUT TYPE=BUTTON VALUE=Submit onclick='return checkVal();'>&nbsp;<INPUT TYPE=RESET VALUE=Reset></TH>");
				out.println("</TABLE>");
				out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doAdd'><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"><INPUT TYPE=HIDDEN NAME=examid VALUE="+examid+">");
				out.println("</FORM>");

				out.println("</BODY></HTML>");

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
//			int cid = Integer.parseInt(req.getParameter("cid"));
			int examid = Integer.parseInt(req.getParameter("examid"));
			String paymode = req.getParameter("paymode");
			int amount = Integer.parseInt(req.getParameter("amount"));
			String currency = req.getParameter("currency");
			int ddno = Integer.parseInt(req.getParameter("ddno"));

			int dddate = Integer.parseInt(req.getParameter("dddate"));
			String dt = "",mt= "";
			if (dddate<10){dt = "0" + dddate;}
			int ddmonth = Integer.parseInt(req.getParameter("ddmonth"));
			if (ddmonth<10){mt = "0" + ddmonth;}
			int ddyear = Integer.parseInt(req.getParameter("ddyear"));
			String chdate = "" + ddyear + "-" + mt + "-" + dt ;
//out.println("ch date : " + chdate);

			String drawnbank = req.getParameter("drawnbank");
			String branchname = req.getParameter("branchname");

			sql = "INSERT INTO PaymentDetails (ExamID,CandidateID,Amount,Currency,Date,modeOfPayment,Bank,Branch,ChequeNo) VALUES (" + examid + "," + cid + "," + amount + ",'" + currency + "','" + chdate + "','" + paymode + "','"  + drawnbank + "','" + branchname + "'," + ddno + ")" ;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
			int confirm = pstmt.executeUpdate(sql);
			if (confirm>0)
			{
				out.println("Payments Details Added Sucessfully !!");
			}
			else
				out.println("Payment Updation Problem !!");
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
