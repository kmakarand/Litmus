
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<html>
<head>
<title>Section Manager</title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
</head>

<body bgcolor="#fff5e7">
<form action="NewTestSelection.jsp">

<br>
<%@ page language="java" import="java.sql.*,java.text.*,com.ngs.gbl.*" session="true"  %>

<jsp:useBean id="pool2" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%

String c1			= (String)session.getValue("username");
if (c1 == null || c1.equals(null) || c1=="") response.sendRedirect("http://172.16.3.102:8080/zalm/jsp/SessionExpiry.jsp");

Integer CID			= (Integer)session.getValue("CandidateID");
Integer SID			= (Integer)session.getValue("SectionID");
Integer EID			= (Integer)session.getValue("ExamID");
String  NS			= (String)session.getValue("NoOfSections");
int NoOfSections	= Integer.parseInt(NS);
--NoOfSections;
String tsec			= ""+NoOfSections;
session.putValue("NoOfSections",tsec);

int CandidateID		= CID.intValue();
int SectionID		= SID.intValue();
int ExamID			= EID.intValue();

Integer CodeGID		= (Integer)	session.getValue("CodeGID");
int CodeGroupID		= 0;
CodeGroupID			= CodeGID.intValue();

Connection con=null;
Statement  stmt;
			   stmt=null;
ResultSet rses;
			  rses=null;	

String action = request.getParameter("action");		
//if (action == "" || action == null )							
	

	pool2=(ConnectionPool)getServletContext().getAttribute("ConPoolbse");


		try
			 { 
				 con = pool2.getConnection();
	             if(con==null) out.println("Connection not obtained");
				 if(con!=null)
					{
						 //Creating the statement object for executing querry 
				 		 //out.println("Before statement creation");
				 		 stmt  = con.createStatement();
						 try
						 {
							stmt.executeUpdate("Delete from ExamStatus where CandidateID="+CandidateID+" AND SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID);	
						 }
						 catch(SQLException e)
						{
							 out.println("SQL Exception Caught");
						}

		
							try
							{
								
								 rses=stmt.executeQuery("Select ExamStatus.CodeGroupID,NewExamDetails.SectionName  from ExamStatus,NewExamDetails WHERE  ExamStatus.ExamID="+ExamID+" AND ExamStatus.CandidateID="+CandidateID+" AND ExamStatus.SectionID=NewExamDetails.SectionID AND ExamStatus.CodeGroupID=NewExamDetails.CodeGroupID");
							}catch(SQLException e)
								{
							  		out.println("SQL EXCEPTION CAUGHT 1 :"+e.getMessage());
								}

								
								out.println("<table  width=\"480\" height=\"25\">");
								while(rses.next())
								{

									out.println("<tr><td align=\"left\" valign=\"top\">");
									out.println("<input type=radio name=\"rtestname\" value=\""+rses.getInt("CodeGroupID")+"\"</td>"+rses.getString("SectionName"));
									out.println("</tr></td>");
												
								}
								out.println("</table>");
								out.println("<input type=hidden name=dt value=1>");
								out.println("<input type=hidden name=ExamID value="+ExamID+">");
								out.println("<input type=hidden name=SectionID value="+SectionID+">");
								out.println("<br>");
								out.println("<input type=\"image\" src=\"../simages/submit1.gif\" name=\"Image1\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver = \"MM_swapImage('Image1','','../simages/submit2.gif',1)\">");
						}
					}
 					catch(SQLException sqle)
					{
				       out.println(sqle.getMessage());
					}
					catch(Exception e)
					{
					   out.println(e.getMessage());
					}
				    finally
					{
					  //Release the connection
					  if(con!=null)  pool2.releaseConnection(con);
					  else out.println("Connection not obtained");
					}	


					
%>



</body>
</html>

