<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper,org.apache.commons.io.filefilter.WildcardFileFilter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	 "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<title>Nectar Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
<body>
	<CENTER>
		<P>&nbsp;</P>
		<div align="center">
		    <br/><br/>
		    <font align="center">The generated sql script can be download from following links  </font><br/><br/>
			<TABLE BORDER=0 CELLSPACING='1' CELLPADDING='1'>
			<tr><th>File Name</th><th>Download File</th>
			<%
					//File f = new File("/opt/tomcat/temp/");
					String filepath = request.getParameter("filepath");
					String filename = request.getParameter("fileList");
					//System.out.println("success filepath :"+filepath);
					//System.out.println("success filename :"+filename);
					
					File f = new File(filepath+"download/");
			        FileFilter fileFilter = new WildcardFileFilter("*.sql");
					File[] files = f.listFiles(fileFilter);
			        for(int i=0;i<files.length;i++){
			        String name=files[i].getName();
			        String path=files[i].getPath();
			%><tr><td><%=name%></td><td><a href="download.jsp?f=<%=path%>">Download File</a></td></tr>
		    <%}%>
		</table>
		
	</center>
</body>
</html>