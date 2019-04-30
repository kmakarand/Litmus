
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
<%@ page language="java" import="java.sql.*,java.text.*" session="true"  %>

<jsp:useBean id="pool2" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		
String c1			= (String)session.getValue("username");
if (c1 == null || c1.equals(null) || c1=="") response.sendRedirect("SessionExpiry.jsp");

Integer CID			= (Integer)session.getValue("CandidateID");
Integer SID			= (Integer)session.getValue("SectionID");
Integer EID			= (Integer)session.getValue("ExamID");
String  NS			= (String)session.getValue("NoOfSections");
int NoOfSections	= Integer.parseInt(NS);
--NoOfSections;
String tsec			= ""+NoOfSections;
session.putValue("NoOfSections",tsec);
String stnametemp	= c1+"temp";
session.putValue("SectionStatus","ON");
session.putValue("start","start");

int CandidateID		= CID.intValue();
int SectionID		= SID.intValue();
int ExamID			= EID.intValue();

Integer CodeGID		= (Integer)	session.getValue("CodeGID");
int CodeGroupID		= 0;
CodeGroupID			= CodeGID.intValue();


   String  test			= (String)session.getValue("Exam");
   Integer TQ			= (Integer)session.getValue("TotalQuestions");
   int TotalQuestions	= TQ.intValue();
   //Integer CID			= (Integer)session.getValue("CandidateID");
   //int CandidateID		= CID.intValue();
   //Integer EID			= (Integer)session.getValue("ExamID");
  // int ExamID			= EID.intValue();
   Integer EMode		= (Integer)session.getValue("ExamMode");
   int ExamMode			= EMode.intValue();
   int ShowResults		= 1;
   Integer ShowRes		= (Integer)session.getValue("ShowResults");
   ShowResults			= ShowRes.intValue();
   Float Crt			= (Float)session.getValue("Criteria");
   float Criteria		= Crt.floatValue();
   Float NM				= (Float)session.getValue("NegativeMarks");
   float NegativeMarks  = NM.floatValue();
   String r				= "r"+TotalQuestions;
   String FinalAnswer	= "";
   int FinalAnswerint	= 0;
   int TestAttemptNumber= 0;
   Integer ET			= (Integer)	session.getValue("ExamTime");
   int ExamTime			= 0;
   if(ET!=null)			ExamTime=ET.intValue();
   Integer TestAttemptNo= (Integer) session.getValue("TestAttemptNo");
   //System.out.print("Exam Code :"+CodeGID);
   //System.out.println("r : "+r);
   session.putValue("teststatus","new");
   ServletContext context = getServletContext();
				   pool2  = (com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
   
   if(TestAttemptNo!=null)	 TestAttemptNumber= TestAttemptNo.intValue();
   // String  anstatus = 	(String)session.getValue("AttemptNoStatus");
   //if(anstatus.equals("OFF"))   ++TestAttemptNumber;
		
 //  if(CodeGID!=null)	 CodeGroupID= CodeGID.intValue();
  
   String output,gettimetaken;
	   output=gettimetaken="";
   int wrong,right,result,attempted,cnt,timetaken,total,AnswerStatus;
	wrong=right=result=attempted=cnt=timetaken=total=AnswerStatus=0;
	
	float score,PassingCriteria;
		  score=PassingCriteria=0;	 
   if((request.getParameter(r)!="")&&(request.getParameter(r)!=null))
			{
				//System.out.println("1");
				FinalAnswer =request.getParameter(r);
				FinalAnswerint=Integer.parseInt(FinalAnswer);
			}


Connection con=null;
Statement  stmt,stmt2,stmt3,stmt4;
			   stmt=stmt2=stmt3=stmt4=null;
ResultSet rses;
			  rses=null;	

String action = request.getParameter("action");		
//if (action == "" || action == null )							
	

	pool2=(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");



if(ExamMode==1)
		{
			if((request.getParameter("timetaken")!="")&&(request.getParameter("timetaken")!=null))
			{
				gettimetaken	= request.getParameter("timetaken");
				timetaken		= Integer.parseInt(gettimetaken);
			}
		}
				 
	
	
	 try
	  {
		con = pool2.getConnection();
		
		if(con==null) out.println("Connection not obtained");
		if(ExamMode==0)
			{
				
				if(con!=null)
				    {	
						stmt  = con.createStatement();
						stmt2 = con.createStatement();
						stmt3 = con.createStatement();
						//out.println("Entering loop after Statement created");
		
						//Changed
			
   
						
						//out.print(stnametemp);
						ResultSet rsn = stmt.executeQuery("Select * from "+stnametemp+" WHERE  CodeGroupID="+CodeGroupID);

						if(rsn!=null)
							{
								//out.println("rsn obtained");
								while(rsn.next())
									{
										//out.println("Entering while loop");
										int idi		   = rsn.getInt("QuestionID");
										String a1i	   = rsn.getString("ansg");
										String a2i	   = rsn.getString("correct_ans");
										int BookMark   = rsn.getInt("BookMark");
										int ques_timei = rsn.getInt("timetaken");
										String sCodeID = rsn.getString("CodeID");
										int sequence   = rsn.getInt("SequenceNo");

										if(sequence==TotalQuestions)	a1i=""+FinalAnswerint;
										//out.print("getting questions...");
					
											cnt++;
											//out.println(cnt);
											if(a1i.equals("0"))
												{
													
													AnswerStatus=2;
													
												}else if(a1i.equals(a2i))
															{
																right++;
																AnswerStatus=1;
																
															}
															else
																{
																	wrong++;
																	AnswerStatus=0;
																
																}
										try
											{
											  stmt2.executeQuery(" INSERT INTO NewExamTestingDetails VALUES  ('',"+SectionID+",\'"+sCodeID+"\',"+CodeGroupID+","+ExamID+",CURRENT_DATE(),CURRENT_TIME(),"+CandidateID+","+idi+",'"+a1i+"',"+AnswerStatus+","+ques_timei+","+TestAttemptNumber+","+BookMark+")");						
											}
											catch(Exception e)
												{
													out.println("INSERTION IN NEW EXAM TESTING DETAILS ERROR :  "+e.getMessage());
												}
									}//end of while
							 }//end of if(rs!=null)	
	
			
						attempted = right+wrong;//total wrong and right attempted


						

						//if(ShowResults==1)
							//{
								
								score=right-(wrong*NegativeMarks);
								PassingCriteria = TotalQuestions * Criteria/100;
								if(score>=PassingCriteria)		result=1;
											
							//}
						
						//out.println("testattemtnumber"+TestAttemptNumber);


						try
							{
									

								stmt3.executeUpdate("Delete from ExamStatus where CandidateID="+CandidateID+" AND SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID);
							}
							catch(Exception e)
								{out.println("DELETE FROM EXAM STATUS ERROR	"+e.getMessage());}
			
						try
							{
								//String c=stname+"temp";
								stmt.executeQuery("DELETE FROM "+stnametemp);
							}
							catch(Exception e){out.println("TEMPORARY TABLE NOT EMPTIED "+e.getMessage());}

						
						
						try
							{
								stmt.executeUpdate("INSERT INTO NewPerformanceMaster VALUES  ( '',"+CandidateID+","+SectionID+","+CodeGroupID+","+ExamID+",CURRENT_DATE(),CURRENT_TIME(),"+TotalQuestions+","+wrong+","+right+","+result+","+TestAttemptNumber+")"); 
							 }
							 catch(Exception e)
								{
									out.println("INSERTION INTO NEW PERFORMANCE MASTER ERROR "+e.getMessage());
								}
						try
							{
																
								stmt.executeUpdate("UPDATE NewTestStatusDetails SET Status=1,AttemptNo="+TestAttemptNumber+"  WHERE SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID+" AND ExamID="+ExamID+" AND CandidateID="+CandidateID); 
						    }
							catch(Exception e)
								{
									out.println("TEST STATUS DETAILS UPDATE FAILED "+e.getMessage());
								}	
						 //stmt.close();
						// con.close();
					}//end of if(con!=null)
			 	} else if(ExamMode==1)
					{
					 
							
							int atm=0;cnt=1;
							if(con!=null)
							     {	
									stmt = con.createStatement();
									stmt2=con.createStatement();
									stmt3 = con.createStatement();
									ResultSet rs = stmt.executeQuery("Select * from "+stnametemp+" WHERE  CodeGroupID="+CodeGroupID);


									while(rs.next())
									    {

											int idi			= rs.getInt("QuestionID");
											String a2i	    = rs.getString("correct_ans");
											String sCodeID  = rs.getString("CodeID");
											String ansg		= "r"+cnt; 
											String tempans	= "";
											int a1i			= 0;

											if( request.getParameter(ansg) != null)
													{
														tempans = request.getParameter(ansg);
														a1i=Integer.parseInt(tempans);
													}
													else	a1i=0;


											if(tempans.equals("0"))
													 {
														//wrong++;
														AnswerStatus=2;
											          
										  			 }else if(tempans.equals(a2i))
																 {
																	  AnswerStatus=1;
																	  right++;atm++; 
																	
															     }
																  else
																		{
																			 AnswerStatus=0;
																			 wrong++;atm++; 
																			
																		}

												try
												{
												  stmt2.executeQuery(" INSERT INTO NewExamTestingDetails VALUES  ('',"+SectionID+",\'"+sCodeID+"\',"+CodeGroupID+","+ExamID+",CURRENT_DATE(),CURRENT_TIME(),"+CandidateID+","+idi+",\'"+tempans+"\',"+AnswerStatus+",150,"+TestAttemptNumber+",0)");					
												}catch(Exception e)
													{
														out.println("INSERTION IN NewEXAMTESTING DETAILS ERROR : "+e.getMessage());
													}
											cnt++;
											if(cnt==(TotalQuestions+1)) break;
										}//end of while
			
			
										
										//if(ShowResults==1)
											//{
												out.println(output);
												out.println("<br><br>");
												score=right-(wrong*NegativeMarks);
												PassingCriteria = TotalQuestions * Criteria/100;
												
												if(score>=Criteria)
														{
															result=1;
															
														}
														else
															{
																
																}
										
											//}	
											//out.println("TEST ATTEMPT NUMBER  "+TestAttemptNumber);
									
										try
											{
												stmt3.executeUpdate("DELETE FROM ExamStatus WHERE CandidateID="+CandidateID+" AND CodeGroupID ="+CodeGroupID+" AND SectionID="+SectionID);
										    }
											catch(Exception e){out.println("DELETE FROM EXAM STATUS ERROR"+e.getMessage());}
										try
											{
												//String c=stname+"temp";
												stmt.executeQuery("DELETE FROM "+stnametemp);
											}
											catch(Exception e){out.println("TEMPORARY TABLE NOT EMPTIED "+e.getMessage());}
										
										
										try
											{
												stmt.executeUpdate("INSERT INTO NewPerformanceMaster VALUES  ( '',"+CandidateID+","+SectionID+","+CodeGroupID+","+ExamID+",CURRENT_DATE(),CURRENT_TIME(),"+TotalQuestions+","+wrong+","+right+","+result+","+TestAttemptNumber+")"); 
											  }catch(Exception e)
													{
														out.println("INSERTION INTO NEW PERFORMANCE MASTER ERROR"+e.getMessage());
													}
										 try
											  {
												stmt.executeUpdate("UPDATE NewTestStatusDetails SET Status=1,AttemptNo="+TestAttemptNumber+"  WHERE  SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID+" AND ExamID="+ExamID+" AND CandidateID="+CandidateID); 
											  }catch(Exception e)
													{
														out.println("TEST STATUS DETAILS UPDATE FAILED"+e.getMessage());
													}	
		

								 }//end of if(con!=null)
						 

				   }//end of else if(ExamMode==0)


	
	
						 stmt4  = con.createStatement();
						try
							{
								
								 rses=stmt.executeQuery("Select ExamStatus.CodeGroupID,NewExamDetails.SectionName  from ExamStatus,NewExamDetails WHERE  ExamStatus.ExamID="+ExamID+" AND ExamStatus.CandidateID="+CandidateID+" AND ExamStatus.SectionID=NewExamDetails.SectionID AND ExamStatus.CodeGroupID=NewExamDetails.CodeGroupID AND ExamStatus.ExamID=NewExamDetails.ExamID");
							}catch(SQLException e)
								{
							  		out.println("SQL EXCEPTION CAUGHT 1 :"+e.getMessage());
								}

								
								
								out.println("<H2> WHICH SECTION DO YOU WISH TO GO FOR NEXT ? </H2>");
								
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
								out.println("<input type=\"image\" src=\"../simages/submit1.gif\" name=\"Image1\" border=0 onMouseOut=\"MM_swapImgRestore()\" onMouseOver = \"MM_swapImage('Image1','','../simages/submit2.gif',1)\">");
						//}
					
				}//end of try
			   catch (SQLException sqle)
					 {
					   out.println("SQL EXCEPTION  here"+sqle.getMessage());
					 }
		      catch (Exception e)
					 {
					   out.println("GENERAL EXCEPTION  "+ e.getMessage());
					 }
				 
			 finally
					{
				      //Pool Being Emptied on condition
					  if(con!=null)
							{
							  pool2.releaseConnection(con);
							  //pool2.emptyPool();
							  //out.println("Pool Emptied");
							}
					 }
					
%>
</body>
</html>
