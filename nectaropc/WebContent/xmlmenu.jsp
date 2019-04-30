<%@ page language="java" import="java.sql.*,java.util.Hashtable" session="true" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<%@ taglib uri="/WEB-INF/menu.tld" prefix="menu" %>
<html>
<BODY>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
   <tr align="center">
       <td align="right" width="40%"><img width="120" height="120" src="file:///C:/Users/Makarand/NGEPL/NGS/nectar/WebRoot/jsp/simages/newlogo.jpg"></td>
       <td align="left">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="C:\Users\Makarand\NGEPL\NGS\nectar\WebRoot\jsp\simages\newlogo.jpg" width="461" height="26" align="top"></td>
   </tr>
</table>
<menu:renderMenuFromXML xmlFilename="C:\Users\Makarand\NGEPL\NGS\nectar\WebRoot\candidatemenu.xml"/>
</BODY>
</HTML>