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
		Logger log = Logger.getLogger("UserDetails.jsp");
		Connection con = pool.getConnection();
		EntityManager em = EntityManagerHelper.getEntityManager();
		
		String sql="";
		Integer CandidateID = (Integer) session.getAttribute("CandidateID");
		int cid = CandidateID.intValue();
		int clientid=0;

		String ClientID = (String)session.getAttribute("ClientID");
		
		log.info("start	cid:"+cid);
		log.info("start ClientID:"+ClientID);

		if (ClientID == null || ClientID.equals("") ||
				ClientID.equals(null) || ClientID==""){

			if (cid==0) {
				response.sendRedirect("../jsp/Login.jsp");
				return;
			}else {
				clientid=0;
			}
		}else {
			clientid = Integer.parseInt(ClientID);
		}
		
		out.println("<HTML><HEAD><TITLE>Candidate Details</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");

		if (action == null || action == ""){
			try	{
				
				
				// ZILS WANTS TO VIEW ALL CLIENT USER/PWD LIST
				if (clientid==0 && (cid==1 || cid==2)) {
				    ////--------------DisplayClientInfo start -----------------//////////
				    
					out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
					out.println("</br></br><TR><TH COLSPAN=6><B>Details of All Clients</B></TH></TR>");
					out.println("<TR><TH>Sr. No.</TH>"+
								"<TH>Client Name</TH>"+
								"<TH>Code</TH>"+
								"<TH>User Name</TH>"+
								"<TH>Password</TH>"+
								"<TH>E-mail</TH></TR>");
			
					try {
						
						/************start Pagination code ******************/
						log.info("start");
						int rowcount=0;int total_pages;int pageNo;int pagesize=10;
						if(null==request.getParameter("page_number"))
						pageNo = 0;
						else
						pageNo = Integer.parseInt(request.getParameter("page_number"));
						log.info("pageNo :"+pageNo);
						ClientmasterDAO objClientmasterDAO = new ClientmasterDAO();
						List<Clientmaster> cmaList = objClientmasterDAO.findAllClientsWithPaging(pageNo,pagesize);
						List<Clientmaster> allList = objClientmasterDAO.findAll();
						for(Clientmaster cmList:allList)
						{ rowcount++;}
						log.info("rowcount :"+rowcount);
						int count=1;
						if(pageNo>1)
						count = (pagesize*(pageNo-1))+1;
						
						
						/************end Pagination code ******************/
						
						
						//List<Clientmaster> cm = cmDAO.findAll();
						//int count = 1;
						String descryptPassword = "";
					    for(Clientmaster cmList:cmaList)	
					    {
			       				out.println("<TR><TD>" + count++ + "</TD>"+
								"<TD>" + cmList.getClientName() + "</TD>"+
								"<TD>" + cmList.getClientCode() + "</TD>"+
								"<TD>" + cmList.getUsername() + "</TD>"+
								"<TD>" + Encrypter.decrypt(cmList.getPassword()) + "</TD>"+
								"<TD>" + cmList.getEmail() + "</TD></TR>");
			       				
						}
					    
					    int rowend = 0;
						if(rowcount % pagesize >=1)
						rowend=1;
						log.info("rowend :"+rowend);
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
							out.println("<a href='../jsp/UserDetails.jsp?page_number="+i+"'>"+i+"</a>");
							}
							
						}
					
					} catch (Exception e) {
						out.println("DisplayError : " + e);
					}finally {
						
					}
					out.println("</TABLE>");
					 //DisplayClientInfo(req,res);
					 ////--------------DisplayClientInfo end -----------------//////////
				}else
				{
					// code for when client wants to view the report
					out.println("<FORM METHOD=POST>");
					out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
					out.println("<TR><TH COLSPAN=2><B>Select Exam Date</B></TH></TR>");
					out.println("<TR><TD ALIGN=RIGHT>Date :</TD><TD><SELECT name=ScheduleDate>");
					query = em.createNamedQuery("UserDetails-Schedule.sql1");
					query.setParameter(1,clientid);
				    List<Schedule> arr_cust = query.getResultList();
					out.println("List of all Candidates: "+"<br/>");
			        Date newDate=null;String ScheduleDate ="mk";
			        for(Schedule sc:arr_cust)
			        {
			        	//System.out.println("value :"+sc.getScheduleDate());
			            Date fdate = sc.getScheduleDate();
			            SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
						ScheduleDate = sdfDest.format(fdate);
						//System.out.println("ScheduleDate :"+ScheduleDate);
						out.println("<OPTION VALUE="+ScheduleDate+">"+ScheduleDate+"</OPTION>");
			        }
					out.println("</SELECT></TD></TR>");
					out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Submit><INPUT TYPE=HIDDEN NAME=action VALUE=doDisplay></TH></TR>");
					out.println("</FORM>");
				}

				
				
			}catch(Exception e){
				out.println("Error : " + e.getMessage());
			}finally{}
		}
		else if (action.equalsIgnoreCase("doDisplay")){
				try{
		
					clientid=0;
		
					ClientID = (String) session.getAttribute("ClientID");
					if (ClientID == null || ClientID.equals("") ||
							ClientID.equals(null) || ClientID==""){
						response.sendRedirect("../jsp/Login.jsp");
						return;
					}else {
						clientid = Integer.parseInt(ClientID);
					}
		
					CandidateID = (Integer) session.getAttribute("CandidateID");
					cid = CandidateID.intValue();
		
		//			String date = request.getParameter("date");
		//	int scheduleid = Integer.parseInt(request.getParameter("ScheduleID"));
					String scheduledate = request.getParameter("ScheduleDate");
		
					int count=1,examid=0;
					String clientname="",firstname="",
							lastname="",username="",
							password="",actualdate="",
							shdate="",newshdate="",testname="";
		
					boolean mastercheck = false;
					
					Clientmaster cm = cmDAO.findById(clientid);
					clientname = cm.getClientName();
					
					List<Candidatemaster> cmList =null;
					Schedule sc=null;
					if (cid ==0){
						
								SimpleDateFormat sfd = new SimpleDateFormat("yyyy-MM-dd");
							    Date dtScheduledate = sfd.parse(scheduledate);
							    query = em.createQuery("SELECT s FROM Schedule s where s.scheduleDate=?1 " +
										"and s.clientId =?2 ORDER BY s.scheduleDate");
								//createNamedQuery("UserDetails-Schedule.sql2");
								//System.out.println("scheduledate"+scheduledate);
								//System.out.println("clientid"+clientid);
								query.setParameter(1,dtScheduledate);
								query.setParameter(2,clientid); 
								sc = (Schedule) query.getSingleResult();
								//System.out.println("sc"+sc);
								/*scid = scDAO.scfindByNativeQueryPredicate(ClientID=" + clientid + " +
										" and ScheduleID=" + scid.getScheduleId() + " order by FirstName");*/
							    
								 //System.out.println("Userdetails sc.getId().getScheduleId()"+sc.getScheduleId());
								 query = em.createNamedQuery("Userdetails-Candidatemaster.sql3");  
								 //System.out.println("Userdetails clientid"+clientid);
								 query.setParameter(1,clientid); 
								 query.setParameter(2,sc.getScheduleId());
								 cmList = query.getResultList();  
						}

						out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
						out.println("<BR>");
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
								
								out.println("<TR><TD ALIGN=RIGHT>" + count + "</TD>"+
												"<TD>" + k + "</TD>"+
												"<TD>" + firstname + " " + lastname + "</TD>"+
												"<TD>" + username + "</TD>"+
												"<TD>" + password + "</TD>"+
												"<TD ALIGN=CENTER>" +  scheduledate + "</TD></TR>");
								count++;
						    }
						out.println("<TR><Th COLSPAN=6 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
						out.println("</TABLE>");
						
					}
					catch(Exception e)
					{
						out.println("Error : " + e.getMessage());
					}
					finally
					{
					
					}
					
					out.println("</BODY>");
					out.println("</HTML>");

			}
		
%>