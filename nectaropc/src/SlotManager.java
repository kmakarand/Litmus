import java.io.*;
import java.sql.*;
import java.util.Vector;
import java.util.Calendar;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;
import com.ngs.gen.*;

public class SlotManager extends HttpServlet {
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null,rs1 = null,rs2 = null;

	public void init(){
		try{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
			con = pool.getConnection();
			
		}catch(Exception e){
			//System.out.println("Connection Error : " + e.getMessage());
		}
	}

	public void doGet(HttpServletRequest req,HttpServletResponse res) 
		throws ServletException,IOException {

		HttpSession session = req.getSession(true);
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		displayPageHeader(out);
		out.println("<BODY><CENTER>");
		out.println("<H4>Slot Availability Chart</H4><HR><BR>");

		String action = req.getParameter("action");
		String ClientID = (String) session.getAttribute("ClientID");

		if (ClientID == null || ClientID == ""|| ClientID.equals("0")){
			display_main_sub_form(req,res);
		}else if (action == null || action == ""){
			DisplayAvailableSlots(req, res);
		}
		out.println("</BODY></HTML>");
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) 
		throws ServletException,IOException{

		HttpSession session = req.getSession(true);
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		displayPageHeader(out);
		out.println("<BODY><CENTER>");
		out.println("<H4>Slot Availability Chart</H4><HR><BR>");
		String action = req.getParameter("action");

		if (action.equalsIgnoreCase("slotListBSE")){
			DisplayAvailableSlotsBSE(req, res);
		}
		out.println("</BODY></HTML>");
	}

	public synchronized void display_main_sub_form(HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException{

        try{
      
		HttpSession session = req.getSession(true);
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		out.println("<div align='center'>");
		out.println("<form action=" +req.getRequestURI()+ " method='POST'>");

		out.println("<input type=hidden name='action' value='slotListBSE'>");
		
		out.println("<table border='0' cellspacing='1' cellpadding='1' "+
							"width='50%' ALIGN='CENTER'>");
		//Code Added start here
		out.println("<tr><th colspan='2'>Select Client</th></tr>");
		out.println("<tr><td align='right'>Client Name : </td>");
		out.println("<td><select name='clientId'>");
		String sql = "SELECT * FROM ClientMaster";
		pstmt = con.prepareStatement(sql);
		rs2 = pstmt.executeQuery();
		while (rs2.next())
		{
			String clientName = rs2.getString("ClientName");
			String clientId = rs2.getString("ClientID");
			////System.out.println("clientID :"+clientId);
			////System.out.println("clientName :"+clientName);
			
			if (clientName.equals("") || clientName==null )
			{
				out.println("<option value='ALLClients' SELECTED>'ALLClients'</option>");
			}
			else
			out.println("<option value="+clientId+">"+clientName+"</option>");
			
		}
		out.println("<option value=0 SELECTED>ALLClients</option>");
		out.println("</select></td></tr>");
		
		//Code Added end here
		out.println("<tr><th colspan='2'>Select Month and Year</th></tr>");
		out.println("<tr><td align='right'>Month : </td>");
		out.println("<td><select name='month'>");
		out.println("<option value='01'>January</option>");
		out.println("<option value='02'>February</option>");
		out.println("<option value='03'>March</option>");
		out.println("<option value='04'>April</option>");
		out.println("<option value='05'>May</option>");
		out.println("<option value='06'>June</option>");
		out.println("<option value='07'>July</option>");
		out.println("<option value='08'>August</option>");
		out.println("<option value='09'>September</option>");
		out.println("<option value='10'>October</option>");
		out.println("<option value='11'>November</option>");
		out.println("<option value='12'>December</option>");
		out.println("</select></td></tr>");
		out.println("<tr><td align='right'>Year : </td>");
		out.println("<td><select name='year'>");

		Calendar today = Calendar.getInstance();
		int year = 0, thisyear = 0;
		thisyear = today.get(Calendar.YEAR);
		for (int i=-1; i <= 1 ; i++){
			year = thisyear + i;
			out.print("<option value='" + year + "' " +
				(year == thisyear?"SELECTED":"") + ">" + 
				year + "</option>");
		}
		out.println("</select></td></tr>");
		out.println("<tr><th colspan='2'>");
		out.println("<input type='submit' name='Submit' value='Submit'>");
		out.println("</th>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</form>");
		out.println("</div>");
        }catch(Exception e){
		 //System.out.println("Exception in display_main_sub_form Error : " + e.getMessage());
		}
	}	


	private void displayPageHeader(PrintWriter out) throws IOException{
		out.println("<HTML><HEAD><TITLE>Slot Availablity Chart</TITLE>");
		out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
	}

	public void DisplayAvailableSlots(HttpServletRequest req, HttpServletResponse res) 
		throws ServletException,IOException{

		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession(true);
		String sql = null;
		String action = req.getParameter("action");

		try{
			
			int clientid=0;
			String ClientID = "0";

			if (action == null || action == ""){
				ClientID = (String) session.getAttribute("ClientID");
			}else if (action.equalsIgnoreCase("slotListBSE")){
				//ClientID = req.getParameter("ClientID");
			}else{
				ClientID = "0";
			}

			if (ClientID == null || ClientID=="" || ClientID.equals(null) || ClientID.equals("")){
				out.println("Please, Login before checking Slot details.");
			}else{	
				clientid = Integer.parseInt(ClientID);

				String clname="",phone1="",phone2="",date="",timefrom="",timeto="",name="";
				int noseats=0,scheduleid=0,totreg=0;

				sql = "SELECT * FROM ClientMaster WHERE ClientID=" + clientid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()){
					clname = rs.getString("ClientName");
					phone1 = rs.getString("Phone1");
					phone2 = rs.getString("Phone2");
				}
				sql = "SELECT Name FROM ContactPersonsDetails WHERE ClientID=" + clientid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()){
					name = rs.getString("Name");
				}

				out.println("<TABLE BORDER=0 CAELLPADDING=1 CELLSPACING=1 WIDTH='60%'>");
				out.println("<TR><TH COLSPAN=2>Slot Availablity Datewise</TH></TR>");
				out.println("<TR><TD COLSPAN=2>");
				
				out.println("<TABLE BORDER=0 CAELLPADDING=1 CELLSPACING=1 WIDTH='100%'>");
				out.println("<TR><TH>Sr. No.</TH><TH>Test Date</TH><TH>Test Time</TH><TH>Seats Avaliable</TH></TR>");
				int count=1;
				sql = "SELECT * FROM Schedule WHERE ClientID=" + clientid + " ORDER BY ScheduleDate, TimeFrom, TimeTo";	//ExamID,CodeGroupID";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()){
					timefrom = rs.getString("TimeFrom");
					timefrom = timefrom.substring(0,5);
					timeto = rs.getString("TimeTo");
					timeto = timeto.substring(0,5);
					String time = timefrom + " - " + timeto;
					noseats = rs.getInt("NoOfSeats");
					date = Utils.getDate(rs.getString("ScheduleDate"));

					scheduleid = rs.getInt("ScheduleID");

					sql = "SELECT count(*) FROM SlotRegisteration WHERE ScheduleID=" + scheduleid;
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next()){
						totreg = rs1.getInt(1);
					}
					int availseats = 0;
					availseats = noseats-totreg;
					out.println("<TR><TD ALIGN=RIGHT>"+count+"</TD><TD ALIGN=CENTER>"+date+"</TD><TD ALIGN=CENTER>"+time+"</TD><TD ALIGN=CENTER>"+availseats+"</TD></TR>");
					count++;
				}
				out.println("</TABLE>");
				out.println("</TD></TR>");
				out.println("<TR><Th COLSPAN=2>&nbsp;</Th></TR>");
				out.println("</TABLE>");
			}
		}catch(Exception e){
			out.println("Error : " + e.getMessage());
		}finally{
			if (con != null) 
				pool.releaseConnection(con); 
	        else 
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>"); 
		}
	}

	public void DisplayAvailableSlotsBSE(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException,IOException{

			PrintWriter out = res.getWriter();
			HttpSession session = req.getSession(true);
			String year_month = req.getParameter("year") + "-" + req.getParameter("month");
			String varClientId = req.getParameter("clientId");
			////System.out.println("varClientId :"+varClientId);

			out.println("<TABLE BORDER=0 CAELLPADDING=1 CELLSPACING=1 WIDTH='60%'>");
			out.println("<TR><TH>Slot Availablity Datewise</TH></TR>");
			out.println("<TR><TD>");
			out.println("<TABLE BORDER=0 CAELLPADDING=1 CELLSPACING=1 WIDTH='100%'>");
			out.println("<TR><TH>Sr. No.</TH>"+
					"<TH>Client Name</TH>"+
					"<TH>Test Date</TH>"+
					"<TH>Test Time</TH>"+
					"<TH>Seats Avaliable</TH></TR>");


			try{
				con = pool.getConnection();
				PreparedStatement psSlot = con.prepareStatement("SELECT count(*) FROM SlotRegisteration "+
											"WHERE ScheduleID=?");
				PreparedStatement psClient = con.prepareStatement("SELECT * FROM ClientMaster "+
										" where ClientID=? order by ClientName");

				String sqlSchedule="";
                if(varClientId.equals("0"))
                {
					sqlSchedule =  "SELECT * FROM Schedule WHERE " + 
															" ScheduleDate like '"+ year_month +"-%' "	+
															" ORDER BY ScheduleDate, TimeFrom, TimeTo";	
                }
                else
                {
					sqlSchedule =  "SELECT * FROM Schedule WHERE " + 
															" ScheduleDate like '"+ year_month +"-%' "	+
															"and ClientID ="+varClientId+
															" ORDER BY ScheduleDate, TimeFrom, TimeTo";	
                }
				
			
				ResultSet rsSchedule = con.createStatement().executeQuery(sqlSchedule);
			
				int count=1;
				String oldDate = "";
			
				while(rsSchedule.next()){
					int totReg=0;
					int scheduleId = rsSchedule.getInt("ScheduleID");
					int clientId = rsSchedule.getInt("ClientID");
					int noseats = rsSchedule.getInt("NoOfSeats");
				
					String schDate = rsSchedule.getString("ScheduleDate");
					String time = (rsSchedule.getString("TimeFrom")).substring(0,5) + " - " + 
											(rsSchedule.getString("TimeTo")).substring(0,5);
					String date = Utils.getDate(schDate);
				
					if(oldDate.length()==0){
						oldDate = rsSchedule.getString("ScheduleDate");
					}else if(!oldDate.equals(schDate)){
						out.println("<TR><TD colspan=5>&nbsp;</TD></TR>");
						oldDate = schDate;
					}

					psSlot.setInt(1,scheduleId);
					ResultSet rsSlot = psSlot.executeQuery();
				
					if(rsSlot.next()){
						totReg = rsSlot.getInt(1);
					}else{
						totReg = 0;
					}
					
					psClient.setInt(1,clientId);
					ResultSet rsClient = psClient.executeQuery();
					String clientName = "";
					if(rsClient.next()){
						clientName = rsClient.getString("ClientName");
					}

					int availseats = noseats - totReg;
					out.println("<TR><TD ALIGN=RIGHT>"+ (count++) + "</TD>" +
							"<TD>"+clientName+"</TD>"+
							"<TD ALIGN=CENTER>"+date+"</TD>"+
							"<TD ALIGN=CENTER>"+time+"</TD>"+
							"<TD ALIGN=CENTER>"+availseats+" ("+noseats+")</TD></TR>");
				}

				out.println("</TABLE>");
				out.println("</TD></TR>");
				out.println("<TR><Th COLSPAN=5 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
				out.println("</TABLE>");
			}catch(Exception e){
				out.println("Error : " + e);
			}finally{
				if (con != null) 
					pool.releaseConnection(con); 
				else 
					out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>"); 
			}
		}



/*
	public void DisplayCenterSelectionScreen(HttpServletRequest req,HttpServletResponse res) 
			throws ServletException,IOException {

		HttpSession session=req.getSession(true);
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		String sql="";
		String CandidateID = req.getParameter("CandidateID");
		String ExamID = req.getParameter("ExamID");
		int cid = 0,lid=0,examid=0;
		if (CandidateID == null || CandidateID.equals("") || 
				CandidateID.equals(null) || CandidateID==""){
			cid = 2;
		}else{
			cid = Integer.parseInt(CandidateID);
		}

		if (ExamID == null || ExamID.equals("") || ExamID.equals(null) || ExamID==""){
			examid =1;
		}else{
			cid = Integer.parseInt(ExamID);
		}

		try{
			con = pool.getConnection();
			stmt = con.createStatement();
			
			out.println("<FORM METHOD='POST' ACTION='" +req.getRequestURI()+ "'>");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=2>Select Test Centre</TH></TR>");
			out.println("<TR><TD>Centre :</TD><TD><SELECT NAME='ClientID'>");
			sql = "SELECT ClientID,ClientName FROM ClientMaster ORDER BY ClientName";
			rs = stmt.executeQuery(sql);
			while (rs.next()){
				out.println("<OPTION VALUE="+rs.getInt("ClientID")+">"+rs.getString("ClientName")+"</OPTION>");
			}
			out.println("</SELECT></TD></TR>");
			out.println("<TR><INPUT TYPE='HIDDEN' NAME='action' VALUE='doViewSlots'>");
			out.println("<TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Submit></TH></TR>");
			out.println("</TABLE>");
			out.println("</FORM>");
		}catch(Exception e){
			out.println("Error : " + e.getMessage());
		}finally{
			if (con != null) 
				pool.releaseConnection(con); 
	        else 
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>"); 
		}
	}
*/
	public void destroy(){
	}
}
