
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

<%@ page language="java" import="java.sql.*" session="true"%>
<jsp:useBean id="TransCheck" scope="application" class="com.ngs.gen.InsertUpdateC"/>
 <jsp:useBean id="pool3" scope="page" class="com.ngs.gbl.ConnectionPool"/>


<BODY>


<%
	
	String query1 = "INSERT INTO ImageDetails (QuestionID,Image,SequenceID) VALUES (5555,'check',1)";
	String query2 = "select count(*) from ImageDetails where QuestionID=5555 and Image='check' and SequenceID=1";

	try
	{
		pool3=(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
		
		Connection con1 = pool3.getConnection();
		if(con1==null) out.println("Connection null");
		Statement s = null;
		ResultSet rs = null;
		
		try
		{
			s = con1.createStatement();
			if(s==null) out.println("s null");

		
			if(!TransCheck.checkTranscation(query2,con1))
			{
				s.executeQuery(query1);
			}
		}catch(SQLException e)
		{
			out.println("Exception caught : "+e.getMessage());
		}


	}
	catch( Exception e)
	{
		out.println("Exception caught :"+e.getMessage());
	}
%>
</BODY>
</HTML>
