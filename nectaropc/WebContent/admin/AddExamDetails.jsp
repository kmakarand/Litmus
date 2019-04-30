<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,com.ngs.gbl.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper,org.apache.commons.io.filefilter.WildcardFileFilter"%>
<%@page import="com.ngs.ReadExcelFile"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<html>
<head>
<title>Add Exam Details</title>
<script language="javascript">
	function x(){
	alert("hello");
}
</script>
</head>
<body  bgcolor="#FEF9E2">
<%
	String action = request.getParameter("action");
//	ConnectionPool pool = null;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	try
	{
		pool = (ConnectionPool)getServletContext().getAttribute("CONNECTION_POOL");
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
<H3>Add Exam Details</H3>
<hr size="1"><br>
Select name of Exam and submit to enter details of Exam:
<br>
<FORM METHOD="POST">
<INPUT TYPE=HIDDEN NAME=action VALUE="AddExamDetails">

Select Exam : 
<SELECT NAME=ExamID>
<%
		//System.out.println("0");
			while (rs.next())
			{
				int ExamID = rs.getInt("ExamID");
				String Exam = rs.getString("Exam");

				out.println("<OPTION VALUE='" + ExamID + "'>" +Exam+ "</OPTION>");
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
		
%>
<CENTER>
<H3>Add Exam Details</H3>
<hr size=1><br>

<FORM METHOD="POST">
<INPUT TYPE=HIDDEN NAME=action VALUE="DoAddExamDetails">
<INPUT TYPE=HIDDEN NAME=ExamID VALUE="<%=ExamID%>">

<table align="center"><b>
	<tr>
<%
	try
	{
		Statement st1 = conn.createStatement();
		ResultSet rs1 = st1.executeQuery("SELECT * FROM SubjectMaster order by Subject");	
		ResultSetMetaData rsmd = rs1.getMetaData();
		int col = rsmd.getColumnCount();	
		out.println("<td><b>Subject Name : </td>");
		out.println("<td>");
		out.println("<select name='subjectid'>");
		//System.out.println("1");
		while(rs1.next())
		{
			out.print("<OPTION VALUE='" + rs1.getString("SubjectID") + "'>" + rs1.getString(2) + "</OPTION>");
		}
		out.print("</select>");
		out.println("</td></tr>");
		out.println("<tr>");
		out.println("<td> No. Questions : </td>");
		out.println("<td> <input type='text' name='noquest' OnLostFocus='x();'></td></tr>");
		out.println("<td> Response Time : </td>");
		out.println("<td> <input type='text' name='responsetime'></td></tr>");
		out.println("<td> No. of Breaks : </td>");
		out.println("<td> <input type='text' name='nobreaks'></td></tr>");
		out.println("<td> Breaks Intervals : </td>");
		out.println("<td> <input type='text' name='breakinterval'></td></tr>");
		out.println("<td> Criteria : </td>");
		out.println("<td> <input type='text' name='criteria'></td></tr>");
		out.println("<td> Exam Time : </td>");
		out.println("<td> <input type='text' name='examtime'></td></tr>");
		out.println("<td> No. of Modules : </td>");
		out.println("<td> <input type='text' name='nomodules'></td></tr>");
		System.out.print("hello");		
		out.println("<tr><td> <input type='submit' name='DoAddExamDetails' value='Submit' ></td></tr>");
		rs1.close();
		st1.close();
	}
	catch(Exception e)
	{
		System.err.println("ERROR: " + e.getMessage());
	}
%>
</b>
</table>

</FORM>
</CENTER>
	<%}

	else if (action.equals("DoAddExamDetails"))
	{

		String subjectid = request.getParameter("subjectid");
		String section = request.getParameter("ExamID");
		String noquestions = request.getParameter("noquest");
		String responsetime = request.getParameter("responsetime");
		String nosbreaks = request.getParameter("nobreaks");
		String breakinterval = request.getParameter("breakinterval");
		String criteria = request.getParameter("criteria");
		String examtime = request.getParameter("examtime");
		String modules = request.getParameter("nomodules");
		
		Statement stmt2 = conn.createStatement();
		Statement stmt3 = conn.createStatement();
		ResultSet rs3=null;
		int num=0;
		try
		{
			rs3 = stmt3.executeQuery("SELECT max(SequenceID) FROM ExamPattern");
			while(rs3.next())
			{
				String nu = rs3.getString(1);
				num = Integer.parseInt(nu);
				out.println("number : " +num);
				num++;
			}
			
			int ret = stmt3.executeUpdate("insert into ExamPattern (ExamCode,ExamId,SubjectID,ModuleID,SequenceID,NegativeMarkinfs,NegativeMarks) values ('',"+ section + "," + subjectid + "," + modules + "," + num + 0 + 0 +")");

			if (ret > 0) out.println("Sucess : " + ret);
			else out.println("No : " + ret);
			
			String q="INSERT INTO  	ExamDetails(ExamID,SubjectID,NoOfQuestions,ResponseTime,NoOfBreaksAllowed,BreakInterval,Criteria,ExamTime,NoOfModules)VALUES ("+ section +","+subjectid+"," + noquestions + "," + responsetime + "," + nosbreaks + "," + breakinterval + "," + criteria + "," +	examtime+ ","+ modules + ")";
				
			int val = stmt2.executeUpdate(q);
			//System.out.println(val);
			if (val > 0)
			{
				out.println("<B>SUCCESS</B> : Section <B>" + section + "</B> added successfully.");
			}
			else
			{
				out.println("<FONT COLOR=red><B>ERROR</B></FONT> : Section <B>" + section + "</B> is not added.");
			}
			
			stmt2.close();
//			conn.close();
			
		}
		catch (SQLException e)
		{
			out.println("<FONT COLOR=red><B>ERROR</B></FONT> : Possibly Value may already present in database" + e.getMessage());
			e.printStackTrace();
		}
		finally
		{
//			pool.releaseConnection(conn);
		}

	}
	else
		out.println("not fired");
%>
<a href="../admin/zalmhome.htm"><h4>Home</h4> </a> 
</body>
</html>