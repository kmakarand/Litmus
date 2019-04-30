
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
	int SectionID	= Integer.parseInt(request.getParameter("rtestname"));
	String tsections= "Sections"+SectionID;
	int NoOfSections= Integer.parseInt(request.getParameter(tsections));
	String sections =""+NoOfSections;
	session.putValue("NoOfSections",sections);
	
	/*//System.out.println("NoOfSections:::::"+NoOfSections);
	//System.out.println("sections:::::"+sections);
	//System.out.println("ExamID:::::"+ExamID);
	//System.out.println("SectionID:::::"+SectionID);*/
	
	
	if(NoOfSections>1 )
		{
		
		////System.out.println("Forward to DisplaySections.jsp");
		%>
		  <jsp:forward page="DisplaySections.jsp">
		  <jsp:param name="ExamID" value="<%=ExamID%>"/>
		  <jsp:param name="NoOfSections" value="<%=NoOfSections%>"/>
		  </jsp:forward>

		 <%
	 }
	 else
	     {
	     ////System.out.println("Forward to NewTestSelection.jsp");
			%>

			<jsp:forward page="NewTestSelection.jsp">
			<jsp:param name="ExamID" value="<%=ExamID%>"/>
			<jsp:param name="rtest" value="<%=ExamID%>"/>
			<jsp:param name="SectionID" value="<%=SectionID%>"/>
			<jsp:param name="dt" value="1"/>
			</jsp:forward>

			<%
 		     }

%>
 </body>
</html>
