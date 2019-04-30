<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper,org.apache.commons.io.filefilter.WildcardFileFilter"%>
<%@page import="com.ngs.ReadExcelFile"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
String adminuser = (String) session.getValue("username");

if (adminuser == "" || adminuser == null)
{
	response.sendRedirect("../jsp/Login.jsp");
}
%>
<html><head><title>Admin Module</title>
<style>p{font-family:verdana,arial;font-color:#ffffff;}
body{font-family:verdana,arial;font-color:#330099;}</style>
</head><body bgcolor="#FEF9E2">
<%
String path="../servlet/ExamTestDetail";
String databasen="nectar";
Connection con=null;
ResultSet rst=null;
try{
	con = pool.getConnection();
    }
	 catch(Exception e){//System.out.println("Exception ! could not be connected" +e.getMessage());
	 }
	 Statement stmt=con.createStatement();
	 rst=stmt.executeQuery("show tables");

%>
<br><br><br>

<form method="post" action="/nectar/jsp/ExamTestDetail.jsp">
  <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center"> <tr>
  <td width="44%">Select The Name of The Table :</td><td width="56%">
        <select name="tablename">
        <%
        while(rst.next())    {
        String tables_name=rst.getString("Tables_in_"+databasen+"");
        out.println("<option value='"+tables_name+"'>"+tables_name+"</option>");
        //System.out.println("<option value='"+tables_name+"'>"+tables_name+"</option>");
     }
        %>
</select></td></tr><tr><td width="44%">&nbsp;</td><td width="56%">&nbsp;</td></tr><tr>
<td width="44%" height="18">&nbsp;</td>
<td width="56%" height="18"><input type='hidden' name='editmodify' value='modrecords'></td>
</tr><tr><td width="44%">&nbsp;</td><td width="56%">&nbsp;</td></tr><tr>
<td colspan="2"><div align="center"><input type="submit" name="Submit" value="Submit">
</div></td></tr></table></form><p>&nbsp;</p>
<p>&nbsp;</p></body></html>
