<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper,java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ngs.gbl.RegistrationKey"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		Query query=null;
		//int cid = Integer.parseInt(request.getParameter("CandidateID"));
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		ClientmasterDAO cmDAO = new ClientmasterDAO();
		ScheduleDAO scDAO = new ScheduleDAO();
		CandidatemasterDAO cndDAO = new CandidatemasterDAO();
		Logger log = Logger.getLogger("SlotManager.jsp");
		Connection con = pool.getConnection();
		EntityManager em = EntityManagerHelper.getEntityManager();
		
		out.println("<HTML><HEAD><TITLE>Slot Availablity Chart</TITLE>");
		out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		out.println("<br><br><font color=blue family=gorgia size=3>Slot Availability Chart</font><HR><BR>");
		
		if (action == null || action == ""){
			String sql = null;
			log.info("action :"+action);
			String ClientID = (String) session.getAttribute("ClientID");
			log.info("ClientID :"+ClientID);
			try{
				
				int clientid=0;
				ClientID = "0";
				if (ClientID == null || ClientID == ""|| ClientID.equals("0")){
						try{
      						out.println("<div align='center'>");
							out.println("<form action=" +request.getRequestURI()+ " method='POST'>");
					
							out.println("<input type=hidden name='action' value='slotListBSE'>");
							
							out.println("<table border='0' cellspacing='1' cellpadding='1' "+
												"width='50%' ALIGN='CENTER'>");
							//Code Added start here
							out.println("<tr><th colspan='2'>Select Client</th></tr>");
							out.println("<tr><td align='right'>Client Name : </td>");
							out.println("<td><select name='clientId'>");
							cmDAO = new ClientmasterDAO();
							List<Clientmaster> cmList = cmDAO.findAll();
							for(Clientmaster cm:cmList)
							{
								String clientName = cm.getClientName();
								String clientId = String.valueOf(cm.getClientId());
								//log.info("clientID :"+clientId);
								//log.info("clientName :"+clientName);
								
								if (clientName.equals("") || clientName==null )
								{
									out.println("<option value='ALLClients' SELECTED>'ALLClients'</option>");
								}
								else
								out.println("<option value="+clientId+">"+clientName+"</option>");
								
							}
							out.println("<option value=0 SELECTED>ALLClients</option>");
							out.println("</select></td></tr>");
							
							//Code Added end here
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
					
							Calendar today = Calendar.getInstance();
							int year = 0, thisyear = 0;
							thisyear = today.get(Calendar.YEAR);
							for (int i=-1; i <= 1 ; i++){
								year = thisyear + i;
								out.print("<option value='" + year + "' " +
									(year == thisyear?"SELECTED":"") + ">" + 
									year + "</option>");
							}
							out.println("</select></td></tr>");
							out.println("<tr><th colspan='2'>");
							out.println("<input type='submit' name='Submit' value='Submit'>");
							out.println("</th>");
							out.println("</tr>");
							out.println("</table>");
							out.println("</form>");
							out.println("</div>");
					        }catch(Exception e){
							 //System.out.println("Exception in display_main_sub_form Error : " + e.getMessage());
							}
					}else if (action == null || action == ""){
					ClientID = (String) session.getAttribute("ClientID");
				}else if (action.equalsIgnoreCase("slotListBSE")){
					//ClientID = request.getParameter("ClientID");
				}else{
					ClientID = "0";
				}
	
				if (ClientID == null || ClientID=="" || ClientID.equals(null) || ClientID.equals("")){
					out.println("Please, Login before checking Slot details.");
				}else{	
					clientid = Integer.parseInt(ClientID);
	
					String clname="",phone1="",phone2="",date="",timefrom="",timeto="",name="";
					int noseats=0,scheduleid=0,totreg=0;
	
					cmDAO = new ClientmasterDAO();
					Clientmaster cm = cmDAO.findById(clientid);
					clname = cm.getClientName();
					phone1 = cm.getPhone1();
					phone2 = cm.getPhone2();
					
					sql = "SELECT cpd.name FROM Contactpersonsdetails cpd WHERE cpd.clientId=?1";
					query = em.createQuery(sql);
					query.setParameter(1, clientid);
					name = (String)query.getSingleResult();
					//log.info("name :"+name);
					
	
					out.println("<TABLE BORDER=0 CAELLPADDING=1 CELLSPACING=1 WIDTH='60%'>");
					out.println("<TR><TH COLSPAN=2>Slot Availablity Datewise</TH></TR>");
					out.println("<TR><TD COLSPAN=2>");
					
					out.println("<TABLE BORDER=0 CAELLPADDING=1 CELLSPACING=1 WIDTH='100%'>");
					out.println("<TR><TH>Sr. No.</TH><TH>Test Date</TH><TH>Test Time</TH><TH>Seats Avaliable</TH></TR>");
					int count=1;
					sql = "SELECT s FROM Schedule s WHERE s.clientId=?1 ORDER BY ScheduleDate, TimeFrom, TimeTo";	//ExamID,CodeGroupID";
					query = em.createQuery(sql);
					query.setParameter(1, clientid);
					List<Schedule> scList = query.getResultList();
					for(Schedule sc:scList){
						timefrom = sc.getTimeFrom();
						timefrom = timefrom.substring(0,5);
						timeto = sc.getTimeTo();
						timeto = timeto.substring(0,5);
						String time = timefrom + " - " + timeto;
						noseats = sc.getNoOfSeats();
						date = Utils.ConvertDateToString(sc.getScheduleDate());
	
						scheduleid = sc.getScheduleId();
	
						sql = "SELECT count scheduleId FROM Slotregisteration sr WHERE sr.scheduleId=?1";
						query = em.createQuery(sql);
						query.setParameter(1, scheduleid);
						Number totregNum =(Number)query.getSingleResult();
						totreg = totregNum.intValue();
						int availseats = 0;
						//log.info("noseats :"+noseats);
						//log.info("totreg :"+totreg);
						availseats = noseats-totreg;
						//log.info("availseats :"+availseats);
						out.println("<TR><TD ALIGN=RIGHT>"+count+"</TD><TD ALIGN=CENTER>"+date+"</TD><TD ALIGN=CENTER>"+time+"</TD><TD ALIGN=CENTER>"+availseats+"</TD></TR>");
						count++;
					}
					out.println("</TABLE>");
					out.println("</TD></TR>");
					out.println("<TR><Th COLSPAN=2>&nbsp;</Th></TR>");
					out.println("</TABLE>");
				}
			}catch(Exception e){
				//out.println("Error : " + e.getMessage());
				e.printStackTrace();
			}finally{
				
			}
		}else if (action.equalsIgnoreCase("slotListBSE")){
				try
				{
				String sql = "",passVar="";
				log.debug("Display");
				Date newDate=null;
				//String ScheduleDate = request.getParameter("ScheduleDate");
				int ClientID = Integer.parseInt(request.getParameter("clientId"));
				//log.info("ClientID  :"+ClientID);
				/*if(!ScheduleDate.equals("pass"))
				{
				SimpleDateFormat sdfSource =new SimpleDateFormat("yyyy-MM-dd");
				newDate = (Date)sdfSource.parse(ScheduleDate);
				SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
				ScheduleDate = sdfDest.format(newDate);
				}
				//log.info("ScheduleDate  :"+ScheduleDate);*/
				
				Calendar today = Calendar.getInstance();
				int month = Integer.parseInt(request.getParameter("month"));//today.get(Calendar.MONTH);
				month++;
				log.warn(" month :"+month);
				String mth = "";
				if (month<10)
				{
					mth = "0" + month;
				}
				else
					mth = "" + month;
				int year = today.get(Calendar.YEAR);
				String strstartdt = year + "-" + (month-1) + "-" + 1 ;
				String strenddt = year + "-" + month + "-" + 1 ;
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
				
				int count=1;
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<BR></BR>");
				out.println("<TR><TH COLSPAN=9>SCHEDULE FOR TRAINING PROGRAME</TH></TR>");
				//List<Schedule> newscList = Utils.removeDuplicates(scList);
				out.println("<TR><TH>Sr. No.</TH><TH>Client Name</TH><TH>Exam Name</TH><TH>Schedule Date</TH><TH>From Time</TH><TH>To Time</TH><TH>Total Seats</TH><TH>Registered Seats</TH><TH>Seats Available</TH></TR>");
				if(flag)
				{
					//log.info("Scheduled obj ClientID");	
					List<Object[]> objList = query.getResultList();
					
					for(Object[] obj:objList)
					{
							//log.info("Scheduled ClientID:"+(Integer)obj[2]);	
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
							
							//sql = "SELECT count sr.scheduleId FROM Slotregisteration sr WHERE sr.scheduleId=?1";
							query = em.createNamedQuery("SlotRegistration-Slotregisteration.sql1");
							query.setParameter(1, (Integer)obj[0]);
							Number totregNum =(Number)query.getSingleResult();
							int totreg = totregNum.intValue();
							int availseats = 0;
							int noseats = (Integer)obj[7];
							//log.info("noseats"+noseats);
							//log.info("totreg"+totreg);
							availseats = noseats-totreg;
							//log.info("availseats :"+availseats);
							out.println("<TD align=center>" + strScheduleDate + "</TD><TD align=center>" + timefrom + 
									"</TD><TD align=center>" + timeto + 
									"</TD><TD align=center>" + noseats + "</TD>"+
									"</TD><TD align=center>" + totreg + "</TD>"+
									"</TD><TD align=center>" + availseats + "</TD></TR>");
							count++;
						}
				}
				else
				{
					scList = query.getResultList();
					for(Schedule sc:scList)
					{
							////log.info("...............................Scheduled ClientID:"+sc.getClientId());	
							out.println("<TR><TD>"+count+"</TD>");
							sql = "SELECT cm.clientName FROM Clientmaster cm WHERE cm.clientId=?1";
							query = em.createQuery(sql);
							query.setParameter(1, sc.getClientId());
							String clientName = (String)query.getSingleResult();
							out.println("<TD>"+clientName+"</TD>");
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
							//sql = "SELECT count scheduleId FROM Slotregisteration sr WHERE sr.scheduleId=?1";
							//query = em.createQuery(sql);
							query = em.createNamedQuery("SlotRegistration-Slotregisteration.sql1");
							query.setParameter(1,sc.getScheduleId());
							Number totregNum =(Number)query.getSingleResult();
							int totreg = totregNum.intValue();
							int availseats = 0;
							int noseats = sc.getNoOfSeats();
							//log.info("noseats :"+noseats);
							//log.info("totreg :"+totreg);
							availseats = noseats-totreg;
							//log.info("availseats :"+availseats);
							out.println("<TD align=center>" + strScheduleDate + "</TD><TD align=center>" + timefrom + 
									"</TD><TD align=center>" + timeto + 
									"</TD><TD align=center>" + noseats + "</TD>"+
									"</TD><TD align=center>" + totreg + "</TD>"+
									"</TD><TD align=center>" + availseats + "</TD></TR>");
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
		out.println("</BODY></HTML>");
		
		
		
%>