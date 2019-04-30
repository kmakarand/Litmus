<%@ page language="java" import="java.sql.*,java.io.*" session="true"%>
<html>
<title>Message Box</title>
<style>td{font-family:arial;font-size:10pt;} body{font-family:arial;font-size:11pt;} b{font-family:arial;font-size:11pt;}</style>
<script language='javascript'>
function go()
{
	window.close();
}
</script>
<body bgcolor='#FEF9E2'>
<%
	String message="";
	message =(String) session.getValue("message");
//	out.println("hello messs : " + message);
	/*out.println("<script language='javascript'>");
	out.println("javascript:alert('"+message+"')");
	out.println("javascript:window.close();");
	out.println("</script>");
*/
	out.println("<form>");
	out.println("<h4>"+message+"<h4>");
	out.println("<input type= button value=OK width=50 onclick=go();>");
	out.println("</form>");
%>
</body>
</html>