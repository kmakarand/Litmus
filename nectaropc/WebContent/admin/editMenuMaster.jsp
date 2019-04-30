<html>
<head>
 <title>Database Input Manager Console</title>
 <%@ page language="java" import="java.sql.*"  session="true"%>
<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>

<%
/*
String adminuser = (String) session.getValue("username");
out.print(adminuser);
if (adminuser == "" || adminuser == null)
{
	response.sendRedirect("/zalm/admin/zeealmadmin.htm");
}
*/
%>
  
 
</head>


<body bgcolor=#FEF9E2>
<FORM METHOD="GET" ACTION="enterMenuMaster.jsp">
<table align="left" cellspacing="1" cellpadding="1" border="0"> 

<tr><td>Menu ID(exact 8 characters): </td><td>  <INPUT TYPE="text" NAME="menuid" SIZE="8" maxlength="8"></td></tr> 
<tr><td>Menu Description: </td><td>   <INPUT TYPE="text" NAME="menudescription" SIZE="50" maxlength="120"></td></tr> 
<tr><td>Menu Name: </td><td>   <INPUT TYPE="text" NAME="menuname" SIZE="50" maxlength="120"></td></tr> 
<tr><td>Command URL: </td><td>   <INPUT TYPE="text" NAME="commandurl" SIZE="50" maxlength="120"></td></tr> 
<tr><td>TargetFrame : </td><td>   <INPUT TYPE="text" NAME="targetframe" SIZE="1" maxlength="1"></td></tr> 
<tr><td>HelpURL  : </td><td>   <INPUT TYPE="text" NAME="helpurl" SIZE="20" maxlength="20"></td></tr> 
<tr><td>FAQURL  : </td><td>   <INPUT TYPE="text" NAME="faqurl" SIZE="20" maxlength="20"></td></tr> 
<tr><td>Severity  : </td><td>   <INPUT TYPE="text" NAME="severity" SIZE="2" maxlength="2"></td></tr> 
<tr><td>Applicability  : </td><td>   <INPUT TYPE="text" NAME="applicability" SIZE="2" maxlength="2"></td></tr> 
</table>
 <br>
  <br>
   <br>
    <br>
	 <br>

<hr>

   <INPUT TYPE="SUBMIT" VALUE="Save">
   </FORM>
<FORM METHOD="POST" ACTION="../servlet/ExamTestDetail?tablename=MenuMaster&editmodify=modrecords">

 <INPUT TYPE="SUBMIT" VALUE="Modify/Delete">
 </FORM>
 </td>

 
</body>
</html>


