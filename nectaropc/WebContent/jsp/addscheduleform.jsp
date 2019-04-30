<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
	Vector vlocationid = new Vector();Connection con = null;
	String ClientID="",ClientName="";
	int ScheduleID=0,ExamID=0,SectionID=0,TimeFrom=0,TimeTo=0,NoOfSeats=0,examid=0;
	java.util.Date ScheduleDate=null;
	Logger log = Logger.getLogger("addscheduleform.jsp");
	EntityManager em = EntityManagerHelper.getEntityManager();
	int cid = 0,lid=0,clientid=0;
	int totLic=0,totReg=0;
	Query query=null;
	
	String action = request.getParameter("action");
	
	if (action == null || action == "")
	{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
			con = pool.getConnection();
		
			response.setContentType("text/html");
			out.println("<HTML><HEAD><TITLE>Registration Form</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
					
		    query = em.createNamedQuery("AddScheduleForm-ScheduleId.sql1");
		    Number result = (Number) query.getSingleResult();
		    ScheduleID = result.intValue() + 1;
			//log.debug("Addscheduleform ScheduleID :"+ScheduleID);
			
			out.println("<FORM METHOD=POST NAME=form1 action=\"addscheduleform.jsp\">");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<BR></BR>");
			out.println("<TR><TH COLSPAN=4>SCHEDULE FORM FOR TRAINING PROGRAME</TH></TR>");
			out.println("<TR><TD align=right>Schedule Date :</TD><TD><SELECT NAME=sdate>");
			for (int i=1;i<=31 ;i++ )
			{
				if (i<10)
				{
					out.println("<OPTION VALUE=0"+i+">"+i+"</OPTION>");
				}
				else
				out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT>-<SELECT NAME=smonth>");
			out.println("<OPTION VALUE=01>Jan</OPTION>");
			out.println("<OPTION VALUE=02>Feb</OPTION>");
			out.println("<OPTION VALUE=03>Mar</OPTION>");
			out.println("<OPTION VALUE=04>Apr</OPTION>");
			out.println("<OPTION VALUE=05>May</OPTION>");
			out.println("<OPTION VALUE=06>Jun</OPTION>");
			out.println("<OPTION VALUE=07>Jul</OPTION>");
			out.println("<OPTION VALUE=08>Aug</OPTION>");
			out.println("<OPTION VALUE=09>Sep</OPTION>");
			out.println("<OPTION VALUE=10>Oct</OPTION>");
			out.println("<OPTION VALUE=11>Nov</OPTION>");
			out.println("<OPTION VALUE=12>Dec</OPTION>");
			out.println("</SELECT>-<SELECT NAME=syear>");
			for (int i=2014;i<=2020 ;i++ )
			{
				out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT></TD>");	
			out.println("<TD align=right>Client Name :</TD><TD><SELECT NAME=ClientID>");
			
			//query = em.createNamedQuery("AddScheduleForm-Clientmaster.sql2");
			ClientmasterDAO cmDAO = new ClientmasterDAO();
			List<Clientmaster> cmList = cmDAO.findAll();
			//List<Clientmaster> cmList = (List<Clientmaster>)query.getResultList();
			for(Clientmaster cm:cmList)
			{
				clientid = cm.getClientId();
				ClientName = cm.getClientName();
				NoOfSeats = cm.getAvailableSeats();
			
				if (ClientName.equals("") || ClientName==null )
				{
					out.println("<OPTION VALUE=100 SELECTED>'All Clients'</OPTION>");
				}
				else
					out.println("<OPTION VALUE="+clientid+">"+ClientName+"</OPTION>");
			}
			out.println("<option value=100 SELECTED>ALLClients</option>");
			out.println("</SELECT></TD></TR>");
			out.println("<TR><TD ALIGN=RIGHT>From Time :</TD><TD ALIGN=LEFT><SELECT NAME=fromhrs>");
			for (int i=1;i<25 ; i++)
			{
				if (i==13)
				{
					out.println("<OPTION VALUE="+i+" SELECTED>"+i+"</OPTION>");
				}
				else
					out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT>hr &nbsp <SELECT NAME=frommin><OPTION VALUE=00>00</OPTION>");
			for (int i=15;i<=60 ; i=i+15)
			{
				out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT>min</TD>");

			out.println("<TD ALIGN=RIGHT>To Time :</TD><TD ALIGN=LEFT><SELECT NAME=tohrs>");
			for (int i=1;i<25 ; i++)
			{
				if (i==16)
				{
					out.println("<OPTION VALUE="+i+" SELECTED>"+i+"</OPTION>");
				}
				else
					out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT>hr &nbsp <SELECT NAME=tomin><OPTION VALUE=00>00</OPTION>");
			for (int i=15;i<=60 ; i=i+15)
			{
				out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
			}
			out.println("</SELECT>min</TD></TR>");
			String testname = "";
			examid = 0;
			out.println("<TR><TD align=center COLSPAN=4>Test Name :<SELECT NAME=ExamID>");
			query = em.createNamedQuery("AddScheduleForm-NewexamdetailsId.sql3");
			//System.out.println(":query:"+query);
			List<Newexamdetails> nxdList = query.getResultList();
			for(Newexamdetails nxid:nxdList)
			{
				examid = nxid.getExamId();
				//System.out.println(":examid:"+examid);
				testname = nxid.getTestName();
				if(examid==10531)
				{
					out.println("<OPTION VALUE="+examid+" SELECTED>"+testname+"</OPTION>");
				}
				else
					out.println("<OPTION VALUE="+examid+">"+testname+"</OPTION>");
			}
			out.println("</SELECT></TD></TR>");

			out.println("<TR><TH COLSPAN=4><FONT COLOR=red>*</FONT> Indicates compulsory Fields !!</TH></TR>");

			out.println("<TR><TH COLSPAN=4><INPUT TYPE=Submit VALUE=Submit>&nbsp;<INPUT TYPE=RESET VALUE=Reset>&nbsp;<INPUT TYPE=BUTTON VALUE=Back onclick='javascript:history.back();'></TH><TR>");
			out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doAdd'>");
			out.println("</TABLE>");
			out.println("</FORM>");
			out.println("</BODY></html>");
			out.println("<BR></BR>");
			
			String msg = request.getParameter("msg");
			String ReqScheduleDate = request.getParameter("ReqScheduleDate");
			if(msg!=null && ReqScheduleDate!=null)
			out.println("<H4><FONT COLOR=red>Schedule is already available for date :"+ReqScheduleDate+"</FONT></H4>");
		}
		else if (action.equals("doAdd"))
		{
			System.err.println("RegistrationForm:  before doPost");
			String sql = null,errorstr="",sdate="",smonth="",syear="",fromhrs="",frommin="",tohrs="",tomin="";
			ClientID = request.getParameter("ClientID");
			System.err.println("ScheduleTime 1:ClientID"+ClientID);
			sdate = request.getParameter("sdate");
			smonth = request.getParameter("smonth");
			syear = request.getParameter("syear");
			fromhrs = request.getParameter("fromhrs");
			frommin = request.getParameter("frommin");
			tohrs = request.getParameter("tohrs");
			tomin = request.getParameter("tomin");
			examid = Integer.parseInt(request.getParameter("ExamID"));
			query=null;ClientmasterDAO cmDAO = new ClientmasterDAO();
			ScheduleDAO scDAO = new ScheduleDAO();
			
			if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
			{
				response.sendRedirect("../jsp/Login.jsp");
			}
			else
				clientid = Integer.parseInt(ClientID);
				//log.info("clientid :"+clientid);
				
			String scdate = "" + syear + "-" + smonth + "-" + sdate;
		
//			  out.println("<br>date : " + scdate);//delete from Schedule where ScheduleId>5
			int seats = 0;
			String tempfrom = ""+fromhrs + ":" + frommin +":00";
			String tempto = ""+tohrs + ":" + tomin + ":00";
			//log.info("tempfrom :"+tempfrom);
			//log.info("tempto :"+tempto);
			int nextscheduleID=0,sectionid=0;
			boolean val=false;
			List<Schedule> scList=null;
			
			
			
			com.ngs.gen.NextValues scheduleID    =   new com.ngs.gen.NextValues("Schedule", "ScheduleID");
			nextscheduleID  =  scheduleID.getNextValue();
	
			try
			{
				
				ScheduleDate = Utils.ConvertStrToDate(scdate);
				//log.info("ScheduleDate :"+ScheduleDate);
				
				int allClientID=0;
				int count=0,confirm=0;
				int rsClientID=0;Schedule sid =null;
				if(clientid==100)
				{
					List<Clientmaster> cmList = cmDAO.findAll();
					for(Clientmaster cm:cmList)
					{
						allClientID = cm.getClientId();
						//log.info("clientid->>>>>>>clientid :"+clientid);
						sql = "SELECT s FROM Schedule s where s.scheduleDate=?1 and s.clientId =?2";
						query = em.createQuery(sql);
						//query = em.createNamedQuery("AddScheduleForm-ScheduleId.sql4");
						query.setParameter(1, Utils.ConvertStrToDate(scdate));
						query.setParameter(2, allClientID);
						scList= query.getResultList();
						Iterator scItr = scList.iterator();
						if(scItr.hasNext())
						{
							//log.info("clientid==100,Schedule is available"+scdate+"request.getRequestURI()"+request.getRequestURI());
							response.sendRedirect(request.getRequestURI()+"?msg=showAllClient&ReqScheduleDate="+scdate);
						}else
						{
								//log.info("clientid==100,Schedule Training Program"+cm.getClientId());
								ClientmasterDAO clmDAO = new ClientmasterDAO();
								Clientmaster clm = clmDAO.findById(cm.getClientId());
								NoOfSeats = clm.getAvailableSeats();
								rsClientID = clm.getClientId();
								EntityManagerHelper.beginTransaction();
								Schedule scid = new Schedule();
								scid.setScheduleId(nextscheduleID);
								scid.setClientId(rsClientID);
								scid.setExamId(examid);
								scid.setSectionId(sectionid);
								scid.setScheduleDate(ScheduleDate);
								scid.setTimeFrom(tempfrom);
								scid.setTimeTo(tempto);
								scid.setNoOfSeats(NoOfSeats);
								scDAO.save(scid);
								EntityManagerHelper.commit();
								nextscheduleID++;
								val    =    scheduleID.setNextValue();
								//log.info("clientid==100,val :"+val);
								//log.info("clientid==100,nextscheduleID :"+nextscheduleID);
						}
					}
				}///closing of if(clientid==100)
				else
				{
						//log.info("clientid=="+clientid+",Schedule Training Program");
						sql = "SELECT s FROM Schedule s where s.scheduleDate=?1 and s.clientId =?2";
						query = em.createQuery(sql);
						//query = em.createNamedQuery("AddScheduleForm-ScheduleId.sql5");
						query.setParameter(1, Utils.ConvertStrToDate(scdate));
						query.setParameter(2, clientid);
						scList= query.getResultList();
						Iterator scItr = scList.iterator();
						if(scItr.hasNext())
						{
							//log.info("clientid->>>>>>>Schedule is available"+scdate+"request.getRequestURI()"+request.getRequestURI());
							response.sendRedirect(request.getRequestURI()+"?msg=showClient&ReqScheduleDate="+scdate);
						}else
						{
								//log.info("sid is null");
								ClientmasterDAO clmDAO = new ClientmasterDAO();
								Clientmaster clm = clmDAO.findById(clientid);
								NoOfSeats = clm.getAvailableSeats();
								rsClientID = clm.getClientId();
								EntityManagerHelper.beginTransaction();
								Schedule scid = new Schedule();
								scid.setScheduleId(nextscheduleID);
								scid.setClientId(rsClientID);
								scid.setExamId(examid);
								scid.setSectionId(sectionid);
								scid.setScheduleDate(ScheduleDate);
								scid.setTimeFrom(tempfrom);
								scid.setTimeTo(tempto);
								scid.setNoOfSeats(NoOfSeats);
								scDAO.save(scid);
								EntityManagerHelper.commit();
								nextscheduleID++;
								val    =    scheduleID.setNextValue();
								//log.info("clientid==100,val :"+val);
								//log.info("clientid==100,nextscheduleID :"+nextscheduleID);
							}
						
						}///end of if(clientid==100)
				
						if (scList.isEmpty())
						{
							out.println("<br></br><br></br>");
							out.println("<div align='center'>");
							out.println("<H4><FONT COLOR=red>Schedule Sucessfully Inserted!!</font></h4>");
							out.println("</div");
		
						}
						else
						{
							out.println("Problem in Inserting in Schedule !!");
						}
	
			  }
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
		}
			
	}
		
%>