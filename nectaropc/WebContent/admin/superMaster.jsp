<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title> Usernames </title>
 
</head>
<div align="center">
  <p><br>
    <font size="3" face="Arial, Helvetica, sans-serif"><b><font size="5" color="#000099">Rights Revise Console</font></b></font></p>
  <p align="left">&nbsp;&nbsp;____________________________________________________________________________________________</p>
  <p align="left">&nbsp;</p>
<%
String adminuser = (String) session.getValue("username");
 
if (adminuser == "" || adminuser == null)
{
	response.sendRedirect("/zalm/admin/zeealmadmin.htm");
}

 
int rights=0;
Connection con=null;
Statement stmt2=null;
ResultSet rs2=null; 
 
try{

      //If the pool is not initialised
        con = pool.getConnection();
 		stmt2 = con.createStatement(); 
	  
	%>	
		
	<BODY bgColor=#FEF9E2>
<Form  action=rightsOptions.jsp method=POST>


<table border=0 cellspacing=2 cellpadding=2 width=100%>
<tr valign=top>
 
 <td align="right">Select Username For Alter: </td>
      <td colspan="5"> &nbsp; 
        <select name="username">
         <%

rs2 = stmt2.executeQuery("SELECT * FROM CandidateMaster");
			while(rs2.next()){
				%>

<OPTION VALUE="<%out.print(rs2.getString("CandidateID"));%>"><%out.print(rs2.getString("Username"));%>
			<%
				}
			%>
			</SELECT>

 
</tr>
 
<%

        }
    catch (Exception e)   {
		   out.print("Exception pinjo!!!!!!  "+e);
		}
%>
  
</tr></td> 
  
  <input type="Submit" value="Revise Rights">
		<input type=reset value=Reset>
</form>
 
</body>
</html>
