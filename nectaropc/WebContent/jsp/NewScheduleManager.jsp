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
		Logger log = Logger.getLogger("UserDetails.jsp");
		Connection con = pool.getConnection();
		EntityManager em = EntityManagerHelper.getEntityManager();
		Vector vlocationid = new Vector();
		
		out.println("<HTML><HEAD><TITLE>Schedule Manager</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		
		try
		{
			if (action == null || action == "")
			{
				String sql = null,errorstr="";
				try
				{
					String CandidateID = request.getParameter("CandidateID");//session
					int candidateid=0,examid=0;
					if (CandidateID == null || CandidateID == "" || CandidateID.equals(null) || CandidateID.equals("")){
						candidateid = 1;}
					else
						candidateid = Integer.parseInt(CandidateID);
		
					out.println("<FORM NAME=frmAdd METHOD=POST ACTION="+request.getRequestURI()+">");
					out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
					out.println("<BR></BR><BR></BR>");
					out.println("<TR><TH COLSPAN=2>View Schedule Exam</TH></TR>");
					out.println("<TR><TD ALIGN=RIGHT>Client Name :</TD><TD ALIGN=LEFT><SELECT NAME=ClientID>");
					sql = "select distinct c.clientname,c.clientid from Clientmaster c,Schedule s"+ 
									  " where c.clientId=s.clientId and c.clientId IN"+
									  " (SELECT distinct s.clientId FROM Schedule s"+
									  " where s.scheduleDate>= CURRENT_DATE ORDER BY s.scheduleDate)";
		
					String ClientName="";
					int ClientID=0;
					query = em.createNamedQuery("NewScheduleManager-Clientmaster.sql1");
					List<Object[]> objList = query.getResultList();
					for(Object[] obj:objList)
					{
						ClientName=(String)obj[0];
						ClientID=(Integer)obj[1];
						////log.info("ClientName :"+ClientName);
						////log.info("ClientID :"+ClientID);
						out.println("<OPTION VALUE="+ClientID+">"+ClientName+"</OPTION>");
					}
					out.println("<option value="+0+" SELECTED>Please Select Client</option>");
					out.println("</SELECT></TD></TR>");
					
					out.println("<TR><TD ALIGN=RIGHT>Schedule Date :</TD><TD ALIGN=LEFT><SELECT NAME=ScheduleDate>");
					//sql = "SELECT distinct s.scheduleDate FROM Schedule s where s.scheduleDate>= CURRENT_DATE ORDER BY s.scheduleDate";
					DateFormat formatter=null; 
					String rsDate="";
					//query = em.createNamedQuery("NewScheduleManager-Schedule.sql2");
					sql= "SELECT distinct s.scheduleDate FROM Schedule s where s.scheduleDate>=CURRENT_DATE ORDER BY s.scheduleDate";
					query = em.createQuery(sql);
					List<Date> objList1 = query.getResultList();
					for(Date obj:objList1)
					{				
						formatter = new SimpleDateFormat("yyyy-MM-dd");
		 				rsDate = Utils.ConvertDateToString(obj);
		 				//log.info("Schedule Date :"+rsDate);
						out.println("<OPTION VALUE="+rsDate+">"+rsDate+"</OPTION>");
					}
					out.println("<option value=pass SELECTED>Please Select Schedule Date</option>");
					out.println("</SELECT></TD></TR>");
						
					Calendar mycal = Calendar.getInstance();
					int month = mycal.get(Calendar.MONTH);
					month++;
					out.println("<TR><TD ALIGN=RIGHT>Month :</TD><TD ALIGN=LEFT><SELECT NAME=month>");
					switch (month)
					{
						case 1:
							out.println("<OPTION VALUE=0 SELECTED>January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 2:
							out.println("<OPTION VALUE=0>January</OPTION><OPTION VALUE=1 SELECTED>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 3:
							out.println("<OPTION VALUE=0>January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2 SELECTED>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 4:
							out.println("<OPTION VALUE=0>January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3 SELECTED>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 5:
							out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4 SELECTED>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 6:
							out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 SELECTED>June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 7:
							out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5>June</OPTION><OPTION VALUE=6 SELECTED>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 8:
							out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7 SELECTED>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 9:
							out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8 SELECTED>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 10:
							out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9 SELECTED>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 11:
							out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10 SELECTED>November</OPTION><OPTION VALUE=11>December</OPTION>");
							break;
						case 12:
							out.println("<OPTION VALUE=0 >January</OPTION><OPTION VALUE=1>Feburary</OPTION><OPTION VALUE=2>March</OPTION><OPTION VALUE=3>April</OPTION><OPTION VALUE=4>May</OPTION><OPTION VALUE=5 >June</OPTION><OPTION VALUE=6>July</OPTION><OPTION VALUE=7>August</OPTION><OPTION VALUE=8>September</OPTION><OPTION VALUE=9>October</OPTION><OPTION VALUE=10>November</OPTION><OPTION VALUE=11 SELECTED>December</OPTION>");
							break;
					}
					out.println("</SELECT></TD></TR>");
					out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Submit><INPUT TYPE=HIDDEN NAME=action VALUE='doDisplay'><INPUT TYPE=HIDDEN NAME=examid VALUE="+examid+"></TH></TR>");
					out.println("</TABLE>");
					out.println("</FORM>");
					out.println("</BODY>");
					out.println("</HTML>");
				}
				catch(Exception e)
				{
					out.println("Add Mod Error : " + e.getMessage());
				}
				finally
				{
					
				}
			}
			else if (action.equals("doDisplay"))
			{
				try
					{
					String sql = "",passVar="";
					//log.debug("Display");
					Date newDate=null;
					int ClientID=0;
					String ScheduleDate = request.getParameter("ScheduleDate");
					ClientID = Integer.parseInt(request.getParameter("ClientID"));
					//log.info("ClientID  :"+request.getParameter("ClientID"));
					if(!ScheduleDate.equals("pass"))
					{
					SimpleDateFormat sdfSource =new SimpleDateFormat("yyyy-MM-dd");
					newDate = (Date)sdfSource.parse(ScheduleDate);
					SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
					ScheduleDate = sdfDest.format(newDate);
					}
					//log.info("ScheduleDate  :"+ScheduleDate);
					Calendar today = Calendar.getInstance();
					int month = Integer.parseInt(request.getParameter("month"));//today.get(Calendar.MONTH);
					month++;
					//log.warn(" month :"+month);
					String mth = "";
					if (month<10)
					{
						mth = "0" + month;
					}
					else
						mth = "" + month;
					int year = today.get(Calendar.YEAR);
					String strstartdt = year + "-" + month + "-" + 1 ;
					String strenddt = year + "-" + (month+1) + "-" + 1 ;
					Date startdt = Utils.ConvertStrToDate(strstartdt);
					Date enddt = Utils.ConvertStrToDate(strenddt);
					//log.info("Display startdt :"+startdt);
					//log.info("Display enddt :"+enddt);
					em.clear();
					List<Schedule> scList = null;
					boolean flag=false;
					/*if (ClientID > 0)
					{
						//log.info("in clientid>0");
						sql = "SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and  s.scheduleDate<?2 " +
						  "and s.clientId = ?3 ORDER BY s.scheduleDate";
						query = em.createQuery(sql);
						query.setParameter(1,startdt);
						query.setParameter(2,enddt);
						query.setParameter(3,ClientID);
						scList = query.getResultList();
					}*/
					if(!ScheduleDate.equals("pass"))
					{
						//log.info("in !ScheduleDate==pass clientid>0");
						if (ClientID > 0)
						{
							//log.info("in !ScheduleDate==pass ");
							sql = "SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and  s.scheduleDate<?2 " +
								  "and s.clientId = ?3 ORDER BY s.scheduleDate";
							query = em.createQuery(sql);
							query.setParameter(1,startdt);
							query.setParameter(2,enddt);
							query.setParameter(3,ClientID);
						}
						else
						{
							//log.info("in else !ScheduleDate==pass clientid>0");
							sql = "SELECT s FROM Schedule s WHERE s.scheduleDate=?1" +
							      "ORDER BY s.scheduleDate";
							query = em.createQuery(sql);
							query.setParameter(1,Utils.ConvertStrToDate(ScheduleDate));
						}
						
					}
					else
					{
						//log.info("In else ScheduleDate  ClientID:"+ClientID);
						if (ClientID > 0)
						{
							//log.info("In ClientID > 0");
							/*sql = "SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and  s.scheduleDate<?2 " +
							  "and s.clientId = ?3 ORDER BY s.scheduleDate";
							query = em.createQuery(sql);*/
							query = em.createNamedQuery("NewScheduleManager-Schedule.sql4");
							query.setParameter(1,startdt);
							query.setParameter(2,enddt);
							query.setParameter(3,ClientID);
						}
						else
						{
							flag = true;
							//log.info("In else ClientID == 0 flag :"+flag);
							sql = "SELECT s.scheduleId,s.clientId,s.examId,s.sectionId,s.scheduleDate,s.timeFrom,s.timeTo,s.noOfSeats "+
							      "FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<?2 ORDER BY s.scheduleDate";
							//query = em.createNamedQuery("NewScheduleManager-Schedule.sql3");
							query = em.createQuery(sql);
							query.setParameter(1,startdt);
							query.setParameter(2,enddt);
							
						}
					}
					
					int count=1;
					out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
					out.println("<BR></BR>");
					out.println("<TR><TH COLSPAN=7>SCHEDULE FOR TRAINING PROGRAME</TH></TR>");
					//List<Schedule> newscList = Utils.removeDuplicates(scList);
					out.println("<TR><TH>Sr. No.</TH><TH>Client Name</TH><TH>Exam Name</TH><TH>Schedule Date</TH><TH>From Time</TH><TH>To Time</TH><TH>Number of Seats Available</TH></TR>");
					//log.info("flag :"+flag);
					if(flag)
					{
						//log.info("Scheduled obj ClientID");	
						List<Object[]> objList = query.getResultList();
						for(Object[] obj:objList)
						{
								//log.info("Scheduled ClientID:"+(Integer)obj[1]);	
								out.println("<TR><TD>"+count+"</TD>");
								sql = "SELECT cm.clientName FROM Clientmaster cm WHERE cm.clientId=?1";
								query = em.createQuery(sql);
								query.setParameter(1, (Integer)obj[1]);
								String clientName = (String)query.getSingleResult();
								//log.info("clientName :"+clientName);
								out.println("<TD>"+clientName+"</TD>");
								sql = "SELECT exm.exam FROM Exammaster exm WHERE exm.examId=?1";
								query = em.createQuery(sql);
								query.setParameter(1, (Integer)obj[2]);
								String examName = (String)query.getSingleResult();
								//log.info("examName :"+examName);
								out.println("<TD>"+examName+"</TD>");
				    			Date date = (Date)obj[4];
				    			String strScheduleDate = Utils.ConvertDateToString(date);
				    			//log.info("strScheduleDate :"+strScheduleDate);
								String timefrom = (String)obj[5];
								timefrom = timefrom.substring(0,5);
								String timeto = (String)obj[6];
								timeto = timeto.substring(0,5);
								out.println("</TD><TD align=center>" + strScheduleDate + "</TD><TD align=center>" + timefrom + "</TD><TD align=center>" + timeto + "</TD><TD align=center>" + ((Integer)obj[7]) + "</TD></TR>");
								count++;
							}
					}
					else
					{
						scList = query.getResultList();
						for(Schedule sc:scList)
						{
								//log.info("Scheduled ClientID:"+sc.getClientId());	
								out.println("<TR><TD>"+count+"</TD>");
								sql = "SELECT cm.clientName FROM Clientmaster cm WHERE cm.clientId=?1";
								query = em.createQuery(sql);
								query.setParameter(1, sc.getClientId());
								String clientName = (String)query.getSingleResult();
								out.println("<TD>"+clientName+"</TD>");
								//log.info("Scheduled exam:"+sc.getExamId());	
								sql = "SELECT exm.exam FROM Exammaster exm WHERE exm.examId=?1";
								query = em.createQuery(sql);
								query.setParameter(1, sc.getExamId());
								String examName = (String)query.getSingleResult();
								out.println("<TD>"+examName+"</TD>");
				    			Date date = sc.getScheduleDate();
				    			String strScheduleDate = Utils.ConvertDateToString(date);
								String timefrom = sc.getTimeFrom();
								timefrom = timefrom.substring(0,5);
								String timeto = sc.getTimeTo();
								timeto = timeto.substring(0,5);
								out.println("</TD><TD align=center>" + strScheduleDate + "</TD><TD align=center>" + timefrom + "</TD><TD align=center>" + timeto + "</TD><TD align=center>" + sc.getNoOfSeats() + "</TD></TR>");
								count++;
							}
					}
							
						out.println("</TABLE>");
						out.println("</BODY>");
						out.println("</HTML>");
				}
				catch(Exception e)
				{
					out.println("Add Mod Error : " + e.getMessage());
				}
				finally
				{
					
				}
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		
%>