<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="com.ngs.gbl.RegistrationKey"%>
<%@page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		//System.out.println(" action:"+action);
		Query query=null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("postponementrequest.jsp");
		Connection con = pool.getConnection();
		ClientmasterDAO cmDAO = new ClientmasterDAO();
		ScheduleDAO scDAO = new ScheduleDAO();
		CandidatemasterDAO cndDAO = new CandidatemasterDAO();
		PreparedStatement pstmt = null;
		ResultSet rs = null,rs1 = null,rs2 = null;
		EntityManager em = EntityManagerHelper.getEntityManager();
		
		int clientid=0;
//		String sql="";
		String ClientID = (String) session.getAttribute("ClientID");
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
			clientid =1;
			response.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);
			
		log.info("postponement clientid	:"+clientid);
		log.info("postponement action	:"+action);
			
		try
		{
			if (action == null || action == "")
			{
				response.setContentType("text/html");
				log.info("postponement action	:"+action);
				out.println("<HTML><HEAD><TITLE>Postponement Request</TITLE>");
				out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				out.println("<H4>Postponement Request</H4><HR SIZE=1>");
				out.println("<FORM NAME=frmname METHOD=POST >");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				if(clientid==0)
				{
						out.println("<tr><th colspan='2'>Select Client</th></tr>");
						out.println("<tr><td align='right'>Client Name : </td>");
						out.println("<td><select name='client'>");
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
				}
				else
				{
					out.println("<TR><TH COLSPAN=2>Select Name for Postponement</TH></TR>");
					out.println("<TR><TD>Name :</TD><TD><SELECT NAME=cid>");
					//sql = "Select * from candidatemaster WHERE ClientID=? ORDER BY CandidateID,FirstName";
					String sql =   "Select * from CandidateMaster cm,SlotRegisteration sr,Schedule s"+
							" WHERE cm.CandidateID=sr.CandidateID and sr.ScheduleID=s.ScheduleID and"+
							" cm.ClientID=? and cm.Status>0 and s.ScheduleDate>Current_date"+
							" Group BY cm.CandidateID,cm.FirstName";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,clientid);
					//System.out.println(" pstmt:"+pstmt);
					rs = pstmt.executeQuery();
					while (rs.next())
					{
						int cid =  rs.getInt("CandidateID");
						////System.out.println(" cid:"+cid);
						if(cid>0)
						{
						RegistrationKey regkey = new RegistrationKey (cid);
						String tpkey = regkey.getKeyCode();
						//System.out.println(" tpkey:"+tpkey);
						out.println("<OPTION VALUE="+cid+">"+rs.getString("FirstName")+ " "  + rs.getString("LastName") + " [" + tpkey + "]" +"</OPTION>");
						}else
						{
							out.println("<OPTION VALUE="+cid+">"+rs.getString("FirstName")+ " "  + rs.getString("LastName")+"</OPTION>");
						}
					}
				}
					out.println("</SELECT></TD></TR>");
					out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=submit><INPUT TYPE=HIDDEN NAME=action VALUE=doDetails></TH></TR></TABLE>");
					out.println("</FORM>");
			}else 
			{
			
				if (action.equalsIgnoreCase("doModify"))
				{
					log.info("postponement action	doModify:");
					String sql = null;
					try
					{
						con = pool.getConnection();
						
						clientid = Integer.parseInt(request.getParameter("clientid"));
						int cid = Integer.parseInt(request.getParameter("cid"));
						int examid = Integer.parseInt(request.getParameter("examid"));
						int scheduleid = Integer.parseInt(request.getParameter("scheduleid"));
						int ScIDdate = Integer.parseInt(request.getParameter("ScIDdate"));
			//			int ScIDtimefrom = Integer.parseInt(request.getParameter("ScIDtimefrom"));
						String olddate = request.getParameter("olddate");
						String oldtimefrom = request.getParameter("oldtimefrom");
						String oldtimeto = request.getParameter("oldtimeto");
						String testname = request.getParameter("testname");
						
						/*//System.out.println("olddate :"+olddate);
						//System.out.println("oldtimefrom :"+oldtimefrom);
						//System.out.println("oldtimeto :"+oldtimeto);
						//System.out.println("testname :"+testname);*/
			
						sql = "SELECT ScheduleID FROM SlotRegisteration WHERE CandidateID=" + cid ;
			//out.println("<br>"+sql);
			  			pstmt = con.prepareStatement(sql);
			  			rs1 = pstmt.executeQuery();
						while (rs1.next()){
							scheduleid = rs1.getInt("ScheduleID");
						}
						////System.out.println("scheduleid 1:"+scheduleid);
						int seatsfilled =0,totalseats=0;
						sql = "SELECT count(*) FROM SlotRegisteration WHERE ScheduleID=?";
			//out.println("<br>"+sql);
			  			pstmt = con.prepareStatement(sql);
			  			pstmt.setInt(1,scheduleid);
			  			rs1 = pstmt.executeQuery();
						while (rs1.next()){
							seatsfilled = rs1.getInt(1);
							////System.out.println("seatsfilled :"+seatsfilled);
						}
						////System.out.println("scheduleid 2:"+scheduleid);
						sql = "SELECT NoOfSeats FROM Schedule WHERE ScheduleID=?";
			//out.println("<br>"+sql);
			  			pstmt = con.prepareStatement(sql);
			  			pstmt.setInt(1,scheduleid);
			  			rs1 = pstmt.executeQuery();
						while (rs1.next()){
							totalseats = rs1.getInt("NoOfSeats");
							////System.out.println("totalseats :"+totalseats);
						}
						int seatsaval = totalseats - seatsfilled;
			//out.println("<br>totseats : " +totalseats + " seats filled : " +seatsfilled);
						if (seatsaval>0){
			//out.println("<BR>"+ScIDdate + " " + ScIDtimefrom);
			//			if (ScIDdate==ScIDtimefrom)
			//			{
							out.println("<HTML><HEAD><TITLE>Postponement Request</TITLE>");
							out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
							out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
							out.println("<BODY><CENTER>");
							out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDDING=1>");
							out.println("<TR><TH COLSPAN=2>Postponement Details</TH></TR>");
			
							sql = "UPDATE SlotRegisteration SET ScheduleID=" + ScIDdate + " WHERE ScheduleID=" + scheduleid + " and CandidateID=" + cid;
			//out.println("<BR>"+sql);
							String newdate ="";
							pstmt = con.prepareStatement(sql);
							int confirm = pstmt.executeUpdate(sql);
							if (confirm > 0){
								sql = "UPDATE CandidateMaster SET ScheduleID=" + ScIDdate + " where CandidateID=" + cid;
			//out.println("<BR>"+sql);
			  				pstmt = con.prepareStatement(sql);
			  				confirm = pstmt.executeUpdate(sql);
								sql = "SELECT ScheduleDate FROM Schedule WHERE ScheduleID=" + ScIDdate;
			//out.println("<BR>"+sql);
			  					pstmt = con.prepareStatement(sql);
			  					rs = pstmt.executeQuery(sql);
								while (rs.next()){
									newdate = rs.getString("ScheduleDate");
								}
								
								java.util.Date fdate = new java.util.Date();String ScheduleDate ="0000-00-00";
					            SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
								ScheduleDate = sdfDest.format(fdate);
								//System.out.println("Todayy  :"+ScheduleDate);
								
								PostponeslotdetailsDAO objPostponeslotdetailsDAO = new PostponeslotdetailsDAO();
								List<Postponeslotdetails> objlistPD = objPostponeslotdetailsDAO.findByProperty("candidateId",cid);
								Postponeslotdetails objPostponeslotdetails = new Postponeslotdetails();
								objPostponeslotdetails.setCandidateId(cid);
								objPostponeslotdetails.setAllotedScheduleId(ScIDdate);
								objPostponeslotdetails.setPostponeRequestDate(ScheduleDate);
								objPostponeslotdetails.setRequestedScheduleId(scheduleid);
								objPostponeslotdetails.setIsApproved(1);
								EntityManagerHelper.beginTransaction();
								if(objlistPD.isEmpty())
								{
									//System.out.println("objPostponeslotdetails CandidateId:"+objPostponeslotdetails.getCandidateId());
									//System.out.println("objPostponeslotdetails PostponeRequestDate:"+objPostponeslotdetails.getPostponeRequestDate());
									objPostponeslotdetailsDAO.save(objPostponeslotdetails);
								}
								else
								{
									objPostponeslotdetailsDAO.update(objPostponeslotdetails);
								}
								EntityManagerHelper.commit();
								
								/*sql = "INSERT INTO PostponeSlotDetails (CandidateID,AllotedScheduleID,RequestedScheduleID,PostponeRequestDate,isApproved) VALUES ("+cid+","+ScIDdate+","+scheduleid+",'"+ScheduleDate+"',1)";
			//out.println("<BR>"+sql);
								pstmt = con.prepareStatement(sql);
								confirm = pstmt.executeUpdate(sql);
								if (confirm<=0){
									out.println("Problem in PostponeSlotDetails insertion !!");
								}*/
			
								out.println("<TR><TD ALIGN=RIGHT>Test Name :</TD><TD ALIGN=LEFT>"+testname+"</TD></TR>");
								//out.println("<TR><TD ALIGN=RIGHT>Previous Date :</TD><TD ALIGN=LEFT>"+olddate+"</TD></TR>");
								//out.println("<TR><TD ALIGN=RIGHT>Previous Timae :</TD><TD ALIGN=LEFT>"+oldtimefrom +"-"+oldtimeto+"</TD></TR>");
								out.println("<TR><TD COLSPAN=2>&nbsp;</TD></TR>");
			
								out.println("<TR><TD ALIGN=RIGHT>New Date :</TD><TD>"+Utils.getDate(newdate)+"</TD></TR>");
								sql = "SELECT TimeFrom,TimeTo FROM Schedule WHERE ScheduleID="+ScIDdate;
								pstmt = con.prepareStatement(sql);
								rs = pstmt.executeQuery(sql);
								while (rs.next())
								{
									String timefr=rs.getString("TimeFrom");
									timefr = timefr.substring(0,5);
									String timeto=rs.getString("TimeTo");
									timeto = timeto.substring(0,5);
									out.println("<TR><TD ALIGN=RIGHT>New Time :</TD><TD>"+timefr +" - "+timeto+"</TD></TR>");
								}
							}
							out.println("</TABLE>");
						}
						else
						{
							out.println("All Seats are booked for this Schedule !!");
						}
			
						out.println("</BODY>");
						out.println("</HTML>");
			
					}
					catch(Exception e)
					{
						out.println("Mod Error : " + e.getMessage());
						////System.out.println("Error : " + e.getMessage());
					}
					finally
					{
						if (con != null)
							pool.releaseConnection(con);
				        else
					        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
					}
				}
				else if (action.equalsIgnoreCase("doDetails"))
				{
				    log.info("postponement doDetails start:");
				    ClientID = (String) session.getAttribute("ClientID");
					log.info("postponement doDetails ClientID:"+ClientID);
					
					String sql = null,testname ="";
					int examid=0,scheduleid=0;
					if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
					{
			//			clientid =1;
						response.sendRedirect("../jsp/Login.jsp");
					}
					else
						clientid = Integer.parseInt(ClientID);
					
					    log.info("postponement doDetails client: "+clientid);
						int cid = Integer.parseInt(request.getParameter("cid"));
						//System.out.println("cid :"+cid);

					try
					{
						con = pool.getConnection();
						sql = "SELECT ExamID FROM CandidateDetails WHERE CandidateID=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1,cid);
						rs1 = pstmt.executeQuery();
						while (rs1.next())
						{
							examid = rs1.getInt("ExamID");
						}
						sql = "SELECT TestName FROM NewExamDetails WHERE ExamID=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1,examid);
						rs1 = pstmt.executeQuery();
						while (rs1.next())
						{
							testname = rs1.getString("TestName");
						}
						
						sql = "SELECT ScheduleID FROM SlotRegisteration WHERE CandidateID=?";
			//out.println("<br>"+sql);
			  			pstmt = con.prepareStatement(sql);
			  			pstmt.setInt(1,cid);
			  			////System.out.println("ScheduleID FROM slotregisteration :"+pstmt);
			  			rs1 = pstmt.executeQuery();
						while (rs1.next())
						{
							scheduleid = rs1.getInt("ScheduleID");
							////System.out.println("scheduleid :"+scheduleid);
						}
						////System.out.println("testname 1:"+testname);
						//out.println("testname 1:"+testname);
						out.println("<HTML><HEAD><TITLE>Postponement Request</TITLE>");
						out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
						out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
						out.println("<BODY><CENTER>");
						out.println("<H4>Postponement Request</H4><HR SIZE=1>");
						out.println("<FORM METHOD=POST NAME=form1>");
						out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
						out.println("<TR><TH COLSPAN=2>Select Test Centre</TH></TR>");
						out.println("<TR><TD ALIGN=RIGHT>Test Name :</TD><TD ALIGN=LEFt>"+testname+"</TD></TR>");
						//---------------------testing code starts---------------------------//
								////System.out.println("testname 2:"+testname);
						//out.println("testname 2:"+testname);
						////System.out.println("ScheduleID	:"+scheduleid);
						////System.out.println("ExamID	:"+examid);
						sql = "SELECT ScheduleDate,TimeFrom,TimeTo FROM Schedule WHERE ScheduleID=? and ExamID=?";
			//out.println("<br>"+sql);
						String olddate="",oldtimefrom="",oldtimeto="";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1,scheduleid);
						pstmt.setInt(2,examid);
						////System.out.println("pstmt :"+pstmt);
						rs = pstmt.executeQuery();
						while (rs.next())
						{
							String chshdate = rs.getString("ScheduleDate");
							//System.out.println("chshdate	:"+chshdate);
							int date = Integer.parseInt(chshdate.substring(8,10));
							int month = Integer.parseInt(chshdate.substring(5,7));
							int year = Integer.parseInt(chshdate.substring(0,4));
							////System.out.println("date	:"+date);
							////System.out.println("month	:"+month);
							////System.out.println("year	:"+year);
							Calendar today = Calendar.getInstance();
							Calendar syscal = Calendar.getInstance();
							syscal.add(Calendar.DATE, 1);	// specified by -> BSE 3 days before Exam
			
							Calendar examcal = Calendar.getInstance();
							examcal.set(year, month-1, date);	// mont starts from 0 . keep this in mind !!!
			
							if (today.after(examcal) || syscal.after(examcal) )
							{
								out.println("Sorry you are late for postponement !!!");
								String link = request.getRequestURI()+"?action=doDisplayError";
								response.sendRedirect(link);
								break;
							}
			
							olddate = Utils.getDate(chshdate);
							oldtimefrom = rs.getString("TimeFrom");
							oldtimefrom = oldtimefrom.substring(0,5);
							oldtimeto = rs.getString("TimeTo");
							oldtimeto = oldtimeto.substring(0,5);
							////System.out.println("olddate	:"+olddate);
							////System.out.println("oldtimefrom	:"+oldtimefrom);
							////System.out.println("oldtimeto	:"+oldtimeto);
							out.println("<TR><TD ALIGN=RIGHT>Schedule Test Date :</TD><TD ALIGN=LEFt>"+olddate+"</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Schedule Test Time :</TD><TD ALIGN=LEFt>"+oldtimefrom +"-" + oldtimeto +"</TD></TR>");
						}
						
						//---------------------testing code ends---------------------------//
						
						out.println("<TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>");
						out.println("<TR><TD ALIGN=RIGHT>New Test Date :</TD><TD><SELECT NAME=ScIDdate>");
			
						sql = "SELECT ScheduleID,ScheduleDate, TimeFrom,TimeTo FROM Schedule "+
								" WHERE ClientID=? AND ScheduleDate > CURRENT_DATE ORDER BY ScheduleDate";
			//out.println("<br>"+sql);
			  			pstmt = con.prepareStatement(sql);
			  			pstmt.setInt(1,clientid);
			  			////System.out.println("pstmt :"+pstmt);
			  			rs1 = pstmt.executeQuery();
						int counter=1;		// max 4 scheddule to be displayed to Center Mager for Postponement
						while (rs1.next()){
							String date = Utils.getDate(rs1.getString("ScheduleDate"));
							//System.out.println("date 1:"+date);
							String timefrom = rs1.getString("TimeFrom");
							timefrom = timefrom.substring(0,5);
							String timeto = rs1.getString("TimeTo");
							timeto = timeto.substring(0,5);
							//System.out.println("timefrom 1:"+timefrom);
							//System.out.println("timeto 1:"+timeto);
							//System.out.println("<OPTION VALUE=\""+rs1.getString("ScheduleID")+"\">"+date + " | " +timefrom + "-" + timeto + "</OPTION>");
							out.println("<OPTION VALUE=\""+rs1.getString("ScheduleID")+"\">"+date + " | " +
								timefrom + "-" + timeto + "</OPTION>");
							//System.out.println("counter 1:"+counter);
							if (counter>4)
							{
								break;
								
							}
							//System.out.println("counter :"+counter);
							counter++;
						}
						out.println("</TD></SELECT></TR>");
						
			//			out.println("<TR><TD ALIGN=RIGHT>New Test Time :</TD><TD><SELECT NAME=ScIDtimefrom>");
			//			sql = "SELECT ScheduleID,TimeFrom,TimeTo FROM schedule WHERE ClientID="+clientid + " ORDER BY ScheduleDate";
			
			//			rs = stmt.executeQuery(sql);
			//			while (rs.next())
			//			{
			//				String timefrom = rs.getString("TimeFrom");
			//				timefrom = timefrom.substring(0,5);
			//				String timeto = rs.getString("TimeTo");
			//				timeto = timeto.substring(0,5);
			//				out.println("<OPTION VALUE="+rs.getString("ScheduleID")+">"+timefrom + "-" + timeto +"</OPTION>");
			//			}
			//			out.println("</TD></SELECT></TR>");
						////System.out.println("testname 3:"+testname);
						//out.println("testname 3:"+testname);
						
						out.println("<TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>");
						out.println("<TR><TH COLSPAN=2><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'>&nbsp;<INPUT TYPE=SUBMIT VALUE=Submit></TH></TR>");
						out.println("<INPUT TYPE=HIDDEN NAME=action VALUE=doModify><INPUT TYPE=HIDDEN NAME=olddate VALUE='"+olddate+"'><INPUT TYPE=HIDDEN NAME=oldtimefrom VALUE='"+oldtimefrom+"'><INPUT TYPE=HIDDEN NAME=oldtimeto VALUE='"+oldtimeto+"'><INPUT TYPE=HIDDEN NAME=testname VALUE='"+testname+"'><INPUT TYPE=HIDDEN NAME=clientid VALUE="+clientid+"><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"><INPUT TYPE=HIDDEN NAME=examid VALUE="+examid+"><INPUT TYPE=HIDDEN NAME=scheduleid VALUE="+scheduleid+">");
						out.println("</TABLE>");
						out.println("</FORM>");
						out.println("</BODY></HTML>");
						
					}catch(Exception e){
						out.println("Mod Error : " + e.getMessage());e.printStackTrace();
						////System.out.println("Error : " + e.getMessage());
					}
					finally
					{
						if (con != null)
							pool.releaseConnection(con);
				        else
					        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
					}
				}
				else if (action.equalsIgnoreCase("doDisplayError"))
				{
					log.info("postponement action doDisplayError:");
					ClientID = (String) session.getAttribute("ClientID");
					String sql = null,testname ="";
					int examid=0,scheduleid=0;
					if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
					{
			//			clientid =1;
						response.sendRedirect("../jsp/Login.jsp");
					}
					else
						clientid = Integer.parseInt(ClientID);
						
					out.println("<HTML><HEAD><TITLE>Postponement Request</TITLE>");
					out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
					out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
					out.println("<BODY><CENTER>");
					out.println("<BR><B>Sorry your time is up for Posponement !!</B>");
					out.println("<FORM NAME=back METHOD=GET action="+request.getRequestURI()+">");
					out.println("<INPUT TYPE=SUBMIT VALUE='Go Back'>");
					out.println("</FORM>");
					out.println("</BODY></HTML>");
				}
				
			}
		}catch(Exception e){
			out.println("Error : " + e.getMessage());
		}finally{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}
%>