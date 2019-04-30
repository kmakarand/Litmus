<%@ page language="java" import="java.sql.*" session="true" %>
<html>
<head>
<title>Login</title>
<style>
body{font-family:arial;font-size:11pt;color:#330099;}
.bi{font-family:arial;font-size:16pt;color:#ff0000;}
</style>
<script language=javascript>

function PopWindow(url)
{
	window.open(url, "new", "width=400,height=250,left=200,top=100,resizable=0");
}
</script>
</head>

<body bgcolor="#FEF9E2">
<%
String action = request.getParameter("action");

//System.out.println("Action : " + action);

if (action == null || action == "")
{
%>
  <CENTER>
  <p><br>
  <b><font size="5" face="Arial, Helvetica, sans-serif" color="#000099">Login to Zee Adaptive Learning Methodology</font></b></p>
   <hr size=1>
  <p align="left">&nbsp;</p>
  <form name="f1" action="/zalm/servlet/superValidationServlet" method=POST>    
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td align="right"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#993333">Username :&nbsp;</font></b></td>
      <td><b><font face="Arial, Helvetica, sans-serif" size="2"> 
        <input type="text" name="Username"></font></b></td>
    </tr>
    <tr> 
      <td align="right"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#993333">Passcode :&nbsp;</font></b></td>
      <td><b><font face="Arial, Helvetica, sans-serif" size="2"> 
        <input type="password" name="Password">
        </font></b></td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td><input type=hidden name=action value="Login"></td>
      <td><b><font face="Arial, Helvetica, sans-serif" size="2">
        <input type="submit" name="t1" value="Login">
        </font></b></td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
	  <td>&nbsp;</td>
	  <td><font face="Arial, Helvetica, sans-serif" size="2"><a href='Register.jsp'>New User ? Sign Up Now !</a></font></td>
    </tr>
    <tr> 
	  <td>&nbsp;</td>
      <td><font face="Arial, Helvetica, sans-serif" size="2"><a href="javascript:PopWindow('forgetpassword.jsp')">Forgot Passcode ?</a></font></td>
    </tr>
  </table>
 </form>
<%
}
else if (action.equals("Login"))
{
%>
  <CENTER>
  <p><br>
  <b>Welcome to Zee Adaptive Learning Methodology</b></p>
	<div align=right><a href=Login.jsp?action=Logout>Log Out</a></div>
  <hr size=1>
<%
}
else if(action.equals("Logout") || action.equals("logout"))
{
	session.invalidate();

	out.println("<CENTER><TABLE BORDER=0>");
	out.println("<TR><TD bgcolor='#DCDCDC'><B>Success</B></TD></TR>");
	out.println("<TR><TD><P><br><B>You are successfully Logged Out.</B></P>");
	out.println("If uou are logged out by mistake, <a href='Login.jsp'>Login</a> again.<br>");
	out.println("<br>You can close this window.<br>");
	out.println("<FORM><INPUT onclick=window.close() type=submit value='Close Window'></FORM></TD></TR>");
	out.println("</TABLE>");

}
%>
</body>
</html>
