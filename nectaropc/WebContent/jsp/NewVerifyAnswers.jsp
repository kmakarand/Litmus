
<!--
Developer    : Makarand G. Kulkarni
Organisation : Zee Interactive Learning Systems
Project Code : Zed CA Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<head>
<title>Verify  Answers</title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
</head>

<body bgcolor="#fff5e7">

<br>
<%@ page language="java" import="java.util.*,java.sql.*,java.text.*" session="true"  %>

<jsp:useBean id="pool2" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="NMC" scope="application" class="com.ngs.gen.NMCalculate"/>
<jsp:useBean id="T" scope="application" class="com.ngs.gen.InsertUpdateC"/>



<%

String c1			= (String)session.getValue("username");
if (c1 == null || c1.equals(null) || c1=="") response.sendRedirect("../jsp/SessionExpiry.jsp");

Integer CID			= (Integer)session.getValue("CandidateID");
Integer SID			= (Integer)session.getValue("SectionID");
Integer EID			= (Integer)session.getValue("ExamID");
//String tsec			= ""+NoOfSections;

String stnametemp	= "temp_"+c1;
int d1=0;
int CandidateID		= CID.intValue();
int SectionID		= SID.intValue();
int ExamID			= EID.intValue();

Integer CodeGID		= (Integer)	session.getValue("CodeGID");
int CodeGroupID		= 0;
CodeGroupID			= CodeGID.intValue();


   String  test			= (String)session.getValue("Exam");
   Integer TQ			= (Integer)session.getValue("TotalQuestions");
   int TotalQuestions	= TQ.intValue();
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

   ServletContext context = getServletContext();
				   pool2  = (com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");

   if(TestAttemptNo!=null)	 TestAttemptNumber= TestAttemptNo.intValue();

   //String  anstatus = 	(String)session.getValue("AttemptNoStatus");
  // if(anstatus.equals("OFF"))   ++TestAttemptNumber;

 //  if(CodeGID!=null)	 CodeGroupID= CodeGID.intValue();

 session.putValue("AttemptNoStatus","OFF");
 session.putValue("SectionStatus","OFF");
 StringBuffer doc = new StringBuffer("<h2>Dear "+ c1+", your results for the Test are</h2><br>" );

   String output,gettimetaken;
	   output=gettimetaken="";
   int wrong,right,result,attempted,cnt,timetaken,total,AnswerStatus;
	wrong=right=result=attempted=cnt=timetaken=total=AnswerStatus=0;

	int curr_wrong,curr_right,curr_unatt,curr_totalques;
		curr_wrong=curr_right=curr_unatt=curr_totalques=0;



	String rightans		= "Your answer was correct";
	String wrongans		= "Your answer was wrong!!";

	float score,PassingCriteria;
		  score=PassingCriteria=0;

	float curr_score;
			curr_score=0;

	int AllQuestions =0;
/*
   if((request.getParameter(r)!="")&&(request.getParameter(r)!=null))
			{
				System.out.println("1");
				FinalAnswer =request.getParameter(r);
				FinalAnswerint=Integer.parseInt(FinalAnswer);
			}
*/

Connection con=null;
Statement  stmt,stmt2,stmt3,stmt4,stmt5;
			   stmt=stmt2=stmt3=stmt4=stmt5=null;
ResultSet rses,rs1;
			  rses=rs1=null;

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
						stmt5 = con.createStatement();
						//out.println("Entering loop after Statement created");

						//Changed



						//out.print(stnametemp);

						try
						{
							rs1	= stmt5.executeQuery("SELECT ShowResults from ExamMaster where ExamID="+ExamID);
						}
						catch(SQLException e)
						{out.print("Exam Master Exception "+e.getMessage());}

						while(rs1.next())
						{
							ShowResults = rs1.getInt("ShowResults");
						}

%>
		<%@ include file="LastUpdate.jsp" %>


<%

						Statement s11 = con.createStatement();
						ResultSet rs11= null;

						Vector CGALL = new Vector();
						int x=0;
						//int TotalMarks =0;
						try
						{
							rs11 = s11.executeQuery("Select CodeGroupID,NoOfQuestions from NewExamDetails where ExamID="+ExamID+" and SectionID="+SectionID);


						}
						catch(SQLException e)
						{
							out.println("SQL Exception here "+e.getMessage());
						}

						while(rs11.next())
						{
							CGALL.add(x,new Integer(rs11.getInt("CodeGroupID")));
							AllQuestions = AllQuestions + rs11.getInt("NoOfQuestions");
						}

						out.println("checking");
						//System.out.println("NewVerifyAnswers checking");

						Statement stt = con.createStatement();
						ResultSet rstt = null;

						for(int i=0;i<CGALL.size();++i)
						{

							CodeGroupID = ((Integer)CGALL.get(i)).intValue();


							try
							{
								rstt = stt.executeQuery("Select NoOfQuestions from NewExamDetails where ExamID="+ExamID+" and SectionID="+SectionID+" and CodeGroupID="+CodeGroupID);

							}catch(SQLException e)
							{
								out.println("SQL Exception caught :"+e.getMessage());
							}

							while(rstt.next()) TotalQuestions = rstt.getInt("NoOfQuestions");

							ResultSet rsn = stmt.executeQuery("Select * from "+stnametemp+" WHERE  CodeGroupID="+CodeGroupID);

							//+" WHERE  CodeGroupID="+CodeGroupID);


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
										
										//System.out.println("NewVerifyAnswers checking idi ali a1i a2i bookmark qtime scodeid seq"+idi+"-"+a1i+"-"+BookMark+"-"+ques_timei+"-"+sCodeID+"-"+sequence);


										//out.println("ansg"+a1i);
										//out.println("Correct ans"+a2i);

										TotalMarks = TotalMarks + NMC.getMarks(idi,con);

											cnt++;
											//out.println(cnt);
											if(a1i.equals("0"))
												{

													AnswerStatus=2;

												}else if(a1i.equals(a2i))
															{
																score = score + 1;//NMC.getMarks(idi,con);
																AnswerStatus=1;
																right++;
																curr_right++;
																curr_score=curr_score + 1; //NMC.getMarks(idi,con);
																//System.out.println("Right Score"+score);

															}
															else
																{
																	wrong++;
																	score = score -  0;//NMC.getMarksReductionValue(idi,con);
																	AnswerStatus=0;
																	curr_wrong++;
																	curr_score = curr_score -  0;//NMC.getMarksReductionValue(idi,con);	
																	//System.out.println("Wrongscore"+score);

																}
										try
											{
												//System.out.println("INSERT INTO NewExamTestingDetails :");
												int j = stmt2.executeUpdate("INSERT INTO NewExamTestingDetails (SectionID,CodeID,CodeGroupID,ExamID,Date,Time,CandidateID,QuestionID,Answer,AnswerStatus,TimeTaken,AttemptNo,BookMark,SequenceNo) VALUES  ("+SectionID+",\'"+sCodeID+"\',"+CodeGroupID+","+ExamID+",CURRENT_DATE(),CURRENT_TIME(),"+CandidateID+","+idi+",'"+a1i+"',"+AnswerStatus+","+ques_timei+","+TestAttemptNumber+","+BookMark+","+sequence+")");
												//System.out.println("INSERT INTO NewExamTestingDetails j:"+j);												
												//System.out.println("INSERT INTO NewExamTestingDetails : (SectionID,CodeID,CodeGroupID,ExamID,Date,Time,CandidateID,QuestionID,Answer,AnswerStatus,TimeTaken,AttemptNo,BookMark,SequenceNo)"+SectionID+",\'"+sCodeID+"\',"+CodeGroupID+","+ExamID+CandidateID+idi+","+a1i+"',"+AnswerStatus+","+ques_timei+","+TestAttemptNumber+","+BookMark+","+sequence);
											}
											catch(SQLException e)
												{
													out.println("INSERTION IN NEW EXAM TESTING DETAILS ERROR :  "+e.getMessage());
													//System.out.println("INSERTION IN NEW EXAM TESTING DETAILS ERROR :  "+e.getMessage());
												}
									}//end of while
							 }//end of if(rs!=null)



						try
						{
							stmt.executeUpdate("INSERT INTO NewPerformanceMaster (CandidateID,SectionID,CodeGroupID,ExamID,Date,Time,TotalQuestions,NoOfWrong,NoOfCorrect,Result,AttemptNo,Score) VALUES  ("+CandidateID+","+SectionID+","+CodeGroupID+","+ExamID+",CURRENT_DATE(),CURRENT_TIME(),"+TotalQuestions+","+curr_wrong+","+curr_right+","+result+","+TestAttemptNumber+","+curr_score+")");
							//System.out.println("NewPerformanceMaster result:"+result);
							//System.out.println("NewPerformanceMaster score :"+score);
							
						}
						catch(SQLException e)
						{
							out.println("INSERTION INTO NEW PERFORMANCE MASTER ERROR "+e.getMessage());
						}

						try
						{

							stmt.executeUpdate("UPDATE NewTestStatusDetails SET Status=1,AttemptNo="+TestAttemptNumber+"  WHERE SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID+" AND ExamID="+ExamID+" AND CandidateID="+CandidateID);
						}
						catch(SQLException e)
						{
							out.println("TEST STATUS DETAILS UPDATE FAILED "+e.getMessage());
						}

						curr_right=0;
						curr_wrong=0;
						curr_score=0;

					}// end of for cgid

						attempted = right+wrong;//total wrong and right attempted


						//score = (float)Math.ceil(score);



/*						if(ShowResults==1)
							{

								//score=right-(wrong*NegativeMarks);
								score = (right*100)/TotalQuestions;
								PassingCriteria = TotalQuestions * Criteria/100;
								if(score>=PassingCriteria)		result=1;

							}

*/						//out.println("testattemtnumber"+TestAttemptNumber);

					try
					{
						stmt3.executeUpdate("Delete from ExamStatus where CandidateID="+CandidateID);
						//+" AND SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID);
					}
					catch(SQLException e)
					{out.println("DELETE FROM EXAM STATUS ERROR	"+e.getMessage());}


					Statement srem = con.createStatement();
					try
					{
						//String c=stname+"temp";
						srem.executeQuery("DELETE FROM "+stnametemp);
					}
					catch(SQLException e){out.println("TEMPORARY TABLE NOT EMPTIED "+e.getMessage());}

					Statement sdel = con.createStatement();
					try
					{
						String c="temp_"+c1;
						sdel.executeQuery("DROP TABLE "+c);
					}
					catch(SQLException e){out.println("TEMPORARY TABLE DELETION ERROR"+e.getMessage());}

					Statement scmup = con.createStatement();
					try
					{
						scmup.executeUpdate("UPDATE CandidateMaster SET isTableCreated=0,Status=0 WHERE Username=\'"+c1+"\'");
					}
					catch(SQLException e){out.println("IS TABLE CREATED UPDATE FAILED "+e.getMessage());}

					session.putValue("isTableCreated","0");


						 //stmt.close();
					stmt.close();

//Final Score Calculation and evaluation of result.
//*************************************************//
						int unatt =0;
						unatt = AllQuestions - (right+wrong);
						//score=(right-(wrong*NegativeMarks))*2;
						//TotalMarks = TotalQuestions * 2;
						Statement ssc = con.createStatement();
						ResultSet rsc= null;
						try
						{
							rsc= ssc.executeQuery("Select NoOfQuestions,LevelID from NewExamDetails where ExamID="+ExamID+" and SectionID="+SectionID);

						}
						catch(SQLException e)
						{
							out.println("SQL Score Exception :"+e.getMessage());
						}

						TotalMarks=0;
						while (rsc.next())
						{
							TotalMarks = TotalMarks +(rsc.getInt("NoOfQuestions")*rsc.getInt("LevelID"));
						}

						PassingCriteria = TotalMarks * Criteria/100;
						//System.out.println("Total marks"+TotalMarks);
						//System.out.println("Passing Criteria "+PassingCriteria);
						//System.out.println(" Criteria %"+Criteria);
						//System.out.println(" score "+score);





					//	if(score>=PassingCriteria) result=1;

						float scorep = (score*100)/TotalMarks;

						int pco=(right*100/AllQuestions);

                        //System.out.println("Obtained ScorePercent :"+pco);

// DETERMINES THE RESULT BASED ON PERCENTAGE OBTAINED

						if (pco>=50)
						{ 
						result=1;
						//System.out.println("ScorePercent :"+pco);
						}
						else{
						result=0;
					    //System.out.println("ScorePercent :"+pco);
						}
                        //System.out.println("Obtained Result:"+result);						
 

						Statement sup = con.createStatement();

						try
						{
							sup.executeUpdate("Update NewPerformanceMaster set Result="+ result +" where CandidateID="+CandidateID+" and ExamID="+ExamID+" and SectionID="+SectionID+" and  AttemptNo="+TestAttemptNumber);
						}
						catch(SQLException e)
						{
							out.println("SQL Exception caught for sup"+e.getMessage());
						}

//*************************************************//



//Update Slot registeration to record attendance
//*******************************************************************************/////
//*******************************************************************************/////

						Statement s1 = con.createStatement();
						ResultSet rs50= null;
						try
						{
							rs50= s1.executeQuery("Select ScheduleID from SlotRegisteration where CandidateID="+CandidateID);

						}
						catch(SQLException e)
						{
							out.println("SQL Score Exception :"+e.getMessage());
						}

						int ScheduleID = 0;
						while(rs50.next())	ScheduleID = rs50.getInt("ScheduleID");

						Statement s2 = con.createStatement();
						try
						{ s2.executeUpdate("Update SlotRegisteration set Attended=1 where CandidateID="+CandidateID+" and ScheduleID="+ScheduleID);

						}
						catch(SQLException e)
						{
							out.println("SQL Score Exception :"+e.getMessage());
						}

//*******************************************************************************/////
//*******************************************************************************/////
						 String URL="./ScoreChart.jsp?right="+right+"&wrong="+wrong+"&unatt="+unatt+"&NegativeMarks="+NegativeMarks+"&scorep="+scorep+"&d1="+d1+"&AllQuestions="+AllQuestions+"&TotalQuestions="+AllQuestions+"&result="+result+"&PassingCriteria="+PassingCriteria;
						 //System.out.println("Scoreeeee 222:"+score);

						 out.println(URL);
						response.sendRedirect(URL);
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
												}catch(SQLException e)
													{
														out.println("INSERTION IN NewEXAMTESTING DETAILS ERROR : "+e.getMessage());
													}
											cnt++;
											if(cnt==(TotalQuestions+1)) break;
										}//end of while



										if(ShowResults==1)
											{
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

											}
											out.println("TEST ATTEMPT NUMBER  "+TestAttemptNumber);

										try
											{
												stmt3.executeUpdate("DELETE FROM ExamStatus WHERE CandidateID="+CandidateID+" AND CodeGroupID ="+CodeGroupID+" AND SectionID="+SectionID);
										    }
											catch(SQLException e){out.println("DELETE FROM EXAM STATUS ERROR"+e.getMessage());}
										try
											{
												//String c=stname+"temp";
												stmt.executeQuery("DELETE FROM "+stnametemp);
											}
											catch(SQLException e){out.println("TEMPORARY TABLE NOT EMPTIED "+e.getMessage());}

										try
											{
												String c="temp_"+c1;
												stmt.executeQuery("DROP TABLE "+c);
											}
										catch(SQLException e){out.println("TEMPORARY TABLE DELETION ERROR"+e.getMessage());}


										try
											{
												stmt.executeUpdate("UPDATE CandidateMaster SET isTableCreated=0 WHERE Username=\'"+c1+"\'");
											}
											catch(SQLException e){out.println("IS TABLE CREATED UPDATE FAILED "+e.getMessage());}

							session.putValue("isTableCreated","0");



										try
											{
												stmt.executeUpdate("INSERT INTO NewPerformanceMaster VALUES  ( '',"+CandidateID+","+SectionID+","+CodeGroupID+","+ExamID+",CURRENT_DATE(),CURRENT_TIME(),"+TotalQuestions+","+wrong+","+right+","+result+","+TestAttemptNumber+")");
											 }catch(SQLException e)
													{
														out.println("INSERTION INTO NEW PERFORMANCE MASTER ERROR"+e.getMessage());
													}
										 try
											  {
												stmt.executeUpdate("UPDATE NewTestStatusDetails SET Status=1,AttemptNo="+TestAttemptNumber+"  WHERE  SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID+" AND ExamID="+ExamID+" AND CandidateID="+CandidateID);
											  }catch(SQLException e)
													{
														out.println("TEST STATUS DETAILS UPDATE FAILED"+e.getMessage());
													}


								 }//end of if(con!=null)


				   }//end of else if(ExamMode==0)

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







