<%@ page language="java" import="java.sql.*,java.util.Hashtable" session="true" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<%@ taglib uri="/WEB-INF/menu.tld" prefix="menu" %>

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 

</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<link rel="stylesheet" href="../alm.css" type="text/css">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr align="left">
       <td width="30%" rowspan="2"><img src="simages/logoN1.jpg" width="320" height="120" align="right"></td>
       <td width="60%" height="10"><img src="simages/newlogo.jpg" width="461" height="26" hspace="40" vspace="20" align="top"></td>
 </tr>
  <tr align="left">
  <td width="80" rowspan="2" valign="top">
    <menu:renderMenuFromDB driverName="com.mysql.jdbc.Driver"
                         driverUrl = "jdbc:mysql://localhost:3306/nectar"
                         userName="nectar"
                         password="nec76tar"/></td>
    <%--<%if(groupxid.equals("00")){%>
    <td rowspan="2" width="20%" align="center"><menu:renderMenuFromXML xmlFilename="C:\Users\Makarand\NGEPL\NGS\nectar\WebRoot\jsp\xml\superusermenu.xml"/></td>
    <%}else if(groupxid.equals("05")){%>
    <td width="20%" rowspan="2" align="center"><menu:renderMenuFromXML xmlFilename="C:\Users\Makarand\NGEPL\NGS\nectar\WebRoot\jsp\xml\adminmenu.xml"/></td>
    <%}else if(groupxid.equals("15")){%>
    <td width="20%" rowspan="2" align="center"><menu:renderMenuFromXML xmlFilename="C:\Users\Makarand\NGEPL\NGS\nectar\WebRoot\jsp\xml\managermenu.xml"/></td>
    <%}else if(groupxid.equals("20")){%>
    <td width="20%" rowspan="2" align="center"><menu:renderMenuFromXML xmlFilename="C:\Users\Makarand\NGEPL\NGS\nectar\WebRoot\jsp\xml\candidatemenu.xml"/></td>
    <%}%>
  --%></tr>
  
 </table>
 <iframe width="100%" height="445px" name="main_page" src="welcome.jsp" frameborder=0 ALLOWTRANSPARENCY="true"></iframe>
</div>
 </BODY>
</HTML>