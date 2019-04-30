<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		Query query=null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("changepassword.jsp");
		Connection con = pool.getConnection();
		String sql="";
		String ClientID = (String)session.getAttribute("ClientID");
		//log.info("ClientID :"+ClientID);
		int clientid=0;
		EntityManager em = EntityManagerHelper.getEntityManager();
		
		if (action == null || action == "")
		{
			if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="" || ClientID.equals("0")){
			Integer CandidateID = (Integer) session.getAttribute("CandidateID");
			int cid= CandidateID.intValue();
			//log.info("CandidateID :"+cid);
			out.println("<HTML><HEAD><script language='javascript' src='../js/validatefunction.js'></script><TITLE>Change Password</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<FORM NAME=form1 METHOD=POST action=\"\">");
			out.println("<H4>You Can Change Your Password Here<HR SIZE=1></H4>");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=2>Please Provide The Informations</TH></TR>");
			CandidatemasterDAO cmDAO = new CandidatemasterDAO();
			Candidatemaster cm = cmDAO.findById(cid);
				{
					out.println("<TR><TD  ALIGN=RIGHT> Client Name :</TD><TD  ALIGN=LEFT>"+cm.getFirstName() + " " + cm.getLastName() +"</TD></TR>");
					out.println("<TR><TD  ALIGN=RIGHT> Old Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=oldPassword></TD></TR>");
					out.println("<TR><TD  ALIGN=RIGHT> New Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=newPassword></TD></TR>");
					out.println("<TR><TD ALIGN=RIGHT> Confirm Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=conPassword></TD></TR>");
				}
				out.println("<TR><TH colspan=2><input type=submit name=submit value=Submit><input type=hidden name=action value=doSaveBse></TH></TR>");
				out.println("</table>");
				out.println("</FORM></BODY></HTML>");
			
			}
			else
			{
				clientid = Integer.parseInt(ClientID);
				ClientID = (String)session.getAttribute("ClientID");
				clientid=0;
		
				if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID==""){
					session.invalidate();
					response.sendRedirect("../jsp/Login.jsp");
					return;
				}
				else
					clientid = Integer.parseInt(ClientID);
				
				out.println("<HTML><HEAD><script language='javascript' src='../js/validatefunction.js'></script><TITLE>Change Password</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				out.println("<FORM NAME=form1 METHOD=POST>");
				out.println("<H4>You Can Change Your Password Here<HR SIZE=1></H4>");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=2>Please Provide The Informations</TH></TR>");
				sql = "SELECT clm.clientName FROM Clientmaster clm WHERE clm.clientId=?1";
				query = em.createQuery(sql);
				query.setParameter(1,clientid);
				String ClientName = (String)query.getSingleResult();
					{
						out.println("<TR><TD  ALIGN=RIGHT> Client Name :</TD><TD  ALIGN=LEFT>"+ClientName+"</TD></TR>");
						out.println("<TR><TD  ALIGN=RIGHT> Old Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=oldPassword></TD></TR>");
						out.println("<TR><TD  ALIGN=RIGHT> New Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=newPassword></TD></TR>");
						out.println("<TR><TD ALIGN=RIGHT> Confirm Password :</TD><TD  ALIGN=LEFT><input type= password maxlength=10 size= 10 name=conPassword></TD></TR>");
					}
					out.println("<TR><TH colspan=2><input type=submit  value=Submit><input type=HIdden name=action value=doSaveClient></TH></TR>");
					out.println("</table>");
					out.println("</FORM></BODY></HTML>");
					}
		   }
		   else if (action.equalsIgnoreCase("doSaveClient"))
		   {
				try {
					
					response.setContentType("text/html");
					String sql1="",sql2="";
					String oldP= (String) request.getParameter("oldPassword");
					String newP= (String) request.getParameter("newPassword");
					String conP= (String) request.getParameter("conPassword");
			//		String ClientID =(String) request.getParameter("ClientID");
					ClientID = (String)session.getAttribute("ClientID");
					clientid=0;
					newP = Encrypter.encrypt(newP);
					conP = Encrypter.encrypt(conP);
			
					if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID==""){
						//clientid =0;
						session.invalidate();
						response.sendRedirect("../jsp/Login.jsp");
						return;
					}else{
						clientid = Integer.parseInt(ClientID);
					}
			
					out.println("<HTML><HEAD><TITLE>Changed Password</TITLE>");
					out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
					out.println("<BODY><CENTER>");
			
					if(!newP.equals(conP)){
						out.println("New Password does not match with Confirm Password!!");
						out.println("<BR><form><Input type=button value=\"Go Back\" onclick=\"javascript:history.back()\">");
					}else {
							/*sql1 = "SELECT clm FROM Clientmaster clm WHERE clm.clientId=?1";
							query = em.createQuery(sql1);
							query.setParameter(1,clientid);*/
							ClientmasterDAO clmDAO = new ClientmasterDAO();
							Clientmaster clm = clmDAO.findById(clientid);
							//log.debug("Old Password entered :"+oldP);
							//log.debug("Old Password database:"+Encrypter.decrypt(clm.getPassword()).trim());
							
							if(EntityManagerHelper.getSingleResult(query)!=null)
							{
								if(!Encrypter.decrypt(clm.getPassword()).trim().equals(oldP)){
									out.println("Invalid Old Password!!");
									out.println("<BR><form><Input type=button value=\"Go Back\" onclick=\"javascript:history.back()\">");
									}else{
										EntityManagerHelper.beginTransaction();
										clm.setPassword(newP);
										clmDAO.update(clm);
										EntityManagerHelper.commit();
									out.println("<FORM NAME=form1>");
									out.println("<H4>You Have Succefully Changed The Password <HR SIZE=1></H4>");
									out.println("</FORM>");
									}
							}
					}
							
					out.println("</BODY></HTML>");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
			}
			else if (action.equalsIgnoreCase("doSaveBse"))
			{
				//log.info("doSaveBse start :");
				String sql1="",sql2="";
				String oldP= (String) request.getParameter("oldPassword");
				String newP= (String) request.getParameter("newPassword");
				String conP= (String) request.getParameter("conPassword");
		
				Integer CandidateID = (Integer) session.getAttribute("CandidateID");
				int cid= CandidateID.intValue();
		
				out.println("<HTML><HEAD><TITLE>Changed Password</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				
				//log.info("doSaveBse newP :"+newP);
				//log.info("doSaveBse conP :"+conP);
		
				if(!newP.equals(conP)){
					out.println("New Password does not match with Confirm Password!!");
					out.println("<BR><form><Input type=button value=\"Go Back\" onclick=\"javascript:history.back()\">");
				}else {
					    CandidatemasterDAO cmDAO = new CandidatemasterDAO();
					    Candidatemaster cm = cmDAO.findById(cid);
					    String dboldP = Encrypter.decrypt(cm.getPassword()).trim();
						if(cm!=null){
							if(!dboldP.equals(oldP)){
								out.println("Old Password entered :"+oldP);
								out.println("Old Password database:"+dboldP);
								out.println("Invalid Old Password!!");
								out.println("<BR><form><Input type=button value=\"Go Back\" onclick=\"javascript:history.back()\">");
							}else{
								/*sql2="UPDATE Candidatemaster cm SET cm.password =?1 WHERE cm.candidateId=?2";
								query = em.createQuery(sql2);
								query.setParameter(1, newP);
								query.setParameter(2, cid);*/
								EntityManagerHelper.beginTransaction();
								cm.setPassword(Encrypter.encrypt(newP));
								cmDAO.save(cm);
								EntityManagerHelper.commit();
								out.println("<FORM NAME=form1>");
								out.println("<H4>You Have Succefully Changed The Password <HR SIZE=1></H4>");
								out.println("</FORM>");
							}
						}
					
				}
				out.println("</BODY></HTML>");
			}
%>