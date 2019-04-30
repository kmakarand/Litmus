<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->
<html>
<head>
<title> Parse Confirm </title>
</head>

<body bgcolor=#FEF9E2>
<%@ page language="java" import="java.io.*"  session="true"%>
<%/*
String adminuser = (String) session.getValue("adminuser");

if (adminuser == "" || adminuser == null)
{
	response.sendRedirect("/zalm/admin/zeealmadmin.htm");
}*/
%>
<%
String filename=request.getParameter("filename");
String fileList=request.getParameter("fileList");
String exam=request.getParameter("exam");
String tablename=request.getParameter("tablename");
%><br><%
out.println(filename);
%><br><%
out.println(fileList);
%><br><%
out.println(exam);
%><br><%
out.println(tablename);
%><br><%
out.println("Parsing Completed by String");
%>

<jsp:useBean id="parser" scope="page" class="rehanpinjo.saxOne"/>

<h3> Parsing Complete Confirmed </h3>
<%

//parser.setUrl(filename);
//parser.setUri(filelist);
parser.setdb(exam);
parser.setTable(tablename);
parser.setUrl(filename);
parser.parseURI();


%>

</body>
</html>
