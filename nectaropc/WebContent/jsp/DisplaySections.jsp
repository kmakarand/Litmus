
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002
DOE          : 03 - 03 - 2002
-->



<html>
	  <head>
			<title> Display Sections  </title>
			<style>body{font-family:arial;font-size:11pt;color:#960317;}</style>
			<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
	  </head>



 <body bgcolor="#fff5e7" onLoad="MM_preloadImages( '../simages/submit1.gif', '../simages/submit2.gif' )" >
 <form name="displaysection" action="NewTestSelection.jsp" method="GET">
 <%@ page language="java" import="java.sql.*" session="true"%>
 <jsp:useBean id="pool3" scope="page" class="com.ngs.gbl.ConnectionPool"/>
 <jsp:useBean id="T" scope="application" class="com.ngs.gen.InsertUpdateC"/>


 <%

	String c1 = (String)session.getValue("username");

		if (c1 == null || c1.equals(null) || c1=="") response.sendRedirect("/zalm/jsp/SessionExpiry.jsp");

	String tstatus		= (String)session.getValue("teststatus");
	Integer CID			= (Integer)session.getValue("CandidateID");
	int CandidateID		= CID.intValue();
	int TotalTests		= 0;
	int ExamID			= Integer.parseInt(request.getParameter("ExamID"));
	int SectionID		= Integer.parseInt(request.getParameter("SectionID"));
	int NoOfSections	= Integer.parseInt(request.getParameter("NoOfSections"));
	int CurrentCGID  = 0;




	Connection con=null;
	Statement  stmt,stmt1;
			   stmt=stmt1=null;
	ResultSet rsed;
			  rsed=null;
			  int ExamMode=0;
			  int ShowResults=0;
			  int attempted=0;
			  int allowedAttempts=0;
			  boolean areTestsOver=false;


	pool3=(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");

		try
			 {
				 con = pool3.getConnection();
	             if(con==null) out.println("Connection not obtained");
				 if(con!=null)
					{
						 //Creating the statement object for executing querry
				 		 //out.println("Before statement creation");
				 		 stmt  = con.createStatement();
						 stmt1  = con.createStatement();
out.println("NoOfSections"+NoOfSections);
						 int CGID[] = new int[NoOfSections+1];//+1
						 int SectionTime[] = new int[NoOfSections+1];
						 int i=0;int n=0;


							//out.println("<input type=\"hidden\" name=\"dt\" value=1>");
							//out.println("<H2> WHICH SECTION DO YOU WISH TO GO FOR FIRST ? </H2>");
							try
							{
//Note section time has been changed to examtime
								 rsed=stmt.executeQuery("Select DISTINCT(SectionID),SectionName,CodeGroupID,ExamTime from NewExamDetails WHERE  ExamID="+ExamID+" AND SectionID="+SectionID+" ORDER BY SectionID asc");

							}catch(SQLException e)
								{
							  		out.println("SQL EXCEPTION CAUGHT 1 :"+e.getMessage());
								}


								out.println("<input type=hidden name=SectionID value="+SectionID+" >");
								out.println("<input type=hidden name=ExamID value="+ExamID+" >");
								//out.println("<table  width=\"480\" height=\"25\">");
								while(rsed.next())
								{

									out.println("i :"+i);
									out.println("Length : "+CGID.length);


									out.println("CGID :"+CGID[i]);
									CGID[i] = rsed.getInt("CodeGroupID");
									if(i==0)
									{
										CurrentCGID = CGID[i];
										out.println("<input type=hidden name=\"rtestname\" value=\""+CGID[i]+"\">");

									}

									out.println(rsed.getInt("ExamTime"));
									SectionTime[i]=rsed.getInt("ExamTime");


									//out.println("<tr><td align=\"left\" valign=\"top\">");
									//out.println("<input type=radio name=\"rtestname\" value=\""+CGID[i]+"\"</td>"+rsed.getString("SectionName"));
									//out.println("</tr></td>");
									out.println(rsed.getString("SectionName"));
									++n;
									++i;

								}
								//out.println("</table>");

								String q1 = "";
								String q2 = "";


// INTRODUCING CHECK FOR NUMBER OF ATTEMPTES ALLOWED FOR DISPLAYED TESTS
									ResultSet rsc,rsc2;
									rsc=rsc2=null;

									try
									{

										 rsc = stmt.executeQuery("Select AttemptNo from NewTestStatusDetails where CandidateID="+CandidateID+" and ExamID="+ExamID+"  and SectionID="+SectionID);
									}catch (Exception e)
									{
										out.println("Exception Caught Here");
									}
									while(rsc.next()) attempted = rsc.getInt("AttemptNo");



									try
									{
										 rsc2 = stmt1.executeQuery("Select NoOfAttemptsAllowed from NewExamDetails where ExamID="+ExamID+ "  and SectionID="+SectionID);
									}
									catch (Exception e1)
									{
										out.println("Exception in this");
									}

									while(rsc2.next())
									allowedAttempts = rsc2.getInt("NoOfAttemptsAllowed");

									if(attempted>=allowedAttempts) areTestsOver=true;


//=FINISHING THE CHECK FOR NUMBER OF ATTEMPTS ALLOWED




								if(!areTestsOver)
								{




								for(int j=0;j<n;++j)
								{
									q1="INSERT INTO ExamStatus (CandidateID,ExamID,CodeGroupID,SectionID,SectionStart,TimeLeft,BreaksTaken) VALUES ("+CandidateID+","+ExamID+","+CGID[j]+","+SectionID+",0,"+SectionTime[j]+",0)";
									out.println(q1);

									q2="Select count(*) from ExamStatus where CandidateID="+CandidateID+" and  ExamID="+ExamID+" and CodeGroupID="+CGID[j]+" and SectionID="+SectionID+" and  SectionStart=0 and TimeLeft="+SectionTime[j]+" and BreaksTaken=0";

									try
									{
										if(!T.checkTranscation(q2,con))
										{
											stmt.executeUpdate(q1);
										}
									}
									catch(SQLException se)
									{
										out.println("SQLExcetpion caught for insertion : "+se.getMessage());
									}

								 }


								}// if are tests over

								//out.println("<br>");
								//out.println("<input type=\"image\" src=\"../simages/submit1.gif\" name=\"Image1\" border=0 onMouseOut=\"MM_swapImgRestore()\" onMouseOver = \"MM_swapImage('Image1','','../simages/submit2.gif',1)\">");

						}//end of if
						String URL = "NewTestSelection.jsp?SectionID="+SectionID+"&ExamID="+ExamID+"&rtestname="+CurrentCGID+"&dt=1";
						out.println(URL);
						response.sendRedirect(URL);
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
					  if(con!=null)  pool3.releaseConnection(con);
					  else out.println("Connection not obtained");
					}



%>
	</form>
	</body>
	</html>
