<%@ page import="java.sql.*"%>
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<html>
<head>
<title>Change Section </title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
</head>

<body bgcolor="#fff5e7">
<form action="NewTestSelection.jsp">

<br>
<%@ page %>



<%
		


	
	--NoOfSections;
	String tsec			= ""+NoOfSections;
	session.putValue("NoOfSections",tsec);
	//String stnametemp	= c1+"temp";
	session.putValue("SectionStatus","ON");
	int mCGID = 0;
   
	Integer TestAttemptNo= (Integer) session.getValue("TestAttemptNo");

	Statement	s1,s2,s3,s4;
				s1=s2=s3=s4=null;
	ResultSet	rses;
				rses=null;	


			
						s1  = con.createStatement();
						s2 = con.createStatement();
						s3 = con.createStatement();
						s4 = con.createStatement();

						//out.println("teststart2 :"+teststart2);


						if(!teststart2.equals("start"))
						{
							try
								{
									
									//out.println("Delete from ExamStatus where CandidateID="+CandidateID+" AND SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID);

									s1.executeUpdate("Delete from ExamStatus where CandidateID="+CandidateID+" AND SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID);
								}
								catch(Exception e)
									{out.println("DELETE FROM EXAM STATUS ERROR	"+e.getMessage());}
						}
						


						ResultSet rs22 = null;

				
						try
						{
							rs22=s2.executeQuery("Select min(CodeGroupID) from ExamStatus where CandidateID="+CandidateID);
						}
						catch(SQLException e)
						{
							out.println("Exception caught");
						}
						
						while(rs22.next()) mCGID= rs22.getInt(1);

						try
						{
							s4.executeUpdate("Update ExamStatus set SectionStart=1 where CandidateID="+CandidateID+" and ExamID="+ExamID+" and SectionID="+SectionID+" and CodeGroupID="+mCGID);
						}
						catch(SQLException e)
						{
							out.println("Exception caught");
						}

	//out.println("mcid :"+mCGID);					
						
						ResultSet rs32 = null;
						try
						{
							rs32 = s3.executeQuery("Select LevelID,NoOfQuestions from NewExamDetails where ExamID="+ExamID+" and SectionID="+SectionID+" and CodeGroupID="+mCGID);
						}
						catch(SQLException e)
						{
							out.println("Exception caught");
						}
						
						while(rs32.next())
						{
							session.setAttribute("TotalQuestions",new Integer(rs32.getInt("NoOfQuestions")));
							session.setAttribute("LevelID",new Integer(rs32.getInt("LevelID")));
						}

						session.setAttribute("CodeGID",new Integer(mCGID));
						session.setAttribute("switchsections","true");

						
					
			 			

	
	
					
								
					
					
				
					
%>
</body>
</html>
