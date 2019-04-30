<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*,com.ngs.gbl.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.ngs.PaginationBean"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		int cid;// = Integer.parseInt(request.getParameter("CandidateID"));
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Connection con = pool.getConnection();
		EntityManager em = EntityManagerHelper.getEntityManager();
		StringTokenizer stringtoken=null;
		String clientName=null,candID=null;
		String sql = "";
		Logger log = Logger.getLogger("candidatelist.jsp");
	
		final int PASS_PERCENTAGE = 50;
		final int ZILS_USER = 1;
		final int BSE_USER = 2;
		Query query=null;String wild_month_year="";
		
		log.info("CandidateList doGet");
		log.info("CandidateList display_css action:"+action);
		response.setContentType("text/html");
		out.println("<html><head><title>Candidate List</title>");
		out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' "+"HREF='alm.css'></head>");
		out.println("<body><center><P>&nbsp;</P>");
		
		if (action == null || action == "")
		{
			log.info("CnadidateList start display_main_sub_form");
			out.println("<div align='center'>");
			out.print("<h4>Candidates' Master List</h4>");
			out.println("<form action=" +request.getRequestURI()+ " method='GET'>");
			out.println("<table border='0' cellspacing='1' cellpadding='1' "+
								"width='50%' ALIGN='CENTER'>");
			out.println("<tr><th colspan='2'>Select Month and Year</th></tr>");
			out.println("<tr><td align='right'>Month : </td>");
			out.println("<td><select name='month'>");
			out.println("<option value='01'>January</option>");
			out.println("<option value='02'>February</option>");
			out.println("<option value='03'>March</option>");
			out.println("<option value='04'>April</option>");
			out.println("<option value='05'>May</option>");
			out.println("<option value='06'>June</option>");
			out.println("<option value='07'>July</option>");
			out.println("<option value='08'>August</option>");
			out.println("<option value='09'>September</option>");
			out.println("<option value='10'>October</option>");
			out.println("<option value='11'>November</option>");
			out.println("<option value='12'>December</option>");
			out.println("</select></td></tr>");
			out.println("<tr><td align='right'>Year : </td>");
			out.println("<td><select name='year'>");
	// -------------------------------
			Calendar today = Calendar.getInstance();
			int year = 0, thisyear = 0;
	
			thisyear = today.get(Calendar.YEAR);
	
			for (int i=-1; i <= 1 ; i++){
				year = thisyear + i;
	
				out.print("<option value='");
				out.print( year );
				if (year == thisyear)
					out.print("' SELECTED>");
				else
					out.print("'>");
	
				out.print( year );
				out.println("</option>");
			}
	
			out.println("</select></td></tr>");
			out.println("<tr><th colspan='2'>");
			out.println("<input type='submit' name='Submit' value='Submit'>");
			out.println("</th>");
			Integer CandidateID = (Integer) session.getAttribute("CandidateID");
			cid = CandidateID.intValue();
			if (cid == ZILS_USER || cid == BSE_USER){
				out.println("<input type=hidden name='action' value='doExamDateWiseListForBSE'>");
			}else{
				out.println("<input type=hidden name='action' value='ShowExamDates'>");
			}
			out.println("</tr>");
			out.println("</table>");
			out.println("</form>");
			out.println("</div>");
	
		}//end of action null
		else if (action.equals("ShowExamDates"))	{
			String questionType = null;
			try	{
				String startmonth = request.getParameter("month");
				String endmonth ="";
				if(Integer.parseInt(startmonth)>=1 && Integer.parseInt(startmonth)<=11)
				{
					endmonth = "0"+String.valueOf(Integer.parseInt(startmonth) + 1);
				}
				String startyear = request.getParameter("year");
				String endyear = startyear;
				if(Integer.parseInt(startmonth)== 12)
				{
					endyear = String.valueOf(Integer.parseInt(startyear) + 1);
					endmonth = "01";
				}
				String start = startyear+"-"+startmonth+"-"+1;
				String end = endyear+"-"+endmonth+"-"+"1";
				String valid_month = "'"+start+"' and s.scheduleDate<='"+end+"'";
				
				String ClientID = "" + (String)session.getAttribute("ClientID");
				
				sql = "";
				int ScheduleID = 0;
				String ScheduleDate = "";
				String TimeFrom = "";
				String TimeTo = "";
				
				/*
					Uncomment following query to get report up to today's date.
					( Comment out next to next line )
				*/
	//			sql = "SELECT * FROM Schedule WHERE ScheduleDate <= NOW() AND ScheduleDate like \'"+wild_month_year+"%\' AND ClientID=" +ClientID+ " ORDER BY ScheduleDate";
				
				sql = "SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<=?2 AND s.clientId=?3 ORDER BY s.scheduleDate ";
				query = em.createQuery(sql);
				query.setParameter(1,Utils.ConvertStrToDate(start));
				query.setParameter(2,Utils.ConvertStrToDate(end));
				query.setParameter(3,Integer.parseInt(ClientID));
				List<Schedule>	scList = query.getResultList();
				log.info("CnadidateList start scList:"+scList.size()+scList);
				Iterator scItr = scList.iterator();
				if (scItr.hasNext()){
					Schedule sc = (Schedule)scItr.next();
					out.println("<FORM ACTION='" +request.getRequestURI()+ 
											"' METHOD='POST'>");
					out.println("<TABLE BORDER='0' CELLSPACING='1' CELLPADDING='1'"+
									" ALIGN='CENTER'>");
					out.println("<TR><TH COLSPAN=2>Exams were conducted on "+
								"following dates in the <U>" +startmonth+ "</U> month.");
					out.println("");
					out.println("<BR>Please, Select Exam Date to view the "+
								"Candidate List.</TH></TR>");
	
					out.println("<TR><TD ALIGN='RIGHT'>Exam Date : </TD>");
					out.println("<TD><SELECT NAME='ScheduleDate'>");
	
					for(Schedule scl:scList){
						ScheduleID = scl.getScheduleId();
						ScheduleDate = Utils.ConvertDateToString(scl.getScheduleDate());
						TimeFrom = scl.getTimeFrom();
						TimeTo = scl.getTimeTo();
	
						//ScheduleDate = Utils.getDate(ScheduleDate);
						TimeFrom = TimeFrom.substring(0, 5);
						TimeTo = TimeTo.substring(0, 5);
	
						out.println("<OPTION VALUE='" +ScheduleDate+ "'>");
						out.println(ScheduleDate + " | " +TimeFrom+ " - " +TimeTo);
	
						out.println("</OPTION>");
					}
					out.println("</SELECT></TD></TR>");
					out.println("<TR><TH COLSPAN=2><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'>&nbsp;<INPUT TYPE='Submit' "+
									"VALUE='View Report'></TH>");
					out.println("<INPUT TYPE=hidden NAME='action' "+
									"VALUE='ExamDateWiseList'></TR>");
					out.println("</TABLE>");
					out.println("</FORM>");
				}else{
					out.println("<h4>No Exams were conducted during this month."+
																		"</h4>");
				}
			}catch (Exception e){
				out.println("Error : " +e.getMessage() );
			}
		}else if(action.equals("ExamDateWiseList")){
				int ScheduleID = 0;//Integer.parseInt(request.getParameter("ScheduleID"));
				String strScheduleDate = request.getParameter("ScheduleDate");
				//System.out.println("before Score string scheduleDate:"+strScheduleDate);
				java.util.Date scheduleDate = Utils.ConvertStrToDate(strScheduleDate);
				//System.out.println("after Score date scheduleDate:"+scheduleDate);
				String ReportType = "";
				int ClientID = Integer.parseInt((String) session.getAttribute("ClientID"));
				int ExamID = 0, SectionID= 0;
				String TestDate = "", TimeFrom = "", TimeTo = "";
				String tempDate = "";
				try{
					sql = "SELECT s FROM Schedule s WHERE s.scheduleDate=?1 and s.clientId=?2";
					query = em.createQuery(sql);
					query.setParameter(1,scheduleDate);
					query.setParameter(2,ClientID);
					List<Schedule> scList = query.getResultList();
					for(Schedule sc:scList){
						ScheduleID = sc.getScheduleId();
						ExamID = sc.getExamId();
						SectionID = sc.getSectionId();
						tempDate = TestDate = Utils.ConvertDateToString(sc.getScheduleDate());
						TimeFrom = sc.getTimeFrom();
						TimeTo = sc.getTimeTo();
						TestDate = Utils.getDate(TestDate);
						TimeFrom = TimeFrom.substring(0, 5);
						TimeTo = TimeTo.substring(0, 5);
					}
		
					out.print("<h4>Candidates' Master List</h4>");
					out.println("<TABLE BORDER='0' CELLSPACING='1' CELLPADDING='1' "+
								"ALIGN='CENTER' width='70%'>");
					out.println("<TR><TH COLSPAN=5>Summary of the Exam conducted on "+
								TestDate + "(" +  TimeFrom+ " - " +TimeTo + ")" +
								"</TH></TR>");
		
					sql = "SELECT c FROM Candidatemaster c WHERE c.scheduleId=?1 ORDER BY c.firstName, c.lastName";
					query = em.createQuery(sql);
					query.setParameter(1,ScheduleID);
					List<Candidatemaster> cmList = query.getResultList();
					int Count = 1, CandidateID = 0;
					String FirstName = "", LastName = "";
		
					out.println("<TR><TD ALIGN='CENTER' COLSPAN=5>");
					Iterator scItr = cmList.iterator();
					if (scItr.hasNext()){
						Candidatemaster c = (Candidatemaster)scItr.next();
						//out.println("<TABLE BORDER='0' CELLSPACING='1' "+
											//"CELLPADDING='1' ALIGN='CENTER' width='100%'>");
							out.println("<TR><TH>Sr. No.</TH>"+
											"<TH>Registration Number</TH>"+
											"<TH>Candidate Name</TH>" +
											"<TH>Scored (%)</TH>"+
											"<TH>Result</TH></TR>");
						for(Candidatemaster cm:cmList){
							CandidateID = cm.getCandidateId();
							FirstName = cm.getFirstName();
							LastName = cm.getLastName();
							
							RegistrationKey rkey = new RegistrationKey(CandidateID);
		
							//System.out.println("Start :");
							out.println("<TR>");
							out.println("<TD ALIGN='RIGHT'>" +Count+ "&nbsp;</TD>");
							out.println("<TD ALIGN='CENTER'>" +rkey.getKeyCode()+"</TD>");
							
							// CODE FOR MARKSHEET LINK 
							/*sql = "select Date from NewPerformanceMaster "+
								" where CandidateId=" + CandidateID + " and " +
								" Date = '" + tempDate +"'";*/
							
							String str = FirstName+ " " +LastName;
							out.println("<TD>"+str+"</TD>");
							/*System.out.println("before Score:");
							System.out.println("before Score CandidateID:"+CandidateID);
							System.out.println("before Score ExamID:"+ExamID);*/
							int Score = 0,totquest=0,nocorrect=0;
							String result="";
							query = em.createNamedQuery("Analysis-Newperformancemaster.sql16");
							query.setParameter(1, CandidateID);
							query.setParameter(2, ExamID);
							Number rtotquest = (Number)query.getSingleResult();
							totquest = rtotquest.intValue();
							query = em.createNamedQuery("Analysis-Newperformancemaster.sql18");
							query.setParameter(1, CandidateID);
							query.setParameter(2, ExamID);
							Number rnocorrect = (Number)query.getSingleResult();
							nocorrect = rnocorrect.intValue();
							query = em.createNamedQuery("Analysis-Newperformancemaster.sql19");
							query.setParameter(1, CandidateID);
							query.setParameter(2, ExamID);
							Number rscore = (Number)query.getSingleResult();
							Score = rscore.intValue();
							//Score = (nocorrect * 100 ) / totquest;
							//out.println("<TD ALIGN='CENTER'>"+Score+"</TD>");
							if(Score>=50)
								result="Pass";
							else
								result="Fail";
							//out.println("<TD ALIGN='CENTER'>"+result+"</TD>");
							//System.out.println("After Score:"+Score);
							//sql = "Select nxd.noofquestions,nxd.levelId from Newexamdetails nxd where nxd.examId=?1";
							query = em.createNamedQuery("CandiadateList-Newperformancemaster.sql1");
							query.setParameter(1,ExamID);
							List<Object[]> objList = query.getResultList();
							int TotalMarks=0;
							float Percent=0.00f;
							for(Object[] obj:objList)
							{
							  TotalMarks += (Integer)obj[0]*(Integer)obj[1];
							}
							//System.out.println("After Score TotalMarks:"+TotalMarks);
							if(TotalMarks > 0)
							{
								Percent = ((Score*100)/TotalMarks) ;
								if (Percent < 0){
													Percent = 0;
												}
							}
							else 
							{
								Percent = 0;
							}
							DecimalFormat df = new DecimalFormat("##.##");
							String strPercent	= df.format(Percent);
							
							
							//sql = "SELECT npm.result FROM Newperformancemaster npm"+
							//		" WHERE npm.examID=?1 AND npm.sectionId=?2 AND npm.candidateId=?3 GROUP BY npm.candidateId";
							query = em.createNamedQuery("CandiadateList-Newperformancemaster.sql2");
							//System.out.println("before query ExamID :"+ExamID);
							//System.out.println("before query SectionID :"+SectionID);
							//System.out.println("before query CandidateID :"+CandidateID);
							query.setParameter(1,ExamID);
							query.setParameter(2,SectionID);
							query.setParameter(3,CandidateID);
							int Result = 0;
							//System.out.println("before query Result :"+Result);
							if(EntityManagerHelper.getSingleResult(query)!=null){
								Result = (Integer)query.getSingleResult();
							}else{
								Result = -1;
							}
							
							out.println("<TD ALIGN='RIGHT'>"+ (Result==-1?"N/A":strPercent+"")+"&nbsp;</TD>");
							out.println("<TD ALIGN='CENTER'>"+ (Result==-1?"N/A":
											"<a href=\"marksheet.jsp?CandidateID="+ CandidateID +"&action=showmarksheet\">"+
													(Percent<=PASS_PERCENTAGE?"Fail":"Pass")+"</a>")+
										"</TD>");
			
							out.println("</TR>");
							Count++;
						}
						out.println("<TR><Th COLSPAN=5 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
						out.println("</TABLE>");
					}else{
						out.println("<b>No Candidate found.</b>");
					}
		
					out.println("</TD></TR>");
					out.println("</TABLE>");
				}catch(Exception e){
					out.print("Error :" +e.getMessage()+ "<BR>");
				}
		}else if(action.equals("doExamDateWiseListForBSE")){
			String questionType = null;
			//log.info("ExamDateWiseListBSE start :");
			try	{
				String startmonth = request.getParameter("month");
				String endmonth ="";
				if(Integer.parseInt(startmonth)>=1 && Integer.parseInt(startmonth)<=11)
				{
					endmonth = "0"+String.valueOf(Integer.parseInt(startmonth) + 1);
				}
				String startyear = request.getParameter("year");
				String endyear = startyear;
				if(Integer.parseInt(startmonth)== 12)
				{
					endyear = String.valueOf(Integer.parseInt(startyear) + 1);
					endmonth = "01";
				}
				String start = startyear+"-"+startmonth+"-"+1;
				String end = endyear+"-"+endmonth+"-"+"1";
				String valid_month = "'"+start+"' and s.scheduleDate<='"+end+"'";
				//System.out.println("date valid_month:"+valid_month);
				sql = "";
				int ScheduleID = 0;
				String ScheduleDate = "";
				String TimeFrom = "";
				String TimeTo = "";
				int examid=0,clientid=0,count=1,rest=0,schid=0;
				String schdate ="",centrename="",firstname="",lastname="",result="";
				StringBuffer canschedule = new StringBuffer();
				float score = 0.0f;
				float Percent = 0;
	
				out.println("<H4>Candidates' Master List(CML)</H4>");
				out.println("<table border='0' cellspacing='1' cellpadding='1' "+
								"width='70%' ALIGN='CENTER'>");
				out.println("<TR><TH>Sr. No.</TH><TH>Centre Name</TH><TH>Date of Test</TH><TH>Registration No.</TH><TH>Candidate's Name</TH><TH>Score (%)</TH><TH>Result</TH></TR>");
				//log.info("ExamDateWiseListBSE before query :");
				
				/*sql ="SELECT CandidateID,FirstName,LastName,ClientID,ScheduleID FROM CandidateMaster WHERE ScheduleID IN "+
				"(SELECT ScheduleID FROM Schedule WHERE ScheduleDate LIKE ? group by ScheduleDate,ClientID order by "+
				"ScheduleDate,ClientID) ORDER BY CandidateID,FirstName,LastName,ClientID";*/
				/*String sql1="select s.scheduleDate,c.candidateId,c.firstName,c.lastName,c.clientId,"+
						"s.scheduleId,cm.clientName,cd.examId from Candidatemaster c, Schedule s,"+
						"Clientmaster cm,Candidatedetails cd where s.scheduleDate>='?1' and "+
						"s.scheduleDate<='?2' and c.scheduleId=s.scheduleId "+
						"and cm.clientId=c.clientId and cd.candidateId=c.candidateId "+
						"group by c.candidateId,s.scheduleDate,c.firstName,"+
						"c.lastName,c.clientId,s.scheduleId,cm.clientName,cd.examId order by "+
						"s.scheduleDate,c.candidateId";
						//query = em.createQuery(sql1);*/
						query = em.createNamedQuery("CandidateList-Candidatemaster.sql1");
						query.setParameter(1,Utils.ConvertStrToDate(start));
						query.setParameter(2,Utils.ConvertStrToDate(end));
						List<Object[]> rowList = query.getResultList();
						int datasize = rowList.size();
						/************start Pagination code ******************/
						
						log.info("start");
						log.info("datasize :"+datasize);
						int rowcount=0;int total_pages;int pageNo;int pagesize=10;
						if(null==request.getParameter("page_number"))
						pageNo = 1;
						else
						pageNo = Integer.parseInt(request.getParameter("page_number"));
						log.info("pageNo :"+pageNo);
						log.info("pagesize :"+pagesize);
						PaginationBean objPaginationBean = new PaginationBean();
						List<Object[]> objList = objPaginationBean.findAllByObjectWithPaging(pageNo,pagesize,query);
						for(Object[] cmList:rowList)
						{ rowcount++;}
						log.info("rowcount :"+rowcount);
						String strPassword="";count=1;
						if(pageNo>1)
						count = (pagesize*(pageNo-1))+1;
						
						/************end Pagination code ******************/
						//Iterator objItr = objList.iterator();
						//System.out.println("before rs pstmt ");
						for(Object[] obj:objList){
						
						Percent = 0;
						rest = 0;
						score = 0;
						result = "Fail";
						//System.out.println("inside rs pstmt shDate");
						clientid = (Integer)obj[4];
						cid = (Integer)obj[1];
						firstname = (String) obj[2];
						lastname = (String) obj[3];
						schid = (Integer)obj[5];
						//System.out.println("inside rs pstmt schid"+schid);
						java.util.Date shDate = (java.util.Date)obj[0];
						//System.out.println("inside rs pstmt shDate"+shDate);
						schdate = Utils.ConvertDateToString(shDate);
						ClientmasterDAO clmDAO = new ClientmasterDAO();
						Clientmaster clm= clmDAO.findById(clientid);
					    centrename = clm.getClientName();
						//System.out.println("inside rs pstmt centrename"+centrename);
					    CandidatedetailsDAO cdDAO = new CandidatedetailsDAO();
					    //System.out.println("inside rs pstmt cid"+cid);
					    Candidatedetails cd = cdDAO.findById(cid);
						examid = cd.getExamId();
						//System.out.println("inside rs pstmt examid"+examid);
						
						sql = "SELECT npm.result FROM Newperformancemaster npm WHERE npm.candidateId=?1 and npm.examId=?2";
						query = em.createQuery(sql);
						query.setParameter(1,cid);
						query.setParameter(2,examid);
						//System.out.println("inside rs pstmt cid"+cid);
						//System.out.println("inside rs pstmt examid"+examid);
						if(EntityManagerHelper.getSingleResult(query)!=null){
							rest = (Integer)query.getSingleResult();
						}else{
							rest = -1;
						}
						log.info("rest :"+rest);
						
						if(rest!=-1){
							sql = "SELECT sum(npm.score) FROM Newperformancemaster npm WHERE npm.candidateId=?1 and npm.examId=?2";
							//System.out.println("before Score:"+Score);
							query = em.createQuery(sql);
							query.setParameter(1,cid);
							query.setParameter(2,examid);
							Number scoreResult = (Number)query.getSingleResult();
							score = scoreResult.floatValue();
							//System.out.println("After Score:"+score);
							sql = "Select nxd.noOfQuestions,nxd.levelId from Newexamdetails nxd where nxd.examId=?1";
							query = em.createQuery(sql);
							query.setParameter(1,examid);
							objList = query.getResultList();
							int TotalMarks=0;
							Percent=0;
							for(Object[] objl:objList)
							{
							  TotalMarks += (Integer)objl[0]*(Integer)objl[1];
							}
							Percent = ((score*100)/TotalMarks) ;
							if (Percent < 0){
								Percent = 0;
							}
							if (rest==1){
								result = "PASS"; 
							}else if(rest==0){
								result = "Fail";
							}
						}else{
							if(shDate.getTime()>System.currentTimeMillis()){
								rest = -1;
							}else{
								rest = 0;
							}
						}
						
						DecimalFormat df = new DecimalFormat("##.##");
						String strPercent	= df.format(Percent);
						System.out.println("After Score Percent:::::::::::::"+strPercent);
						
						RegistrationKey regkey = new RegistrationKey (cid);
						out.println("<TR><TD ALIGN=CENTER>"+count+"</TD>"+
							"<TD>"+centrename+"</TD>"+
							"<TD>"+schdate+"</TD>"+
							"<TD>"+regkey.getKeyCode()+"</TD>"+
							"<TD>"+firstname + " " +lastname+"</TD>"+
							"<TD align='center'>"+(rest==-1?"N/A":strPercent+"")+"</TD>"+
							"<TD> "+
								(rest==-1?"N/A":"<a href=\"marksheet.jsp?CandidateID="+ cid +"&action=showmarksheet\">"+result+"</a>")+
							"</TD></TR>");
						count++;
					}
					
					int rowend = 0;
					if(rowcount % pagesize >=1)
					rowend=1;
					log.info("rowend :"+rowend);
					log.info("(rowcount/pagesize)+rowend :"+(rowcount/pagesize)+rowend);
					out.println("<TR>");
					out.print("<TD ALIGN='CENTER' COLSPAN=7>");
					for(int i = 1; i <=(rowcount/pagesize)+rowend; i++)
					{ 
						if(i == pageNo)
						{
						// This is the only page. so no link
						out.println("<FONT COLOR=red><B>page:"+i+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B></FONT>");
						}
						else {
						out.println("<a href='../jsp/candidatelist.jsp?action=doExamDateWiseListForBSE&month="+startmonth+"&year="+startyear+"&page_number="+i+"'>"+i+"</a>");
						}
						
					}
					
				
				out.println("<TR><TH COLSPAN=7> N/A -> Not Appeared</TH></TR>");
				out.println("<TR><Th COLSPAN=7 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR></TABLE>");
			}catch (Exception e){
				out.println("Error : " +e);
				e.printStackTrace();
			}
		}
		
%>