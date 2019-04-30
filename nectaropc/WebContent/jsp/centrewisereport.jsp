<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = req.getParameter("action");
		Query query=null;
		int cid = Integer.parseInt(req.getParameter("CandidateID"));
		PreparedStatement pstmt = null;
		Statement stmt_performance_details=null;Statement stmt_contact_details = null;Statement stmt_address_deatils = null;Statement stmt_client_master = null;Statement stmt_data_fetch = null;	Statement stmt5 = null;Statement stmt_performance_details1=null;Statement stmt_performance_details2=null;Statement stmt_performance_details3=null;Statement stmt_candidate_master=null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs_performance_details=null;ResultSet rs_contact_details = null;ResultSet rs_address_deatils = null;ResultSet rs_client_master = null;ResultSet rs_data_fetch = null;ResultSet rs5 = null; ResultSet rs_performance_details1=null;ResultSet rs_performance_details2=null;ResultSet rs_performance_details3=null;ResultSet rs_candidate_master=null;
		StringTokenizer stringtoken=null;
		String scheduleID=null;
		String clientName=null,candID=null;
		EntityManager em = EntityManagerHelper.getEntityManager();
		Query query=null;List<Object[]> objList=null;
		ScheduleDAO scDAO = new ScheduleDAO();
		Schedule sc = new Schedule();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Connection con = pool.getConnection();
		
		out.println("<html><head><title>Subject Manager</title>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='alm.css'></head>");
		
		if (action == null || action == "")
		{
			SequenceNo=1;
			try
			{
				//con=pool.getConnection();
				sql = "SELECT * FROM Schedule";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				stmt_client_master=con.createStatement();
				rs_client_master=stmt_client_master.executeQuery("Select * from ClientMaster where ClientType='1'");
			}
			catch(Exception ex)
			{
				out.print(" CONNECTION FAILURE :"+ex+"<BR>");
			}
	
			out.println("<h5 align='center'><b>Candidates' Master List<br>");
			out.println(" </b></h5>");
			out.println("<form action=" +req.getRequestURI()+ " method='get'>");
			out.println(" <table border='0' cellspacing='1' cellpadding='1' align='center'>	<tr> <th colspan='2'>");
			out.println("<div align='center'>Select test center and test date for summary of Exam conducted. </div>  </th>");
			out.println("</tr><tr><td align='right'><div align='right'>Test Center :</div>  </td> <td>");
			out.println("<select name='center'>");
			try
			{
				while (rs_client_master.next())
				{
					out.println("<option value="+rs_client_master.getString("ClientID")+">"+rs_client_master.getString("ClientName")+"</option>");
				}
			}
			catch(Exception ex)
			{}
			out.println("</select>");
			out.println("</td></tr><tr><td align='right'>");
	
			out.println("<div align='right'>Test Date :</div> </td><td>");
	
			out.println("<select name='date'>");
	
			try
			{
				rs_performance_details.beforeFirst();
				while (rs_performance_details.next())
				{
					out.println("	<option value="+rs_performance_details.getString("ScheduleDate")+">"+rs_performance_details.getString("ScheduleDate")+"</option>");
				}
			}
			catch(Exception ex)
			{
				out.print("EXCEPTION  IN THE DROP DOWN :"+ex);
			}
	
			out.println("</select>");
			out.println("</td></tr><tr>");
	
			out.println("<td align='right'>Test Time :</div></td><td>");
	
			out.println("<select name='time'>");
			try
			{
				rs_performance_details.beforeFirst();
				while (rs_performance_details.next())
				{
				String timefrom=rs_performance_details.getString("TimeFrom");
				String timeto=rs_performance_details.getString("TimeTo");
				out.print("SubString"+timefrom.substring(1,6));
	
				out.println("	<option value="+rs_performance_details.getString("ScheduleID")+">"+timefrom.substring(0,5)+" to "+timeto.substring(0,5)+"</option>");
				}
			}
			catch(Exception ex)
			{
				out.print("EXCEPTION  IN THE DROP DOWN :"+ex);
			}
	
			out.println("</select>");
			out.println("</td></tr><tr> ");
			out.println("<td colspan='2'> ");
			out.println("<div align='center'>");
			out.println("<input type='submit' name='Submit' value='Display Summary'>");
			out.println("<input type=hidden name='action' value='reportgenerator'>");
			out.println("</div>");
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("</form>");

		}//end of action null
		else if (action.equals("reportgenerator"))
		{
			String timefrom = null;
			String timeto = null;
	
			res.setContentType("text/html");
			PrintWriter out = res.getWriter();
			String questionType = null;
	
			try
			{
				
				Schedule sc = scDAO.findById(Integer.parseInt(req.getParameter("time")));
				{
						timefrom = sc.getTimeFrom();
						timeto = sc.getTimeTo();
						scheduleID = String.valueOf(sc.getScheduleId());
				}
	
	//			stmt_performance_details = con.createStatement();
				sql = "Select s.clientId from Schedule s where s.clientId=?1 and s.scheduleDate=?2 and s.timeFrom=?3 and s.timeTo=?4";
				query = em.createQuery(sql);
				query.setParameter(1,req.getParameter("center"));
				query.setParameter(2,req.getParameter("date"));
				query.setParameter(3,req.getParameter("timefrom"));
				query.setParameter(4,req.getParameter("timeto"));
				String clientID=(String)query.getSingleResult();
				
				/*sql = "Select * from ContactPersonsDetails where ClientID=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,clientID);
				rs = pstmt.executeQuery();
	
				sql = "Select * from ClientMaster where ClientID=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,clientID);
				rs = pstmt.executeQuery();*/
				
				ClientmasterDAO clmDAO = new ClientmasterDAO();
				sql = "Select clm.clientName from Clientmaster clm where clm.clientId=?1";
				clientName = (String)query.getSingleResult();
				
	
			}
			catch(Exception ex)
			{
				out.print(" CONNECTION FAILURE :"+ex+"<BR>");
			}
	
			out.println("<h5 align='center'><b>Candidates' Master List</b><br>");
			out.println("<br></h5>");
			out.println("<table width='100%' border='0' cellspacing='1' cellpadding='1'>");
			out.println("<tr><th colspan='4'>Summary of the Exam Conducted</th></tr><tr> ");
			out.println("<td align='right'>Test Center :</td>");
			out.println("<td colspan=3>" +clientName+ "</td>");
			out.println("</tr> ");
	
			try
			{
				rs_performance_details2.beforeFirst();
				while (rs_performance_details2.next())
				{
					out.println("		 <tr><td align='right'>Center Telephone :</td>");
					out.println("		<td>"+rs_performance_details2.getString("Phone1")+"</td>");
					out.println("		<td align='right'>Center Fax :</td>");
					out.println("		<td>"+rs_performance_details2.getString("Fax")+"</td>");
					out.println("	  </tr>	  <tr>");
					out.println("		<td align='right'>City :</td>");
					out.println("		<td>"+rs_performance_details2.getString("Address")+"</td>");
					out.println("		<td align='right'>E-mail :</td>");
					out.println("		<td>"+rs_performance_details2.getString("Email")+"</td>");
					out.println("	  </tr><tr> ");
				}
				//(stringtoken=new StringTokenizer(req.getParameter("date"),"#"))(stringtoken=new StringTokenizer( req.getParameter("time"),"#"))
				out.println("		<td align='right'>Test Date:</td>");
				out.println("		<td>"+req.getParameter("date")+"</td>");
				out.println("		<td align='right'>Test Time :</td>");
				out.println("		<td>"+timefrom+" to "+timeto+"</td>");
				out.println("	  </tr> <tr> ");
				while (rs_contact_details.next())
				{
					out.println("		<td align='right'><b>Contact Person Details</b></td>");
					out.println("		<td colspan='3'>&nbsp;</td>");
					out.println("	  </tr> <tr> ");
					out.println("		<td align='right'>Name :</td>");
					out.println("		<td>"+rs_contact_details.getString("Name")+"</td>");
					out.println("		<td align='right'>&nbsp;</td>");
					out.println("		<td>&nbsp;</td> </tr> <tr> ");
					out.println("		<td align='right'>Phone :</td>");
					out.println("		<td>"+rs_contact_details.getString("Phone1")+"</td>");
					out.println("		<td align='right'>E-mail :</td>");
					out.println("		<td>"+rs_contact_details.getString("Email1")+"</td>");
				}
	
				out.println("	  </tr> <tr> ");
				out.println("		<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td> </tr>  <tr> ");
				out.println("		<td colspan='4'> ");
				out.println("		  <table width='100%' border='0' cellspacing='1' cellpadding='1'>");
				out.println("			<tr>   <th>Sr.No.</th>  <th>Reg.No.</th> <th>Candidate Name</th>  <th>Address</th>  <th>Phone</th> <th>Candidate Sign</th> <th>Invigilator Sign</th> <th>Score (%)</th>  <th>Result</th></tr> ");
	
				stmt_performance_details3=con.createStatement();
				//out.println("<BR>Select * from SlotRegisteration where ScheduleID=\'"+scheduleID+"\'");
	
				stmt_candidate_master=con.createStatement();
				stmt_address_deatils=con.createStatement();
				rs_performance_details.beforeFirst();
	
				rs_performance_details3=stmt_performance_details3.executeQuery("Select * from SlotRegisteration where ScheduleID=\'"+scheduleID+"\'");
				String clientID3=null;
	
				while (rs_performance_details3.next())
				{
					rs_performance_details=stmt_performance_details.executeQuery("Select * from Schedule where ClientID=\'"+req.getParameter("center")+"\' and ScheduleDate=\'"+req.getParameter("date")+"\' and TimeFrom=\'"+timefrom+"\' and TimeTo=\'"+timeto+"\' and ScheduleID=\'"+rs_performance_details3.getString("ScheduleID")+"\'");
	
					//out.println("<BR>Select * from Schedule where ClientID=\'"+req.getParameter("center")+"\' and ScheduleDate=\'"+req.getParameter("date")+"\' and TimeFrom=\'"+timefrom+"\' and TimeTo=\'"+timeto+"\' and ScheduleID=\'"+rs_performance_details3.getString("ScheduleID")+"\'");
					//clientID3=rs_performance_details3.getString("CandidateID");
					while (rs_performance_details.next())
					{
						clientID3=rs_performance_details3.getString("CandidateID");
	
						//out.println("<BR>Select * from CandidateMaster where CandidateID=\'"+clientID3+"\'");
						//out.println("<BR>Select * from AddressDetails where AddressDetails.CandidateID="+clientID3+"");
	
						rs_candidate_master=stmt_candidate_master.executeQuery("Select * from CandidateMaster where CandidateID=\'"+clientID3+"\'");
						rs_address_deatils=stmt_address_deatils.executeQuery("Select * from AddressDetails where CandidateID="+clientID3+"");
	
						String name=null;
						while (rs_candidate_master.next())
						{
							name=rs_candidate_master.getString("FirstName");
							candID=rs_candidate_master.getString("CandidateID");
						}
	
						int i=1;
						try
						{
							while (rs_address_deatils.next())
							{
								RegistrationKey regkey = new RegistrationKey (i);
								String  key = regkey.getKeyCode();
	
								out.println("	<tr>   <td><div align='right'>"+i+"</div> </td>  <td>"+key+"</td>  <td>"+name+"</td>  <td>"+rs_address_deatils.getString("Address")+",<BR>"+rs_address_deatils.getString("Street")+",<BR>"+rs_address_deatils.getString("LocationID")+",<BR>PINCODE : "+rs_address_deatils.getString("Pincode")+"</td>  <td>321456</td> <td>&nbsp;</td>  <td>&nbsp;</td> <td align='right'>68.78</td>  <td>Pass</td></tr> ");
								i++;
							}
						}
						catch(Exception ex)
						{
							out.print("EXCEPTION IN ADDRESS DETAILS"+ex);
						}
					}//   Select * from SlotRegisteration where ScheduleID
				}//rs_performance_details.next()
				out.println("	  </table></td></tr></table>");
				out.println("	<p align='center'>&nbsp; </p>");
				out.println("	<p>&nbsp;</p>");
				out.println("<a HREF='Centre_Report'> BACK </a>");
			}
			catch(Exception ex)
			{
				out.print("EXCEPTION CAUGHT "+ex);
			}
		}
		else if (action.equals("overall"))
		{
			out.print("<b>Overall Performance Report</b>");
			
		}
		
%>