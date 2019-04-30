

<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
 <title>Question Data Entry Module</title>
 <style>td{font-family:arial;font-size:9pt;}  body{font-family:arial;font-size:9pt;}</style>
<body>
</head>
			<form action="Question.jsp" method='post'>
			<input type="text" name="message" size="70" maxlength="100">
			<INPUT TYPE="submit" name="add" value="add">


				<%
				//<head><LINK REL="stylesheet" TYPE="text/css" HREF="rlms.css"> 

Statement stat=null;
Statement stat1=null;
Connection con=null;
ResultSet rs=null;
				try{
					
					con =pool.getConnection();   
					
					String action=request.getParameter("message");

					if (action==null){
						}else{
					stat1 = con.createStatement(); 
					//out.print("INSERT INTO pinjo(message,name) VALUES ('"+request.getParameter("message")+"','name')");
					stat1.executeQuery("INSERT INTO pinjo(message,name) VALUES ('"+request.getParameter("message")+"','name')");

						}
				
					stat = con.createStatement(); 
					rs=stat.executeQuery("Select * from pinjo");

					while (rs.next()){
						out.println("&nbsp"+rs.getString("message"));
					}


					}catch (Exception e1)
					{
							out.println(" Question not present for id :"+e1.getMessage());
					}

				%>





 </form>
</body>
</html>