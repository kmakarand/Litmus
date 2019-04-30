
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->



<html>
<head>
 <title> Sections </title>
 </head>
 <%@ page language="java" %>
 <body>
 <%
	int ExamID		= Integer.parseInt(request.getParameter("ExamID"));
 %>

  <jsp:forward page="Sections.jsp">
  <jsp:param name="ExamID" value="<%=ExamID%>"/>
  <jsp:param name="dt" value="1"/>
  <jsp:param name="rtestname" value="1"/>
  <jsp:param name="Sections1" value="1"/>
  </jsp:forward>

 </body>
 </html>





















