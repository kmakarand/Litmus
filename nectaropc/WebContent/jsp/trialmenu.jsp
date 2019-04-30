<%@ page language="java" import="java.sql.*,java.util.Hashtable" session="true" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<%@ taglib uri="/WEB-INF/menu.tld" prefix="menu" %>

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<link rel="stylesheet" href="../alm.css" type="text/css">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr align="left">
       <td width="10%" rowspan="3"><img src="simages/logoN1.jpg" width="120" height="120" align="right"></td>
       <td width="30%" height="5"><img src="simages/newlogo.jpg" width="461" height="26" hspace="20" vspace="10" align="top"></td>
	   <td width="60%" rowspan="3"><menu:renderMenuFromDB driverName="com.mysql.jdbc.Driver"
                         driverUrl = "jdbc:mysql://localhost:3306/nectar"
                         userName="nectar"
                         password="nec76tar"/></td>
 </tr>
  <tr align="left">
    <td height="41">&nbsp;</td>
  </tr>
  <tr align="left">
    <td height="10">&nbsp;</td>
  </tr>
 </table>
</div>
</BODY>
</HTML>