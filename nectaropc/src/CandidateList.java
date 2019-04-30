import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gen.*;

public class CandidateList extends HttpServlet
{
	ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ResultSet rs1 = null,rs2 = null;
	ResultSet rs3 = null;
	StringTokenizer stringtoken=null;
	String clientName=null,candID=null;
	String sql = "";

	final int PASS_PERCENTAGE = 60;
	final int ZILS_USER = 1;
	final int BSE_USER = 2;
	
	public void database_handler(HttpServletRequest req,HttpServletResponse res)
				 throws ServletException,IOException {
		String action = req.getParameter("action");
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
	}//end of the database handler

	HttpSession session	= null;
	String question_engine_Type=null;
	int SequenceNo = 0;
	String fDir = "";
	boolean doLogin = false;

	public void init(){
		try	{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		}catch(Exception ex){
			System.err.println("CONNECTION FAILURE :" +ex+"<BR>");
		}
	}
	
	public synchronized void display_css(HttpServletRequest req,
			 HttpServletResponse res) throws ServletException, IOException {
		String action = req.getParameter("action");
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		out.println("<html><head><title>Candidate List</title>");
		out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' "+
										"HREF='../alm.css'></head>");
		out.println("<body><center><P>&nbsp;</P>");
	}
	
	public synchronized void ShowExamDates(HttpServletRequest req,
		 HttpServletResponse res) throws ServletException,IOException{		

		HttpSession session = req.getSession(true);
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		String questionType = null;
		
		try	{
			con= pool.getConnection();
			String month = req.getParameter("month");
			String year = req.getParameter("year");
			String wild_month_year = year+"-"+month;
		
			String ClientID = "" + (String)session.getAttribute("ClientID");
			
			String sql = "";
			int ScheduleID = 0;
			String ScheduleDate = "";
			String TimeFrom = "";
			String TimeTo = "";
			
			/*
				Uncomment following query to get report up to today's date.
				( Comment out next to next line )
			*/
//			sql = "SELECT * FROM Schedule WHERE ScheduleDate <= NOW() AND ScheduleDate like \'"+wild_month_year+"%\' AND ClientID=" +ClientID+ " ORDER BY ScheduleDate";

			sql = "SELECT * FROM Schedule WHERE ScheduleDate LIKE ?% AND ClientID=? ORDER BY ScheduleDate ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,wild_month_year);
			pstmt.setInt(2,Integer.parseInt(ClientID));
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				out.println("<FORM ACTION='" +req.getRequestURI()+ 
										"' METHOD='POST'>");
				out.println("<TABLE BORDER='0' CELLSPACING='1' CELLPADDING='1'"+
								" ALIGN='CENTER'>");
				out.println("<TR><TH COLSPAN=2>Exams were conducted on "+
							"following dates in the <U>" +month+ "</U> month.");
				out.println("");
				out.println("<BR>Please, Select Exam Date to view the "+
							"Candidate List.</TH></TR>");

				out.println("<TR><TD ALIGN='RIGHT'>Exam Date : </TD>");
				out.println("<TD><SELECT NAME='ScheduleID'>");

				rs.beforeFirst();
				while (rs.next()){
					ScheduleID = rs.getInt("ScheduleID");
					ScheduleDate = rs.getString("ScheduleDate");
					TimeFrom = rs.getString("TimeFrom");
					TimeTo = rs.getString("TimeTo");

					ScheduleDate = Utils.getDate(ScheduleDate);
					TimeFrom = TimeFrom.substring(0, 5);
					TimeTo = TimeTo.substring(0, 5);

					out.println("<OPTION VALUE='" +ScheduleID+ "'>");
					out.println(ScheduleDate + " | " +TimeFrom+ " - " +TimeTo);

					out.println("</OPTION>");
				}
				out.println("</SELECT></TD></TR>");
				out.println("<TR><TH COLSPAN=2><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'>&nbsp;<INPUT TYPE='Submit' "+
								"VALUE='View Report'></TH>");
				out.println("<INPUT TYPE=hidden NAME='action' "+
								"VALUE='ExamDateWiseList'></TR>");
				out.println("</TABLE>");
				out.println("</FORM>");
			}else{
				out.println("<h4>No Exams were conducted during this month."+
																	"</h4>");
			}
		}catch (Exception e){
			out.println("Error : " +e.getMessage() );
		}
	}
	
	public synchronized void ShowExamDateWiseList(HttpServletRequest req,
			 HttpServletResponse res) throws ServletException,IOException {
		
		HttpSession session = req.getSession(true);
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();		
		
		String ScheduleID = "";
		ScheduleID = req.getParameter("ScheduleID");
		String ReportType = "";
		String ClientID = (String) session.getAttribute("ClientID");
		int ExamID = 0, SectionID= 0;
		String TestDate = "", TimeFrom = "", TimeTo = "";
		String tempDate = "";
		try{
			con=pool.getConnection();
			sql = "SELECT ExamID,SectionID,ScheduleDate,TimeFrom,TimeTo FROM Schedule WHERE ScheduleID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,ScheduleID);
			rs = pstmt.executeQuery();

			while (rs.next()){
				ExamID = rs.getInt("ExamID");
				SectionID = rs.getInt("SectionID");
				tempDate = TestDate = rs.getString("ScheduleDate");
				TimeFrom = rs.getString("TimeFrom");
				TimeTo = rs.getString("TimeTo");
				TestDate = Utils.getDate(TestDate);
				TimeFrom = TimeFrom.substring(0, 5);
				TimeTo = TimeTo.substring(0, 5);
			}

			out.print("<h4>Candidates' Master List</h4>");
			out.println("<TABLE BORDER='0' CELLSPACING='1' CELLPADDING='1' "+
						"ALIGN='CENTER'>");
			out.println("<TR><TH COLSPAN=4>Summary of the Exam conducted on "+
						TestDate + "(" +  TimeFrom+ " - " +TimeTo + ")" +
						"</TH></TR>");

			sql = "SELECT CandidateID,FirstName,LastName FROM CandidateMaster WHERE ScheduleID=? ORDER BY FirstName, LastName";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,ScheduleID);
			rs = pstmt.executeQuery();

			int Count = 1, CandidateID = 0;
			String FirstName = "", LastName = "";

			out.println("<TR><TD ALIGN='CENTER' COLSPAN=4>");

			if (rs.next()){
				rs.beforeFirst();
				out.println("<TABLE BORDER='0' CELLSPACING='1' "+
									"CELLPADDING='1' ALIGN='CENTER' width='100%'>");
					out.println("<TR><TH>Sr. No.</TH>"+
									"<TH>Registration<BR>Number</TH>"+
									"<TH>Candidate<BR>Name</TH>" +
									"<TH>%<BR>Scored</TH>"+
									"<TH>Result</TH></TR>");
				while(rs.next()){
					CandidateID = rs.getInt("CandidateID");
					FirstName = rs.getString("FirstName");
					LastName = rs.getString("LastName");

					RegistrationKey rkey = new RegistrationKey(CandidateID);

					//System.out.println("Start :");
					out.println("<TR>");
					out.println("<TD ALIGN='RIGHT'>" +Count+ "&nbsp;</TD>");
					out.println("<TD ALIGN='CENTER'>" +rkey.getKeyCode()+"</TD>");
					
					// CODE FOR MARKSHEET LINK 
					/*sql = "select Date from NewPerformanceMaster "+
						" where CandidateId=" + CandidateID + " and " +
						" Date = '" + tempDate +"'";*/
					
					String str = FirstName+ " " +LastName;
					out.println("<TD>"+str+"</TD>");
					//System.out.println("before Score:");
					float Score = 0;
					sql = "SELECT SUM(Score) FROM NewPerformanceMaster "+
							"WHERE ExamID=? AND CandidateID=?";
							
					//System.out.println("before Score:"+Score);
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,ExamID);
					pstmt.setInt(2,CandidateID);
					rs3 = pstmt.executeQuery();
					if(rs3.next()){
						Score = rs3.getFloat(1);
					}
					//System.out.println("After Score:"+Score);
					sql = "Select NoOfQuestions,LevelID from NewExamDetails"+
						" where ExamID=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,ExamID);
					rs3 = pstmt.executeQuery();
					int TotalMarks=0;
					float Percent=0;
					while(rs3.next()){
						TotalMarks += rs3.getInt("NoOfQuestions")*rs3.getInt("LevelID");
					}
					//System.out.println("After Score TotalMarks:"+TotalMarks);
					if(TotalMarks > 0)
					{
						Percent = ((Score*100)/TotalMarks) ;
						if (Percent < 0){
											Percent = 0;
										}
					}
					else 
					{
						Percent = 0;
					}
					
					
					sql = "SELECT Result FROM NewPerformanceMaster "+
							" WHERE ExamID=? AND SectionID=? AND CandidateID=? GROUP BY CandidateID";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,ExamID);
					pstmt.setInt(2,SectionID);
					pstmt.setInt(3,CandidateID);
					rs3 = pstmt.executeQuery();
					int Result = 0;
					if(rs3.next()){
						Result = rs3.getInt("Result");
					}else{
						Result = -1;
					}

					out.println("<TD ALIGN='RIGHT'>"+ (Result==-1?"N/A":Percent+"")+"&nbsp;</TD>");
					out.println("<TD ALIGN='CENTER'>"+ (Result==-1?"N/A":
									"<a href=\"MarkSheet?CandidateID="+ CandidateID +"\">"+
											(Percent<=PASS_PERCENTAGE?"Fail":"Pass")+"</a>")+
								"</TD>");
	
					out.println("</TR>");
					Count++;
				}
				out.println("<TR><Th COLSPAN=5 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
				out.println("</TABLE>");
			}else{
				out.println("<b>No Candidate found.</b>");
			}

			out.println("</TD></TR>");
			out.println("</TABLE>");
		}catch(Exception e){
			out.print("Error :" +e.getMessage()+ "<BR>");
		}
	}

	public synchronized void display_main_sub_form(HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException{

		HttpSession session = req.getSession(true);
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		out.println("<div align='center'>");
		out.println("<h4>Candidate Master List</h4>");
		out.println("<form action=" +req.getRequestURI()+ " method='GET'>");
		out.println("<table border='0' cellspacing='1' cellpadding='1' "+
							"width='50%' ALIGN='CENTER'>");
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

		for (int i=-1; i <= 1 ; i++){
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

		out.println("</select></td></tr>");
		out.println("<tr><th colspan='2'>");
		out.println("<input type='submit' name='Submit' value='Submit'>");
		out.println("</th>");
		Integer CandidateID = (Integer) session.getAttribute("CandidateID");
		int cid = CandidateID.intValue();
		if (cid == ZILS_USER || cid == BSE_USER){
			out.println("<input type=hidden name='action' value='doExamDateWiseListForBSE'>");
		}else{
			out.println("<input type=hidden name='action' value='ShowExamDates'>");
		}
		out.println("</tr>");
		out.println("</table>");
		out.println("</form>");
		out.println("</div>");
	}	
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		String action = req.getParameter("action");
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		if (action == null || action == ""){
			display_css(req,res);
			display_main_sub_form(req,res);
	
		}//end of action null
		else {
			doPost(req, res);
		}	
	}//end of public void doGet

	public void doPost(HttpServletRequest req, HttpServletResponse res) 
				throws ServletException, IOException{
		String action = req.getParameter("action");
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		if (action.equals("ShowExamDates"))	{
			database_handler(req,res);
			display_css(req,res);
			ShowExamDates(req, res);
		}else if(action.equals("ExamDateWiseList")){
			display_css(req,res);
			ShowExamDateWiseList(req,res);
		}else if(action.equals("doExamDateWiseListForBSE")){
			display_css(req,res);
			ExamDateWiseListBSE(req,res);
		}

		out.println("</body>");
		out.println("</html>");
	}

	public synchronized void ExamDateWiseListBSE(HttpServletRequest req,
			 HttpServletResponse res) throws ServletException,IOException {
		
		HttpSession session = req.getSession(true);
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		String questionType = null;
		
		try	{
			con= pool.getConnection();
			String month = req.getParameter("month");
			String year = req.getParameter("year");
			String vaild_month_year = year+"-"+month+"%";
			String sql = "";
			int ScheduleID = 0;
			String ScheduleDate = "";
			String TimeFrom = "";
			String TimeTo = "";
			int cid=0,examid=0,clientid=0,count=1,rest=0,schid=0;
			String schdate ="",centrename="",firstname="",lastname="",result="";
			StringBuffer canschedule = new StringBuffer();
			float score = 0.0f;
			float Percent = 0;

			out.println("<H4>Candidates' Master List(CML)</H4>");
			out.println("<table border='0' cellspacing='1' cellpadding='1' "+
							"width='100%' ALIGN='CENTER'>");
			out.println("<TR><TH>Sr. No.</TH><TH>Centre Name</TH><TH>Date of Test</TH><TH>Registration No.</TH><TH>Candidate's Name</TH><TH>Score (%)</TH><TH>Result</TH></TR>");
			
			sql = "SELECT ScheduleID,ScheduleDate FROM Schedule WHERE ScheduleDate LIKE ? order by ScheduleDate,ClientID";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,vaild_month_year);
			System.out.println("pstmt "+pstmt);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()){
				sql = "SELECT CandidateID,FirstName,LastName,ClientID,ScheduleID FROM CandidateMaster WHERE ScheduleID IN (?)  ORDER BY ClientID,FirstName";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,rs.getInt("ScheduleID"));
				ResultSet rs2 = pstmt.executeQuery();
				while (rs2.next()){
					Percent = 0;
					rest = 0;
					score = 0;
					result = "Fail";

					clientid = rs2.getInt("ClientID");
					cid = rs2.getInt("CandidateID");
					firstname = rs2.getString("FirstName");
					lastname = rs2.getString("LastName");
					schid = rs2.getInt("ScheduleID");

					java.sql.Date shDate = rs.getDate("ScheduleDate");
					schdate = shDate.toString();
					sql = "SELECT ClientName FROM ClientMaster WHERE ClientID=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,clientid);
					ResultSet rs1 = pstmt.executeQuery();
					if (rs1.next()){
						centrename = rs1.getString("ClientName");
					}

					sql = "SELECT ExamID FROM CandidateDetails WHERE CandidateID=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,cid);
					rs1 = pstmt.executeQuery();
					while (rs1.next()){
						examid = rs1.getInt("ExamID");
					}

					sql = "SELECT Result FROM NewPerformanceMaster WHERE CandidateID=? and ExamID=? group by SectionID";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,cid);
					pstmt.setInt(2,examid);
					rs1 = pstmt.executeQuery();
					
					if(rs1.next()){
						rest = rs1.getInt("Result");
					}else{
						rest = -1;
					}
					
					if(rest!=-1){
						sql = "SELECT sum(Score) FROM NewPerformanceMaster "+
							" WHERE CandidateID=? and ExamID=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1,cid);
						pstmt.setInt(2,examid);
						ResultSet rsScore = pstmt.executeQuery();
						if (rsScore.next()){
							score = rsScore.getFloat(1);
						}
						sql = "Select NoOfQuestions,LevelID from NewExamDetails"+
							" where ExamID=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1,examid);
						ResultSet rsExamDetails = pstmt.executeQuery();
						int TotalMarks=0;
						while(rsExamDetails.next()){
							TotalMarks += rsExamDetails.getInt("NoOfQuestions")*rsExamDetails.getInt("LevelID");
						}
						Percent = ((score*100)/TotalMarks) ;
						if (Percent < 0){
							Percent = 0;
						}
						if (rest==1){
							result = "PASS"; 
						}else if(rest==0){
							result = "Fail";
						}
					}else{
						if(shDate.getTime()>System.currentTimeMillis()){
							rest = -1;
						}else{
							rest = 0;
						}
					}
					
					RegistrationKey regkey = new RegistrationKey (cid);
					out.println("<TR><TD ALIGN=CENTER>"+count+"</TD>"+
						"<TD>"+centrename+"</TD>"+
						"<TD>"+Utils.getFullDate(schdate)+"</TD>"+
						"<TD>"+regkey.getKeyCode()+"</TD>"+
						"<TD>"+firstname + " " +lastname+"</TD>"+
						"<TD>"+(rest==-1?"N/A":Percent+"")+"</TD>"+
						"<TD> "+
							(rest==-1?"N/A":"<a href=\"MarkSheet?CandidateID="+ cid +"&action=showmarksheet\">"+result+"</a>")+
						"</TD></TR>");
					count++;
				}
				
			}
			out.println("<TR><TH COLSPAN=7> N/A -> Not Appeared</TH></TR>");
			out.println("<TR><Th COLSPAN=7 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR></TABLE>");
		}catch (Exception e){
			out.println("Error : " +e);
		}
	}
}
