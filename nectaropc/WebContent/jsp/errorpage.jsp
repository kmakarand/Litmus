
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->



<%@ page language="java" %>
<%@ page isErrorPage="true"%>
<html>
<body bgcolor="#fff5e7">
<br><br><br>
<center>
<table width=400 border=3 bordercolor='#960317'>
<tr><td><center><b><font color='#960317'> ERROR <%=exception.getMessage()%></font></b></center></tr></td>
<tr>
<td><i>The request could not be processed.
The message has been logged together with more detailed information
about the error so we can analyze it further.<br>Please try again, and
<a href="mailto:webmaster@zils.com"> let us know</a> if the 
problem persists.</i>
</tr></td>
</table>
</center>
</body>
</html>

