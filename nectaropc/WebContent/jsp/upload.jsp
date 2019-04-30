<%@ page language="java" import="javax.persistence.*,com.ngs.entity.*,com.ngs.dao.*,com.ngs.security.*,com.ngs.gbl.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
 <%@ page import ="javax.sql.*" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title>Nectar Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
</head>
<body>

<%
//MultipartRequest m = new MultipartRequest(request, "/opt/tomcat/webapps/nectar/admin/upload/");
MultipartRequest m = new MultipartRequest(request, "c:/nectar");
out.print("successfully uploaded");
%>
<jsp:forward page="../admin/AddQuestionBank.jsp"/> 
						
  </body>
</html>