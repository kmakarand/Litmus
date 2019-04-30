<%@ page language="java" import="java.sql.*"  session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title> Usernames </title>
 <style>td{font-family:arial;font-size:9pt;} body{font-family:arial;font-size:9pt;}
 a{text-decoration:none} .ti{font-family:arial;font-size:11pt;color:#960317}</style>
</head><BODY bgColor=#FEF5E7>

<%
String sql="";
Connection con=null;
Statement stmt=null;
ResultSet rs=null;

try{

      //If the pool is not initialised
        ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		con = pool.getConnection();
 		stmt = con.createStatement();
    }catch(Exception e){}

    sql="select * from ExamMaster";
    rs=stmt.executeQuery(sql);
 %><br><br><br>
 <center>
 <span class=ti><b>Select the Exam of which you wish to view the Questions:</b><span>
 <form name='f1' method='post' action='previewQuestionName.jsp'>
 <select name='ExamId'>
 <%
    while(rs.next()){

    out.print("<option value='"+rs.getString("ExamID")+"'>"+rs.getString("Exam")+"</option>");

    }
	%>
	</select><br><br>
	<input type='submit' value='Get Questions'></center>
	</form>
	</body></html>
