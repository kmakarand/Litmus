<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper,java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ngs.gbl.RegistrationKey"%>
<%@page import="java.text.DateFormat"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		Query query=null;
		//int cid = Integer.parseInt(request.getParameter("CandidateID"));
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		ClientmasterDAO cmDAO = new ClientmasterDAO();
		ScheduleDAO scDAO = new ScheduleDAO();
		CandidatemasterDAO cndDAO = new CandidatemasterDAO();
		Logger log = Logger.getLogger("Monthly_Summary.jsp");
		Connection con = pool.getConnection();
		EntityManager em = EntityManagerHelper.getEntityManager();
		StringTokenizer stringtoken=null;
		String scheduleID=null;String wild_month_year = "";String sql = null;String question_engine_Type=null;
		int SequenceNo;String fDir = "";boolean doLogin = false;
		
		out.println("<html><head><title>Monthly Summary Report</title>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></head>");
		
		int cid =0;

		if (action == null || action == "")
		{
			SequenceNo=1;
			out.println("<div align='center'>");
			out.println("<br><br><font color=blue family=gorgia size=3>Monthly Summary Statement</font><HR><BR>");
			out.println("<form action=" +request.getRequestURI()+ " method='get'>");
			out.println("<table border='0' cellspacing='1' cellpadding='1' width='50%'>");
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
	
			for (int i=-1; i <= 1 ; i++)
			{
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
	// -------------------------------
	
			out.println("</select></td></tr>");
			out.println("<tr><th colspan='2'>");
			out.println("<input type='submit' name='Submit' value='Show Report'>");
			out.println("</th>");
			cid = 0;
			String ClientID = (String)session.getAttribute("ClientID");
			if(ClientID.equals("0") || ClientID==null || ClientID=="" || ClientID.equals("")  )
			{
				Integer CandidateID = (Integer) session.getAttribute("CandidateID");
				cid = CandidateID.intValue();
				if (cid == 2 || cid ==1)
				{
					out.println("<input type=hidden name='action' value='doBSEMomthlyReport'>");
					
				}
			}
			else
			{
	//out.println("client id : " + ClientID);
				out.println("<input type=hidden name='action' value='reportgenerator'>");
			}
			out.println("</tr>");
			out.println("</table>");
			out.println("</form>");
			out.println("</div>");			
		}//end of action null
		else if (action.equals("reportgenerator")){
			out.print("<div align='center'> ");
			out.println("<br><br><font color=blue family=gorgia size=3>Monthly Summary Statement</font><HR><BR>");
			out.print("<form name='form1' method='post' action=''>");
			
			int month = Integer.parseInt(request.getParameter("month"));
			int year = Integer.parseInt(request.getParameter("year"));
			String startdt = year + "-" + month + "-" + 1 ;
			String enddt = year + "-" + (month+1) + "-" + 1 ;
			wild_month_year = year+"-"+month;
			//log.info("startdt 1:"+startdt);
			//log.info("enddt 2:"+enddt);
			String ClientID = "" + session.getAttribute("ClientID");
			
	
			try{	
						
	//check for valid month
				sql = "SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<=?2 ORDER BY s.scheduleDate ";
				query = em.createQuery(sql);
				query.setParameter(1,Utils.ConvertStrToDate(startdt));
				query.setParameter(2,Utils.ConvertStrToDate(enddt));
				//int scheduleid = (Integer)query.getSingleResult();
				StringBuffer canschedule = new StringBuffer();
				StringBuffer canids = new StringBuffer();
				List<Schedule> scList = query.getResultList();
				Iterator scItr = scList.iterator();
				if (scItr.hasNext())
				{
					while(scItr.hasNext()){
					Schedule sc = (Schedule)scItr.next();
					int totcan=0,totappear=0,totpassed=0,totfailed=0,totabsent=0,grossamt=0;
					float grandtot = 0,totamtcollected=0;
					out.print("<table border='0' cellspacing='1' cellpadding='1'>");
					out.print("<tr> ");
					out.print("<th>Sr. No.</th>");
					out.print("<th>Date of Test</th>");
					out.print("<th>Test Time</th>");
					out.print("<th>No. of<BR>Candidates<BR>Registered</th>");
					out.print("<th>No. of<BR>Candidates<BR>Appeared</th>");
					out.print("<th>No. of<BR>Candidates<BR>Passed</th>");
					out.print("<th>No. of<BR>Candidates<BR>Failed</th>");
					out.print("<th>No. of<BR>Candidates<BR>Absent<BR>(Whose fees <BR>are forfited)</th>");
					out.print("<th>Amount<BR>Collected</th>");
					out.print("<th>Gross Amount<BR>due to BSE <BR>@ Rs. 150 per <BR>candidate appeared <BR>for the test & <BR>@ Rs. 550 per <BR>candidate absent <BR>for the test</th>");
					out.print("</tr>");
					///////////////////////////////////////
					
					//Schedules falling in this month
					sql = "SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<=?2 AND s.scheduleDate <= CURRENT_DATE";
					query = em.createQuery(sql);
					query.setParameter(1,Utils.ConvertStrToDate(startdt));
					query.setParameter(2,Utils.ConvertStrToDate(enddt));
					scList = query.getResultList();
					for(Schedule sc1:scList){
						canschedule.append(sc1.getScheduleId());
						canschedule.append(",");
					}
					String candList = canschedule.toString().substring(0,canschedule.length()-1);
					//log.info("candList :"+candList);
	
					//candidates registered for those Schedules for this client
					//sql = "SELECT CandidateID FROM CandidateMaster WHERE ScheduleID IN (" + candList + ") AND ClientID=" + ClientID;
					sql = "SELECT cm FROM Candidatemaster cm WHERE cm.scheduleId IN ("+candList+") AND cm.clientId=?1";
					query = em.createQuery(sql);
					query.setParameter(1, Integer.parseInt(ClientID));
					List<Candidatemaster> cmList = query.getResultList();
					for(Candidatemaster cm:cmList){
						canids.append(cm.getCandidateId());
						canids.append(",");
					}
					String candIDS = canids.toString().substring(0,canids.length()-1);
					//log.info("candIDS :"+candIDS);
	
					///////////////////////////////////////////////
					
					//Details of all those candidates 
					sql = "SELECT cm FROM Candidatemaster cm WHERE cm.candidateId IN (" + candIDS + ") and cm.clientId=?1 and cm.candidateId >3 and cm.scheduleId>0 GROUP BY cm.scheduleId ORDER BY cm.scheduleId,cm.firstName";
					query = em.createQuery(sql);
					query.setParameter(1, ClientID);
					cmList = query.getResultList();
					int count=1;
					int ScheduleID = 0;
					int ExamID = 0;
					int SectionID = 0;
					float TotalAmount = 0;
					float PresentAmount = 0;
					float AbsentAmount = 0;
	
					String timefrom = null;
					String timeto = null;
					Date ExamDate = null;
	//out.println(sql);	
					Iterator cmItr = cmList.iterator();
					if(cmItr.hasNext())
					{
						for(Candidatemaster cm:cmList)
						{
							timefrom = "";
							timeto = "";
							int NumberTotal = 0;
							int NumberPresent = 0;
							int NumberAbsent = 0;
							ScheduleID = cm.getScheduleId();
							cid = cm.getCandidateId();
							scDAO = new ScheduleDAO();
							sc = scDAO.findById(ScheduleID);
							timefrom 	= sc.getTimeFrom();
							timeto   	= sc.getTimeTo();
							SectionID 	= sc.getSectionId();
							ExamDate 	= sc.getScheduleDate();
							sql = "Select cd.examId from Candidatedetails cd WHERE cd.candidateId=?1";
							query = em.createQuery(sql);
							query.setParameter(1, cid);
							ExamID = (Integer) query.getSingleResult();
							if (timefrom != "" && timefrom != null)
								timefrom = timefrom.substring(0, 5);
							if (timeto != "" && timeto != null)
								timeto = timeto.substring(0, 5);
		
							out.print("<tr> ");
							out.print("<td align='right'>" +count+ "&nbsp;</td>");
							out.print("<td align='center'>" +Utils.ConvertDateToString(ExamDate)+ "&nbsp;</td>");
							out.print("<td align='center'>" +timefrom+ " - " +timeto+ "</td>");
							sql = "Select count sr.scheduleId from Slotregisteration sr WHERE sr.scheduleId=?1";
							query = em.createQuery(sql);
							query.setParameter(1, ScheduleID);
							Number schedid = (Number) query.getSingleResult();
							NumberTotal = schedid.intValue();
							out.print("<td align='right'>" +NumberTotal+ "&nbsp;</td>");
							totcan = totcan+NumberTotal;
							sql = "Select count sr.scheduleId from Slotregisteration sr WHERE Attended=1 AND sr.scheduleId=?1";
							query = em.createQuery(sql);
							query.setParameter(1, ScheduleID);
							Number schedidpr = (Number) query.getSingleResult();
							NumberPresent = schedidpr.intValue();
							out.print("<td align='right'>" +NumberPresent+ "&nbsp;</td>");
							totappear = totappear + NumberPresent;
							sql = "Select COUNT(DISTINCT(npm.candidateId)) from Newperformancemaster npm WHERE npm.candidateId IN (SELECT s.scheduleId FROM Schedule s WHERE s.scheduleDate LIKE ?1% AND s.scheduleDate <= CURRENT_DATE) AND npm.examId=?2 AND SectionID=?3 AND Date=?4 AND Result=1";
							query = em.createQuery(sql);
							query.setParameter(1, wild_month_year);
							query.setParameter(2, ExamID);
							query.setParameter(3, SectionID);
							query.setParameter(4, ExamDate);
							Number schedtemp = (Number) query.getSingleResult();
							int temp = schedtemp.intValue();
							out.print("<td align='right'>" +temp+ "&nbsp;</td>");
							totpassed += temp;
							sql = "Select COUNT(DISTINCT(npm.candidateId)) from Newperformancemaster npm WHERE npm.candidateId IN (SELECT s.scheduleId FROM Schedule s WHERE s.scheduleDate LIKE ?1% AND s.scheduleDate <= CURRENT_DATE) AND npm.examId=?2 AND SectionID=?3 AND Date=?4 AND Result=0";
							query = em.createQuery(sql);
							query.setParameter(1, wild_month_year);
							query.setParameter(2, ExamID);
							query.setParameter(3, SectionID);
							query.setParameter(4, ExamDate);
							Number schedfail = (Number) query.getSingleResult();
							int temp1 = schedfail.intValue();
							out.print("<td align='right'>" +temp+ "&nbsp;</td>");
							totfailed += temp;
							sql = "Select count sr.scheduleId from Slotregisteration sr WHERE sr.attended=0 AND sr.scheduleId=?1";
							query = em.createQuery(sql);
							query.setParameter(1, ScheduleID);
							Number schedAbsent = (Number) query.getSingleResult();
							NumberAbsent = schedAbsent.intValue();
							out.print("<td align='right'>" +NumberAbsent+ "&nbsp;</td>");
							totabsent += NumberAbsent;
							String Criteria = "";
							sql = "SELECT rs FROM Revenuesharing rs WHERE Client='BSE'";
							query = em.createQuery(sql);
							List<Revenuesharing> rsList = query.getResultList();
							for(Revenuesharing rs:rsList)
							{
								TotalAmount = rs.getAmount();
								Criteria = rs.getCriteria();
								PresentAmount =0;
								AbsentAmount =0;
								if (Criteria.equalsIgnoreCase("Present")){
									PresentAmount = rs.getClientShare();
								}
								else if (Criteria.equalsIgnoreCase("Absent")){
									AbsentAmount = rs.getClientShare();
								}
							}
							float dueAmount = 0;
							dueAmount = (NumberPresent * 150) + (NumberAbsent * 550);
							float cal = (NumberTotal * TotalAmount);
							totamtcollected += cal;
							grossamt += dueAmount;
							grandtot += dueAmount;
							out.print("<td align='right'>&nbsp;" +(NumberTotal * TotalAmount)+ "</td>");
							out.print("<td align='right'>" + dueAmount+ " &nbsp;</td>");
							out.print("</tr>");
		//					out.println(NumberTotal + " " + TotalAmount);
							count++;
						}
						out.print("<tr><th colspan=3 align=center>Grand Total :</th>");
						out.print("<th align='right'>"+totcan+"&nbsp;</th>");
						out.print("<th align='right'>"+totappear+"&nbsp;</th>");
						out.print("<th align='right'>"+totpassed+"&nbsp;</th>");
						out.print("<th align='right'>"+totfailed+"&nbsp;</th>");
						out.print("<th align='right'>"+totabsent+"&nbsp;</th>");
						out.print("<th align='right'>"+totamtcollected+"&nbsp;</th>");
						out.print("<th align='right'>"+grandtot+"&nbsp;&nbsp</th></tr>");
						out.println("<TR><Th COLSPAN=11 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR></TABLE>");
					}
				}
				}
				else{
					out.println("<h4>No Exams were conducted during this month.</h4>");
				}
			}catch(Exception e){
				out.print("EXCEPTION occured while creating Report.<BR>"+e);
			}
	
			 out.print("</table>");
			 out.print("</form>");
			 out.print("</div>");
			 out.print("<p align=center>&nbsp;</p>");
	//		 out.print("<input type=Button Value='Go Back' onclick='history.back();'>");	
		}else if (action.equals("overall")){
			//display_css(req,res);
			//overal_report(req,res);
		}
		else if (action.equals("doBSEMomthlyReport")){
			
//			out.print("<b>Overall Performance Report</b>");
			out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
			String questionType=null;
			out.print("<div align='center'> ");
			out.print("</tr>");
			int month = Integer.parseInt(request.getParameter("month"));
			int year = Integer.parseInt(request.getParameter("year"));
			String startdt = year + "-" + month + "-" + 1 ;
			String enddt = year + "-" + (month+1) + "-" + 1 ;
			wild_month_year = year+"-"+month;
			
			//log.info("startdt 3:"+startdt);
			//log.info("enddt 4:"+enddt);
			String ClientID = "" + session.getAttribute("ClientID");
			//log.info("ClientID 5:"+ClientID);
			
			
			// Check for schedule for the particular month		
				sql = "SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<=?2 and s.scheduleDate <= CURRENT_DATE ORDER BY s.scheduleDate ";
				query = em.createQuery(sql);
				query.setParameter(1,Utils.ConvertStrToDate(startdt));
				query.setParameter(2,Utils.ConvertStrToDate(enddt));
				StringBuffer canschedule = new StringBuffer();
				List<Schedule> scList = query.getResultList();
				Iterator sclistItr = scList.iterator();
				if(sclistItr.hasNext())
				{
					Schedule sc = (Schedule)sclistItr.next();
					int totcan=0,totappear=0,totpassed=0,totfailed=0,totabsent=0,grossamt=0;
					float grandtot = 0,totamtcollected=0;
					out.println("<br><br><font color=blue family=gorgia size=3>Monthly Summary Statement</font><HR><BR>");
					out.print("<form name='form1' method='post' action=''>");
					out.print("<table border='0' cellspacing='1' cellpadding='1'>");
					out.print("<tr> ");
					out.print("<th>Sr. No.</th>");
					out.print("<th>Centre Name</th>");
	//				out.print("<th>Date of Test</th>");
	//				out.print("<th>Test Time</th>");
					out.print("<th>No. of<BR>Candidates<BR>Registered</th>");
					out.print("<th>No. of<BR>Candidates<BR>Appeared</th>");
					out.print("<th>No. of<BR>Candidates<BR>Passed</th>");
					out.print("<th>No. of<BR>Candidates<BR>Failed</th>");
					out.print("<th>No. of<BR>Candidates<BR>Absent<BR>(Whose fees <BR>are forfited)</th>");
					out.print("<th>Amount<BR>Collected</th>");
					out.print("<th>Gross Amount<BR>due to BSE <BR>@ Rs. 150 per <BR>candidate appeared <BR>for the test & <BR>@ Rs. 550 per <BR>candidate absent <BR>for the test</th>");
	
	//Get ScheduleID for the Current Month
					sql = "SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<=?2  and s.scheduleDate <= CURRENT_DATE ORDER BY s.scheduleDate ";
					query = em.createQuery(sql);
					query.setParameter(1,Utils.ConvertStrToDate(startdt));
					query.setParameter(2,Utils.ConvertStrToDate(enddt));
					scList = query.getResultList();
					for(Schedule sc1:scList)
					{
						canschedule.append(sc1.getScheduleId());
						canschedule.append(",");
					}
					String scidList = canschedule.toString().substring(0,canschedule.length()-1);
					log.info("scidList 6:"+scidList);
	
	//rs for number of clients where test was conducted
					//sql = "SELECT cm FROM Candidatemaster cm WHERE cm.scheduleId IN (SELECT s.scheduleId FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<=?2  and s.scheduleDate <= CURRENT_DATE) and cm.candidateId >3 and cm.scheduleId>0 and cm.clientId>0";//GROUP BY ScheduleID ORDER BY ScheduleID,FirstName 
	//out.println("<br>"+sql);
					//query = em.createQuery(sql);
					query = em.createNamedQuery("Monthly_Summary-Candidatemaster.sql2");
					query.setParameter(1,Utils.ConvertStrToDate(startdt));
					query.setParameter(2,Utils.ConvertStrToDate(enddt));
					
					log.info("Monthly_Summary startdt:"+startdt);
					log.info("Monthly_Summary enddt:"+enddt);
					
	  				int count=1;
					int ScheduleID = 0;
					int ExamID = 0;
					int SectionID = 0;
					float TotalAmount = 0;
					float PresentAmount = 0;
					float AbsentAmount = 0;
					String timefrom = null;
					String timeto = null;
					Date ExamDate = null;
					List<Candidatemaster> cmList = query.getResultList();
					//log.info("cmList:"+cmList.size());
					Iterator cmlistItr = cmList.iterator();
					//log.info("cmlistItr:"+cmlistItr.hasNext());
					if(cmlistItr.hasNext())
					{
					//log.info("cmList:"+cmList.size());
					Candidatemaster cm = (Candidatemaster)cmlistItr.next();
					timefrom = "";
					timeto = "";
					int NumberTotal = 0;
					int NumberPresent = 0;
					int NumberAbsent = 0;
					ScheduleID = cm.getScheduleId();
					cid = cm.getCandidateId();
					int clientid = cm.getClientId();
					//log.info("clientid 7:"+clientid);
					//log.info("scidList 8:"+scidList);
					sql = "SELECT cm FROM Candidatemaster cm WHERE cm.scheduleId IN ("+scidList+")";
					//log.info("sql 9:"+sql);
					query = em.createQuery(sql);
					cmList = query.getResultList();
					StringBuffer canid = new StringBuffer();
					for(Candidatemaster cm1:cmList)
					{
						canid.append(cm1.getCandidateId());
						canid.append(",");
					}
					String candIDS = canid.toString().substring(0,canid.length()-1);
					////log.info("candIDS :"+candIDS);
					sql = "SELECT cm FROM Candidatemaster cm WHERE cm.clientId="+clientid+" AND cm.candidateId IN ("+candIDS+")";
						StringBuffer can_client = new StringBuffer();
						cmList = query.getResultList();
						for(Candidatemaster cm2:cmList){
							can_client.append(cm2.getCandidateId());
							can_client.append(",");
						}
						String canForClient = can_client.toString().substring(0,can_client.length()-1);
						////log.info("NumberTotal canForClient :"+canForClient);
	
						String centrename = "";
						
						scDAO = new ScheduleDAO();
						sc = scDAO.findById(ScheduleID);
						timefrom 	= sc.getTimeFrom();
						timeto   	= sc.getTimeTo();
						SectionID 	= sc.getSectionId();
						ExamDate 	= sc.getScheduleDate();
					
						if (timefrom != "" && timefrom != null)
							timefrom = timefrom.substring(0, 5);
						if (timeto != "" && timeto != null)
							timeto = timeto.substring(0, 5);
						sql = "Select clm.clientName from Clientmaster clm WHERE clm.clientId=?1";
						query = em.createQuery(sql);
						query.setParameter(1, clientid);
						centrename = (String)query.getSingleResult();					
						sql = "Select cd.examId from Candidatedetails cd WHERE cd.candidateId=?1";
						query = em.createQuery(sql);
						query.setParameter(1, cid);
						ExamID 	= (Integer)query.getSingleResult();							
						out.print("<tr> ");
						out.print("<td align='right'>" +count+ "&nbsp;</td>");
						out.print("<td align='right'>"+centrename+"</td>");
						sql = "Select count(sr.scheduleId) from Slotregisteration sr WHERE sr.candidateId IN ("+canForClient+")";
						query = em.createQuery(sql);
						Number schedid = (Number) query.getSingleResult();
						NumberTotal = schedid.intValue();
						out.print("<td align='right'>" +NumberTotal+ "&nbsp;</td>");
						totcan = totcan+NumberTotal;
						sql = "Select count(sr.scheduleId) from Slotregisteration sr WHERE sr.attended=1 AND sr.candidateId IN ("+canForClient +")";
						query = em.createQuery(sql);
						Number schePresent = (Number) query.getSingleResult();
						NumberPresent = schePresent.intValue();
						out.print("<td align='right'>" +NumberPresent+ "&nbsp;</td>");
						totappear = totappear + NumberPresent;
						sql = "Select COUNT(npm.candidateId) from Newperformancemaster npm WHERE npm.examId=?1 AND npm.sectionId=?2 AND npm.candidateId IN ("+canForClient+") AND npm.result=1";
						query = em.createQuery(sql);
						query.setParameter(1, ExamID);
						query.setParameter(2, SectionID);
						Number schetemp = (Number) query.getSingleResult();
						int temp = schetemp.intValue();
						out.print("<td align='right'>" +temp+ "&nbsp;</td>");
						totpassed += temp;
						sql = "Select COUNT(npm.candidateId) from Newperformancemaster npm WHERE npm.examId=?1 AND npm.sectionId=?2 AND npm.candidateId IN ("+canForClient+") AND npm.result=0";
						query = em.createQuery(sql);
						query.setParameter(1, ExamID);
						query.setParameter(2, SectionID);
						schetemp = (Number) query.getSingleResult();
						temp = schetemp.intValue();
						out.print("<td align='right'>" +temp+ "&nbsp;</td>");
						totfailed += temp;
						/*sql = "Select count(sr.scheduleId) from Slotregisteration sr WHERE sr.attended=0 AND sr.scheduleId IN ("+scidList+")";
						query = em.createQuery(sql);
						//query.setParameter(1, ScheduleID);
						Number schedAbsent = (Number) query.getSingleResult();
						NumberAbsent = schedAbsent.intValue();
						out.print("<td align='right'>" +NumberAbsent+ "&nbsp;</td>");
						//totabsent += NumberAbsent;*/
						totabsent = totcan - totappear ;
						out.print("<td align='right'>" +totabsent+ "&nbsp;</td>");
						String Criteria = "";
						sql = "SELECT rs FROM Revenuesharing rs WHERE rs.client='BSE'";
						query = em.createQuery(sql);
						List<Revenuesharing> rsList = query.getResultList();
						for(Revenuesharing rs:rsList)
						{
							TotalAmount = rs.getAmount();
							Criteria = rs.getCriteria();
							PresentAmount =0;
							AbsentAmount =0;
							if (Criteria.equalsIgnoreCase("Present")){
								PresentAmount = rs.getClientShare();
							}
							else if (Criteria.equalsIgnoreCase("Absent")){
								AbsentAmount = rs.getClientShare();
							}
						}
						float dueAmount = 0;
						try{
							dueAmount = (NumberPresent * 150) + (totabsent * 550);//PresentAmount,AbsentAmount
						}catch(Exception e){}
						float cal = (NumberTotal * TotalAmount);
						totamtcollected += cal;
						out.print("<td align='right'>&nbsp;" +cal+ "&nbsp;</td>");
						grossamt += dueAmount;
						out.print("<td align='right'>" + dueAmount+ " &nbsp;</td>");
						out.print("</tr>");
						count++;
						grandtot += dueAmount;
						out.println("<!--  DUE AMOUNT : " + dueAmount + " -->");
						}
					//}
					out.print("<tr><th colspan=2 align=center>Grand Total :</th>");
					out.print("<th align='right'>"+totcan+"&nbsp;</th>");
					out.print("<th align='right'>"+totappear+"&nbsp;</th>");
					out.print("<th align='right'>"+totpassed+"&nbsp;</th>");
					out.print("<th align='right'>"+totfailed+"&nbsp;</th>");
					out.print("<th align='right'>"+totabsent+"&nbsp;</th>");
					out.print("<th align='right'>"+totamtcollected+"&nbsp;</th>");
					out.print("<th align='right'>"+grandtot+"&nbsp;&nbsp</th></tr>");
					out.println("<TR><Th COLSPAN=11 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
					
				}
				else{
					out.println("<br><br><font color=blue family=gorgia size=3>No Exams were conducted during this month.</font><HR><BR>");
					}
			 out.print("</table>");
			 out.print("</form>");
			 out.print("</div>");
			 out.print("<p align=center>&nbsp;</p>");
	//		 out.print("<input type=Button Value='Go Back' onclick='history.back();'>");	
	
		}
		
		
	
		
%>