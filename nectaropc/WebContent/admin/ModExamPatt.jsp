<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<html>
<head>
<title>Modify Exan Pattern </title>
<script language=javascript>
	function x(){
	alert("hello");
}
</script>
</head>
<%
String adminuser = (String) session.getValue("adminuser");

if (adminuser == "" || adminuser == null)
{
	response.sendRedirect("/zalm/admin/zeealmadmin.htm");
}
%>
<body bgcolor="#FEF9E2">
<%
	String action = request.getParameter("action");
//	ConnectionPool pool = null;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	try
	{
		conn = pool.getConnection();
	}
	catch (Exception e)
	{
		System.err.println("ERROR: Unable to Get Connection fron the Connection Pool.");
		e.printStackTrace();
	}

	if (action == null || action == "")
	{
		try
		{
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM ExamMaster");
%>
<CENTER>
<H3>Modify Exam Pattern</H3>
<hr size=1><br>
Select Exam id and submit to modify details of Exam:
<br>
<FORM METHOD="POST">
<INPUT TYPE=HIDDEN NAME=action VALUE="AddExamDetails">

Select Exam id : 
<SELECT NAME=ExamID>
<%

			while (rs.next())
			{
				String Exam = rs.getString("Exam");
				int ExamID = rs.getInt("ExamID");
				out.println("<OPTION VALUE='" + ExamID + "'>" +Exam+ "</OPTION>");
//				out.println("<input type=hidden name=exam value=" + Exam+ ">");
			}

%>
</SELECT>
<br><br>
<INPUT TYPE=SUBMIT VALUE=Submit>
<br>
</FORM>
</CENTER>
<%
			stmt.close();
		}
		catch (SQLException e)
		{
			out.println("<FONT COLOR=red><B>ERROR</B></FONT> : " + e.getMessage());
			e.printStackTrace();
		}
		finally
		{
//			pool.releaseConnection(conn);
		}
	}
	else if (action.equals("AddExamDetails"))
	{
		String ExamID = request.getParameter("ExamID");
		String exam = request.getParameter("exam");
%>
<CENTER>
<H3>Modify Exam Pattern</H3>
<hr size=1><br>

<FORM METHOD="POST">
<INPUT TYPE=HIDDEN NAME=action VALUE="DoAddExamDetails">
<INPUT TYPE=HIDDEN NAME=ExamID VALUE="<%=ExamID%>">

<table align="center" border='1'>
	<tr>
		<td>Exam Code</td>
		<td>Subject Name</td>
		<td>Module</td>
		<td>Sequence Id</td>
		<td>Negative Marks</td>
	</tr>
<%
	try
	{
		Statement st1 = conn.createStatement();
		Statement st2 = conn.createStatement();
		
		String examname="";
		ResultSet rs5=st1.executeQuery("SELECT Exam from ExamMaster where ExamID = " + ExamID);
		while(rs5.next())
		{
			examname=rs5.getString("Exam");
		}
		rs5.close();

		ResultSet rs2=st1.executeQuery("SELECT count(*) from ExamPattern where ExamID = " + ExamID);
		int totrec=0;
		
		while(rs2.next())
		{
			totrec=rs2.getInt(1);
			//System.out.println("tot rec: " + totrec);
		}
		out.println("<input type=hidden name=totalrec value="+totrec+">");
		
		ResultSet rs3 = st1.executeQuery("SELECT * from ExamPattern where ExamID = " + ExamID + " order by SubjectID,ModuleID");
		
		int j=0;
		
		out.println("<h4>Modify Record for Exam : " + examname+ "<h4><hr>");

		while(rs3.next())
		{
			out.println("<tr>");
			out.println("<td>" + rs3.getString("ExamCode")+ "</td>");
			String ecode="examcode"+j;
			out.println("<input type=hidden name="+ecode+" value=" + rs3.getString("ExamCode")+ ">");
			String sname = "select Subject from SubjectMaster where SubjectID = " + rs3.getString("SubjectID");
			ResultSet rs4 = st2.executeQuery(sname);
			while(rs4.next())
			{
				out.println("<td>" + rs4.getString("Subject")+ "</td>");
				rs4.close();
			}
			out.println("<td>" + rs3.getString("ModuleID")+ "</td>");
			String sid = "sequenceid"+j;
			out.println("<td align=center><select name="+sid+"  width='50%'>");
			
			int sidno=0;
			for (int i=1;i<=totrec;i++)
			{

				String sid2= rs3.getString("SequenceID");
				sidno =Integer.parseInt(sid2);
				out.print("<OPTION ");//VALUE=" + sidno + "
				if (i==rs3.getInt("SequenceID")){out.print(" Selected");}
				out.println(">" + i + "</option>");
			}

			out.print("</select></td>");
			String nem="nemarks"+j;
			out.println("<td><input align='right' type=text name=" + nem + " value = "+ rs3.getString("NegativeMarks")+" ></td></tr>");
			++j;
		}
	}
	catch(Exception e)
	{
		System.err.println("ERROR: " + e.getMessage());
	}

%>
	
</table>
<br><br>
<INPUT TYPE=SUBMIT NAME=DoAddExamDetails VALUE=Submit >
</b>
</FORM>
</CENTER>

<INPUT TYPE=HIDDEN NAME=action VALUE="DoAddExamDetails">
<INPUT TYPE=HIDDEN NAME=ExamID VALUE="<%=ExamID%>">

<%
	}
	else if (action.equals("DoAddExamDetails"))
	{

		Statement st2 = conn.createStatement();
		String section = request.getParameter("ExamID");
		int sec=Integer.parseInt(section);

		String examcode[] = request.getParameterValues("ecode");		
		String sequenceid[] = request.getParameterValues("sequenceid");
		String nemar[] = request.getParameterValues("nem");

		int total =Integer.parseInt(request.getParameter("totalrec"));
		
		for (int i=0; i<total; i++)//examcode
		{
			String sid = "sequenceid"+i;
			int sidi= Integer.parseInt(request.getParameter(sid));
					
			String ecode="examcode"+i;
			int ecodei =Integer.parseInt(request.getParameter(ecode));

			String nems = "nemarks"+i;

			Float abc = new Float(request.getParameter(nems));
			float nemarks = abc.floatValue();
			
			st2.executeUpdate("UPDATE ExamPattern SET SequenceID ="+ sidi+ ",NegativeMarks = " + nemarks+ " where ExamCode = " + ecodei +"");

			
		}
		out.println("<h4>Exam Pattern is Sucessfuly defined<h4>");

	}
	
%>
<a href="/zalm/admin/securelogin.jsp"><h4>Home</h4> </a> 
</body>
</html>
