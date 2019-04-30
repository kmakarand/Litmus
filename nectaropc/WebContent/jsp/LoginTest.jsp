
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->



<%@ page language="java" import="javax.persistence.*,com.ngs.entity.*,com.ngs.dao.*,com.ngs.security.*,com.ngs.gbl.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
 <%@ page import ="javax.sql.*" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<html>
<head>
<title>Nectar Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
<script language=javascript>

if (top.mainFrame)
{
	top.location.href = "Login.jsp"
}

function PopWindow(url)
{
	window.open(url, "new", "width=400,height=200,left=200,top=100,resizable=0");
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<CENTER>
  <form name="f1" method=POST>
    <table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
      <tr>
        <td align="center"><img src="simages/logoN1.jpg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td align="center"><img src="simages/newlogo.jpg"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td align="center"> <br>
          <table border="0" cellspacing="1" cellpadding="1" align="center">
            <tr>
              <th colspan="2">Login</th>
            </tr>
            <tr>
              <td align="right">Username : </td>
              <td>
                <input type="text" name="Username">
              </td>
            </tr>
            <tr>
              <td align="right">Passcode : </td>
              <td>
                <input type="password" name="Password">
              </td>
            </tr>
            <tr>
            	<TD align=right>Choose Test or Module:</TD>
            	<TD><SELECT NAME="testormod">
            	<OPTION VALUE="module">Module</OPTION><OPTION VALUE="exam">Examination</OPTION>
				</SELECT></TD>
            </tr>
            <tr>
              <input type=hidden name=action value="doLogin">
              <th colspan="2" valign="top">
                <input type=submit value="Login" name="submit">
              </th>
            </tr>
          </table>
	         <!-- <p><img src="simages/Nectar_Logo.jpg" width="780" height="319"><br></p> -->
	          </td>
	      </tr>
	      <tr>
	        <td align="center">&nbsp;</td>
	        <td align="center"></td>
	      </tr>
	    </table>
	    </form>
	</CENTER>
</body>
</html>
