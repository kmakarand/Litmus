<%@ page language="java" import="javax.persistence.*,com.ngs.entity.*,com.ngs.dao.*,com.ngs.security.*,com.ngs.gbl.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
 <%@ page import ="javax.sql.*" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title>Nectar Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
</head>
<body>

	<form action="/nectar/jsp/upload.jsp" method="post" enctype="multipart/form-data">
			<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
	     	 <tr><BR/><BR/>
	          <td align="center" colspan="2"><font family=gorgia size=3>Add Question Bank</font></td>
	      	</tr>
	      	<tr>
	        <td align="center">&nbsp;</td>
	        <td align="center"> <br>
         	<table border="0" cellspacing="1" cellpadding="1" align="center">
  		 	<tr><td>Select the file to be uploaded:</td><td><INPUT TYPE="FILE" NAME="fileList"></td></tr> <BR>
		 	<tr>
              <input type=hidden name=flag value="AddQuestion">
              <input type=hidden name=action value="AddQuestion">
              <th colspan="2" valign="top">
                <input type=submit value="Upload File" name="submit">
              </th>
            </tr>
          	</table>
	</form>

</body>
</html>
