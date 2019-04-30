import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Vector;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.log4j.Logger;

import com.ngs.EntityManagerHelper;
import com.ngs.dao.ClientmasterDAO;
import com.ngs.dao.ScheduleDAO;
import com.ngs.entity.Clientmaster;
import com.ngs.entity.NewexamdetailsId;
import com.ngs.entity.Schedule;
//import com.ngs.entity.ScheduleId;
import com.ngs.gbl.*;
import com.ngs.gen.*;
import com.ngs.security.Encrypter;
import com.ngs.security.ExpiryValidation;
import java.io.IOException;


public class AddScheduleForm extends HttpServlet
{
	Vector vlocationid = new Vector();
	String ClientID="",ClientName="";
	int ScheduleID=0,ExamID=0,SectionID=0,TimeFrom=0,TimeTo=0,NoOfSeats=0;
	Date ScheduleDate=null;
	Logger log = Logger.getLogger(AddScheduleForm.class);
	EntityManager em = EntityManagerHelper.getEntityManager();

	@SuppressWarnings("unchecked")
	public void doGet(HttpServletRequest req,HttpServletResponse res)
				throws ServletException,IOException{
			PrintWriter out = res.getWriter();
			String action = req.getParameter("action");
			HttpSession session=req.getSession(true);
			String sql="";
			int cid = 0,lid=0,clientid=0;
			int totLic=0,totReg=0;
			Query query=null;
		
		
			try{
				if (action == null || action == ""){
					res.setContentType("text/html");
					out.println("<HTML><HEAD><TITLE>Registration Form</TITLE>");
					out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
					out.println("<BODY><CENTER>");
					out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
							
				    query = em.createNamedQuery("AddScheduleForm-ScheduleId.sql1");
				    Number result = (Number) query.getSingleResult();
				    ScheduleID = result.intValue() + 1;
					log.debug("Addscheduleform ScheduleID :"+ScheduleID);
					
					out.println("<FORM METHOD=POST NAME=form1 action=\"../servlet/AddScheduleForm\">");
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
					for (int i=2012;i<=2020 ;i++ )
					{
						out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
					}
					out.println("</SELECT></TD>");	
					out.println("<TD align=right>Client Name :</TD><TD><SELECT NAME=ClientID>");
					
					query = em.createNamedQuery("AddScheduleForm-Clientmaster.sql2");
					List<Clientmaster> cmList = query.getResultList();
					ScheduleID = result.intValue() + 1;
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
					out.println("</SELECT>hr &nbsp <SELECT NAME=frommin><OPTION VALUE=0>00</OPTION>");
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
					out.println("</SELECT>hr &nbsp <SELECT NAME=tomin><OPTION VALUE=0>00</OPTION>");
					for (int i=15;i<=60 ; i=i+15)
					{
						out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
					}
					out.println("</SELECT>min</TD></TR>");
					String testname = "";
					int examid = 0;
					out.println("<TR><TD align=center COLSPAN=4>Test Name :<SELECT NAME=ExamID>");
					query = em.createNamedQuery("AddScheduleForm-NewexamdetailsId.sql3");
					List<NewexamdetailsId> nxidList = query.getResultList();
					for(NewexamdetailsId nxid:nxidList)
					{
						examid = nxid.getExamId();
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
					
					String msg = req.getParameter("msg");
					String ReqScheduleDate = req.getParameter("ReqScheduleDate");
					if(msg!=null && ReqScheduleDate!=null)
					out.println("<H4><FONT COLOR=red>Schedule is already available for date :"+ReqScheduleDate+"</FONT></H4>");
				}
				else
				{
					System.err.println("RegistrationForm:  before doPost");
					doPost(req,res);
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
		
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
		{
			res.setContentType("TEXT/HTML");
			PrintWriter out = res.getWriter();
			out.println("<HTML><HEAD><TITLE>Registration Confirmation</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			try
			{
				String action = req.getParameter("action");
				System.err.println("RegistrationForm:doPost  action:"+action);
				if (action.equalsIgnoreCase("doAdd"))
				{
					Add(req,res);
				}
				
			}
			catch(Exception e)
			{
				//out.println("Error : " + e.getMessage());
			}
		}
		
	public void Add(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
		{
			PrintWriter out = res.getWriter();
			String sql = null,errorstr="",sdate="",smonth="",syear="",fromhrs="",frommin="",tohrs="",tomin="";
			int clientid = 0,examid=0,cid=0,sectionid=1;
			HttpSession session=req.getSession(true);
			String ClientID = req.getParameter("ClientID");
			System.err.println("ScheduleTime 1:ClientID"+ClientID);
			sdate = req.getParameter("sdate");
			smonth = req.getParameter("smonth");
			syear = req.getParameter("syear");
			fromhrs = req.getParameter("fromhrs");
			frommin = req.getParameter("frommin");
			tohrs = req.getParameter("tohrs");
			tomin = req.getParameter("tomin");
			examid = Integer.parseInt(req.getParameter("ExamID"));
			Query query=null;ClientmasterDAO cmDAO = new ClientmasterDAO();
			ScheduleDAO scDAO = new ScheduleDAO();
			
			if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
			{
				res.sendRedirect("../jsp/Login.jsp");
			}
			else
				clientid = Integer.parseInt(ClientID);
				log.info("clientid :"+clientid);
				
			String scdate = "" + syear + "-" + smonth + "-" + sdate;
		
//			  out.println("<br>date : " + scdate);//delete from Schedule where ScheduleId>5
			int seats = 0;
			String tempfrom = ""+fromhrs + ":" + frommin +":00";
			String tempto = ""+tohrs + ":" + tomin + ":00";
			int nextscheduleID=0;
			boolean val=false;
			
			
			
			com.ngs.gen.NextValues scheduleID    =   new com.ngs.gen.NextValues("Schedule", "ScheduleID");
			nextscheduleID  =  scheduleID.getNextValue();
	
			try
			{
				SimpleDateFormat sdfSource =new SimpleDateFormat("yyyy-MMM-dd");
				Date ScheduleDate = (Date)sdfSource.parse(scdate);
				
				int allClientID=0;
				int count=0,confirm=0;
				int rsClientID=0;Schedule sid =null;
				if(clientid==100)
				{
					List<Clientmaster> cmList = cmDAO.findAll();
					for(Clientmaster cm:cmList)
					{
						allClientID = cm.getClientId();
						query = em.createNamedQuery("AddScheduleForm-ScheduleId.sql4");
						sid = (Schedule) query.getSingleResult();
						query.setParameter(scdate, scdate);
						query.setParameter(allClientID, allClientID);
						if(sid!=null)
						{
							log.info("clientid==100,Schedule is available"+scdate+"req.getRequestURI()"+req.getRequestURI());
							res.sendRedirect(req.getRequestURI()+"?msg=showAllClient&ReqScheduleDate="+scdate);
						}else
						{
								NoOfSeats = sid.getNoOfSeats();
								rsClientID = sid.getClientId();
								EntityManagerHelper.beginTransaction();
								Schedule sc = new Schedule();
								Schedule scid = new Schedule();
								scid.setScheduleId(nextscheduleID);
								scid.setClientId(rsClientID);
								scid.setExamId(examid);
								scid.setSectionId(sectionid);
								scid.setScheduleDate(ScheduleDate);
								scid.setTimeFrom(tempfrom);
								scid.setTimeTo(tempto);
								scid.setNoOfSeats(NoOfSeats);
								//sc.setId(scid);
								scDAO.save(sc);
								EntityManagerHelper.commit();
								nextscheduleID++;
								val    =    scheduleID.setNextValue();
								log.info("clientid==100,val :"+val);
								log.info("clientid==100,nextscheduleID :"+nextscheduleID);
						}
					}
				}///closing of if(clientid==100)
				else
				{
						log.info("clientid->>>>>>>clientid :"+clientid);
						query = em.createNamedQuery("AddScheduleForm-ScheduleId.sql5");
						sid = (Schedule) query.getSingleResult();
						query.setParameter(scdate, scdate);
						query.setParameter(clientid, clientid);
						if(sid!=null)
						{
							log.info("clientid->>>>>>>Schedule is available"+scdate+"req.getRequestURI()"+req.getRequestURI());
							res.sendRedirect(req.getRequestURI()+"?msg=showClient&ReqScheduleDate="+scdate);
						}else
						{
							query = em.createNamedQuery("AddScheduleForm-ScheduleId.sql6");
							sid = (Schedule) query.getSingleResult();
							query.setParameter(clientid, clientid);
							while (sid!=null)
								{
									NoOfSeats = sid.getNoOfSeats();
									rsClientID = sid.getClientId();
									EntityManagerHelper.beginTransaction();
									Schedule sc = new Schedule();
									Schedule scid = new Schedule();
									scid.setScheduleId(nextscheduleID);
									scid.setClientId(rsClientID);
									scid.setExamId(examid);
									scid.setSectionId(sectionid);
									scid.setScheduleDate(ScheduleDate);
									scid.setTimeFrom(tempfrom);
									scid.setTimeTo(tempto);
									scid.setNoOfSeats(NoOfSeats);
									//sc.setId(scid);
									scDAO.save(sc);
									EntityManagerHelper.commit();
									nextscheduleID++;
									val    =    scheduleID.setNextValue();
									log.info("clientid==100,val :"+val);
									log.info("clientid==100,nextscheduleID :"+nextscheduleID);
								}
						
						}///end of if(clientid==100)
	
				  }
				  
				if (sid==null)
				{
					out.println("Problem in Inserting in Schedule !!");

				}
				else
				{
					out.println("Schedule Sucessfully Inserted!!");
				}

			}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			EntityManagerHelper.closeEntityManager();
		}
			
	}
}
	