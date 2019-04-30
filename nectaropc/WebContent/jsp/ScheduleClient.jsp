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
		ClientmasterDAO cmDAO = new ClientmasterDAO();
		ScheduleDAO scDAO = new ScheduleDAO();
		CandidatemasterDAO cndDAO = new CandidatemasterDAO();
		Logger log = Logger.getLogger("ScheduleClient.jsp");
		Connection con = pool.getConnection();
		EntityManager em = EntityManagerHelper.getEntityManager();
		PreparedStatement pstmt = null;
		ResultSet rs = null,rs1 = null,rs2 = null;
		Vector vlocationid = new Vector();
		
		if (action == null || action == "")
			{
				String sql = null;
				try
				{
					int clientid = Integer.parseInt(request.getParameter("clientid")) ;
					String clientname = "" ;
					int noseats = 0;
		//out.println("clid : " + clientid);
					sql = "select ClientName,AvailableSeats from ClientMaster WHERE ClientID=" + clientid;
					pstmt =con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next())
					{
						clientname = rs.getString("ClientName");
						noseats = rs.getInt("AvailableSeats");
					}
		
					sql = "SELECT ScheduleID FROM Schedule WHERE ClientID=" + clientid;
		//out.println(sql);
				  	pstmt =con.prepareStatement(sql);
				  	rs = pstmt.executeQuery();
					if (!rs.next())
					{
						boolean check =false;
						sql = "SELECT * FROM Schedule WHERE ScheduleDate >= CURRENT_DATE GROUP BY ScheduleDate,TimeFrom,TimeTo ORDER BY ScheduleDate";
		//out.println("<br>"+sql);
						pstmt =con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while (rs.next())
						{
							String schdate = rs.getString("ScheduleDate");
							String timefrom = rs.getString("TimeFrom");
							String timeto = rs.getString("TimeTo");
							com.ngs.gen.NextValues scheduleID    =   new com.ngs.gen.NextValues("Schedule", "ScheduleID");
							int nextscheduleID    =    scheduleID.getNextValue();
							boolean val    =    scheduleID.setNextValue();
		
							sql = "INSERT INTO Schedule (ScheduleID,ClientID,ExamID,SectionID,ScheduleDate,TimeFrom,TimeTo,NoOfSeats) VALUES (" + nextscheduleID + "," + clientid + ",31,1,'" + schdate + "','" + timefrom + "','" + timeto + "'," + noseats +")";
		//out.println("<br>"+sql);
		  					pstmt =con.prepareStatement(sql);
							int confirm = pstmt.executeUpdate();
							if (confirm <= 0)
							{
								out.println("Problem in Inserting in Schedule !!");
							}
							else
							{
								check = true;
							}
						}
						if (check == true)
						{
							out.println("" + clientname + " properly registered and scheduled !!");
						}
					}
					else
					{
						out.println("Schedule Already present for the selected Client <B>"+clientname+"</b> !!");
						out.println("<BR><INPUT TYPE=BUTTON VALUE=BACK onclick='javascript:history.back();'>");
					}
				}
				catch(Exception e)
				{
					out.println("Add Mod Error : " + e.getMessage());
				}
				finally
				{
					if (con != null)
						pool.releaseConnection(con);
			        else
				        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
				}
			}
			
%>