<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="ChartDirector.*" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		String sql="";Query query=null;
		Integer CandidateID = (Integer) session.getAttribute("CandidateID");
		int cid = 0,lid=0,examid=0;
		cid = CandidateID.intValue();
		EntityManager em = EntityManagerHelper.getEntityManager();
		Logger log = Logger.getLogger("analysis.jsp");
		CandidatemasterDAO cmDAO = new CandidatemasterDAO();
		ClientmasterDAO clmDAO = new ClientmasterDAO();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Connection con = pool.getConnection();
		
		response.setContentType("text/html");
		out.println("<HTML><HEAD><TITLE>Analysis</TITLE></HEAD>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		
		if (action == null || action == "")
			{
				try
				{
						log.info("Analysis:doGet action is null:");
						log.info("Analysis:doGet action is null:");
						String ques="",quesc="";
						int cdgroupid=0;
						int status=0;
						int candid=0,sectionid=0;
						String fname="",lname="";Candidatemaster cm=null;
	
						//query = em.createNamedQuery("Analysis-Candidatemaster.sql1");
						//query = em.createQuery("SELECT cm.firstName,cm.lastName,cm.candidateId from Candidatemaster cm where cm.candidateId =?1");
						cm = cmDAO.findById(cid);
						fname = cm.getFirstName();
						lname = cm.getLastName();
						log.info("fname: " + fname);
						log.info("lname: " + lname);
						query = em.createQuery("SELECT npm.candidateId from Newperformancemaster npm where npm.candidateId=?1");
						query.setParameter(1,cid);Number resultStatus =null;
						if(EntityManagerHelper.getSingleResult(query)!=null)
						{resultStatus = (Number) query.getSingleResult();status=resultStatus.intValue();}
						else
						status=0;
						log.info("status :"+status);
								
							if (status >=1)
							{
								query = em.createNamedQuery("Analysis-Candidatedetails.sql3");
								query.setParameter(1, cid);
								examid = (Integer) query.getSingleResult();
								String remark="",examname="";;
								int attemptno=0,ecode=0;
								out.println("<H3><font color=#996633>Analysis of Exams Appeared</font></H3>");
								out.println("Candidate Name : <b>"+fname+" "+lname+"</b><br> ");
								
								log.info("Candidate Name : <b>"+fname+" "+lname);
								out.println("<center><TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1 ><TR><TH>Sr.No</TH><TH>Test Name</TH><TH>Result</TH><TH>Attempt No.</TH><TH WIDTH='70'>Exam Date<TH>Question Type</TH><TH>Action</TH><TH>Graphical View</TH></TR>");
	
								int exid=0,counter=1;
								
								query = em.createNamedQuery("Analysis-NewExamDetails.sql4");
								query.setParameter(1, examid);
								List<Object[]> nxidList = query.getResultList();
								log.info("psn.next()");
								String subname="",rest="";
								java.util.Date dat=null;
								Time time=null;
								for(Object[] objList:nxidList)
								{
									sectionid = (Integer)objList[0];
									subname = (String)objList[1];
									log.info("sectionid :"+sectionid+"subname:"+subname);
								}
								query = em.createNamedQuery("Analysis-Newperformancemaster.sql5");
								query.setParameter(1, cid);
								query.setParameter(2, examid);
								query.setParameter(3, sectionid);
								attemptno = (Integer) query.getSingleResult();
								int count=0;
								int totquest=0,nowrong=0,nocorrect=0,result=0,formno=1,incorrect=0,unattempted=0,noattempted=0,anal=1;
								int cgid=0;

								query = em.createNamedQuery("Analysis-Newperformancemaster.sql6");
								query.setParameter(1, cid);
								query.setParameter(2, sectionid);
								query.setParameter(3, examid);
								Newperformancemaster npm = (Newperformancemaster) query.getSingleResult();
								out.println("<form name=form"+ formno+" method=post>");

								result = npm.getResult();
								dat= npm.getDate();
								time = npm.getTime();
								attemptno= npm.getAttemptNo();

								int currentqid=0;
								int Qnumber=0;

								if (result<=0)
									rest="FAIL";
								else
									rest="PASS";

								String passcolor="";
								if (rest.equals("FAIL"))
									passcolor="red";
								else
								{
									passcolor="green";
									rest="PASS";
								}

//										int statcorrect=0,statwrong=0;

								out.println("<INPUT TYPE=HIDDEN NAME='action' VALUE='doDetails'>");
								Utils myUtil = new Utils();
								//SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
								//ScheduleDate = sdfDest.format(fdate);
								//SimpleDateFormat sdfSource =new SimpleDateFormat("yyyy-MMM-dd");
								//newDate = (Date)sdfSource.parse(ScheduleDate);
								//dat = myUtil.getDate(dat);

								out.println("<INPUT TYPE=HIDDEN NAME=dat VALUE=" + dat + ">");
								out.println("<INPUT TYPE=HIDDEN NAME=rest VALUE="+ rest+ ">");
								out.println("<INPUT TYPE=HIDDEN NAME=cid VALUE="+ cid+ ">");
								out.println("<INPUT TYPE=HIDDEN NAME=sectionid VALUE="+ sectionid+ ">");
								out.println("<INPUT TYPE=HIDDEN NAME=examcode VALUE="+ cgid+ ">");
								out.println("<INPUT TYPE=HIDDEN NAME=examid VALUE="+ examid+ ">");
								out.println("<INPUT TYPE=HIDDEN NAME=fname VALUE="+ fname+ ">");
								out.println("<INPUT TYPE=HIDDEN NAME=lname VALUE="+ lname+ ">");
						//		out.println("<INPUT TYPE=HIDDEN NAME=subname VALUE=\""+ subname+ "\">");

								out.println("<INPUT TYPE=HIDDEN NAME='Qnumber' VALUE='"+ Qnumber+ "'>");
								out.println("<INPUT TYPE=HIDDEN NAME=exid VALUE='"+ exid+ "'>");
								out.println("<INPUT TYPE=HIDDEN NAME=currentqid VALUE="+ currentqid+ ">");
								out.println("<INPUT TYPE=HIDDEN NAME=time VALUE="+ time+ ">");
								out.println("<INPUT TYPE=HIDDEN NAME=passcolor VALUE="+ passcolor+ ">");

								out.println("<TR><TD ALIGN=RIGHT VALIGN='TOP'>"+counter+"</TD><TD>"+subname+"</TD><TD ALIGN='CENTER' VALIGN='CENTER'><font color='"+passcolor+"'>"+rest+"</font></TD><TD ALIGN=CENTER VALIGN='CENTER'>"+attemptno+"</TD><TD ALIGN='CENTER' VALIGN='CENTER'>"+dat+"</TD><TD VALIGN='CENTER'><select name=questtype><option value=1>All Answers</option><option value=2>Correct Answers</option><option value=3>Unattempted Answers</option><option value=4>Wrong Answers</option><option value=5>Bookmark</option></select></TD><TD VALIGN='CENTER'><INPUT TYPE = SUBMIT VALUE=Analyse></TD></FORM>");
								out.println("<form name=formGraph method=post action="+request.getRequestURI()+"><TD VALIGN='CENTER'><center><INPUT TYPE=SUBMIT VALUE='Graphical View'></center><INPUT TYPE=HIDDEN NAME=examcode VALUE="+ cgid+ "><INPUT TYPE=HIDDEN NAME=time VALUE='"+ time+"'><INPUT TYPE=HIDDEN NAME=cid VALUE="+ cid+ "><INPUT TYPE=HIDDEN NAME=examid VALUE="+ examid+ "><INPUT TYPE=HIDDEN NAME='action' VALUE='doGraph'><INPUT TYPE=HIDDEN NAME=sectionid VALUE="+ sectionid+ "></TD></form></TR>");
								counter++;

								++formno;
								
							
//							pstmt.close();
//							pstmt1.close();
							out.println("</TABLE>");
							out.println("</Form>");
//							}//(action==null)
						// candidateDetails  ExamID
					}//(if status ==1)
					else
						out.println("<b>" + fname +" "+ lname +"</b> Please appear for test before Analysis !!");
//					}//(username==null)
				}
				catch(Exception e)
				{
					out.println("Error : " + e.getMessage());
				}

			}//(action==null)
			else if (action.equalsIgnoreCase("doDetails"))
			{
				log.info("Analysis:Display start");
				response.setContentType("TEXT/HTML");
				cid = Integer.parseInt(request.getParameter("cid"));
				examid = Integer.parseInt(request.getParameter("examid"));
				
				log.info("Analysis:Display cid:"+cid);
				log.info("Analysis:Display examid:"+examid);
				try
				{
					response.setContentType("text/html");
					int statright=0,statquest=0;
					try
					{
						String examcode=request.getParameter("examcode");
						int Qnumber=Integer.parseInt(request.getParameter("Qnumber"));
						String dat=request.getParameter("dat");
						String rest=request.getParameter("rest");
						String lname=request.getParameter("lname");
						String fname=request.getParameter("fname");
						int questtype=Integer.parseInt(request.getParameter("questtype"));
		//				String subname=request.getParameter("subname");
						String subname="";
						int currentqid=Integer.parseInt(request.getParameter("currentqid"));
						int exid=Integer.parseInt(request.getParameter("exid"));
						int sectionid=Integer.parseInt(request.getParameter("sectionid"));
						String time=request.getParameter("time");
						String passcolor=request.getParameter("passcolor");
						String exam="",pql="",tql="",expl="",remark="";
						int tempqid=0,actualanswer=0,reasonabletime=0,studans=0,image=0,timetaken=0;
						int totquest=0,nocorrect=0,nowrong=0,totcount=0,unattempted=0,cgid=0;
						float nemarks=0,percent=0.00f,score=0.00f;
		
						NumberFormat nf = NumberFormat.getInstance();
						nf.setMinimumFractionDigits(2);
						nf.setMaximumFractionDigits(2);
		
						query = em.createNamedQuery("Analysis-NewExamDetailsId.sql7");
						query.setParameter(1, exid);
						if(EntityManagerHelper.getSingleResult(query)!=null)
						{
							nemarks = (Integer) query.getSingleResult();
						}
						else
							nemarks=0;
					
						log.info("Analysis:Display nemarks:"+nemarks);
						/*log.info("Analysis:Display questtype:"+questtype);
						log.info("Analysis:Display sectionid:"+sectionid);
						log.info("Analysis:Display cid:"+cid);
						log.info("Analysis:Display examid:"+examid);*/
						switch(questtype)
						{
							case 1 :
							{
		//out.println("All Ans");
								query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql8");
								query.setParameter(1, sectionid);
								query.setParameter(2, cid);
								query.setParameter(3, examid);
								break;
							}
							case 2 :
							{
		//out.println("Right Ans");
								query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql9");
								query.setParameter(1, sectionid);
								query.setParameter(2, cid);
								
								break;
							}
							case 3 :
							{
		//out.println("Unattempted Ans");
								query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql10");
								query.setParameter(1, sectionid);
								query.setParameter(2, cid);
								
								break;
							}
							case 4 :
							{
		//out.println("Wrong Ans");
								query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql11");
								query.setParameter(1, sectionid);
								query.setParameter(2, cid);
								
								break;
							}
							case 5 :
							{
		//out.println("Book Marks");
								query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql12");
								query.setParameter(1, sectionid);
								query.setParameter(2, cid);
								
								break;
							}
		
							/*
							default:
							pql = "SELECT QuestionID,CodeGroupID,TimeTaken,Answer from NewExamTestingDetails where CodeGroupID="+examcode +" AND CandidateID="+ cid + "  AND Time='"+time+"' ORDER BY SequenceNo";
		
							break;
							*/
		
						}// end switch
		//out.println(pql);
						List<Newexamtestingdetails> nxtdList = query.getResultList();
						for(Newexamtestingdetails nxtd:nxtdList)
						{	totcount++;	}
		//out.println("quest : " +totcount);
						if(Qnumber == 0)
							Qnumber = 1;
						else
						{
							++Qnumber;
						}
						log.info("Analysis:Display totcount:"+totcount);
						log.info("Analysis:Display Qnumber:"+Qnumber);
						if(totcount  == Qnumber-1)
						{
							out.println("<center>");
		//					out.println("<form method=post action='"+request.getRequestURI()+"'>");
							out.println("<br><br><br><br><b>All Questions have been completed !!</b>");
		//					out.println("<INPUT TYPE=SUBMIT VALUE=OK>");
							//out.println("<input type=image src="../simages/ok1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../simages/ok2.gif',1)" border=0>"):
		//					out.println("</form>");
						}
						else
						{
							out.println("<form method=post>");
							out.println("<table width='80%' cellspacing=1 cellpadding=1 border=0>");
							out.println("<tr><th>Performance Analysis</th>");
							out.println("<tr><td align='center'>");
							query = em.createNamedQuery("Analysis-NewexamdetailsId.sql13");
							log.info("examid :"+examid);
							log.info("sectionidsectionidsectionidsectionidsectionid :"+sectionid);
							query.setParameter(1, examid);
							query.setParameter(2, sectionid);
							subname = (String)query.getSingleResult();
							log.info("Analysis:Display subname:"+subname);
							out.println("<table width='100%' border='0' cellspacing='1' cellpadding='1'>");
							out.println("<tr><td align='right'><b>Candidate Name :</b></td><td>"+fname +" "+lname+"</td><td align='right'><b>Date of Test :</b></td><td>"+dat+"</td></tr>");
							out.println("<tr><td align='right'><b>Test Name :</b></td><td>"+subname+"</td><td></td><td></td></tr>");
							out.println("</table>");
		
							out.println("</td></tr>");
							out.println("<tr><td>&nbsp;</td></tr>");
		
		//out.println(pql);
							int count = 0,questid=0,rowcount=0;
							Iterator stIterator=nxtdList.iterator();
							Newexamtestingdetails nxtd = null;
							while (count <= Qnumber-1)
							{
								count++;
								nxtd = (Newexamtestingdetails)stIterator.next();
								questid=nxtd.getQuestionId();
								log.info("questid :"+questid);
								log.info("inside count :"+count);
							}
							log.info("outside count :"+count);
							log.info("Qnumber :"+Qnumber);
							{
								
								questid=nxtd.getQuestionId();
								log.info("questid :"+questid);
								cgid=nxtd.getCodeGroupId();
								QuestionmasterDAO qmDAO = new QuestionmasterDAO();
								Questionmaster qm = qmDAO.findById(questid);
								if (qm!=null)
								{
									actualanswer=Integer.parseInt(qm.getNewAnswer());
									reasonabletime=qm.getResonableTime();
									log.info("Analysis:Display before Analysis-Newexamtestingdetails.sql14");
									log.info("Analysis:Display sectionid:"+sectionid);
									log.info("Analysis:Display cid:"+cid);
									log.info("Analysis:Display questid:"+questid);
									log.info("Analysis:Display examid:"+examid);
									String message="";
									query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql14");
									
									query.setParameter(1, sectionid);
									query.setParameter(2, cid);
									query.setParameter(3, questid);
									query.setParameter(4, examid);
									Newexamtestingdetails nxtdi = (Newexamtestingdetails)query.getSingleResult();
									studans=Integer.parseInt(nxtdi.getAnswer());
									log.info("Analysis:Display studans:"+studans);
									if (studans==actualanswer)
									{
										message = "Correct Selection !!";
									}
									else if (studans!=1 && studans!=2 && studans!=3 && studans!=4 )
									{
										message = "No Selection has been made !!";
									}
									else
									{
										message = "Incorrect Selection !!";
									}
		
									expl=qm.getExplanation();
									if (expl==null)expl="Not Available !!";
		
									out.println("<tr align=center><td><table border=0 cellspacing=1 cellpadding=1 width='100%'><tr> <th width=15% align=right><b>Question No : </b></th><th align=left>"+Qnumber+"</th></tr><tr> <td valign=top align=right><b>Question : </b> </td><td>"+qm.getQuestion()+"</td></tr><tr> <td align=right><b>Marks: </b></td><td>"+qm.getMarks()+"</td></tr><tr><td align=right><b>Options </b></td><td>"+message+"</td></tr>");
		
		
									String opt1 = qm.getOption1().trim();
		//out.println(opt1);
									//if (opt1 != null && !opt1.equals(" ") && opt1.equals("No Option") && opt1.equals("No Options"))
									if (opt1 != null && !opt1.equals("") && !opt1.equals("No Option") && !opt1.equals("No Options"))
									{
										out.println("<tr>");
										out.println("<td align=center");
										if((studans==1)&&(actualanswer==1))
											out.println("class=true");
										else if((studans==1)&&(actualanswer!=1))
											out.println("class=false");
										else if (actualanswer==1)
											out.println("class=true");
										out.println(">(A)</td><td>"+opt1+"</td></tr> ");
									}
		
									String opt2 = qm.getOption2().trim();
									if (opt2 != null && !opt2.equals("") && !opt2.equals("No Option") && !opt2.equals("No Options"))
									{
										out.println("<tr><td align=center");
										if((studans==2)&&(actualanswer==2))
											out.println("class=true");
										else if((studans==2)&&(actualanswer!=2))
											out.println("class=false");
										else if (actualanswer==2)
											out.println("class=true");
										out.println(">(B)</td><td>"+opt2+"</td></tr> ");
									}
		
									String opt3 = qm.getOption3().trim();
									if (opt3 != null && !opt3.equals("") && !opt3.equals("No Option") && !opt3.equals("No Options"))
									{
										out.println("<tr><td align=center");
										if((studans==3)&&(actualanswer==3))
											out.println("class=true");
										else if((studans==3)&&(actualanswer!=3))
											out.println("class=false");
										else if (actualanswer==3)
											out.println("class=true");
										out.println(">(C)</td><td>"+opt3+"</td></tr> ");
									}
									String opt4 = qm.getOption4().trim();
									if ((opt4 != null) && (!opt4.equals("")) && (!opt4.equals("NoOption")) && (!opt4.equals("no Options")))
									{
										out.println("<tr><td align=center");
										if((studans==4)&&(actualanswer==4))
											out.println("class=true");
										else if((studans==4)&&(actualanswer!=4))
											out.println("class=false");
										else if (actualanswer==4)
											out.println("class=true");
		
										out.println(">(D)</td><td>"+opt4+"</td></tr><tr> ");
									}
		
									out.println("<td align=right valign=top></td><td></td></tr><tr align=center> <th colspan=2> <input type=Button value='Previous Question' onclick='javascript:history.back();'><input type=submit value='Next Question'></th></tr></table></td></tr>");
		
									image=qm.getImage();
									if (image==1)
									{
										/*query = em.createNamedQuery("Analysis-Imagedetails.sql15");
										query.setParameter(tempqid, tempqid);
										Imagedetails imid = (Imagedetails)query.getSingleResult();
										out.println("<img src='../simages/"+imid.getImage()+"'>");*/
									}
		
									out.println("<tr><td align=center><table border=0 cellspacing=0 cellpadding=0><tr><td width=12 height=12 class=false>&nbsp;</td><td width=12 height=12>&nbsp;=&nbsp;</td><td>Wrong Answer</td><td width=20 bgcolor=#00FF00>&nbsp;</td><td width=12 height=12 class=true>&nbsp;</td><td width=12 height=12>&nbsp;=&nbsp;</td><td>Correct Answer</td></tr></table></td></tr><tr> <td>&nbsp;</td></tr> ");
		
									//"SELECT Score,Date,TotalQuestions,NoOfWrong,NoOfCorrect,Result FROM NewPerformanceMaster WHERE CandidateID=" +cid + " and ExamID=" + examid +" and Time='" + time +"'";
									
									query = em.createNamedQuery("Analysis-Newperformancemaster.sql16");
									query.setParameter(1, cid);
									query.setParameter(2, examid);
									Number rtotquest = (Number)query.getSingleResult();
									totquest = rtotquest.intValue();
									query = em.createNamedQuery("Analysis-Newperformancemaster.sql17");
									query.setParameter(1, cid);
									query.setParameter(2, examid);
									Number rnowrong = (Number)query.getSingleResult();
									nowrong = rnowrong.intValue();
									query = em.createNamedQuery("Analysis-Newperformancemaster.sql18");
									query.setParameter(1, cid);
									query.setParameter(2, examid);
									Number rnocorrect = (Number)query.getSingleResult();
									nocorrect = rnocorrect.intValue();
									query = em.createNamedQuery("Analysis-Newperformancemaster.sql19");
									query.setParameter(1, cid);
									query.setParameter(2, examid);
									Number rscore = (Number)query.getSingleResult();
									score = rscore.intValue();
									}
									
									query = em.createNamedQuery("Analysis-NewexamdetailsId.sql20");
									query.setParameter(1, examid);
									query.setParameter(2, sectionid);
									List<Object[]> nxdidList = query.getResultList();
									int noofquestions=0,levelid=0;
									for(Object[] objList:nxdidList)
									{
										noofquestions = (Integer)objList[0];
										levelid = (Integer)objList[1];
									}
									int TotalMarks=0;
									{
										TotalMarks = TotalMarks +(noofquestions*levelid);
									}
		
									unattempted=totquest-(nocorrect+nowrong);
									percent	= ((score*100)/TotalMarks) ;
									if (percent < 0)
									{
										percent = 0;
									}
		
									/*int per =(int)percent;
									float tempunatt = (unattempted*100)/TotalMarks;
									unattempted = (int) tempunatt;
									float tempnocorrect = (nocorrect*100)/TotalMarks;
									nocorrect = (int) tempnocorrect;
									float tempnowrong = (nowrong*100)/TotalMarks;
									nowrong = (int) tempnowrong;*/
		
									double formatpercent1 = (double) percent;
									String formatpercent =	nf.format(formatpercent1);
		
									out.println("<tr> <td> <table width=100% border=0 cellspacing=1 cellpadding=1><tr> <th colspan=6><b>Score Details</b></th></tr><tr> <th align=right>Total Questions</th><th>Correct Answers</th><th>Wrong Answers</th><th>Unattempted Questions</th><th>Percentage (%)</th><th>Result</th></tr><tr align=center> <td>"+totquest+"</td><td>"+nocorrect+"</td><td>"+nowrong+"</td><td>"+unattempted+"</td><td>"+formatpercent+"</td><td>"+rest+"</td></tr></table>");
								}
		
		
		//						out.println("<br><center> <INPUT TYPE=BUTTON VALUE=Back onclick=javascript:history.back();> <INPUT TYPE=SUBMIT VALUE=Next>");
								//	<input type='image' src="../simages/prev1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../simages/prev2.gif',1)" border=0 onclick='return reverse();'>
								//	<input type='image' src="../simages/next1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../simages/next2.gif',1)" border=0>
		
								out.println("</center>");
								out.println("<INPUT TYPE=HIDDEN NAME='action' VALUE='doDetails'>");
								out.println("<INPUT TYPE=HIDDEN NAME=examcode VALUE="+examcode+">");
								out.println("<INPUT TYPE=HIDDEN NAME=Qnumber VALUE="+Qnumber+">");
								out.println("<INPUT TYPE=HIDDEN NAME=exid VALUE="+exid+">");
								out.println("<INPUT TYPE=HIDDEN NAME=currentqid VALUE="+tempqid+">");
								out.println("<INPUT TYPE=HIDDEN NAME=dat VALUE="+dat+" >");
								out.println("<INPUT TYPE=HIDDEN NAME=rest VALUE="+rest+">");
								out.println("<INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+">");
								out.println("<INPUT TYPE=HIDDEN NAME=sectionid VALUE="+sectionid+">");
								out.println("<INPUT TYPE=HIDDEN NAME=fname VALUE="+fname+">");
								out.println("<INPUT TYPE=HIDDEN NAME=lname VALUE="+lname+">");
								out.println("<INPUT TYPE=HIDDEN NAME=examid VALUE="+examid+">");
								out.println("<INPUT TYPE=HIDDEN NAME=questtype VALUE="+questtype+">");
		//						out.println("<INPUT TYPE=HIDDEN NAME=subname VALUE='"+subname+"'>");
								out.println("<INPUT TYPE=HIDDEN NAME=time VALUE="+time+">");
								out.println("<INPUT TYPE=HIDDEN NAME=passcolor VALUE="+passcolor+">");
		
								out.println("</form>");
		
							}// end of while(rs1.next())
							
												
					}
					catch(Exception e)
					{
						out.println("Error : " + e.getMessage());
					}
				}
				catch(Exception e)
				{
					out.println("Error : " + e.getMessage());
				}
				finally
				{
				}
			}
			else if (action.equalsIgnoreCase("doGraph"))
			{
				try
				{
					//out.println("<B>Graphical View of your Performance</B><BR>");
					cid=Integer.parseInt(request.getParameter("cid"));
					int sectionid=Integer.parseInt(request.getParameter("sectionid"));
					examid=Integer.parseInt(request.getParameter("examid"));
					String examcode=request.getParameter("examcode");
					String time=request.getParameter("time");
					//SELECT Score,Date,TotalQuestions,SectionID,CodeGroupID,NoOfWrong,Time,NoOfCorrect,Result FROM NewPerformanceMaster WHERE CandidateID=1 and ExamID=8 and Time='20:47:19'
					String tql = "SELECT sum(Score),sum(TotalQuestions),sum(NoOfWrong),sum(NoOfCorrect) FROM NewPerformanceMaster WHERE CandidateID=" +cid + " and ExamID=" + examid;
		
					int totquest=0,nocorrect=0,nowrong=0,unattempted=0;
					float score=0.00f;
					query = em.createNamedQuery("Analysis-Newperformancemaster.sql16");
					query.setParameter(1, cid);
					query.setParameter(2, examid);
					Number rtotquest = (Number)query.getSingleResult();
					totquest = rtotquest.intValue();
					query = em.createNamedQuery("Analysis-Newperformancemaster.sql17");
					query.setParameter(1, cid);
					query.setParameter(2, examid);
					Number rnowrong = (Number)query.getSingleResult();
					nowrong = rnowrong.intValue();
					query = em.createNamedQuery("Analysis-Newperformancemaster.sql18");
					query.setParameter(1, cid);
					query.setParameter(2, examid);
					Number rnocorrect = (Number)query.getSingleResult();
					nocorrect = rnocorrect.intValue();
					query = em.createNamedQuery("Analysis-Newperformancemaster.sql19");
					query.setParameter(1, cid);
					query.setParameter(2, examid);
					Number rscore = (Number)query.getSingleResult();
					score = rscore.intValue();
		
					unattempted=totquest-(nocorrect+nowrong);
		
		
					query = em.createNamedQuery("Analysis-NewexamdetailsId.sql20");
					query.setParameter(1, examid);
					query.setParameter(2, sectionid);
					List<Object[]> nxdidList = query.getResultList();
					int noofquestions=0,levelid=0;
					for(Object[] objList:nxdidList)
					{
						noofquestions = (Integer)objList[0];
						levelid = (Integer)objList[1];
					}
					int TotalMarks=0;
					{
						TotalMarks = TotalMarks +(noofquestions*levelid);
					}
					
					float percent	= ((score*100)/TotalMarks) ;
					int per =(int)percent;
					float tempunatt = (unattempted*100)/TotalMarks;
					unattempted = (int) tempunatt;
					float tempnocorrect = (nocorrect*100)/TotalMarks;
					nocorrect = (int) tempnocorrect;
					float tempnowrong = (nowrong*100)/TotalMarks;
					nowrong = (int) tempnowrong;
					int totalpercent =unattempted+nowrong+nocorrect;
					/*out.println("<center>");
					out.println("<applet code=\"PieChart.class\" width=500 codebase=\".\"  height=320><param name=\"correctans\" value="+nocorrect+"><param name=\"wrongans\"  value="+nowrong+"><param name=\"unattemptedans\" value="+unattempted+"><param name=\"backgroundRGB\" value=\"254,249,226\"><param name=\"correctRGB\" value=\"00,00,00\"><param name=\"wrongRGB\" value=\"0,100,200\"><param name=\"unattemptedRGB\" value=\"220,150,250\"><param name=\"totalquestions\" value="+totalpercent+"><param name=\"correctmessage\" value=\"Correct Answers.\"><param name=\"wrongmessage\" value=\"Wrong Answers.\"><param name=\"unattemptedmessage\" value=\"Unattempted Answers.\"></applet>");
					out.println("</center>");//totquest*/
					System.out.println("</unattempted>"+unattempted);
					
					String chart1URL=null;
					// The data for the pie chart
					if(unattempted==0)
					{
					double[] data = {nocorrect,nowrong};
					String[] labels = {"correct", "wrong"};
					// Create a PieChart object of size 360 x 300 pixels
					PieChart c = new PieChart(360, 300);
					
					// Set the center of the pie at (180, 140) and the radius to 100 pixels
					c.setPieSize(180, 140, 100);
					
					// Set the pie data and the pie labels
					c.setData(data, labels);
					
					// Output the chart
					chart1URL = c.makeSession(request, "chart1");
					
					// Include tool tip for the chart
					String imageMap1 = c.getHTMLImageMap("", "", "title='{label}: US${value}K ({percent}%)'");
					}
					else
					{
					double[] data1 = {unattempted,nocorrect,nowrong};
					String[] labels1 = {"unattempted", "correct", "wrong"};
					// Create a PieChart object of size 360 x 300 pixels
					PieChart c = new PieChart(360, 300);
					
					// Set the center of the pie at (180, 140) and the radius to 100 pixels
					c.setPieSize(180, 140, 100);
					
					// Set the pie data and the pie labels
					c.setData(data1, labels1);
					
					// Output the chart
					chart1URL = c.makeSession(request, "chart1");
					
					// Include tool tip for the chart
					String imageMap1 = c.getHTMLImageMap("", "", "title='{label}: US${value}K ({percent}%)'");
					}
					
					// The labels for the pie chart
					//String[] labels = {"unattempted", "correct", "wrong"};
					
					
					
					/*out.print("chart1URL"+chart1URL);
					String str = "getchart.jsp?"+chart1URL;
					out.print("getchart.jsp?+chart1URL"+str);
					out.print("<div style=\"font-size:18pt; font-family:verdana; font-weight:bold\"> Simple Pie Chart	</div>");
					out.print("<hr color=\"#000080\">");
					out.print("<img src=response.encodeURL(str) usemap=\"#map1\" border=\"0\"> </img>");*/
					//out.print("<img src=response.encodeURL(http://localhost:8080/nectar/jsp/getchart.jsp?img=chart1&id=90C976973C8A02144AF2B32828C8D737_8) border=\"0\"/>");
					//out.print("<map name=\"map1\">imageMap1</map>");
					%>
					<div style="font-size:12pt; font-family:verdana; font-weight:bold"> Graphical View of your Performance </div>
					<hr color="#000080">
					<img src='<%=response.encodeURL("getchart.jsp?"+chart1URL)%>' border="0">
					<%
				
					//http://localhost:8080/nectar/jsp/getchart.jsp?img=chart1&id=90C976973C8A02144AF2B32828C8D737_8
		
				}
				catch(Exception e)
				{
					out.println("Error : " + e.getMessage());
				}
				finally
				{
					
				}
			}
			
%>