<%@ page language="java" session="true" %>
<html>
<head>
<title>Logged out of Nectar Online Exam</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=javascript>

<script type="text/javascript"> 
if (self.parent.frames.length != 0){
    self.parent.location=document.location.href;
}

if (top.menu_page)
{
	top.location.href = "Logout.jsp"
}

</SCRIPT>

</head>

<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<%
	session.invalidate();
%>
<CENTER>
    <table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
      <tr>
       <!-- <td align="center"><img src="simages/top-ZCA.gif" width="780" height="71"></td> -->
      </tr>
      <tr>
        <td align="center"> <br>
          <table border="0" cellspacing="1" cellpadding="1" align="center">
            <tr>
              <th>Success</th>
            </tr>
            
            <tr>
              <td><P><br><B>You are successfully Logged Out.</B></P>If you are logged out by mistake, <a target=_top href='Login.jsp'>Login</a> again.<br>
			  </td>
            </tr>
          </table>
	   </td>
	  </tr>
	</table>
</body>
</html>
