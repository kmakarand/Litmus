import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ngs.gen.Utils;


public class Monthly_Summary extends HttpServlet
{
	
	public Monthly_Summary(){}

	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null, stmt1 = null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
	StringTokenizer stringtoken=null;
	String scheduleID=null;	
	
	public void database_handler(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException
	{

		String action = req.getParameter("action");
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
	}//end of the database handler

	HttpSession session	= null;
	String sql = null;
	String question_engine_Type=null;
	int SequenceNo;
	String fDir = "";
	boolean doLogin = false;

	public void init()
	{						
	}// end of INIT
	
	public synchronized void display_css(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		String action = req.getParameter("action");
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		out.println("<html><head><title>Monthly Summary Report</title>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></head>");
	}

	public synchronized void report_engine(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException
	{
		HttpSession session = req.getSession(true);
		
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		String questionType=null;
		
		try{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		}catch(Exception ex){
			out.print("EXCEPTION CAUGHT "+ex);
		}
		out.print("<div align='center'> ");
		out.print("<h4>Monthly Summary Statement</h4>");
		out.print("<form name='form1' method='post' action=''>");
					
		String month = req.getParameter("month");
		String year = req.getParameter("year");
		String wild_month_year = year+"-"+month;

		String ClientID = "" + session.getAttribute("ClientID");
		String sql = "";

		try{	
			con=pool.getConnection();
			
//check for valid month
			sql = "SELECT ScheduleID FROM Schedule WHERE ScheduleDate LIKE '" +
					wild_month_year+ "%' ORDER BY ScheduleDate ";
			pstmt = con.prepareStatement(sql);
			ResultSet rs7 = pstmt.executeQuery();
			StringBuffer canschedule = new StringBuffer();
			StringBuffer canids = new StringBuffer();
			if (rs7.next())
			{
				int totcan=0,totappear=0,totpassed=0,totfailed=0,totabsent=0,grossamt=0;
				float grandtot = 0,totamtcollected=0;
				out.print("<table border='0' cellspacing='1' cellpadding='1'>");
				out.print("<tr> ");
				out.print("<th>Sr. No.</th>");
				out.print("<th>Date of Test</th>");
				out.print("<th>Test Time</th>");
				out.print("<th>No. of<BR>Candidates<BR>Registered</th>");
				out.print("<th>No. of<BR>Candidates<BR>Appeared</th>");
				out.print("<th>No. of<BR>Candidates<BR>Passed</th>");
				out.print("<th>No. of<BR>Candidates<BR>Failed</th>");
				out.print("<th>No. of<BR>Candidates<BR>Absent<BR>(Whose fees <BR>are forfited)</th>");
				out.print("<th>Amount<BR>Collected</th>");
				out.print("<th>Gross Amount<BR>due to BSE <BR>@ Rs. 150 per <BR>candidate appeared <BR>for the test & <BR>@ Rs. 550 per <BR>candidate absent <BR>for the test</th>");
				out.print("</tr>");

//Schedules falling in this month
				sql = "SELECT ScheduleID FROM Schedule WHERE ScheduleDate LIKE '" + wild_month_year + "%' AND ScheduleDate <= CURRENT_DATE";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()){
					canschedule.append(rs.getInt("ScheduleID"));
					canschedule.append(",");
				}
				String candList = canschedule.toString().substring(0,canschedule.length()-1);

//candidates registered for those Schedules for this client
				sql = "SELECT CandidateID FROM CandidateMaster WHERE ScheduleID IN (" + candList + ") AND ClientID=" + ClientID;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()){
					canids.append(rs.getInt("CandidateID"));
					canids.append(",");
				}
				String candIDS = canids.toString().substring(0,canids.length()-1);

//Details of all those candidates 
				sql = "SELECT * FROM CandidateMaster WHERE CandidateID IN (" + candIDS + ") and ClientID=" + ClientID + " and CandidateID >3 and ScheduleID>0 GROUP BY ScheduleID ORDER BY ScheduleID,FirstName";//GROUP BY ScheduleID 
//out.println("SELECT * FROM CandidateMaster WHERE CandidateID IN (" + candIDS + ") and ClientID=" + ClientID + " and CandidateID >3 and ScheduleID>0 GROUP BY ScheduleID ORDER BY ScheduleID,FirstName");
  				pstmt = con.prepareStatement(sql);
  				rs = pstmt.executeQuery();
				int count=1;
				int ScheduleID = 0;
				int ExamID = 0;
				int SectionID = 0;
				float TotalAmount = 0;
				float PresentAmount = 0;
				float AbsentAmount = 0;

				String timefrom = null;
				String timeto = null;
				String ExamDate = null;
//out.println(sql);	
				while (rs.next())
				{
					timefrom = "";
					timeto = "";
					int NumberTotal = 0;
					int NumberPresent = 0;
					int NumberAbsent = 0;
					ScheduleID = rs.getInt("ScheduleID");
					int cid = rs.getInt("CandidateID");
					try{	   
					rs1 = stmt1.executeQuery("Select * from Schedule WHERE ScheduleID="+ScheduleID );
					}catch(Exception e){}
//out.println("Select * from SlotRegisteration WHERE ScheduleID="+ScheduleID);
					while (rs1.next()){
						timefrom 	= rs1.getString("TimeFrom");
						timeto   	= rs1.getString("TimeTo");
						SectionID 	= rs1.getInt("SectionID");
						ExamDate 	= rs1.getString("ScheduleDate");
					}
					try{
					sql = "Select ExamID from CandidateDetails WHERE CandidateID="+cid;
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();	   
					}catch(Exception e){}
					while (rs1.next()){
						ExamID 		= rs1.getInt("ExamID");						
					}

					
					if (timefrom != "" && timefrom != null)
						timefrom = timefrom.substring(0, 5);
					if (timeto != "" && timeto != null)
						timeto = timeto.substring(0, 5);

					out.print("<tr> ");
					out.print("<td align='right'>" +count+ "&nbsp;</td>");
					out.print("<td align='center'>" +Utils.getFullDate(ExamDate)+ "&nbsp;</td>");
					out.print("<td align='center'>" +timefrom+ " - " +timeto+ "</td>");
					
					try{	
					sql = "Select count(*) from SlotRegisteration WHERE ScheduleID="+ScheduleID + " GROUP BY ScheduleID";
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();	   
					}catch(Exception e){}
					while (rs1.next()){
						NumberTotal = rs1.getInt(1);
						out.print("<td align='right'>" +NumberTotal+ "&nbsp;</td>");
						totcan = totcan+NumberTotal;
					}

					try{
					sql = "Select count(*) from SlotRegisteration WHERE Attended=1 AND ScheduleID="+ScheduleID;
					pstmt = con.prepareStatement(sql);
					rs2 = pstmt.executeQuery();	
					}catch(Exception e){}
					while (rs2.next()){
						NumberPresent = rs2.getInt(1);
						out.print("<td align='right'>" +NumberPresent+ "&nbsp;</td>");
						totappear = totappear + NumberPresent;
					}
					
					try{
					sql = "Select COUNT(DISTINCT(CandidateID)) from NewPerformanceMaster WHERE CandidateID IN ("+candIDS+") AND ExamID=" +ExamID+ " AND SectionID=" +SectionID+ " AND Date='" +ExamDate+ "' AND Result=1";
					pstmt = con.prepareStatement(sql);
					rs3 = pstmt.executeQuery();	
					}catch(Exception e){}

					while (rs3.next()){
						int temp = rs3.getInt(1);
						 out.print("<td align='right'>" +temp+ "&nbsp;</td>");
						totpassed += temp;
					}
					try{
					sql = "Select COUNT(DISTINCT(CandidateID)) from NewPerformanceMaster WHERE CandidateID IN ("+candIDS+") AND ExamID=" +ExamID+ " AND SectionID=" +SectionID+ " AND Date='" +ExamDate+ "' AND Result=0";
					pstmt = con.prepareStatement(sql);
					rs4 = pstmt.executeQuery();	
					}catch(Exception e){}

					while (rs4.next()){
						int temp = rs4.getInt(1);
						 out.print("<td align='right'>" +temp+ "&nbsp;</td>");
						 totfailed += temp;
					}
					try{
					sql = "Select count(*) from SlotRegisteration WHERE Attended=0 AND ScheduleID=" +ScheduleID;
					pstmt = con.prepareStatement(sql);
					rs5 = pstmt.executeQuery();	
					}catch(Exception e){}

					while (rs5.next()){
						NumberAbsent = rs5.getInt(1);
						out.print("<td align='right'>" +NumberAbsent+ "&nbsp;</td>");
						totabsent += NumberAbsent;
					}
					
					String Criteria = "";
					try{
					sql = "SELECT * FROM RevenueSharing WHERE Client='BSE'";
					pstmt = con.prepareStatement(sql);
					rs6 = pstmt.executeQuery();	
					}catch(Exception e){}

					while (rs6.next()){
						TotalAmount = rs6.getFloat("Amount");
						Criteria = rs6.getString("Criteria");
						PresentAmount =0;
						AbsentAmount =0;
						if (Criteria.equalsIgnoreCase("Present")){
							PresentAmount = rs6.getFloat("ClientShare");
						}
						else if (Criteria.equalsIgnoreCase("Absent")){
							AbsentAmount = rs6.getFloat("ClientShare");
						}
					}
					float dueAmount = 0;
//					try{
						dueAmount = (NumberPresent * 150) + (NumberAbsent * 550);
//					}catch(Exception e){}
//					out.println(NumberPresent + " " + PresentAmount + " " + NumberAbsent + " " + AbsentAmount);
					float cal = (NumberTotal * TotalAmount);
					totamtcollected += cal;
					grossamt += dueAmount;
					grandtot += dueAmount;
					out.print("<td align='right'>&nbsp;" +(NumberTotal * TotalAmount)+ "</td>");
					out.print("<td align='right'>" + dueAmount+ " &nbsp;</td>");
					out.print("</tr>");
//					out.println(NumberTotal + " " + TotalAmount);
					count++;

				}
				out.print("<tr><th colspan=3 align=center>Grand Total :</th>");
				out.print("<th align='right'>"+totcan+"&nbsp;</th>");
				out.print("<th align='right'>"+totappear+"&nbsp;</th>");
				out.print("<th align='right'>"+totpassed+"&nbsp;</th>");
				out.print("<th align='right'>"+totfailed+"&nbsp;</th>");
				out.print("<th align='right'>"+totabsent+"&nbsp;</th>");
				out.print("<th align='right'>"+totamtcollected+"&nbsp;</th>");
				out.print("<th align='right'>"+grandtot+"&nbsp;&nbsp</th></tr>");
				out.println("<TR><Th COLSPAN=11 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR></TABLE>");
			}
			else{
				out.println("<h4>No Exams were conducted during this month.</h4>");
			}
		}catch(Exception e){
			out.print("EXCEPTION occured while creating Report.<BR>"+e);
		}

		 out.print("</table>");
		 out.print("</form>");
		 out.print("</div>");
		 out.print("<p align=center>&nbsp;</p>");
//		 out.print("<input type=Button Value='Go Back' onclick='history.back();'>");	
	}
	
	public synchronized void overal_report(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException
	{
			res.setContentType("text/html");
			PrintWriter out = res.getWriter();
	}

	
	public synchronized void display_main_sub_form(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
	{			
		String action = req.getParameter("action");
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
		HttpSession session = req.getSession(true);

		out.println("<div align='center'>");
		out.println("<h4>Monthly Summary Statement</h4>");
		out.println("<form action=" +req.getRequestURI()+ " method='get'>");
		out.println("<table border='0' cellspacing='1' cellpadding='1' width='50%'>");
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
// -------------------------------
		Calendar today = Calendar.getInstance();
		int year = 0, thisyear = 0;

		thisyear = today.get(Calendar.YEAR);

		for (int i=-1; i <= 1 ; i++)
		{
			year = thisyear + i;

			out.print("<option value='");
			out.print( year );
			if (year == thisyear)
				out.print("' SELECTED>");
			else
				out.print("'>");

			out.print( year );
			out.println("</option>");
		}
// -------------------------------

		out.println("</select></td></tr>");
		out.println("<tr><th colspan='2'>");
		out.println("<input type='submit' name='Submit' value='Show Report'>");
		out.println("</th>");
		int cid = 0;
		String ClientID = (String)session.getAttribute("ClientID");
		if(ClientID.equals("0") || ClientID==null || ClientID=="" || ClientID.equals("")  )
		{
			Integer CandidateID = (Integer) session.getAttribute("CandidateID");
			cid = CandidateID.intValue();
			if (cid == 2 || cid ==1)
			{
				out.println("<input type=hidden name='action' value='doBSEMomthlyReport'>");
				
			}
		}
		else
		{
//out.println("client id : " + ClientID);
			out.println("<input type=hidden name='action' value='reportgenerator'>");
		}
		out.println("</tr>");
		out.println("</table>");
		out.println("</form>");
		out.println("</div>");
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		String action = req.getParameter("action");
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
		int cid =0;

		if (action == null || action == "")
		{
			SequenceNo=1;
			display_css(req,res);
			display_main_sub_form(req,res);			
		}//end of action null
		else if (action.equals("reportgenerator")){
			display_css(req,res);
			report_engine(req,res);
		}else if (action.equals("overall")){
			display_css(req,res);
			overal_report(req,res);
		}
		else if (action.equals("doBSEMomthlyReport")){
			display_css(req,res);
//			out.print("<b>Overall Performance Report</b>");
			//overal_report(req,res);
			BSEMomthlyReport(req,res);
		}
	}//end of public void doGet

///////////*****************************************///////////////

	public synchronized void BSEMomthlyReport(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException
	{
		HttpSession session = req.getSession(true);
		
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
		String questionType=null;
		
		try{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		}catch(Exception ex){
			out.print("EXCEPTION CAUGHT "+ex);
		}
		out.print("<div align='center'> ");
		
		out.print("</tr>");
			
		String month = req.getParameter("month");
		String year = req.getParameter("year");
		String wild_month_year = year+"-"+month;

		String ClientID = "" + session.getAttribute("ClientID");
		String sql = "";

		try{	
			con=pool.getConnection();
			
// Check for schedule for the particular month			
			sql = "SELECT ScheduleID FROM Schedule WHERE ScheduleDate LIKE '" +
					wild_month_year+ "%' and ScheduleDate <= CURRENT_DATE ORDER BY ScheduleDate ";
//out.println(sql);
			StringBuffer canschedule = new StringBuffer();
			pstmt = con.prepareStatement(sql);
			ResultSet rs7 = pstmt.executeQuery();
			if (rs7.next())
			{

				int totcan=0,totappear=0,totpassed=0,totfailed=0,totabsent=0,grossamt=0;
				float grandtot = 0,totamtcollected=0;
				out.print("<h4>Monthly Summary Statement</h4>");
				out.print("<form name='form1' method='post' action=''>");
				out.print("<table border='0' cellspacing='1' cellpadding='1'>");
				out.print("<tr> ");
				out.print("<th>Sr. No.</th>");
				out.print("<th>Centre Name</th>");
//				out.print("<th>Date of Test</th>");
//				out.print("<th>Test Time</th>");
				out.print("<th>No. of<BR>Candidates<BR>Registered</th>");
				out.print("<th>No. of<BR>Candidates<BR>Appeared</th>");
				out.print("<th>No. of<BR>Candidates<BR>Passed</th>");
				out.print("<th>No. of<BR>Candidates<BR>Failed</th>");
				out.print("<th>No. of<BR>Candidates<BR>Absent<BR>(Whose fees <BR>are forfited)</th>");
				out.print("<th>Amount<BR>Collected</th>");
				out.print("<th>Gross Amount<BR>due to BSE <BR>@ Rs. 150 per <BR>candidate appeared <BR>for the test & <BR>@ Rs. 550 per <BR>candidate absent <BR>for the test</th>");

//Get ScheduleID for the Current Month
				sql = "SELECT ScheduleID FROM Schedule WHERE ScheduleDate LIKE '" + wild_month_year + "%' and ScheduleDate <= CURRENT_DATE";
//out.println("<br>1."+sql);
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()){
					canschedule.append(rs.getInt("ScheduleID"));
					canschedule.append(",");
				}
				String candList = canschedule.toString().substring(0,canschedule.length()-1);

//rs for number of clients where test was conducted
				sql = "SELECT * FROM CandidateMaster WHERE ScheduleID IN (" + candList + ") and CandidateID >3 and ScheduleID>0 and ClientID>0 GROUP BY ClientID";//GROUP BY ScheduleID ORDER BY ScheduleID,FirstName 
//out.println("<br>"+sql);
  				pstmt = con.prepareStatement(sql);
  				rs = pstmt.executeQuery();
				
				int count=1;
				int ScheduleID = 0;
				int ExamID = 0;
				int SectionID = 0;
				float TotalAmount = 0;
				float PresentAmount = 0;
				float AbsentAmount = 0;

				String timefrom = null;
				String timeto = null;
				String ExamDate = null;
			
				while (rs.next()){
					timefrom = "";
					timeto = "";
					int NumberTotal = 0;
					int NumberPresent = 0;
					int NumberAbsent = 0;

					ScheduleID = rs.getInt("ScheduleID");
					int cid = rs.getInt("CandidateID");
					int clientid = rs.getInt("ClientID");

//Candidate registered for particluar month schedule
					sql = "SELECT CandidateID FROM CandidateMaster WHERE ScheduleID IN ("+candList+")";
//out.println("<br>2. "+sql);
					StringBuffer canid = new StringBuffer();
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next()){
						canid.append(rs1.getInt("CandidateID"));
						canid.append(",");
					}
					String candIDS = canid.toString().substring(0,canid.length()-1);

//Candidate registered for particluar client
					sql = "SELECT CandidateID FROM CandidateMaster WHERE ClientID="+clientid+" AND CandidateID IN ("+candIDS+")";
//out.println("<br>3. "+sql);
					StringBuffer can_client = new StringBuffer();
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next()){
						can_client.append(rs1.getInt("CandidateID"));
						can_client.append(",");
					}
					String canForClient = can_client.toString().substring(0,can_client.length()-1);

					String centrename = "";
					
					try{
						sql = "Select TimeFrom,TimeTo,SectionID,ScheduleDate from Schedule WHERE ScheduleID="+ScheduleID;
						pstmt = con.prepareStatement(sql);
						rs1 = pstmt.executeQuery();	   
					}catch(Exception e){}
//out.println("<br>Select * from Schedule WHERE ScheduleID="+ScheduleID );
					while (rs1.next()){
						timefrom 	= rs1.getString("TimeFrom");
						timeto   	= rs1.getString("TimeTo");
						SectionID 	= rs1.getInt("SectionID");
						ExamDate 	= rs1.getString("ScheduleDate");
					}
					
					if (timefrom != "" && timefrom != null)
						timefrom = timefrom.substring(0, 5);
					if (timeto != "" && timeto != null)
						timeto = timeto.substring(0, 5);


					try{
					sql = "Select ClientName from ClientMaster WHERE ClientID="+clientid;
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();	   
//out.println("<br>Select ClientName from ClientMaster WHERE ClientID="+clientid );
					}catch(Exception e){}
					while (rs1.next()){
						centrename = rs1.getString("ClientName");						
					}
					
					try{	 
					sql = "Select ExamID from CandidateDetails WHERE CandidateID="+cid;
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();	   
					}catch(Exception e){}
//out.println("<br>Select ExamID from CandidateDetails WHERE CandidateID="+cid );
					while (rs1.next()){
						ExamID 		= rs1.getInt("ExamID");						
					}

					out.print("<tr> ");
					out.print("<td align='right'>" +count+ "&nbsp;</td>");
					out.print("<td align='right'>"+centrename+"</td>");

					try{	   
					//rs1 = stmt1.executeQuery("Select count(*) from SlotRegisteration WHERE ScheduleID="+ScheduleID + " GROUP BY ScheduleID");
						sql = "Select count(*) from SlotRegisteration WHERE CandidateID IN ("+canForClient + ")";
						pstmt = con.prepareStatement(sql);
						rs1 = pstmt.executeQuery();
					}catch(Exception e){}
//out.println("<br>Select count(*) from SlotRegisteration WHERE ScheduleID="+ScheduleID + " GROUP BY ScheduleID");
					while (rs1.next()){
						NumberTotal = rs1.getInt(1);
						out.print("<td align='right'>" +NumberTotal+ "&nbsp;</td>");
						totcan = totcan+NumberTotal;
					}
					try{
					//rs2 = stmt2.executeQuery("Select count(*) from SlotRegisteration WHERE Attended=1 AND ScheduleID="+ScheduleID);
//out.println("<br>totappear :Select count(*) from SlotRegisteration WHERE Attended=1 AND CandidateID IN ("+canForClient +")");
  						sql = "Select count(*) from SlotRegisteration WHERE Attended=1 AND CandidateID IN ("+canForClient +")";
						pstmt = con.prepareStatement(sql);
						rs2 = pstmt.executeQuery();
					}catch(Exception e){}
//	out.println("Select count(*) from SlotRegisteration WHERE Attended=1 AND ScheduleID="+ScheduleID);
					while (rs2.next()){
						NumberPresent = rs2.getInt(1);
						out.print("<td align='right'>" +NumberPresent+ "&nbsp;</td>");
						totappear = totappear + NumberPresent;
					}
					try{
						sql = "Select COUNT(DISTINCT(CandidateID)) from NewPerformanceMaster WHERE ExamID=" +ExamID+ " AND SectionID=" +SectionID+ " AND CandidateID IN ("+canForClient+") AND Result=1";
						pstmt = con.prepareStatement(sql);
						rs3 = pstmt.executeQuery();
					}catch(Exception e){}
//	out.println("<br>Select COUNT(DISTINCT(CandidateID)) from NewPerformanceMaster WHERE ExamID=" +ExamID+ " AND SectionID=" +SectionID+ " AND Date='" +ExamDate+ "' AND Result=1");
					while (rs3.next()){
						int temp = rs3.getInt(1);
						 out.print("<td align='right'>" +temp+ "&nbsp;</td>");
						totpassed += temp;
					}
					try{
					//rs4 = stmt4.executeQuery("Select COUNT(DISTINCT(CandidateID)) from NewPerformanceMaster WHERE ExamID=" +ExamID+ " AND SectionID=" +SectionID+ " AND Date='" +ExamDate+ "' AND Result=0");
//out.println("Select COUNT(DISTINCT(CandidateID)) from NewPerformanceMaster WHERE ExamID=" +ExamID+ " AND SectionID=" +SectionID+ " AND Date like '" +wild_month_year+ "%' AND CandidateID IN ("+candIDS+") AND Result=0");
  					sql = "Select COUNT(DISTINCT(CandidateID)) from NewPerformanceMaster WHERE ExamID=" +ExamID+ " AND SectionID=" +SectionID+ " AND  CandidateID IN ("+canForClient+") AND Result=0";
					pstmt = con.prepareStatement(sql);
					rs4 = pstmt.executeQuery();
					}catch(Exception e){}

//	out.println("<br>Select COUNT(DISTINCT(CandidateID)) from NewPerformanceMaster WHERE ExamID=" +ExamID+ " AND SectionID=" +SectionID+ " AND Date='" +ExamDate+ "' AND Result=0");
					while (rs4.next()){
						int temp = rs4.getInt(1);
						 out.print("<td align='right'>" +temp+ "&nbsp;</td>");
						 totfailed += temp;
					}
					try{
					sql = "Select count(*) from SlotRegisteration WHERE Attended=0 AND CandidateID IN (" +canForClient + ")";
					pstmt = con.prepareStatement(sql);
					rs5 = pstmt.executeQuery();
					}catch(Exception e){}
//	out.println("<br>Select count(*) from SlotRegisteration WHERE Attended=0 AND ScheduleID=" +ScheduleID);
					while (rs5.next()){
						NumberAbsent = rs5.getInt(1);
						out.print("<td align='right'>" +NumberAbsent+ "&nbsp;</td>");
						totabsent += NumberAbsent;
					}
					
					String Criteria = "";
					try{
					sql = "SELECT * FROM RevenueSharing WHERE Client='BSE'";
					pstmt = con.prepareStatement(sql);
					rs6 = pstmt.executeQuery();
					}catch(Exception e){}

					while (rs6.next()){
						TotalAmount = rs6.getFloat("Amount");
						Criteria = rs6.getString("Criteria");
						PresentAmount =0;
						AbsentAmount =0;
						if (Criteria.equalsIgnoreCase("Present")){
							PresentAmount = rs6.getFloat("ClientShare");
						}
						else if (Criteria.equalsIgnoreCase("Absent")){
							AbsentAmount = rs6.getFloat("ClientShare");
						}
					}
					float dueAmount = 0;
					try{
						dueAmount = (NumberPresent * 150) + (NumberAbsent * 550);//PresentAmount,AbsentAmount
					}catch(Exception e){}
					float cal = (NumberTotal * TotalAmount);
					totamtcollected += cal;
					out.print("<td align='right'>&nbsp;" +cal+ "&nbsp;</td>");
					grossamt += dueAmount;
					out.print("<td align='right'>" + dueAmount+ " &nbsp;</td>");
					out.print("</tr>");
					count++;
					grandtot += dueAmount;
					out.println("<!--  DUE AMOUNT : " + dueAmount + " -->");
				}
				out.print("<tr><th colspan=2 align=center>Grand Total :</th>");
				out.print("<th align='right'>"+totcan+"&nbsp;</th>");
				out.print("<th align='right'>"+totappear+"&nbsp;</th>");
				out.print("<th align='right'>"+totpassed+"&nbsp;</th>");
				out.print("<th align='right'>"+totfailed+"&nbsp;</th>");
				out.print("<th align='right'>"+totabsent+"&nbsp;</th>");
				out.print("<th align='right'>"+totamtcollected+"&nbsp;</th>");
				out.print("<th align='right'>"+grandtot+"&nbsp;&nbsp</th></tr>");
				out.println("<TR><Th COLSPAN=11 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
			}
			else{
				out.println("<h4>No Exams were conducted during this month.</h4>");
			}
		}catch(Exception e){
			out.print("EXCEPTION occured while creating Report.<BR>"+e);
		}

		 out.print("</table>");
		 out.print("</form>");
		 out.print("</div>");
		 out.print("<p align=center>&nbsp;</p>");
//		 out.print("<input type=Button Value='Go Back' onclick='history.back();'>");	
	}

}//final end of class QuestionAnalysis
