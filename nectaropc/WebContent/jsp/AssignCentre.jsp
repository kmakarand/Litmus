<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="com.ngs.gbl.RegistrationKey"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		System.out.println("actionaction :"+action);
		Query query=null;
		int cid = 0;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Connection con = pool.getConnection();
		Utils myUtils = new Utils();
		EntityManager em = EntityManagerHelper.getEntityManager();
		Logger log = Logger.getLogger("Analysis.jsp");
		CandidatemasterDAO cmDAO = new CandidatemasterDAO();
		ClientmasterDAO clmDAO = new ClientmasterDAO();
		out.println("<HTML><HEAD><TITLE>Centre Assignment</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
			
		if (action == null || action == "")
		{
			try
			{
				response.setContentType("TEXT/HTML");
				out.println("<BR><BR><TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
				out.println("<TR><TH COLSPAN=5><B>Assign Centre</B></TH></TR>");
				out.println("<TR><TH>Sr. NO.</TH><TH>Registration NO.</TH><TH>Centre Manager Name</TH><TH>Centre Assigned</TH><TH>Action</TH></TR>");
				//query = em.createQuery("SELECT cm FROM Candidatemaster cm ORDER BY cm.firstname");
				//query.setParameter(1,15);
				
				query = em.createNamedQuery("Assigncenter-Candidatemaster.sql1");
				query.setParameter(1, "20");
				List<Candidatemaster> cndList = query.getResultList();
				int count=1;
				for(Candidatemaster cm:cndList)
				{
					RegistrationKey regkey = new RegistrationKey(cm.getCandidateId());
					String regno = regkey.getKeyCode();
					out.println("<TR><TD>" + count + "</TD><TD>" + regno + "</TD><TD>" + cm.getFirstName() + " " + cm.getLastName() + "</TD>");
					int clientid = cm.getClientId();
					cid = cm.getCandidateId();
					if (clientid == 0)
					{
						out.println("<TD>NOT Assigned</TR>");
					}
					else
					{
						query = em.createQuery("SELECT cm.clientName FROM Clientmaster cm WHERE cm.clientId=?1");
						query.setParameter(1,clientid);
						String clientname = (String)query.getSingleResult();
						out.println("<TD>" + clientname + "</TD>");
					}
					out.println("<TD><A HREF='"+request.getRequestURI()+"?action=doAssign&CandidateID="+cid+"'>Assign Centre</A></TD></TR>");
					count++;
				}
				out.println("</TABLE>");
			}
			catch(Exception e)
			{
				out.println("Error  here : " + e.getMessage());
			}
			finally
			{
				
			}
		}
		else if (action.equalsIgnoreCase("doAssign"))
		{
			try
			{
				cid=Integer.parseInt(request.getParameter("CandidateID"));
				System.out.println("doAssign cid:"+cid);
				System.out.println("doAssign action:"+cid);
				response.setContentType("TEXT/HTML");
				out.println("<BR><BR><FORM NAME=frmAssign METHOD=POST action="+request.getRequestURI()+">");//
				out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
				out.println("<TR><TH COLSPAN=2><B>Select Centre</B></TH></TR>");
				out.println("<TR><TD ALIGN=RIGHT>Centre Name :</TD><TD><SELECT NAME=ClientID>");
				List<Clientmaster> clmList = clmDAO.findAll();
				Candidatemaster objCandidatemaster = cmDAO.findById(cid);
				int cndClientid = objCandidatemaster.getClientId();
				System.out.println("cndClientid :"+cndClientid);
				int count=1;
				for(Clientmaster clm:clmList)
				{
					if(cndClientid==clm.getClientId())
					out.println("<OPTION VALUE="+clm.getClientId()+" selected>"+clm.getClientName()+"</OPTION>");
					else
					out.println("<OPTION VALUE="+clm.getClientId()+">"+clm.getClientName()+"</OPTION>");
					
				}
				out.println("<OPTION VALUE=0>No Centre</OPTION></SELECT></TD></TR>");
				out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Submit><INPUT TYPE=HIDDEN NAME=action VALUE=doCentreUpdate><INPUT TYPE=HIDDEN NAME=CandidateID VALUE="+cid+"></TH></TR>");
				out.println("</TABLE>");
				out.println("</FORM>");
			}
			catch(Exception e)
			{
				out.println("Error  here : " + e.getMessage());
			}
			finally
			{
				
			}
		}
		else if (action.equalsIgnoreCase("doCentreUpdate"))
		{
			try
			{
				boolean check = false;
				String sql = "";
				
				cid=Integer.parseInt(request.getParameter("CandidateID"));
				int clientid=Integer.parseInt(request.getParameter("ClientID"));
				System.out.println("doCentreUpdate cndClientid :"+clientid);
				response.setContentType("TEXT/HTML");
				Candidatemaster objCandidatemaster = cmDAO.findById(cid);
				int cndClientid = objCandidatemaster.getClientId();
				System.out.println("cndClientid :"+cndClientid);
				if(cndClientid==clientid)
					check =true;
				else
					check=false;
				
				System.out.println("check :"+check);
	
				if (check)
				{
					out.println("<BR><B>Centre has already been assigned !!</B>");
					out.println("<FORM NAME=back METHOD=GET action="+request.getRequestURI()+">");
					out.println("<INPUT TYPE=SUBMIT VALUE='Go BACK'>");
					out.println("</FORM>");
				}
				else
				{
					Candidatemaster cm = cmDAO.findById(cid);
					cm.setClientId(clientid);
					cm.setCandidateId(cid);
				    EntityManagerHelper.beginTransaction();
				    cmDAO.update(cm);
				    EntityManagerHelper.commit();
					if (cmDAO !=null)
					{
						response.sendRedirect(request.getRequestURI());
					}
					else
						out.println("Problem in Modification !!");
				}
	
			}
			catch(Exception e)
			{
				out.println("Error  here : " + e.getMessage());
			}
			finally
			{
			}
		}
		
		out.println("</BODY>");
		out.println("</HTML>");
%>