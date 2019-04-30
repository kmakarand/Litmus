
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->



 <html>
 <head>
 <title> Forward </title>
 </head>
 <%@ page language="java" %>
 <body>
 <form>
 <%


	int ExamID		= Integer.parseInt(request.getParameter("rtest"));
	String tstatus	= (String)session.getValue("teststatus");
	String dt		= "";
	String st		= "";
	String rtestname ="";
	String SectionID ="";
	//String LastSection = "";


	if(request.getParameter("SectionID")!=null) SectionID=request.getParameter("SectionID");
	if(request.getParameter("rtestname")!=null) rtestname=request.getParameter("rtestname");
	if(request.getParameter("st")!=null)		st=request.getParameter("st");
	//if(request.getParameter("lastsection")!=null)		LastSection=request.getParameter("lastsection");
	String CodeGroupID= request.getParameter("CodeGroupID");
	String d = "dt"+ExamID;
	//System.out.println("dt :"+request.getParameter(d));
	//System.out.println("ExamID :"+ExamID);

	if(request.getParameter("dt"+ExamID)!=null) dt=request.getParameter("dt"+ExamID);


	if( dt.equals("1") && tstatus.equals("new"))
		{
		   //System.out.println("Inside 1:" );
		%>
		  <jsp:forward page="DisplayAllTests.jsp">
		  <jsp:param name="ExamID" value="<%=ExamID%>"/>
		  <jsp:param name="rtestname" value="<%=rtestname%>"/>
		  </jsp:forward>
		  <%
		 }
		 else if((tstatus.equals("new"))&&(st.equals("1")))
		     {
		       //System.out.println(" Inside 2:");
			%>
			<jsp:forward page="NewTestSelection.jsp">
			<jsp:param name="ExamID" value="<%=ExamID%>"/>
			<jsp:param name="rtest" value="<%=ExamID%>"/>
			<jsp:param name="st" value="1"/>
			<jsp:param name="dt" value="1"/>
			<jsp:param name="lastsection" value="1"/>
			<jsp:param name="SectionID" value="<%=SectionID%>"/>
			<jsp:param name="rtestname" value="<%=rtestname%>"/>
			</jsp:forward>
			<%
 		     }
			else if(tstatus.equals("new"))
		     {
		       //System.out.println(" Inside new");
		       //System.out.println("ExamID :"+ExamID);
		       //System.out.println("dt :"+dt);
			%>
			<jsp:forward page="NewTestSelection.jsp">
			<jsp:param name="ExamID" value="<%=ExamID%>"/>
			<jsp:param name="rtest" value="<%=ExamID%>"/>
			<jsp:param name="dt" value="<%=dt%>"/>
			</jsp:forward>
			<%
 		     }
			else
		     {
		         //System.out.println(" Inside else");
			%>

			<jsp:forward page="NewTestSelection.jsp">
			<jsp:param name="ExamID" value="<%=ExamID%>"/>
			<jsp:param name="CodeGroupID" value="<%=CodeGroupID%>"/>
			</jsp:forward>

			<%
 		     }


%>
 </form>
 </body>
 </html>
