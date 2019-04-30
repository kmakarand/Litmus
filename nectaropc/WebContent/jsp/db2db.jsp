
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<HTML>
<HEAD>
<TITLE> New Document </TITLE>

</HEAD>
<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<BODY>


<%

	Connection con	= null;
	Connection con2 = null;
	try
	{

	ServletContext context	   = getServletContext();
	pool					   =(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
	con = pool.getConnection();
	con2 = pool.getConnection();

	
	Statement s1 = con.createStatement();
	Statement s2 = con2.createStatement(); 

	
	
			if((con!=null)&&(con2!=null))
				{         
					//----------Creating the statement object for executing query 
					
					
					ResultSet rs =s1.executeQuery("Select QuestionID,LevelID,NewAnswer,Marks from QuestionMaster where ExamID=8");
					
					while(rs.next()) 
					{

						
						s2.executeUpdate("Update QuestionMaster set LevelID="+rs.getInt("LevelID")+",NewAnswer='"+rs.getString("NewAnswer")+"',Marks="+rs.getInt("Marks")+" where ExamID=8 and QuestionID="+rs.getInt("QuestionID"));
						
						out.println("<BR>Query :"+"Update QuestionMaster set LevelID="+rs.getInt("LevelID")+",NewAnswer='"+rs.getString("NewAnswer")+"',Marks="+rs.getInt("Marks")+" where ExamID=8 and QuestionID="+rs.getInt("QuestionID"));

					
					
					
					
					}
					
				}

	}
	catch( Exception e)
	{
		out.println("Exception caught :"+e.getMessage());

	}
	finally
	{
		if(con!=null) pool.releaseConnection(con);
	}
%>
</BODY>
</HTML>
