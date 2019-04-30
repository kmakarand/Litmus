import java.io.*;
import java.sql.*;
import java.util.List;
import java.util.Vector;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.log4j.Logger;

import com.ngs.EntityManagerHelper;
import com.ngs.dao.QuestionmasterDAO;
import com.ngs.entity.Candidatedetails;
import com.ngs.entity.CandidatedetailsId;
import com.ngs.entity.Candidatemaster;
import com.ngs.entity.ImagedetailsId;
import com.ngs.entity.Newexamdetails;
import com.ngs.entity.NewexamdetailsId;
import com.ngs.entity.Newperformancemaster;
import com.ngs.entity.Newexamtestingdetails;
import com.ngs.entity.Questionmaster;
import com.ngs.gbl.*;
import com.ngs.gen.Utils;
import java.util.Date;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;

public class Analysis extends HttpServlet
{
	EntityManager em = EntityManagerHelper.getEntityManager();
	Logger log = Logger.getLogger(Analysis.class);

	
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		log.info("Analysis:doGet start");
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession(true);
		String action = req.getParameter("action");
		log.info("Analysis:doGet action:"+action);
		String sql="";Query query=null;
		Integer CandidateID = (Integer) session.getAttribute("CandidateID");
		int cid = 0,lid=0,examid=0;
		cid = CandidateID.intValue();
		if (cid == 0)
		{
			cid = 1;
			res.sendRedirect("../jsp/Login.jsp");
		}
		try
		{
			if (action == null || action == "")
			{
				try
				{
						log.info("Analysis:doGet action is null:");
						System.out.println("Analysis:doGet action is null:");
						res.setContentType("text/html");
						out.println("<HTML><HEAD><TITLE>Analysis</TITLE></HEAD>");
						out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
						out.println("<BODY><CENTER>");
						String ques="",quesc="";
						int cdgroupid=0;
						int status=0;
						int candid=0,sectionid=0;
						String fname="",lname="";Candidatemaster cm=null;
	
						query = em.createNamedQuery("Analysis-Candidatemaster.sql1");
						query.setParameter(cid, cid);
						cm = (Candidatemaster)query.getSingleResult();
						fname=cm.getFirstName();
						lname=cm.getLastName();
						query = em.createNamedQuery("Analysis-Newperformancemaster.sql2");
						query.setParameter(cid, cid);
						Number resultStatus = (Number) query.getSingleResult();
						status=resultStatus.intValue();
								
							if (status >=1)
							{
								query = em.createNamedQuery("Analysis-CandidatedetailsId.sql3");
								query.setParameter(cid, cid);
								CandidatedetailsId cd = (CandidatedetailsId) query.getSingleResult();
								examid=cd.getExamId();
								String remark="",examname="";;
								int attemptno=0,ecode=0;
								out.println("<H3><font color=#996633>Analysis of Exams Appeared</font></H3>");
								out.println("Candidate Name : <b>"+fname+" "+lname+"</b><br> ");
								
								System.out.println("Candidate Name : <b>"+fname+" "+lname);
								out.println("<center><TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1 ><TR><TH>Sr.No</TH><TH>Test Name</TH><TH>Result</TH><TH>Attempt No.</TH><TH WIDTH='70'>Exam Date<TH>Question Type</TH><TH>Action</TH><TH>Graphical View</TH></TR>");
	
								int exid=0,counter=1;
								
								query = em.createNamedQuery("Analysis-NewExamDetailsId.sql4");
								query.setParameter(examid, examid);
								NewexamdetailsId nxid = (NewexamdetailsId) query.getSingleResult();
								System.out.println("psn.next()");
								String subname="",rest="";
								Date dat=null;
								Time time=null;
								sectionid=nxid.getSectionId();
								subname=nxid.getTestName();
								
								query = em.createNamedQuery("Analysis-Newperformancemaster.sql5");
								query.setParameter(cid, cid);
								query.setParameter(examid, examid);
								query.setParameter(sectionid, sectionid);
								Newperformancemaster npm = (Newperformancemaster) query.getSingleResult();
								attemptno=npm.getAttemptNo();
								int count=0;
								int totquest=0,nowrong=0,nocorrect=0,result=0,formno=1,incorrect=0,unattempted=0,noattempted=0,anal=1;
								int cgid=0;

								query = em.createNamedQuery("Analysis-Newperformancemaster.sql6");
								query.setParameter(cid, cid);
								query.setParameter(examid, examid);
								query.setParameter(sectionid, sectionid);
								npm = (Newperformancemaster) query.getSingleResult();
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
								out.println("<form name=formGraph method=post action="+req.getRequestURI()+"><TD VALIGN='CENTER'><center><INPUT TYPE=SUBMIT VALUE='Graphical View'></center><INPUT TYPE=HIDDEN NAME=examcode VALUE="+ cgid+ "><INPUT TYPE=HIDDEN NAME=time VALUE='"+ time+"'><INPUT TYPE=HIDDEN NAME=cid VALUE="+ cid+ "><INPUT TYPE=HIDDEN NAME=examid VALUE="+ examid+ "><INPUT TYPE=HIDDEN NAME='action' VALUE='doGraph'><INPUT TYPE=HIDDEN NAME=sectionid VALUE="+ sectionid+ "></TD></form></TR>");
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
			else
				doPost(req,res);
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
			
		}

	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		System.out.println("Analysis:doGet start");
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		out.println("<HTML><HEAD><TITLE>Analysis</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		try
		{
			String action = req.getParameter("action");
			System.out.println("Analysis:doGet action->"+action);
			if (action.equalsIgnoreCase("doDetails"))
			{
				Display(req,res);
			}
			if (action.equalsIgnoreCase("doGraph"))
			{
				Graph(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}

	@SuppressWarnings("unchecked")
	public void Display(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		System.out.println("Analysis:Display start");
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		Query query =null;
		int cid = Integer.parseInt(req.getParameter("cid"));
		int examid = Integer.parseInt(req.getParameter("examid"));
		
		System.out.println("Analysis:Display cid:"+cid);
		System.out.println("Analysis:Display examid:"+examid);
		try
		{
			HttpSession session=req.getSession(true);
			res.setContentType("text/html");
			int statright=0,statquest=0;
			try
			{
				String examcode=req.getParameter("examcode");
				int Qnumber=Integer.parseInt(req.getParameter("Qnumber"));
				String dat=req.getParameter("dat");
				String rest=req.getParameter("rest");
				String lname=req.getParameter("lname");
				String fname=req.getParameter("fname");
				int questtype=Integer.parseInt(req.getParameter("questtype"));
//				String subname=req.getParameter("subname");
				String subname="";
				int currentqid=Integer.parseInt(req.getParameter("currentqid"));
				int exid=Integer.parseInt(req.getParameter("exid"));
				int sectionid=Integer.parseInt(req.getParameter("sectionid"));
				String time=req.getParameter("time");
				String passcolor=req.getParameter("passcolor");
				String exam="",pql="",tql="",expl="",remark="";
				int tempqid=0,actualanswer=0,reasonabletime=0,studans=0,image=0,timetaken=0;
				int totquest=0,nocorrect=0,nowrong=0,totcount=0,unattempted=0,cgid=0;
				float nemarks=0,percent=0.00f,score=0.00f;

				NumberFormat nf = NumberFormat.getInstance();
				nf.setMinimumFractionDigits(2);
				nf.setMaximumFractionDigits(2);

				query = em.createNamedQuery("Analysis-NewExamDetailsId.sql7");
				query.setParameter(examid, exid);
				NewexamdetailsId nxid = (NewexamdetailsId) query.getSingleResult();
				nemarks=nxid.getNegativeMarks();
				/*System.out.println("Analysis:Display questtype:"+questtype);
				System.out.println("Analysis:Display sectionid:"+sectionid);
				System.out.println("Analysis:Display cid:"+cid);
				System.out.println("Analysis:Display examid:"+examid);*/
				switch(questtype)
				{
					case 1 :
					{
//out.println("All Ans");
						query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql8");
						query.setParameter(sectionid, sectionid);
						query.setParameter(cid, cid);
						query.setParameter(examid, examid);
						break;
					}
					case 2 :
					{
//out.println("Right Ans");
						query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql9");
						query.setParameter(sectionid, sectionid);
						query.setParameter(cid, cid);
						query.setParameter(examid, examid);
						break;
					}
					case 3 :
					{
//out.println("Unattempted Ans");
						query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql10");
						query.setParameter(sectionid, sectionid);
						query.setParameter(cid, cid);
						query.setParameter(examid, examid);
						break;
					}
					case 4 :
					{
//out.println("Wrong Ans");
						query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql11");
						query.setParameter(sectionid, sectionid);
						query.setParameter(cid, cid);
						query.setParameter(examid, examid);
						break;
					}
					case 5 :
					{
//out.println("Book Marks");
						query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql12");
						query.setParameter(sectionid, sectionid);
						query.setParameter(cid, cid);
						query.setParameter(examid, examid);
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
				System.out.println("Analysis:Display totcount:"+totcount);
				System.out.println("Analysis:Display Qnumber:"+Qnumber);
				if(totcount  == Qnumber-1)
				{
					out.println("<center>");
//					out.println("<form method=post action='"+req.getRequestURI()+"'>");
					out.println("<br><br><br><br><b>All Questions have been completed !!</b>");
//					out.println("<INPUT TYPE=SUBMIT VALUE=OK>");
					//out.println("<input type=image src="../simages/ok1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../simages/ok2.gif',1)" border=0>"):
//					out.println("</form>");
				}
				else
				{
					out.println("<form method=post>");
					out.println("<table width='100%' cellspacing=1 cellpadding=1 border=0>");
					out.println("<tr><th>Performance Analysis</th>");
					out.println("<tr><td align='center'>");

					query = em.createNamedQuery("Analysis-NewexamdetailsId.sql13");
					query.setParameter(sectionid, sectionid);
					query.setParameter(examid, examid);
					NewexamdetailsId nxdid = (NewexamdetailsId)query.getSingleResult();
					subname = nxdid.getTestName();
					out.println("<table width='100%' border='0' cellspacing='1' cellpadding='1'>");
					out.println("<tr><td align='right'><b>Candidate Name :</b></td><td>"+fname +" "+lname+"</td><td align='right'><b>Date of Test :</b></td><td>"+dat+"</td></tr>");
					out.println("<tr><td align='right'><b>Test Name :</b></td><td>"+subname+"</td><td></td><td></td></tr>");
					out.println("</table>");

					out.println("</td></tr>");
					out.println("<tr><td>&nbsp;</td></tr>");

//out.println(pql);
					int count = 0,questid=0;
					while ( count < Qnumber-1)
					{
						count++;
					}

					for(Newexamtestingdetails nxtd:nxtdList)
					{
						questid=nxtd.getQuestionId();
						cgid=nxtd.getCodeGroupId();
						QuestionmasterDAO qmDAO = new QuestionmasterDAO();
						Questionmaster qm = qmDAO.findById(questid);
						if (qm!=null)
						{
							actualanswer=Integer.parseInt(qm.getNewAnswer());
							reasonabletime=qm.getResonableTime();

							String message="";
							System.out.println("Analysis:Display sectionid:"+sectionid);
							System.out.println("Analysis:Display cid:"+cid);
							System.out.println("Analysis:Display questid:"+questid);
							System.out.println("Analysis:Display examid:"+examid);
							query = em.createNamedQuery("Analysis-Newexamtestingdetails.sql14");
							query.setParameter(sectionid, sectionid);
							query.setParameter(cid, cid);
							query.setParameter(questid, questid);
							query.setParameter(examid, examid);
							Newexamtestingdetails nxtdi = (Newexamtestingdetails)query.getSingleResult();
							studans=Integer.parseInt(nxtdi.getAnswer());
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

							out.println("<tr align=center> <td> <table border=0 cellspacing=1 cellpadding=1 width=100%><tr> <th width=15% align=right><b>Question No : </b></th><th align=left>"+Qnumber+"</th></tr><tr> <td valign=top align=right><b>Question : </b> </td><td>"+qm.getQuestion()+"</td></tr><tr> <td align=right><b>Marks: </b></td><td>"+qm.getMarks()+"</td></tr><tr><td align=right><b>Options </b></td><td>"+message+"</td></tr>");


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
								query = em.createNamedQuery("Analysis-ImagedetailsId.sql15");
								query.setParameter(tempqid, tempqid);
								ImagedetailsId imid = (ImagedetailsId)query.getSingleResult();
								out.println("<img src='../simages/"+imid.getImage()+"'>");
							}

							out.println("<tr><td align=center><table border=0 cellspacing=0 cellpadding=0><tr><td width=12 height=12 class=false>&nbsp;</td><td width=12 height=12>&nbsp;=&nbsp;</td><td>Wrong Answer</td><td width=20 bgcolor=#00FF00>&nbsp;</td><td width=12 height=12 class=true>&nbsp;</td><td width=12 height=12>&nbsp;=&nbsp;</td><td>Correct Answer</td></tr></table></td></tr><tr> <td>&nbsp;</td></tr> ");

							//"SELECT Score,Date,TotalQuestions,NoOfWrong,NoOfCorrect,Result FROM NewPerformanceMaster WHERE CandidateID=" +cid + " and ExamID=" + examid +" and Time='" + time +"'";
							
							query = em.createNativeQuery("Analysis-Newperformancemaster.sql16");
							query.setParameter(cid, cid);
							query.setParameter(examid, examid);
							Number rtotquest = (Number)query.getSingleResult();
							totquest = rtotquest.intValue();
							query = em.createNativeQuery("Analysis-Newperformancemaster.sql17");
							query.setParameter(cid, cid);
							query.setParameter(examid, examid);
							Number rnowrong = (Number)query.getSingleResult();
							nowrong = rnowrong.intValue();
							query = em.createNativeQuery("Analysis-Newperformancemaster.sql18");
							query.setParameter(cid, cid);
							query.setParameter(examid, examid);
							Number rnocorrect = (Number)query.getSingleResult();
							nocorrect = rnocorrect.intValue();
							query = em.createNativeQuery("Analysis-Newperformancemaster.sql19");
							query.setParameter(cid, cid);
							query.setParameter(examid, examid);
							Number rscore = (Number)query.getSingleResult();
							score = rscore.intValue();
							}
							
							query = em.createNativeQuery("Analysis-NewexamdetailsId.sql20");
							query.setParameter(examid, examid);
							query.setParameter(sectionid, sectionid);
							nxdid = (NewexamdetailsId)query.getSingleResult();
							int TotalMarks=0;
							{
								TotalMarks = TotalMarks +(nxdid.getNoOfQuestions()*nxdid.getLevelId());
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

	public void Graph(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		System.out.println("Analysis:Graph start");
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();Query query=null;
		String sql = null;
		try
		{
		
			HttpSession session=req.getSession(true);
			out.println("<B>Graphical View of your Performance</B><BR>");
			int cid=Integer.parseInt(req.getParameter("cid"));
			int sectionid=Integer.parseInt(req.getParameter("sectionid"));
			int examid=Integer.parseInt(req.getParameter("examid"));
			String examcode=req.getParameter("examcode");
			String time=req.getParameter("time");
			//SELECT Score,Date,TotalQuestions,SectionID,CodeGroupID,NoOfWrong,Time,NoOfCorrect,Result FROM NewPerformanceMaster WHERE CandidateID=1 and ExamID=8 and Time='20:47:19'
			String tql = "SELECT sum(Score),sum(TotalQuestions),sum(NoOfWrong),sum(NoOfCorrect) FROM NewPerformanceMaster WHERE CandidateID=" +cid + " and ExamID=" + examid;

			int totquest=0,nocorrect=0,nowrong=0,unattempted=0;
			float score=0.00f;
			query = em.createNativeQuery("Analysis-Newperformancemaster.sql16");
			query.setParameter(cid, cid);
			query.setParameter(examid, examid);
			Number rtotquest = (Number)query.getSingleResult();
			totquest = rtotquest.intValue();
			query = em.createNativeQuery("Analysis-Newperformancemaster.sql17");
			query.setParameter(cid, cid);
			query.setParameter(examid, examid);
			Number rnowrong = (Number)query.getSingleResult();
			nowrong = rnowrong.intValue();
			query = em.createNativeQuery("Analysis-Newperformancemaster.sql18");
			query.setParameter(cid, cid);
			query.setParameter(examid, examid);
			Number rnocorrect = (Number)query.getSingleResult();
			nocorrect = rnocorrect.intValue();
			query = em.createNativeQuery("Analysis-Newperformancemaster.sql19");
			query.setParameter(cid, cid);
			query.setParameter(examid, examid);
			Number rscore = (Number)query.getSingleResult();
			score = rscore.intValue();

			unattempted=totquest-(nocorrect+nowrong);


			query = em.createNativeQuery("Analysis-NewexamdetailsId.sql20");
			query.setParameter(examid, examid);
			query.setParameter(sectionid, sectionid);
			NewexamdetailsId nxdid = (NewexamdetailsId)query.getSingleResult();
			int TotalMarks=0;
			{
				TotalMarks = TotalMarks +(nxdid.getNoOfQuestions()*nxdid.getLevelId());
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

			out.println("<center>");
			out.println("<applet code=PieChart.class width=500 codebase=\"../jsp\"  height=320><param name=\"correctans\" value="+nocorrect+"><param name=\"wrongans\"  value="+nowrong+"><param name=\"unattemptedans\" value="+unattempted+"><param name=\"backgroundRGB\" value=\"254,249,226\"><param name=\"correctRGB\" value=\"00,00,00\"><param name=\"wrongRGB\" value=\"0,100,200\"><param name=\"unattemptedRGB\" value=\"220,150,250\"><param name=\"totalquestions\" value="+totalpercent+"><param name=\"correctmessage\" value=\"Correct Answers.\"><param name=\"wrongmessage\" value=\"Wrong Answers.\"><param name=\"unattemptedmessage\" value=\"Unattempted Answers.\"></applet>");
			out.println("</center>");//totquest

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
			
		}

	}
}

