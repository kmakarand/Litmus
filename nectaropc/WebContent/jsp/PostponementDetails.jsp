<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="com.ngs.gbl.RegistrationKey"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%!

	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	//Global variables
	int cid=0,lid=0,allotedid=0,isapproved=0,scheduleid=0;
	String clientname="",firstname="",lastname="",address="",scheduledate="",actualscheduledate="",postponereqdate="",day="",mth="",yr="",phone1="",phone2="",fax="",email="",name="",namephone1="",namephone2="",nameemail="",nameemail2="",city="",timefrom="",timeto="",approved="";

	final int ZILS_USER = 1;
	final int BSE_USER = 2;
	PreparedStatement pstmt =null;

private int posponeDetailsData(JspWriter out, boolean isBSE,int clientId,
			String clientName,int slno, String fromDate){
		try{
		
			//System.out.println("posponeDetailsData	start lid:");
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
			con = pool.getConnection();
			
			String strCandidateList="";
			String sql="SELECT CandidateID from CandidateMaster WHERE ClientID="+clientId;
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while(rs.next()){
				strCandidateList+=rs.getInt("CandidateID")+",";
				//System.out.println("posponeDetailsData	start strCandidateList:"+strCandidateList);
			}

			strCandidateList=strCandidateList.substring(0,strCandidateList.length()-1);
			sql = "SELECT * FROM PostponeSlotDetails where CandidateID in("+strCandidateList+") ";

			sql += isBSE?" AND PostponeRequestDate like '" + fromDate + "'" : "";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()){
				scheduleid = 0;
				cid = rs.getInt("CandidateID");

				sql = "SELECT FirstName,LastName FROM CandidateMaster WHERE CandidateID=" + cid;
				pstmt = con.prepareStatement(sql);
				ResultSet rs1 = pstmt.executeQuery();
				while (rs1.next()){
					firstname = rs1.getString("FirstName");
					lastname = rs1.getString("LastName");
				}

				int oldschid =0,newschid=0;
				String reqpostdate ="",oldscheduledate="",newscheduledate="";
				sql = "SELECT AllotedScheduleID,RequestedScheduleID,PostponeRequestDate FROM PostponeSlotDetails WHERE CandidateID=" + cid;
				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				if (rs1.next()){
					oldschid = rs1.getInt("AllotedScheduleID");
					newschid = rs1.getInt("RequestedScheduleID");
					reqpostdate = rs1.getString("PostponeRequestDate");
				}

				sql = "SELECT ScheduleDate FROM Schedule WHERE ScheduleID=" + oldschid;
				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				while (rs1.next()){
					oldscheduledate = rs1.getString("ScheduleDate");
				}

				sql = "SELECT ScheduleDate FROM Schedule WHERE ScheduleID=" + newschid;
				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();

				while (rs1.next()){
					newscheduledate = rs1.getString("ScheduleDate");
				}

				RegistrationKey regkey = new RegistrationKey (cid);
				out.println("<TR><TD ALIGN=RIGHT>" + slno++ + "</TD>"+
					(isBSE?"<TD>"+clientName+"</TD>":"")+
					"<TD>" + regkey.getKeyCode() + "</TD><TD>" +firstname + " " + lastname + "</TD><TD ALIGN=CENTER>" +  Utils.getFullDate(newscheduledate) +"</TD><TD ALIGN=CENTER>"+ Utils.getFullDate(reqpostdate) +"</TD><TD ALIGN=CENTER>" + Utils.getFullDate(oldscheduledate) + "</TD></TR>");
			}
		}catch(Exception e){
		}finally{
		   try{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		        }catch(Exception e){e.printStackTrace();}
		}
		return (isBSE?slno:0);
	}

%>

<%
		String action = request.getParameter("action");
		Query query=null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("PostponementDetails.jsp");
		Connection con = pool.getConnection();
		int cid=0,lid=0,allotedid=0,isapproved=0,scheduleid=0;
		String clientname="",firstname="",lastname="",address="",scheduledate="",actualscheduledate="",postponereqdate="",day="",mth="",yr="",phone1="",phone2="",fax="",email="",name="",namephone1="",namephone2="",nameemail="",nameemail2="",city="",timefrom="",timeto="",approved="";
	    final int ZILS_USER = 1;
		final int BSE_USER = 2;
		PreparedStatement pstmt =null;
		String sql="";
		int examid=0,clientid=0;

		String ClientID = (String)session.getAttribute("ClientID");
		//System.out.println("displayGetMonth	start ClientID:"+ClientID);
		
		if(ClientID==null || ClientID=="" || ClientID.equals("") || ClientID.equals("0")){
			Integer CandidateID = (Integer) session.getAttribute("CandidateID");
			cid = CandidateID.intValue();
			//System.out.println("displayGetMonth	start cid:"+cid);
			if (cid == BSE_USER || cid == ZILS_USER){
				
				try	{
					out.println("<HTML><HEAD><TITLE>Postponement List</TITLE>");
					out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'>");
					out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'></HEAD>");
					out.println("<BODY><CENTER>");
					out.println("<div align='center'>");
					out.println("<h4>Postponement Details</h4>");
					out.println("<form action=" +request.getRequestURI()+ " method='POST'>");
					out.println("<table border='0' cellspacing='1' cellpadding='1' width='50%' ALIGN='CENTER'>");
					out.println("<tr><th colspan='2'>Select Month and Year</th></tr>"+
						"<tr><td align='right'>Month : </td>"+"<td><select name='month'>"+
						"<option value='01'>January</option>"+"<option value='02'>February</option>"+
						"<option value='03'>March</option>"+"<option value='04'>April</option>"+
						"<option value='05'>May</option>"+"<option value='06'>June</option>"+
						"<option value='07'>July</option>"+"<option value='08'>August</option>"+
						"<option value='09'>September</option>"+"<option value='10'>October</option>"+
						"<option value='11'>November</option>"+"<option value='12'>December</option>"+
						"</select></td></tr>"+"<tr><td align='right'>Year : </td>");
					out.println("<td><select name='year'>");
					// -------------------------------
					Calendar today = Calendar.getInstance();
					int year = 0, thisyear = 0;
					thisyear = today.get(Calendar.YEAR);
					for (int i=-1; i <= 1 ; i++){
						year = thisyear + i;
						out.print("<option value='"+year + "' " +
								(year == thisyear?"SELECTED" : "") + ">"+year+"</option>");
					}
					out.println("</select></td></tr><tr><th colspan='2'>");
					out.println("<input type='submit' name='Submit' value='Submit'>");
					out.println("</th>");
					out.println("<input type=hidden name='action' value='MonthWiseListForBSE'>");
					out.println("</tr></table></form></div></body></html>");
					}
				catch(Exception e){
					out.println("Exception in MonthWiseListForBSE : " + e);
				}
			}
		}else{
			try	
			{
				if (action == null || action == ""){
					if (ClientID == null || ClientID.equals("") || ClientID.equals(null) ||
							ClientID=="" ||	ClientID.equals("0")){
					}else {
							try	{
								con = pool.getConnection();
								int clid = 0;
					////System.out.println("displayGetMonth	start clid:");
								clid = Integer.parseInt((String)session.getAttribute("ClientID"));
					////System.out.println("displayGetMonth	start clid:"+clid);
								sql = "SELECT ClientName,LocationID FROM ClientMaster WHERE ClientID=" + clid;
								pstmt = con.prepareStatement(sql);
								ResultSet rs = pstmt.executeQuery();
								while (rs.next())	{
									clientname = rs.getString("ClientName");
									lid = rs.getInt("LocationID");
									
									////System.out.println("displayGetMonth	start clientname:"+clientname);
									////System.out.println("displayGetMonth	start lid:"+lid);
								}
								//Module for other Clients
								out.println("<HTML><HEAD><TITLE>Centre Details : "+clientname+"</TITLE>");
								out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'>");
								out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'></HEAD>");
								out.println("<BODY><CENTER><H4><B>List of Candidates requesting Postponement</B></H4>");
					
								out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1 ALIGN=CENTER>");
								out.println("<TR><TH colspan=6>Postponement Details</TH></TR>");
								out.println("<TR><TD COLSPAN=6>");
					
								out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1 WIDTH'100%'>");
								out.println("<TR><TH>Sr. No.</TH>" +
									"<TH>Registration<BR> Number</TH>"+
									"<TH>Candidate Name</TH>"+
									"<TH>Date on which<BR> exams were<BR> scheduled</TH>"+
									"<TH>Date on which<BR> intimation of<BR> postponement received</TH>"+
									"<TH>Date to which<BR> exams postponed</TH></TR>");
					
								posponeDetailsData(out,false,clid,clientname,1,null);
								out.println("</TABLE>");
								out.println("<TR><Th COLSPAN=6 align=center>&nbsp;</Th></TR>");
								out.println("</TD></TR></TABLE>");
							}catch(Exception e){
								out.println("Add Mod Error : " + e.getMessage());
							}finally{
								if (con != null)
									pool.releaseConnection(con);
						        else
							        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
							}
					}
				}
				else if (action.equalsIgnoreCase("doDisplay"))	
				{
					try	{
							con = pool.getConnection();
							int clid = 0;
				
							clid = Integer.parseInt((String)session.getAttribute("ClientID"));
				
							sql = "SELECT ClientName,LocationID FROM ClientMaster WHERE ClientID=" + clid;
							pstmt = con.prepareStatement(sql);
							ResultSet rs = pstmt.executeQuery();
							while (rs.next())	{
								clientname = rs.getString("ClientName");
								lid = rs.getInt("LocationID");
							}
							//Module for other Clients
							out.println("<HTML><HEAD><TITLE>Centre Details : "+clientname+"</TITLE>");
							out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'>");
							out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'></HEAD>");
							out.println("<BODY><CENTER><H4><B>List of Candidates requesting Postponement</B></H4>");
				
							out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1 ALIGN=CENTER>");
							out.println("<TR><TH colspan=6>Postponement Details</TH></TR>");
							out.println("<TR><TD COLSPAN=6>");
				
							out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1 WIDTH'100%'>");
							out.println("<TR><TH>Sr. No.</TH>" +
								"<TH>Registration<BR> Number</TH>"+
								"<TH>Candidate Name</TH>"+
								"<TH>Date on which<BR> exams were<BR> scheduled</TH>"+
								"<TH>Date on which<BR> intimation of<BR> postponement received</TH>"+
								"<TH>Date to which<BR> exams postponed</TH></TR>");
				
							posponeDetailsData(out,false,clid,clientname,1,null);
							out.println("</TABLE>");
							out.println("<TR><Th COLSPAN=6 align=center>&nbsp;</Th></TR>");
							out.println("</TD></TR></TABLE>");
						}catch(Exception e){
							out.println("Add Mod Error : " + e.getMessage());
						}finally{
							if (con != null)
								pool.releaseConnection(con);
					        else
						        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
						}
				}
				else if (action.equalsIgnoreCase("MonthWiseListForBSE"))	
				{
				
				//System.out.println("MonthWiseListForBSE	start action:"+action);
					try	{
						con = pool.getConnection();
						String SelMonth=request.getParameter("month");
						String SelYear=request.getParameter("year");
						int clid = 0;
			//			String NSql="select * from schedule where ScheduleDate like '"+SelYear+"-"+SelMonth+"-%'";
						int count=1;
			
						try {
							clid = Integer.parseInt(request.getParameter("clientid"));
						} catch (Exception e) {
							clid = Integer.parseInt((String)session.getAttribute("ClientID"));
						}
			
						//Module for BSE
						out.println("<HTML><HEAD><TITLE>Postponement Details : BSE</TITLE>");
						out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'><META HTTP-EQUIV='Pragma' CONTENT='no-cache'></HEAD>");
						out.println("<BODY><CENTER><H4><B>List of Candidates requesting Postponement</B></H4>");
						out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1 ALIGN=CENTER>");
						out.println("<TR><TH colspan=7><B>Postponement Details</B></TH></TR><TR><TD COLSPAN=7>");
			
						out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1 WIDTH'100%'>");
						out.println("<TR><TH>Sr. No.</TH>"+
							"<TH>Client Name</TH>" +
							"<TH>Registration<BR> Number</TH>"+
							"<TH>Candidate Name</TH>"+
							"<TH>Date on which<BR> exams were<BR> scheduled</TH>"+
							"<TH>Date on which<BR> intimation of<BR> postponement received</TH>"+
							"<TH>Date to which<BR> exams postponed</TH></TR>");
			
						String sqlClient="select ClientID,ClientName from ClientMaster order by ClientID";
						pstmt = con.prepareStatement(sqlClient);
						ResultSet rs = pstmt.executeQuery();
			
						int slno = 1;
						while(rs.next()){
							slno = posponeDetailsData(out,true,rs.getInt("ClientID"), rs.getString("ClientName"),
											slno, SelYear+"-"+SelMonth+"-%");
						}
			
						out.println("</TABLE>");
						out.println("</TD></TR>");
						out.println("<TR><Th COLSPAN=7 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR></TABLE>");
					}
					catch(Exception e)		{
						out.println("Add Mod Error : " + e.getMessage());
					}
					finally		{
						if (con != null)
							pool.releaseConnection(con);
				        else
					        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
					}
				}
			}catch(Exception e)	{
				out.println("Error : " + e.getMessage());
			}finally{
				if (con != null)
					pool.releaseConnection(con);
				else
					out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
			}
		}
		
		
		
%>