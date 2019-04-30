<%@ page import="java.io.*"%>
<html>
<title>Nectar Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<style>td{font-family:arial;font-size:10pt;} body{font-family:arial;font-size:11pt;} b{font-family:arial;font-size:11pt;}</style>
<div align="center">
    <br/><br/>
    <font align="center">The generated sql script can be download   </font><br/><br/>
<table align="center">
<tr><th>File Name</th><th>Download File</th>
<%
		File f = new File("C:/UploadedFiles");
        File[] files = f.listFiles();
        for(int i=0;i<files.length;i++){
            String name=files[i].getName();
            String path=files[i].getPath();
%>
<tr><td><%=name%></td><td><a href="download.jsp?f=<%=path%>">Download File</a></td></tr>

           
     <%
        }
%>
</table><font><br/><br/><a href="Login.jsp">Back to Login</a></font></div>
</html>