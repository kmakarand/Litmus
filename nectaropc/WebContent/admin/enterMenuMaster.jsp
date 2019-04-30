<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->



<html>
<head>
<title>Database</title>
</head>

<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<style>td{background-color:lightblue;color:black;font-family:arial;}
body{font-family:arial;font-size:10pt}
</style>
<form action=editMenuMaster.jsp method=get>
<body bgcolor=#FEF9E2>
<H4>

<%

		String menuid=request.getParameter("menuid");
		String menudescription=request.getParameter("menudescription");
		String menuname=request.getParameter("menuname");
		String commandurl=request.getParameter("commandurl");
		//String targetframe1=request.getParameter("targetframe");
		int targetframe=Integer.parseInt(request.getParameter("targetframe"));
		String helpurl=request.getParameter("helpurl");
		String faqurl=request.getParameter("faqurl");
		String severity=request.getParameter("severity");
		String applicability=request.getParameter("applicability");


		//int partyid=Integer.parseInt(request.getParameter("partyid"));


 try
    {
      //If the pool is not initialised

      Connection con = pool.getConnection();
	  Statement stat = con.createStatement();

	stat.executeUpdate("INSERT INTO MenuMaster(MenuID,MenuDescription,MenuName,Command,TargetFrame,HelpURL,FAQURL,Severity,Applicability)VALUES(\'"+menuid+"\',\'"+menudescription+"\',\'"+menuname+"\',\'"+commandurl+"\',"+targetframe+",\'"+helpurl+"\',\'"+faqurl+"\',\'"+severity+"\',\'"+applicability+"\')");

/* */


     stat.close();
	 con.close();
	}
	 catch(Exception exception)
					{
						out.println("Duplicate Entry:"+exception);

					}


%>
<jsp:forward page="editMenuMaster.jsp">
<jsp:param name="employee" value="2"/>
</jsp:forward>
</form>
</body>



</html>

