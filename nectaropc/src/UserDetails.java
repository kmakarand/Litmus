import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.EntityManagerHelper;
import com.ngs.dao.CandidatemasterDAO;
import com.ngs.dao.ClientmasterDAO;
import com.ngs.dao.ScheduleDAO;
import com.ngs.entity.*;
import com.ngs.gbl.*;
import com.ngs.gen.*;
import com.ngs.security.Encrypter;
import java.security.GeneralSecurityException;
import java.security.spec.KeySpec;
import java.text.SimpleDateFormat;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;

import org.apache.log4j.Logger;
import org.springframework.orm.jpa.JpaTemplate;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class UserDetails extends HttpServlet
{
	ClientmasterDAO cmDAO = new ClientmasterDAO();
	ScheduleDAO scDAO = new ScheduleDAO();
	CandidatemasterDAO cndDAO = new CandidatemasterDAO();
	
	
	@SuppressWarnings("unchecked")
	public void doGet(HttpServletRequest req,HttpServletResponse res)
		throws ServletException,IOException{
		EntityManager em = EntityManagerHelper.getEntityManager();
		Logger log = Logger.getLogger(UserDetails.class);
		HttpSession session = req.getSession(true);
		PrintWriter out = res.getWriter();
		out.println("<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\"> ");
		String action = req.getParameter("action");
		log.info("action :"+action);
		String sql="";
		Integer CandidateID = (Integer) session.getAttribute("CandidateID");
		int cid = CandidateID.intValue();
		int clientid=0;Query query = null;

		String ClientID = (String) session.getAttribute("ClientID");

		if (ClientID == null || ClientID.equals("") ||
				ClientID.equals(null) || ClientID==""){

			if (cid==0) {
				res.sendRedirect("../jsp/Login.jsp");
				return;
			}else {
				clientid=0;
			}
		}else {
			clientid = Integer.parseInt(ClientID);
		}

		if (action == null || action == ""){
			try	{
				out.println("<HTML><HEAD><TITLE>Candidate Details</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");

				// ZILS WANTS TO VIEW ALL CLIENT USER/PWD LIST
				if (clientid==0 && (cid==1 || cid==2)) {
					DisplayClientInfo(req,res);
				}else
				{
					// code for when client wants to view the report
					out.println("<FORM METHOD=POST>");
					out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
					out.println("<TR><TH COLSPAN=2><B>Select Exam Date</B></TH></TR>");
					out.println("<TR><TD ALIGN=RIGHT>Date :</TD><TD><SELECT name=ScheduleDate>");
					/*List<Schedule> arr_cust=em.createNativeQuery("SELECT distinct(ScheduleDate) FROM Schedule "+
								" WHERE ClientID=" + clientid +
								" and ScheduleDate >=CURRENT_DATE ORDER BY ScheduleDate").getResultList();*/
					query = em.createNamedQuery("Userdetails-scId1");
					query.setParameter(clientid,clientid); 
					List<Schedule> arr_cust = query.getResultList();
					out.println("List of all Candidates: "+"<br/>");
			        Date newDate=null;String ScheduleDate ="";
			        for(Schedule sc:arr_cust){
			            Date fdate = sc.getScheduleDate();
			            SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
						ScheduleDate = sdfDest.format(fdate);
						SimpleDateFormat sdfSource =new SimpleDateFormat("yyyy-MMM-dd");
						newDate = (Date)sdfSource.parse(ScheduleDate);
						out.println("<OPTION VALUE="+newDate+">"+ScheduleDate+"</OPTION>");
					}
					out.println("</SELECT></TD></TR>");
					out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Submit><INPUT TYPE=HIDDEN NAME=action VALUE=doDisplay></TH></TR>");
					out.println("</FORM>");
				}

				out.println("</BODY>");
				out.println("</HTML>");
				
			}catch(Exception e){
				out.println("Error : " + e.getMessage());
			}finally{
				
				}
		}
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res)
		throws ServletException,IOException {
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		out.println("<HTML><HEAD><TITLE>Candidate Details</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		try{
			String action = req.getParameter("action");
			if (action.equalsIgnoreCase("doDisplay")){
				Display(req,res);
			}
		}catch(Exception e){
			out.println("Error : " + e.getMessage());
		}
	}

	public void destroy(){
	}

	public void Display(HttpServletRequest req,HttpServletResponse res)
		throws ServletException,IOException{
		res.setContentType("TEXT/HTML");
		EntityManager em = EntityManagerHelper.getEntityManager();
		PrintWriter out = res.getWriter();
		String sql = null;
		try{

			HttpSession session = req.getSession(true);
			res.setContentType("text/html");

			int clientid=0;

			String ClientID = (String) session.getAttribute("ClientID");
			if (ClientID == null || ClientID.equals("") ||
					ClientID.equals(null) || ClientID==""){
				res.sendRedirect("../jsp/Login.jsp");
				return;
			}else {
				clientid = Integer.parseInt(ClientID);
			}

			Integer CandidateID = (Integer) session.getAttribute("CandidateID");
			int cid = CandidateID.intValue();

//			String date = req.getParameter("date");
//	int scheduleid = Integer.parseInt(req.getParameter("ScheduleID"));
			String scheduledate = req.getParameter("ScheduleDate");

			int count=1,examid=0;
			String clientname="",firstname="",
					lastname="",username="",
					password="",actualdate="",
					shdate="",newshdate="",testname="";

			boolean mastercheck = false;
			
			Clientmaster cm = cmDAO.findById(clientid);
			clientname = cm.getClientName();
			
			out.println("List of all Candidates: "+"<br/>");
			List<Candidatemaster> cmList =null;
			Schedule scid=null;Query query =null;
			if (cid ==0){
				
						query = em.createNamedQuery("UserDetails-ScheduleId.sql2");
						query.setParameter(scheduledate,scheduledate);
						query.setParameter(clientid,clientid); 
						scid = (Schedule) query.getSingleResult();
						/*scid = scDAO.scfindByNativeQueryPredicate(ClientID=" + clientid + " +
								" and ScheduleID=" + scid.getScheduleId() + " order by FirstName");*/
						
						 query = em.createNamedQuery("Userdetails-Candidatemaster.sql3");  
						 query.setParameter(1,clientid); 
						 query.setParameter(2,scid.getScheduleId());
						 cmList = query.getResultList();  
						}

			out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
			out.println("<TR><TH COLSPAN=7><B>Details of "+clientname+" on Exam Date "+Utils.getFullDate(scheduledate)+"</B></TH></TR>");
			out.println("<TR><TH>Sr. No.</TH>"+
						"<TH>Registration No.</TH>"+
						"<TH>Candidate Name</TH>"+
						"<TH>User Name</TH>"+
						"<TH>Password</TH>"+
						"<TH>Date of Registration</TH></TR>");

			    for(Candidatemaster cndList:cmList)
			    {
					cid = cndList.getCandidateId();
					firstname = cndList.getFirstName();
					lastname = cndList.getLastName();
					username = cndList.getUsername();
					password = cndList.getPassword();
	
					password = Encrypter.decrypt(password);
				
					RegistrationKey regkey = new RegistrationKey(cid);
					String k = regkey.getKeyCode();
					SimpleDateFormat sdfSource =new SimpleDateFormat("yyyy-MMM-dd");
					String ScheduleDate = sdfSource.format(cndList.getDateOfRegistration());
	
					out.println("<TR><TD ALIGN=RIGHT>" + count + "</TD>"+
									"<TD>" + k + "</TD>"+
									"<TD>" + firstname + " " + lastname + "</TD>"+
									"<TD>" + username + "</TD>"+
									"<TD>" + password + "</TD>"+
									"<TD ALIGN=CENTER>" +  Utils.getFullDate(ScheduleDate) + "</TD></TR>");
					count++;
			    }
			out.println("<TR><Th COLSPAN=6 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
			out.println("</TABLE>");
			
		}
		catch(Exception e)
		{
			//out.println("Error : " + e.getMessage());
		}
		finally
		{
			em.close();
		}

	}

	private void DisplayClientInfo(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException{

		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		EntityManager em = EntityManagerHelper.getEntityManager();
		out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
		out.println("</br></br><TR><TH COLSPAN=6><B>Details of All Clients</B></TH></TR>");
		out.println("<TR><TH>Sr. No.</TH>"+
					"<TH>Client Name</TH>"+
					"<TH>Code</TH>"+
					"<TH>User Name</TH>"+
					"<TH>Password</TH>"+
					"<TH>E-mail</TH></TR>");

		try {
			List<Clientmaster> cm = cmDAO.findAll();
			int count = 1;
			String descryptPassword = "";
		    for(Clientmaster cmList:cm)	
		    {
       				out.println("<TR><TD>" + count++ + "</TD>"+
					"<TD>" + cmList.getClientName() + "</TD>"+
					"<TD>" + cmList.getClientCode() + "</TD>"+
					"<TD>" + cmList.getUsername() + "</TD>"+
					"<TD>" + Encrypter.decrypt(cmList.getPassword()) + "</TD>"+
					"<TD>" + cmList.getEmail() + "</TD></TR>");
			}
		    
		} catch (Exception e) {
			out.println("DisplayError : " + e);
		}finally {
			em.close();
		}
		out.println("</TABLE>");
	}
}
