
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<html>
<head>
<title> Test Instructions </title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT> 
</head>
<body><!-- oncontextmenu="return false">-->
<form name="tselect" action="NewTestMain.jsp" method="GET">
<%@ page language="java" import="java.sql.*" session="true"%>
<jsp:useBean id="pool3" scope="page" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="T" scope="application" class="com.ngs.gen.InsertUpdateC"/>

<%	
	String c1 = (String)session.getValue("username");
	if (c1 == null || c1.equals(null) || c1=="") response.sendRedirect("../jsp/SessionExpiry.jsp");

	String tstatus		=	(String)session.getValue("teststatus");
	//System.out.println("tstatus  :"+tstatus);
	String test,sCodeGroupID,ShowTime;
	test=sCodeGroupID=ShowTime="";
								//String sCode=	"";
	int Prerequisite =0;
	int SectionID=0;
	int SequenceID,TotalQuestions,ExamMode,LevelID,IncludeSubLevels,ExamID,CodeGroupID,Time,ShowResults;
	  SequenceID=TotalQuestions=ExamMode=LevelID=IncludeSubLevels=ExamID=CodeGroupID=Time=ShowResults=0;
	int ExamTime,BreakInterval,Breaks,QResponseTime,TimerType,Hours,Minutes,Seconds,SectionTime;
		ExamTime=BreakInterval=Breaks=QResponseTime=ExamTime=TimerType=Hours=Minutes=Seconds=SectionTime=0;
	float Criteria,NegativeMarks;
		  Criteria=NegativeMarks=0;
	
	Integer CID			= (Integer)session.getValue("CandidateID");
    int CandidateID		= CID.intValue();
	int status			= 1;
	int statusZeroCount,statusOneCount,allowedAttempts,attempted;
	statusZeroCount=statusOneCount=allowedAttempts=attempted=0;
	boolean areTestsOver=false;

		if(tstatus.equals("old"))	
				{ 
					  sCodeGroupID	= request.getParameter("CodeGroupID");
					  CodeGroupID	= Integer.parseInt(sCodeGroupID);
					  ExamID		= Integer.parseInt(request.getParameter("ExamID"));
			    }
				else if(tstatus.equals("new"))	ExamID = Integer.parseInt(request.getParameter("rtest"));
				
				//out.println("NewTestMain.jsp	ExamID:"+ExamID);
	
	Connection con=null;
	Statement  stmt,stmt1,stmt5,stmt2,stmt6;
			   stmt=stmt1=stmt5=stmt2=stmt6=null;

	pool3=(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
	////System.out.println(pool3);
	
	//out.println("dt  :"  +request.getParameter("dt"));
	//out.println("st  :"  +request.getParameter("st"));
		try
			 { 
				 con = pool3.getConnection();
	             if(con==null) out.println("Connection not obtained");
				 //else out.println("Connection obtained");
		     
			

					if(con!=null)
						{
							 //Creating the statement object for executing querry 
					 		 //out.println("Before statement creation");
				  			stmt  = con.createStatement();
		  					stmt1 = con.createStatement();
							stmt2 = con.createStatement();
							stmt5 = con.createStatement();
							stmt6 = con.createStatement();

							if(tstatus.equals("new"))
									{
									  //String dts = request.getParameter("dt");
									  ////System.out.println("Newtestselection dts:"+dts);
									  
									  if(!request.getParameter("dt").equals("1"))
										{
											
											ResultSet rstest=stmt.executeQuery("Select * from ExamMaster WHERE ExamID="+ExamID);
											//System.out.println("Newtestselection 1:");
									  
											  while(rstest.next())
												{
												  //System.out.println("Newtestselection 2:");
												  ExamMode=rstest.getInt("ExamMode");
												  test=rstest.getString("Exam");
												  ShowResults=rstest.getInt("ShowResults");
												}
								
											  ResultSet rstsd=null;
										  
											  try
												{
													 rstsd=stmt1.executeQuery("Select * from NewTestStatusDetails WHERE  CandidateID="+CandidateID+" AND TestMode=0 AND ExamID="+ExamID+" AND Status=0 ORDER BY SequenceID");
												}catch(SQLException e)
												{
													out.println("Test status details error:"+e.getMessage());
												}
								
                                                //System.out.println("Newtestselection 3:");
												ResultSet rsPM				= null;
												ResultSet rForPrerequisite  = null;
												int Result					= 10;
												while(rstsd.next())
													 {
													    //System.out.println("Newtestselection 4:");
									
														statusZeroCount++;
														CodeGroupID = rstsd.getInt("CodeGroupID");
														out.print("Code :"+CodeGroupID);
														rForPrerequisite=stmt2.executeQuery("Select Prerequisite From NewExamDetails WHERE CodeGroupID="+CodeGroupID);

														while(rForPrerequisite.next())
															{
																  Prerequisite = 	rForPrerequisite.getInt("Prerequisite");
															}
			
									
								
														//if(statusZeroCount>0) break;
														if(Prerequisite!=0)
																{	
																	rsPM=stmt2.executeQuery("Select Result from NewPerformanceMaster where CodeGroupID="+Prerequisite);
																	while(rsPM.next())
																			{
																				Result=rsPM.getInt("Result");
																			}
																}//end of if(Prerequisite!="0")
								
														if((Prerequisite==0)||(Result==0)) break;//result==0
													}//end of while(rstsd.next())

													ResultSet rstsd2=null;
													//System.out.println("statusZeroCount :"+statusZeroCount);
													if(statusZeroCount==0)
															{
																try
																	{
																		rstsd2 = stmt.executeQuery("Select * from NewTestStatusDetails WHERE  CandidateID="+CandidateID+" AND TestMode=0 AND ExamID="+ExamID+" AND Status=1 ORDER BY SequenceID");
																	}
																	 catch (SQLException e) 
																			{
																				out.println("Test Status details 2 : "+ e.getMessage());
																			}
			
																stmt5 = con.createStatement();
																ResultSet rsedcheck=null;
																while(rstsd2.next())
																		{
																			statusOneCount++;
																			if(rstsd2.getInt("CodeGroupID")!=0)
																						{
																						CodeGroupID = rstsd2.getInt("CodeGroupID");
																						attempted=rstsd2.getInt("AttemptNo");
																						//System.out.println("Newtestselection check51	attempted:"+attempted);
																						}
																			String query = "Select NoOfAttemptsAllowed from NewExamDetails where CodeGroupID="+CodeGroupID;
																		
																		try
																			{
																				rsedcheck = stmt5.executeQuery(query);
																				while(rsedcheck.next())
																					{
											 											allowedAttempts	= rsedcheck.getInt("NoOfAttemptsAllowed");
											 											//System.out.println("Newtestselection check5	allowedAttempts:"+allowedAttempts);
																					}
										

																			}
																			catch (SQLException e)
																			{
																				out.println("Exam Details checkkkkk "+ e.getMessage());	
																			}
																				if(attempted<allowedAttempts) break;
																		}//end of while(rstsd2.next())
																		//System.out.println("Newtestselection 5:");
																		//System.out.println("Newtestselection 5	attempted:"+attempted);
																		//System.out.println("Newtestselection 5	allowedAttempts:"+allowedAttempts);
																		if(attempted>=allowedAttempts) 
																				{ 
																					//System.out.println("Attempts Over");
																					areTestsOver=true;
																				}

													}//end of if(statusZeroCount==0)
							
									    //System.out.println("Outside first CodeGroupID:"+CodeGroupID+"----areTestsOver:"+areTestsOver);
									 if((CodeGroupID!=0)&&(areTestsOver==false))
									  {
									    //System.out.println("Inside first CodeGroupID:"+CodeGroupID+"----areTestsOver:"+areTestsOver);
										ResultSet rsed=null;
										Integer TestAttemptNo = new Integer(attempted);
										session.putValue("TestAttemptNo",TestAttemptNo);
										try
											{
												rsed = stmt.executeQuery("Select * from NewExamDetails WHERE ExamID="+ExamID+" AND CodeGroupID="+CodeGroupID);
											}catch(SQLException e)
											{out.println("Edetails:"+e.getMessage());}
										rsed.next();
						
										Integer  true_count=new Integer("0");
										Integer  false_count=new Integer("0");
										Integer level=new Integer("0");
										session.putValue("true_count",true_count);
										session.putValue("false_count",false_count);
										session.putValue("level",level);
										
										
										
										String adaptive     = rsed.getString("adaptive");
										session.putValue("adaptive",adaptive);
																				
										String uplimit      = rsed.getString("uplimit");
										session.putValue("uplimit",uplimit);

										String downlimit    = rsed.getString("downlimit");
										session.putValue("downlimit",downlimit);
										
										String NoOfSections	= rsed.getString("NoOfSections");
										session.putValue("NoOfSections",NoOfSections);
										////System.out.println("Ctsec:  NoOfSections : "+NoOfSections);
										
										SectionID	= rsed.getInt("SectionID");
										session.putValue("SectionID",SectionID);
										//System.out.println("Ctsec:  SectionID : "+SectionID);
										
										
										
										String TestName		= rsed.getString("TestName");
										TotalQuestions		= rsed.getInt("NoOfQuestions");
										Integer TQ			= new Integer(TotalQuestions);
										TimerType			= rsed.getInt("TimerType");
										Integer isQT		= new Integer(TimerType);
										QResponseTime		= rsed.getInt("ResponseTime");
										Integer QRT			= new Integer(QResponseTime);
										SectionTime			= rsed.getInt("SectionTime");
										Integer ST			= new Integer(SectionTime);
										Breaks				= rsed.getInt("NoOfBreaksAllowed");
										Integer Brks		= new Integer(Breaks);
										BreakInterval		= rsed.getInt("BreakInterval");
										Integer BrkInterval = new Integer(BreakInterval);
										ExamTime			= rsed.getInt("ExamTime");
										LevelID				= rsed.getInt("LevelID");
										IncludeSubLevels	= rsed.getInt("IncludeSublevels");
										Criteria			= rsed.getFloat("Criteria");
										NegativeMarks		= rsed.getFloat("NegativeMarks");
										Integer ET			= new Integer(ExamTime);
										Float Crt			= new Float(Criteria);
										Float NM			= new Float(NegativeMarks);
										Integer EMode		= new Integer(ExamMode);
										Integer LID			= new Integer(LevelID);
										Integer ISL			= new Integer(IncludeSubLevels);
										Integer EID			= new Integer(ExamID);
										Integer CodeGID		= new Integer(CodeGroupID);
										Integer ShowRes		= new Integer(ShowResults);	
										
										
															
										Time=ExamTime;
										Seconds =(int) Math.floor(Time%60);
										Time = (int)Math.floor(Time/60);
										Minutes =(int)Math.floor(Time%60);
										Time=(int)Math.floor(Time/60);
										Hours=(int)Math.floor(Time%60);

										ShowTime="Hours :"+Hours+"   Minutes :"+Minutes+"Seconds :"+Seconds;
										
										ResultSet rst = null;
										Integer ATS		 =	(Integer)session.getValue("TestAttemptNo");
										String  anstatus = 	(String)session.getValue("AttemptNoStatus");
										int attempts 	 =   ATS.intValue();
										if(anstatus.equals("OFF"))
										{
											try
											{
											
												rst=stmt5.executeQuery("Select MAX(AttemptNo) from NewExamTestingDetails where CandidateID="+CandidateID+" AND ExamID="+ExamID+" AND SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID);
											}catch(SQLException e)
											{
												out.println("MAX Exception caught "+e.getMessage());
											}

											session.putValue("AttemptNoStatus","ON");

											while(rst.next()) { 
												
													attempts = rst.getInt(1);	
											}
											++attempts;
										}
										
										//System.out.println("attempts :"+attempts);
										//System.out.println("ExamID :"+ExamID);
										//System.out.println("SectionID :"+SectionID);
										
										
										stmt6 = con.createStatement();
										ResultSet rs6 =null;

										try
										{
											rs6 = stmt6.executeQuery("Select sum(NoOfQuestions) SUMQ from NewExamDetails where ExamID="+ExamID+" and SectionID="+SectionID);
										}
										catch (SQLException e)
										{
											out.println("Exception caught in here");
										}

										while(rs6.next())
										{
											session.putValue("AllQuestions",new Integer(rs6.getInt("SUMQ")));
											//System.out.println("AllQuestions	rs6.getInt(1):"+rs6.getInt("SUMQ"));
											
										}
										
										
										Integer AttemptNos = new Integer(attempts);
										session.putValue("TestAttemptNo",AttemptNos);
										
										session.putValue("TotalQuestions",TQ);
										session.putValue("TimerType",isQT);
										session.putValue("QResponseTime",QRT);
										session.putValue("Breaks",Brks);
										session.putValue("BreakInterval",BrkInterval);
										session.putValue("ExamTime",ET);
										session.putValue("SectionTime",ST);
										session.putValue("Criteria",Crt);
										session.putValue("NegativeMarks",NM);
										session.putValue("ExamMode",EMode);
										session.putValue("Exam",test);//test is string object
										session.putValue("CodeGID",CodeGID);
										session.putValue("ExamID",EID);
										session.putValue("LevelID",LID);
										session.putValue("IncludeSubLevels",ISL);
										session.putValue("ShowResults",ShowRes);


										String INS_EXAM_STATUS="INSERT INTO ExamStatus(CandidateID,ExamID ,CodeGroupID,TimeLeft) VALUES ("+CandidateID+","+ExamID+",\'"+CodeGroupID+"\',"+ExamTime+")";
										
										String q2 = "Select count(*) from ExamStatus where CandidateID="+CandidateID+" and  ExamID="+ExamID+" and CodeGroupID="+CodeGroupID+" and TimeLeft="+ExamTime;

										try
										  {
											if(!T.checkTranscation(q2,con))
											{
												stmt.executeUpdate(INS_EXAM_STATUS);
											}
										  }
										  catch (SQLException e)
												{
													out.println(INS_EXAM_STATUS+ " : " + e.getMessage());
												}
										
										String AboutBreaks="";
										if(Breaks>1) AboutBreaks=AboutBreaks + "with "+Breaks+" breaks each of interval "+BreakInterval+" seconds.";
										else if(Breaks==1) AboutBreaks=AboutBreaks + "with "+Breaks+" break of interval "+BreakInterval+" seconds.";
										else AboutBreaks=AboutBreaks+"without a	break.";


										StringBuffer rules =new StringBuffer("<BR><B><font color='#0000FF'>Valuation :</font></B><BR>Each question has a set of answer choices. Select the best answer	by clicking against it.One mark will be provided for each correct answer.<BR><BR>1. The objective of this test is to assess your performance.<BR><BR>2. This test is meant to be taken in one sitting "+AboutBreaks+"<BR><BR>");
										rules.append("3. Time will be displayed at the foot of your browser<br><BR>");
										
										rules.append("4. Test Name           : <b><font color='#FF0000'>"+TestName+"</font></b><br><BR>");
										rules.append("5. Time allocated : <b><font color='#FF0000'>&nbsp;&nbsp;"+ShowTime+"</font></b><BR><BR>");
										rules.append("6. Candidates are not allowed to keep any reference books,notes,cell-phones or pagers etc at the time of taking the test.<BR>&nbsp;&nbsp;&nbsp;&nbsp;However, candidates are allowed to bring manual calculators. Loose sheets of paper for any rough work will be provided to the &nbsp;&nbsp;&nbsp;&nbsp;candidiate.These sheets will be collected at the end of the test.<BR><BR>7. Candidates will not be allowed to take a break while the test is going on.It will not be possible for the candidate to pause the <br>&nbsp;&nbsp;&nbsp;&nbsp;test so that it can be continued later.<BR><BR>");
										String rule = rules.toString();
										out.print(rule);
									}//if(Code!=0)
									if(CodeGroupID==0)	;	//out.println("TESTS OVER");
							}//end of if(!request.getParameter("dt")				
							else 
								{
									
									 //System.out.println("111");
									 //System.out.println("CID : "+CodeGroupID);
									 //System.out.println("ExamID :"+ExamID);
									 //System.out.println(request.getParameter("rtestname"));
									 //System.out.println(request.getParameter("ExamID"));
									String tsections		= (String) session.getValue("NoOfSections");
									String SectionStatus	= (String) session.getValue("SectionStatus");
									String LastSection		= "";
									if(request.getParameter("lastsection")!=null)		LastSection=request.getParameter("lastsection");
									//System.out.println("lastsection : "+request.getParameter("lastsection"));
									////System.out.println("Ctsec:  SectionStatus : "+SectionStatus);
									int tsec				=  Integer.parseInt(tsections);
									String query			=  "";
									String INS_EXAM_STATUS	=	"";
									////System.out.println("1tsec: "+tsec+" SectionStatus : "+SectionStatus);
									ExamID	 = Integer.parseInt(request.getParameter("ExamID"));
									SectionID=Integer.parseInt(request.getParameter("SectionID"));
									//System.out.println("SectionID : "+SectionID);
									//System.out.println("tsec: "+tsec+" SectionStatus : "+SectionStatus);
									CodeGroupID = Integer.parseInt(request.getParameter("rtestname"));
									//System.out.println("CodeGroupID: "+CodeGroupID);
								
									
//***************************************************************************

					



// INTRODUCING CHECK FOR NUMBER OF ATTEMPTES ALLOWED FOR DISPLAYED TESTS
									ResultSet rsc,rsc2;
									rsc=rsc2=null;

									try
									{

										 rsc = stmt.executeQuery("Select AttemptNo from NewTestStatusDetails where CandidateID="+CandidateID+" and ExamID="+ExamID+" and CodeGroupID="+CodeGroupID+" and SectionID="+SectionID); 
									}catch (Exception e)
									{
										out.println("Exception Caught Here");
									}
									while(rsc.next()) attempted = rsc.getInt("AttemptNo");

									//System.out.println("attempted: "+attempted);
									
									try
									{
										 rsc2 = stmt1.executeQuery("Select NoOfAttemptsAllowed from NewExamDetails where ExamID="+ExamID+ " and CodeGroupID="+CodeGroupID+" and SectionID="+SectionID);
									}
									catch (Exception e1)
									{
										out.println("Exception in this");
									}
									
									while(rsc2.next()) 
									allowedAttempts = rsc2.getInt("NoOfAttemptsAllowed");
									
									//System.out.println("allowedAttempts: "+allowedAttempts);
						
									if(attempted>=allowedAttempts) areTestsOver=true;


//=FINISHING THE CHECK FOR NUMBER OF ATTEMPTS ALLOWED


								    //System.out.println("Attempted :"+attempted+" ALLowed attempts :"+allowedAttempts);





								if(!areTestsOver)
								{


//***************************************************************************
									
									
									
									if((tsec>1)||(SectionStatus.equals("ON"))||(LastSection.equals("1")))
									{
										CodeGroupID = Integer.parseInt(request.getParameter("rtestname"));
										//System.out.println("CodeGroupID :"+CodeGroupID);

										query = "Select * from NewExamDetails where CodeGroupID="+CodeGroupID+" AND ExamID="+ExamID+" AND SectionID="+SectionID;
										INS_EXAM_STATUS="Update ExamStatus set SectionStart=1 where SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID;
										//System.out.println(INS_EXAM_STATUS);
										//out.println("CodeGroupID :"+CodeGroupID);

									}
									else
									{
										query = "Select * from NewExamDetails where ExamID="+ExamID+" AND SectionID="+SectionID;
									}
									

									 ResultSet redt= null;
									 
							 
									 try
										{
										   redt = stmt.executeQuery(query);
										}
										catch (SQLException e)
										{out.println("SQL EXCEPTION CAUGHT 10 "+e.getMessage());
										}

										redt.next();

										//System.out.println("redt.next");
										
										Integer  true_count=new Integer("0");
										Integer  false_count=new Integer("0");
										Integer level=new Integer("0");
										session.putValue("true_count",true_count);
										session.putValue("false_count",false_count);
										session.putValue("level",level);
										
										
										
										String adaptive     = redt.getString("adaptive");
										session.putValue("adaptive",adaptive);
																				
										String uplimit      = redt.getString("uplimit");
										session.putValue("uplimit",uplimit);

										String downlimit    = redt.getString("downlimit");
										session.putValue("downlimit",downlimit);
						
										CodeGroupID			= redt.getInt("CodeGroupID");
										String TestName		= redt.getString("TestName");
										TotalQuestions		= redt.getInt("NoOfQuestions");
										Integer TQ			= new Integer(TotalQuestions);
										TimerType			= redt.getInt("TimerType");
										Integer isQT		= new Integer(TimerType);
										QResponseTime		= redt.getInt("ResponseTime");
										Integer QRT			= new Integer(QResponseTime);
										SectionTime			= redt.getInt("SectionTime");
										Integer ST			= new Integer(SectionTime);
										Breaks				= redt.getInt("NoOfBreaksAllowed");
										Integer Brks		= new Integer(Breaks);
										BreakInterval		= redt.getInt("BreakInterval");
										Integer BrkInterval = new Integer(BreakInterval);
										ExamTime			= redt.getInt("ExamTime");
										LevelID				= redt.getInt("LevelID");
										IncludeSubLevels	= redt.getInt("IncludeSublevels");
										Criteria			= redt.getFloat("Criteria");
										NegativeMarks		= redt.getFloat("NegativeMarks");
										Integer ET			= new Integer(ExamTime);
										Float Crt			= new Float(Criteria);
										Float NM			= new Float(NegativeMarks);
										Integer EMode		= new Integer(ExamMode);
										Integer LID			= new Integer(LevelID);
										Integer ISL			= new Integer(IncludeSubLevels);
										Integer EID			= new Integer(ExamID);
										Integer CodeGID		= new Integer(CodeGroupID);
										Integer ShowRes		= new Integer(ShowResults);					
										Integer SID			= new Integer(SectionID);

										Time=ExamTime;
										Seconds =(int) Math.floor(Time%60);
										Time = (int)Math.floor(Time/60);
										Minutes =(int)Math.floor(Time%60);
										Time=(int)Math.floor(Time/60);
										Hours=(int)Math.floor(Time%60);

										ShowTime=""+ "Hours :" +Hours+"  Minutes :"+Minutes+"  Seconds :"+Seconds;
										
										//System.out.println("ShowTime  "+ShowTime);

										ResultSet rst = null;
										Integer ATS		 =	(Integer)session.getValue("TestAttemptNo");
										String  anstatus = 	(String)session.getValue("AttemptNoStatus");
										int attempts 	 =   ATS.intValue();
										if(anstatus.equals("OFF"))
										{
											try
											{
											
											rst=stmt5.executeQuery("Select MAX(AttemptNo) from NewExamTestingDetails where CandidateID="+CandidateID+" AND ExamID="+ExamID+" AND SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID);
											}catch(SQLException e)
											{
												out.println("MAX Exception caught "+e.getMessage());
											}

											session.putValue("AttemptNoStatus","ON");
										

											while(rst.next()) 
												{
													attempts = rst.getInt(1);	
												}
												++attempts;
										}
										
										//System.out.println("attempts :"+attempts);
										
										Integer AttemptNos = new Integer(attempts);
										session.putValue("TestAttemptNo",AttemptNos);
										session.putValue("TotalQuestions",TQ);
										session.putValue("TimerType",isQT);
										session.putValue("QResponseTime",QRT);
										session.putValue("Breaks",Brks);
										session.putValue("BreakInterval",BrkInterval);
										session.putValue("ExamTime",ET);
										session.putValue("SectionTime",ST);
										session.putValue("Criteria",Crt);
										session.putValue("NegativeMarks",NM);
										session.putValue("ExamMode",EMode);
										session.putValue("Exam",test);//test is string object
										session.putValue("CodeGID",CodeGID);
										session.putValue("ExamID",EID);
										session.putValue("LevelID",LID);
										session.putValue("IncludeSubLevels",ISL);
										session.putValue("ShowResults",ShowRes);
										session.putValue("SectionID",SID);


										
										stmt6 = con.createStatement();
										ResultSet rs6 =null;

										try
										{
											rs6 = stmt6.executeQuery("Select sum(NoOfQuestions) from NewExamDetails where ExamID="+ExamID+" and SectionID="+SectionID);
										}
										catch (SQLException e)
										{
											out.println("Exception caught in here");
										}

										while(rs6.next())
										{
											session.putValue("AllQuestions",new Integer(rs6.getInt(1)));
											//System.out.println("AllQuestions	rs6.getInt(1):"+rs6.getInt(1));
											
										}


										if((tsec==1)&&(!LastSection.equals("1"))) INS_EXAM_STATUS="INSERT INTO ExamStatus (CandidateID,ExamID,CodeGroupID,SectionID,SectionStart,TimeLeft,BreaksTaken) VALUES ("+CandidateID+","+ExamID+","+CodeGroupID+","+SectionID+",1,"+ExamTime+",0)";
										
										String q2 = "Select count(*) from ExamStatus where CandidateID="+CandidateID+" and  ExamID="+ExamID+" and CodeGroupID="+CodeGroupID+" and TimeLeft="+ExamTime+" and SectionID="+SectionID+" and SectionStart=1 and BreaksTaken=0";

										if(SectionStatus.equals("OFF"))
										{

											try
											{
												if(!T.checkTranscation(q2,con))
												{

													stmt.executeUpdate(INS_EXAM_STATUS);
												}
											}
											  catch (SQLException e)
												{
													out.println(INS_EXAM_STATUS+ " : " + e.getMessage());
												}
										}
										
										//System.out.println("AboutBreaks");
										
										String AboutBreaks="";
										if(Breaks>1) AboutBreaks=AboutBreaks + "with "+Breaks+" breaks each of interval "+BreakInterval+" seconds.";
										else if(Breaks==1) AboutBreaks=AboutBreaks + "with "+Breaks+" break of interval "+BreakInterval+" seconds.";
										else AboutBreaks=AboutBreaks+"without a	break.";


										StringBuffer rules =new StringBuffer("<BR><B><font color='#0000FF'>Valuation :</font></B><BR>Each question has a set of answer choices. Select the best answer	by clicking against it.One mark will be provided for each correct answer.<BR><BR>1. The objective of this test is to assess your performance.<BR><BR>2. This test is meant to be taken in one sitting "+AboutBreaks+"<BR><BR>");
										rules.append("3. Time will be displayed at the foot of your browser<br><BR>");
										
										rules.append("4. Test Name           : <b><font color='#FF0000'>"+TestName+"</font></b><br><BR>");
										rules.append("5. Time allocated : <b><font color='#FF0000'>&nbsp;&nbsp;"+ShowTime+"</font></b><BR><BR>");
										rules.append("6. Candidates are not allowed to keep any reference books,notes,cell-phones or pagers etc at the time of taking the test.<BR>&nbsp;&nbsp;&nbsp;&nbsp;However, candidates are allowed to bring manual calculators. Loose sheets of paper for any rough work will be provided to the &nbsp;&nbsp;&nbsp;&nbsp;candidiate.These sheets will be collected at the end of the test.<BR><BR>7. Candidates will not be allowed to take a break while the test is going on.It will not be possible for the candidate to pause the <br>&nbsp;&nbsp;&nbsp;&nbsp;test so that it can be continued later.<BR><BR>");
										String rule = rules.toString();

							out.println("<P>&nbsp;</P>");
							out.println("<TABLE BORDER='0' CELLSPACING='1' CELLPADDING='1' ALIGN='CENTER'>");
							out.println("<TR><TH>Instructions for the Nectar Examination</TH></TR>");

							out.println("<TR><TD><BR>"+rule+"<BR><BR></TD></TR>");

									
								}//if !aretests over					
										//out.println("COMING IN");

								}
				}//end of if(tsatus.equals("new");
				else if(tstatus.equals("old"))
				{
					//out.print("entering old");


					ResultSet rsed2=null;
					ResultSet rstest=stmt.executeQuery("Select * from ExamMaster WHERE ExamID="+ExamID);
					while(rstest.next())
					{
						ExamMode=rstest.getInt("ExamMode");
						test=rstest.getString("Exam");
						ShowResults=rstest.getInt("ShowResults");	
					}

						
						Integer SID = (Integer) session.getValue("SectionID");
						SectionID = SID.intValue();
						
						try
						{
							rsed2 = stmt.executeQuery("Select * from NewExamDetails WHERE	ExamID="+ExamID+" AND CodeGroupID="+CodeGroupID+" AND SectionID="+SectionID);
						}catch(SQLException e)
						{out.println("Edetails:"+e.getMessage());}
						rsed2.next();
						
						
						Integer  true_count=new Integer("0");
						Integer  false_count=new Integer("0");
						Integer level=new Integer("0");
						session.putValue("true_count",true_count);
						session.putValue("false_count",false_count);
						session.putValue("level",level);
										
										
										
						String adaptive     = rsed2.getString("adaptive");
						session.putValue("adaptive",adaptive);
						
						String uplimit      = rsed2.getString("uplimit");
						session.putValue("uplimit",uplimit);

						String downlimit    = rsed2.getString("downlimit");
						session.putValue("downlimit",downlimit);
						
						
						
						ExamID				= rsed2.getInt("ExamID");
						TotalQuestions		= rsed2.getInt("NoOfQuestions");
						Integer TQ			= new Integer(TotalQuestions);
						QResponseTime		= rsed2.getInt("ResponseTime");
						String TestName		= rsed2.getString("TestName");
						TimerType			= rsed2.getInt("TimerType");
						Integer isQT		= new Integer(TimerType);
						Integer QRT			= new Integer(QResponseTime);
						Breaks				= rsed2.getInt("NoOfBreaksAllowed");
						Integer Brks		= new Integer(Breaks);
						BreakInterval		= rsed2.getInt("BreakInterval");
						Integer BrkInterval = new Integer(BreakInterval);
						String extime		= (String)session.getValue("TimeLeft");
						ExamTime			= Integer.parseInt(extime);
						Integer ET			= new Integer(ExamTime);
						Criteria			= rsed2.getFloat("Criteria");
						NegativeMarks		= rsed2.getFloat("NegativeMarks");
						Float Crt			= new Float(Criteria);
						Float NM			= new Float(NegativeMarks);
						LevelID				= rsed2.getInt("LevelID");
						IncludeSubLevels	= rsed2.getInt("IncludeSublevels");
						SectionTime			= rsed2.getInt("SectionTime");
						Integer ST			= new Integer(SectionTime);
						Integer EMode		= new Integer(ExamMode);
						Integer LID			= new Integer(LevelID);
						Integer ISL			= new Integer(IncludeSubLevels);
						Integer EID			= new Integer(ExamID);
						Integer CodeGID		= new Integer(CodeGroupID);
						Integer ShowRes		= new Integer(ShowResults);

						
						ResultSet rst = null;
						Integer ATS		 =	(Integer)session.getValue("TestAttemptNo");
						String  anstatus = 	(String)session.getValue("AttemptNoStatus");
						int attempts 	 =   ATS.intValue();

						if(anstatus.equals("OFF"))
						{
							try
							{
							
								rst=stmt5.executeQuery("Select MAX(AttemptNo) from NewExamTestingDetails where CandidateID="+CandidateID+" AND ExamID="+ExamID+" AND SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID);
							}catch(SQLException e)
								{
									out.println("MAX Exception caught "+e.getMessage());
								}

								session.putValue("AttemptNoStatus","ON");

							while(rst.next()) { 
									
									attempts = rst.getInt(1);	
								}
								++attempts;
						}
						
						//System.out.println("attempts :"+attempts);

						Integer AttemptNos = new Integer(attempts);
						session.putValue("TestAttemptNo",AttemptNos);
						session.putValue("TotalQuestions",TQ);
						session.putValue("TimerType",isQT);
						session.putValue("QResponseTime",QRT);
						session.putValue("Breaks",Brks);
						session.putValue("BreakInterval",BrkInterval);
						session.putValue("ExamTime",ET);
						session.putValue("Criteria",Crt);
						session.putValue("NegativeMarks",NM);
						session.putValue("ExamMode",EMode);
						session.putValue("Exam",test);//test is string object
						session.putValue("CodeGID",CodeGID);
						session.putValue("ExamID",EID);
						session.putValue("LevelID",LID);
						session.putValue("IncludeSubLevels",ISL);
						session.putValue("ShowResults",ShowRes);
						session.putValue("SectionTime",ST);

						
						
						
						stmt6 = con.createStatement();
						ResultSet rs6 = null;
						

						
						try
						{
							rs6 = stmt6.executeQuery("Select sum(NoOfQuestions) from NewExamDetails where ExamID="+ExamID+" and SectionID="+SectionID);
						}
						catch (SQLException e)
						{
							out.println("Exception caught in here");
						}

						while(rs6.next())
						{
							
							session.setAttribute("AllQuestions",new Integer(rs6.getInt(1)));
							//System.out.println("AllQuestions	rs6.getInt(1):"+rs6.getInt(1));
						}

						
						String AboutBreaks="";
						
						if(Breaks>1) AboutBreaks=AboutBreaks + "with "+Breaks+" breaks each of interval "+BreakInterval+" seconds.";
						else if(Breaks==1) AboutBreaks=AboutBreaks + "with "+Breaks+" break of interval "+BreakInterval+" seconds.";
						else AboutBreaks=AboutBreaks+"without a	break.";

						//System.out.println("AboutBreaks:"+AboutBreaks);
						
						Time=ExamTime;
						Seconds = (int) Math.floor(Time%60);
						Time	= (int) Math.floor(Time/60);
						Minutes = (int) Math.floor(Time%60);
						Time	= (int) Math.floor(Time/60);
						Hours	= (int) Math.floor(Time%60);
						ShowTime= ""+ "Hours :" +Hours+"&nbsp;&nbsp;&nbsp;&nbsp;Minutes :"+Minutes+"&nbsp;&nbsp;&nbsp;&nbsp;Seconds :"+Seconds;

						StringBuffer rules =new StringBuffer("<BR><B><font color='#0000FF'>Valuation :</font></B><BR>Each question has a set of answer choices. Select the best answer	by clicking against it.One mark will be provided for each correct answer.<BR><BR>1. The objective of this test is to assess your performance.<BR><BR>2. This test is meant to be taken in one sitting "+AboutBreaks+"<BR><BR>");
						rules.append("3. Time will be displayed at the foot of your browser<br><BR>");
						
						rules.append("4. Test Name           : <b><font color='#FF0000'>"+TestName+"</font></b><br><BR>");
						rules.append("5. Time allocated : <b><font color='#FF0000'>&nbsp;&nbsp;"+ShowTime+"</font></b><BR><BR>");
						rules.append("6. Candidates are not allowed to keep any reference books,notes,cell-phones or pagers etc at the time of taking the test.<BR>&nbsp;&nbsp;&nbsp;&nbsp;However, candidates are allowed to bring manual calculators. Loose sheets of paper for any rough work will be provided to the &nbsp;&nbsp;&nbsp;&nbsp;candidiate.These sheets will be collected at the end of the test.<BR><BR>7. Candidates will not be allowed to take a break while the test is going on.It will not be possible for the candidate to pause the <br>&nbsp;&nbsp;&nbsp;&nbsp;test so that it can be continued later.<BR><BR>");
						String rule = rules.toString();

						out.println("<P>&nbsp;</P>");
						out.println("<TABLE BORDER='0' CELLSPACING='1' CELLPADDING='1' ALIGN='CENTER'>");
						out.println("<TR><TH>Instructions for the Nectar Examination</TH></TR>");

						out.println("<TR><TD><BR>"+rule+"<BR><BR></TD></TR>");

/*
						ResultSet rsexam	= stmt.executeQuery("Select * from ExamMaster WHERE ExamID="+ExamID);
						rsexam.next();
						ExamMode			= rsexam.getInt("ExamMode");
						test				= rsexam.getString("Exam");
*/
				}//end of else if(tstatus.equals("old")
				else
				{
					if(areTestsOver) out.println("ALL TESTS COMPLETED");
				}

	 		}//if(con!=null)	
	 }//end of try
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
    
    /*out.println("CodeGroupID	:"+CodeGroupID);
    out.println("areTestsOver	:"+areTestsOver);
    out.println("tstatus		:"+tstatus);*/
    
    if(((CodeGroupID!=0)&&(areTestsOver==false))||(tstatus.equals("old")))
	{
		//out.print("CODE"+CodeGroupID);
//		out.println("<input type=\"image\" src=\"../simages/begintest1.gif\" name=\"Image1\" border=0  onMouseOut=\"MM_swapImgRestore()\" onMouseOver = \"MM_swapImage('Image1','','../simages/begintest2.gif',1)\">");
		out.println("<TR><TH><input type='submit' value='Begin Test'></TH></TR>");
		out.println("</TABLE>");
	}
	else
	{
		out.println("<TABLE BORDER='0' CELLSPACING='1' CELLPADDING='1'>");
		out.println("<TR><TH>Exam Status</TH></TR>");
		out.println("<TR><TD><P>All attempts are complete.</P>Please, contact your examiner for more details.<BR><BR></TD></TR>");
		out.println("</TABLE>");
	}

	%>
<!--<a href="main2.jsp"> Begin Test</a>-->

</form>
</body>
</html>
