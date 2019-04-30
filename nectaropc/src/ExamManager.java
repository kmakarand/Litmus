/*
Modified By :
author : Denis Mathew
Date Modified : 24/01/2002

*/
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Date;
import java.util.Vector;

import com.ngs.ats.ExamMaster;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;
import com.ngs.gen.NextValues;
import com.ngs.gen.Utils;

public class ExamManager extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	String sql = null;
	ResultSet rs = null;

	public synchronized boolean doAddExam(HttpServletRequest req, HttpServletResponse res)
	{
		ExamMaster em = new ExamMaster();
		try
		{
			PrintWriter out = res.getWriter();
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			sql = "SELECT * FROM NextValues WHERE TableName = 'ExamMaster'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int NextValue = 0;
			if (rs.next())
			{
				rs.next();
				NextValue = rs.getInt("NextValue");
				NextValue++;
			}
			else
			{
				System.err.println("NextValue for ExamMaster not Found.");
				return false;
			}
			int EndYear   = Integer.parseInt(req.getParameter("EndYear"));
			int EndMonth  = Integer.parseInt(req.getParameter("EndMonth"));
			int EndDay    = Integer.parseInt(req.getParameter("EndDay"));
			int StartYear = Integer.parseInt(req.getParameter("StartYear"));
			int StartMonth= Integer.parseInt(req.getParameter("StartMonth"));
			int StartDay  = Integer.parseInt(req.getParameter("StartDay"));

			if(req.getParameter("Exam")==null || req.getParameter("Exam").equals("null") ||req.getParameter("Exam").trim().equals(""))
			{
				out.println(Utils.showError("ERROR", "An error has occured while adding new Exam.","Exam name can't be empty."));
				return false;
			}

			if(EndYear>=StartYear) {
				if(EndMonth>=StartMonth) {
					if(EndDay>=StartDay) {
						em.setExamID(NextValue);
						em.setExam( req.getParameter("Exam") );
						em.setExamMode(Integer.parseInt(req.getParameter("ExamMode")));
						em.setRegistrationFee(Float.parseFloat(req.getParameter("RegistrationFee")));
						em.setStartDate(req.getParameter("StartYear")+"-"+req.getParameter("StartMonth")+"-"+req.getParameter("StartDay"));
						em.setEndDate(req.getParameter("EndYear")+"-"+req.getParameter("EndMonth")+"-"+req.getParameter("EndDay"));
						em.setConductedBy(req.getParameter("ConductedBy"));
						em.setCentre(req.getParameter("Centre"));
						em.setCountry(req.getParameter("Country"));
						em.setFrequency(Integer.parseInt(req.getParameter("Frequency")));
						em.setShowResults(Integer.parseInt(req.getParameter("ShowResults")));
						em.setDisplayTests(Integer.parseInt(req.getParameter("DisplayTests")));
					//	em.setStoreID(Integer.parseInt(req.getParameter("StoreID")));
						sql = "INSERT INTO ExamMaster(ExamID, ModeratorID, Exam, ExamMode, StartDate, EndDate, ConductedBy, Centre, Country, Frequency, ShowResults, DisplayTests, RegistrationFee) VALUES (" +em.getExamID()+ ",1, '" +em.getExam()+ "', " +em.getExamMode()+ ", '" +em.getStartDate()+ "', '" +em.getEndDate()+ "', '" +em.getConductedBy()+ "', '" + em.getCentre() +"', '" + em.getCountry() + "', " + em.getFrequency()+ ", " +em.getShowResults()+ ", " +em.getDisplayTests()+ ", " +em.getRegistrationFee() +")";

					    System.out.print(sql);
						pstmt = con.prepareStatement(sql);
						if (pstmt.executeUpdate() > 0)	{
							NextValue += 1;
							sql = "UPDATE NextValues SET NextValue=" +NextValue+ " WHERE TableName='ExamMaster'";
							pstmt = con.prepareStatement(sql);
							pstmt.executeUpdate();

							System.err.println("Exam Successfully Added.");
						}
						else
							System.err.println("Error in adding Exam.");

						return true;
					}
				}
			}
			out.println(Utils.showError("ERROR", "StartDate should be less than EndDate",""));
			return false;
		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			return false;
		}
		finally
		{
			em = null;
			rs = null;
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}

	}

	public synchronized boolean doAddTest(HttpServletRequest req, HttpServletResponse res)
	{
		try
		{
			PrintWriter out = res.getWriter();
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();

		//	int TestCode = 0;
			int SectionID = 0;
			int CodeID=0;
			NextValues nvSectionID	=	new NextValues("NewExamDetails", "ExamID");
		//	NextValues nvTestCode	=	new NextValues(con, "TestCodeDetails", "TestCode");
			NextValues nvCodeID	=	new NextValues("CodeGroupDetails", "CodeID");

//DM2601A
			SectionID = nvSectionID.getNextValue();
		//	TestCode = nvTestCode.getNextValue();
			CodeID=nvCodeID.getNextValue();

			int ExamID = Integer.parseInt(req.getParameter("ExamID"));
			String TestName = req.getParameter("TestName");
			String SectionName = req.getParameter("SectionName");
			int NoOfQuestions = Integer.parseInt(req.getParameter("NoOfQuestions"));
			int TimerType = Integer.parseInt(req.getParameter("TimerType"));
			int ResponseTime = Integer.parseInt(req.getParameter("QuestionTime"));
			int SectionTime = Integer.parseInt(req.getParameter("SectionTime"));
			float NegativeMarks = Float.parseFloat(req.getParameter("NegativeMarks"));
			int LevelID = Integer.parseInt(req.getParameter("Level"));
			int IncludeSublevels = Integer.parseInt(req.getParameter("IncludeSublevels"));
			float Criteria = Float.parseFloat(req.getParameter("Criteria"));
			int NoOfBreaksAllowed = Integer.parseInt(req.getParameter("NoOfBreaksAllowed"));
			int BreakInterval = Integer.parseInt(req.getParameter("BreakInterval"));
			int Prerequisite = Integer.parseInt(req.getParameter("Prerequisite"));
			int NoOfAttemptsAllowed = Integer.parseInt(req.getParameter("NoOfAttemptsAllowed"));
			int ExamTime= Integer.parseInt(req.getParameter("ExamTime"));
		//	int DisplaySections = Integer.parseInt(req.getParameter("DisplaySections"));
		//	int Adaptive = Integer.parseInt(req.getParameter("Adaptive"));
		//	int UpLimit = Integer.parseInt(req.getParameter("UpLimit"));
		//	int DownLimit = Integer.parseInt(req.getParameter("DownLimit"));
		//	int InstructionID = Integer.parseInt(req.getParameter("Instruction"));
			int CodeGroupID=Integer.parseInt(req.getParameter("CodeGroupID")); //new added
			int NoOfSections=0;
			int SequenceID=0;
			String strID[] = req.getParameterValues("CodeGroupID");
			sql = "INSERT INTO NewExamDetails (ExamID, SectionID, CodeGroupID, TestName, NoOfSections, SectionName, NoOfQuestions, TimerType, ResponseTime, SectionTime, SequenceID, NegativeMarks, LevelID, IncludeSublevels, Criteria, NoOfBreaksAllowed, BreakInterval, Prerequisite, `NoOfAttemptsAllowed, ExamTime)values("+ExamID+", "+SectionID+", "+CodeGroupID+", '"+TestName+"', "+NoOfSections+",'"+SectionName+"' ,"+NoOfQuestions+", "+TimerType+" ,"+ResponseTime+" ,"+SectionTime+", "+SequenceID+","+NegativeMarks+", "+LevelID+", "+IncludeSublevels+", "+Criteria+", "+NoOfBreaksAllowed+", "+BreakInterval+", "+Prerequisite+", "+NoOfAttemptsAllowed+", "+ExamTime+")";

			//Added Items: NoOfSections,SequenceID.
			// Removed items:  "+DisplaySections+", "+Adaptive+", "+UpLimit+" ,"+DownLimit+", "+InstructionID+"
			pstmt = con.prepareStatement(sql);
			if (pstmt.executeUpdate() > 0)
			{
				int ID =0;
				for(int i=0; i<strID.length;i++)
				{
					ID = Integer.parseInt(strID[i]);
					sql = "INSERT INTO CodeGroupDetails (ExamID,CodeGroupID,CodeID,NoOfQuestions) values ("+ExamID+", "+CodeGroupID+", "+CodeID+", "+NoOfQuestions+")";
					pstmt = con.prepareStatement(sql);
					pstmt.executeUpdate();
				}

				if (! nvSectionID.setNextValue())
				{
					out.println( Utils.showError("ERROR", "An error has occured while adding Test details.", "Test details are successfully added but an error has occured while trying to update respective tables") );
					System.err.println("Error in Updating NextValues for (NewExamDetails, ExamID)");
					return false;
				}
				if (! nvCodeID.setNextValue())
				{
					out.println( Utils.showError("ERROR", "An error has occured while adding Test details.", "Test details are successfully added but an error has occured while trying to update respective tables") );
					System.err.println("Error in Updating NextValues for (CodeGroupDetails, CodeID)");
					return false;
				}
			}
			else {
				System.err.println("Error in adding Test.");
				return false;
			}
		return true;
		}
		catch(Exception e)
		{
			return false;
		}
	}

	public synchronized void updateExamMaster(HttpServletRequest req, HttpServletResponse res)
	{
		try
		{
			PrintWriter out = res.getWriter();
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();

			int ExamID = Integer.parseInt( req.getParameter("ExamID") );

			sql = "SELECT * FROM ExamMaster WHERE ExamID=" + ExamID;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			out.println("<Center>update ExamMaster.");
			out.println("<form action='" +req.getRequestURI()+ "' method='post'>");
			out.println("<table border=0 cellspacing=1 cellpadding=1 bgcolor='#000000'>");
			out.println("<tr><th colspan=2><b>Exam Details</b></th></tr>");
			while (rs.next())
			{
				out.println("<tr><td align=right><b>Exam :&nbsp;</b></td>");
				out.println("<td><input type=text name=Exam value=\""+rs.getString("Exam")+"\"></td></tr>");

				out.println("<tr><td align=right><b>How would you like Questions to be appeared in the Exam :&nbsp;</b></td>");
				String Optval=rs.getString("ExamMode");
				if(Optval.equals("1")){
				out.println("<td><select name='ExamMode'><option value='1' selected>One Question</option><option value='2'>All Questions</option></select></td></tr>");
				}
				else{
				out.println("<td><select name='ExamMode'><option value='1'>One Question</option><option value='2' selected>All Questions</option></select></td></tr>");
				}
				out.println("<tr><td align=right><b>Exam Registration Fee :&nbsp;</b></td>");
				out.println("<td><input type=text name=RegistrationFee value=\""+rs.getString("RegistrationFee")+"\"></td></tr>");

				Date StartDate = rs.getDate("StartDate");
				out.println("<tr><td align=right><b>StartDate :&nbsp;</b></td>");
				out.println("<td class='small'>");
				out.println(displayIntSelect("StartDay", 1,31,StartDate.getDate()));
				out.println("&nbsp;-&nbsp;");
				out.println(displayIntSelect("StartMonth",1,12,StartDate.getMonth()));
				out.println("&nbsp;-&nbsp;");
				out.println(displayIntSelect("StartYear", 2000,2020,StartDate.getYear()));
				out.println("&nbsp;&nbsp;(DD-MM-YYYY)&nbsp;</td></tr>");

				Date EndDate = rs.getDate("EndDate");
				out.println("<tr><td align=right><b>EndDate :&nbsp;</b></td>");
				out.println("<td class='small'>");
				out.println(displayIntSelect("EndDay", 1,31,EndDate.getDate()));
				out.println("&nbsp;-&nbsp;");
				out.println(displayIntSelect("EndMonth",1,12,EndDate.getMonth()));
				out.println("&nbsp;-&nbsp;");
				out.println(displayIntSelect("EndYear", 2000,2020,EndDate.getYear()));
				out.println("&nbsp;&nbsp;(DD-MM-YYYY)&nbsp;</td></tr>");


				out.println("<tr><td align=right><b>Who is conducting this Exam :&nbsp;</b></td>");
				out.println("<td><input type=text name=ConductedBy value=\""+rs.getString("ConductedBy")+"\"></td></tr>");

				out.println("<tr><td align=right><b>Centre :&nbsp;</b></td>");
				out.println("<td><input type=text name=Centre value=\""+rs.getString("Centre")+"\"></td></tr>");

				out.println("<tr><td align=right><b>Country :&nbsp;</b></td>");
				out.println("<td>");
				out.println(displayCountrySelect(rs.getString("Country")));
				out.println("</td></tr>");

				out.println("<tr><td align=right><b>Frequency :&nbsp;</b></td>");
				out.println("<td><input type=text name=Frequency value=\""+rs.getString("Frequency")+"\"></td></tr>");

				out.println("<tr><td align=right><b>Show Result after Exam ?&nbsp;</b></td>");
				if(rs.getInt("ShowResults")==1)
					out.println("<td><select name=ShowResults><option value=1 selected>Yes</option><option value=0>No</option></td></tr>");
				else
					out.println("<td><select name=ShowResults><option value=1>Yes</option><option value=0 selected>No</option></td></tr>");

				out.println("<tr><td align=right><b>Allow user to select Test ?&nbsp;</b></td>");
				if(rs.getInt("DisplayTests")==1)
					out.println("<td><select name=DisplayTests><option value=1 selected>Yes</option><option value=0>No</option></td></tr>");
				else
					out.println("<td><select name=DisplayTests><option value=1>Yes</option><option value=0 selected>No</option></td></tr>");
				//out.println("<tr><td align=right><b>Result Storage Strategy :&nbsp;</b></td>");
				//out.println("<td>");
				//out.println(displayStoreSelect(rs.getInt("StoreID")));
				//out.println("</td></tr>");
				out.println("<tr><input type=hidden name='action' value='doUpdate'>");
				out.println("<input type=hidden name='ExamID' value='" +ExamID+ "'>");
				out.println("<th colspan=2><input type=submit value='Update'>");
				out.println("<input type=button value=Cancel onClick='javascript:history.back()'></th></tr>");
			}
			out.println("</table></form>");
		}
		catch(Exception e)		{
			System.err.println("Connection Error");
		}
		finally		{
			rs = null;
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}

	}

//////////////////////////////////
	public synchronized void updateTestDetails(HttpServletRequest req, HttpServletResponse res)
	{
		Connection con = null;
		Statement stmt = null;
		ResultSet rs	= null;
		ResultSet rs1 = null;
		try
		{
			PrintWriter out = res.getWriter();
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			stmt = con.createStatement();

			int SectionID = 0;
			NextValues nvSectionID	=	new NextValues("NewExamDetails", "SectionID");
			SectionID=nvSectionID.getNextValue();
			////System.out.println(SectionID);

			//int SectionID = Integer.parseInt( req.getParameter("SectionID") );
			sql = "SELECT * FROM NewExamDetails WHERE SectionID=" + SectionID;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			String TestName = "";
//DM2601B
			out.println("<Center>Update Test Details.");
			out.println("<form action='" +req.getRequestURI()+ "' name=f1 method='get'>");
			out.println("<table border=0 cellspacing=1 cellpadding=1>");
			out.println("<tr><th colspan=2><b>Exam Details</b></th></tr>");
			while (rs.next())
			{
				TestName=rs.getString("TestName");
				out.println("<tr><td align=right><b>Test Name :&nbsp;</b></td>");
				out.println("<td>"+TestName+"</td></tr>");

				out.println("<tr><td align=right><b>SectionName :&nbsp;</b></td>");
				out.println("<td><input type=text name=SectionName value="+rs.getString("SectionName")+"></td></tr>");

				out.println("<tr><td align=right><b>Subjects :&nbsp;</b></td>");
				int ExamID = rs.getInt("ExamID");
				out.println("<td>"+displaySubjectSelect(ExamID)+"</td></tr>");

				out.println("<tr><td align=right><b>NoOfQuestions:&nbsp;</b></td>");
				out.println("<td><input type=text name=NoOfQuestions value='"+rs.getString("NoOfQuestions")+"'></td></tr>");

				out.println("<tr><td align=right><b>TimerType :&nbsp;</b></td>");
				out.println("<td><select name=TimerType>");

				if(rs.getInt("TimerType")==1) {
					out.println("<option value=1 selected>Question Timer</option>");
					out.println("<option value=2>Section Timer</option>");
					out.println("<option value=3>Exam Timer</option>");
				}
				else if(rs.getInt("TimerType")==2) {
					out.println("<option value=1>Question Timer</option>");
					out.println("<option value=2 selected>Section Timer</option>");
					out.println("<option value=3>Exam Timer</option>");
				}
				else if(rs.getInt("TimerType")==3) {
					out.println("<option value=1>Question Timer</option>");
					out.println("<option value=2>Section Timer</option>");
					out.println("<option value=3 selected>Exam Timer</option>");
				}
				out.println("</select></td></tr>");
				out.println("<tr><td align=right><b>QuestionTime :&nbsp;</b></td>");
				out.println("<td><input type=text name=QuestionTime value="+rs.getString("ResponseTime")+"></td></tr>");

				out.println("<tr><td align=right><b>SectionTime :&nbsp;</b></td>");
				out.println("<td><input type=text name=SectionTime value="+rs.getString("SectionTime")+"></td></tr>");

				out.println("<tr><td align=right><b>NegativeMarks :&nbsp;</b></td>");
				out.println("<td><input type=text name=NegativeMarks value="+rs.getString("NegativeMarks")+"></td></tr>");

				out.println("<tr><td align=right><b>Level :&nbsp;</b></td>");
				out.println("<td>"+displayLevelSelect(rs.getInt("ExamID"))+"</td></tr>");

				out.println("<tr><td align=right><b>IncludeSublevels :&nbsp;</b></td>");
				out.println("<td><select name=IncludeSublevels>");
				if(rs.getInt("IncludeSublevels")==1)
				{
					out.println("<option value=1 selected>Yes</option>");
					out.println("<option value=0>No</option>");
				}
				else if(rs.getInt("IncludeSublevels")==0)
				{
					out.println("<option value=1>Yes</option>");
					out.println("<option value=0 selected>No</option>");
				}
				out.println("</select></td></tr>");

				out.println("<tr><td align=right><b>Criteria :&nbsp;</b></td>");
				out.println("<td><input type=text name=Criteria value="+rs.getString("Criteria")+"></td></tr>");

				out.println("<tr><td align=right><b>NoOfBreaksAllowed :&nbsp;</b></td>");
				out.println("<td><input type=text name=NoOfBreaksAllowed value="+rs.getString("NoOfBreaksAllowed")+"></td></tr>");

				out.println("<tr><td align=right><b>BreakInterval :&nbsp;</b></td>");
				out.println("<td><input type=text name=BreakInterval value="+rs.getString("BreakInterval")+"></td></tr>");

				out.println("<tr><td align=right><b>Prerequisite :&nbsp;</b></td>");
				out.println("<td><input type=text name=Prerequisite value="+rs.getString("Prerequisite")+"></td></tr>");

				out.println("<tr><td align=right><b>NoOfAttemptsAllowed :&nbsp;</b></td>");
				out.println("<td><input type=text name=NoOfAttemptsAllowed value="+rs.getString("NoOfAttemptsAllowed")+"></td></tr>");

				out.println("<tr><td align=right><b>ExamTime :&nbsp;</b></td>");
				out.println("<td><input type=text name=ExamTime value="+rs.getString("ExamTime")+"></td></tr>");

			//	out.println("<tr><td align=right><b>DisplaySections :&nbsp;</b></td>");
			//	out.println("<td>"+displayIntSelect("DisplaySections",1,2,rs.getInt("DisplaySections"))+"</td></tr>");

				out.println("<tr><td align=right><b>Level :&nbsp;</b></td>");
				out.println("<td>"+rs.getInt("LevelID")+"</td></tr>");

				out.println("<tr><td align=right><b>Adaptive :&nbsp;</b></td>");
				out.println("<td><select name=Adaptive>");
				if(rs.getInt("Adaptive")==1)
				{
					out.println("<option value=1 selected>Yes</option>");
					out.println("<option value=0>No</option>");
				}
				else if(rs.getInt("Adaptive")==0)
				{
					out.println("<option value=1>Yes</option>");
					out.println("<option value=0 selected>No</option>");
				}
				out.println("</select></td></tr>");

				out.println("<tr><td align=right><b>Up Limit :&nbsp;</b></td>");
				out.println("<td>"+displayIntSelect("UpLimit",1,5,rs.getInt("UpLimit"))+"</td></tr>");

				out.println("<tr><td align=right><b>Down Limit :&nbsp;</b></td>");
				out.println("<td>"+displayIntSelect("DownLimit",1,5,rs.getInt("DownLimit"))+"</td></tr>");


				//out.println("<tr><td align=right><b>Instruction :&nbsp;</b></td>");
				//out.println("<td>"+displayInstructionSelect(rs.getInt("InstructionID"))+"</td></tr>");
			}
			out.println("<tr><td align=center colspan=2>");
			out.println("<input type='hidden' name=action value=doUpdateTest>");
			out.println("<input type='hidden' name=SectionID value="+SectionID+">");
			out.println("<input type='hidden' name=ExamID value="+rs.getString("ExamID")+">");
			out.println("<input type='hidden' name=TestName value="+TestName+">");
			out.println("<input type='hidden' name=CodeGroupID value="+rs.getString("CodeGroupID")+">");
			out.println("<input type=submit value='Update'> &nbsp;&nbsp;&nbsp;<input type=submit value='Add Section' onClick=document.f1.action.value='TestDetails'> &nbsp;&nbsp;&nbsp;<input type=button value=Cancel onClick='javascript:history.back()'></td></tr>");
			out.println("</table></form></center>");
		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
		}
		finally
		{
			rs = null;
			stmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}

	}


//////////////////////////////////
	public synchronized boolean doUpdateExamMaster(HttpServletRequest req, HttpServletResponse res)
	{
		ExamMaster em = new ExamMaster();

		try
		{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			em.setExamID( Integer.parseInt( req.getParameter("ExamID") ) );
			em.setExam( req.getParameter("Exam") );
			em.setExamMode(Integer.parseInt(req.getParameter("ExamMode")));
			em.setStartDate(req.getParameter("StartYear")+"-"+req.getParameter("StartMonth")+"-"+req.getParameter("StartDay"));
			em.setEndDate(req.getParameter("EndYear")+"-"+req.getParameter("EndMonth")+"-"+req.getParameter("EndDay"));
			em.setConductedBy(req.getParameter("ConductedBy"));
			em.setCentre(req.getParameter("Centre"));
			em.setCountry(req.getParameter("Country"));
			em.setFrequency(Integer.parseInt(req.getParameter("Frequency")));
			em.setShowResults(Integer.parseInt(req.getParameter("ShowResults")));
			em.setDisplayTests(Integer.parseInt(req.getParameter("DisplayTests")));
			em.setRegistrationFee(Float.parseFloat(req.getParameter("RegistrationFee")));
		//	em.setStoreID(Integer.parseInt(req.getParameter("StoreID")));

			sql = "UPDATE ExamMaster SET Exam='"+em.getExam()+ "', ExamMode="+em.getExamMode()+", StartDate='"+em.getStartDate()+ "', EndDate='"+ em.getEndDate()+ "',ConductedBy='"+em.getConductedBy()+ "',Centre='"+em.getCentre()+ "', Country='"+em.getCountry()+"',Frequency="+em.getFrequency()+ ",ShowResults="+em.getShowResults()+ ",DisplayTests="+em.getDisplayTests()+ ",RegistrationFee="+em.getRegistrationFee()+" WHERE ExamID="+em.getExamID()+"";
			pstmt = con.prepareStatement(sql);
			if (pstmt.executeUpdate() > 0)
			{
				System.err.println("Exam Successfully Updated.");
			}
			else
			{
				System.err.println("Error in Updating exam.");
			}
			return true;
		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			System.err.println(e.getMessage());
			return false;
		}
		finally
		{
			em = null;
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}
///////////////////////////////

	public synchronized boolean doUpdateTestDetails(HttpServletRequest req, HttpServletResponse res)
	{
		try
		{
			PrintWriter out = res.getWriter();
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			int ExamID = Integer.parseInt(req.getParameter("ExamID"));
			int SectionID = Integer.parseInt(req.getParameter("SectionID"));
			int TestCode = Integer.parseInt(req.getParameter("TestCode"));
			//String TestName = req.getParameter("TestName");
			String SectionName = req.getParameter("SectionName");
			int NoOfQuestions = Integer.parseInt(req.getParameter("NoOfQuestions"));
			int TimerType = Integer.parseInt(req.getParameter("TimerType"));
			int ResponseTime = Integer.parseInt(req.getParameter("QuestionTime"));
			int SectionTime = Integer.parseInt(req.getParameter("SectionTime"));
			float NegativeMarks = Float.parseFloat(req.getParameter("NegativeMarks"));
			int LevelID = Integer.parseInt(req.getParameter("Level"));
			int IncludeSublevels = Integer.parseInt(req.getParameter("IncludeSublevels"));
			float Criteria = Float.parseFloat(req.getParameter("Criteria"));
			int NoOfBreaksAllowed = Integer.parseInt(req.getParameter("NoOfBreaksAllowed"));
			int BreakInterval = Integer.parseInt(req.getParameter("BreakInterval"));
			int Prerequisite = Integer.parseInt(req.getParameter("Prerequisite"));
			int NoOfAttemptsAllowed = Integer.parseInt(req.getParameter("NoOfAttemptsAllowed"));
			int ExamTime= Integer.parseInt(req.getParameter("ExamTime"));
			int DisplaySections = Integer.parseInt(req.getParameter("DisplaySections"));
			int Adaptive = Integer.parseInt(req.getParameter("Adaptive"));
			int UpLimit = Integer.parseInt(req.getParameter("UpLimit"));
			int DownLimit = Integer.parseInt(req.getParameter("DownLimit"));
			int InstructionID = Integer.parseInt(req.getParameter("Instruction"));
			String strID[] = req.getParameterValues("CodeGroupID");

			sql = "UPDATE NewExamDetails SET SectionName='"+SectionName+ "', NoOfQuestions="+NoOfQuestions+", TimerType="+TimerType+ ", ResponseTime="+ ResponseTime+ ",SectionTime="+SectionTime+ ",NegativeMarks="+NegativeMarks+ ", LevelID="+LevelID+",IncludeSublevels="+IncludeSublevels+ ",Criteria="+Criteria+ ",NoOfBreaksAllowed="+NoOfBreaksAllowed+ ",BreakInterval="+BreakInterval+", Prerequisite="+Prerequisite+", NoOfAttemptsAllowed="+NoOfAttemptsAllowed+", ExamTime="+ExamTime+", DisplaySections="+DisplaySections+", Adaptive="+Adaptive+", UpLimit="+UpLimit+", DownLimit="+DownLimit+", InstructionID="+InstructionID+" WHERE SectionID="+SectionID;
			pstmt = con.prepareStatement(sql);
			if (pstmt.executeUpdate() > 0)
			{

				sql="DELETE from CodeGroupDetails where SectionID="+SectionID;
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				int ID =0;
				for(int i=0; i<strID.length;i++)
				{
					ID = Integer.parseInt(strID[i]);
					sql = "INSERT INTO CodeGroupDetails values("+ExamID+", "+TestCode+", "+SectionID+", "+ID+")";
					pstmt = con.prepareStatement(sql);
					pstmt.executeUpdate();
				}

				System.err.println("Test Successfully Updated.");
			}
			else
			{
				System.err.println("Error in Updating test.");
			}
			return true;
		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			System.err.println(e.getMessage());
			return false;
		}
		finally
		{
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}


////////////////////////////////

 	public synchronized void deleteExamMaster(HttpServletRequest req, HttpServletResponse res)
	{
		try{
		PrintWriter out = res.getWriter();
		out.println("<center>Delete ExamMaster.");
		out.println("<form action=" +req.getRequestURI()+ " method='post'>");
		out.println("<table border=0 cellspacing=1 cellpadding=1 width=300 bgcolor='#000000'>");
		out.println("<tr><th><b>WARNING</b></th></tr>");
		out.println("<tr><td><p>Selected Exam will be permenently deleted.<P>Are you sure ?</td>");
		out.println("<tr><input type=hidden name='action' value='doDelete'>");
		out.println("<input type=hidden name='ExamID' value='" +req.getParameter("ExamID")+ "'>");
		out.println("<th><input type=submit value='Delete'>");
		out.println("<input type=button value='Cancel' onClick='javascript:history.back()'></th></tr>");
		out.println("</table></form>");
		}
		catch(Exception e)
		{
			System.err.println(e.getMessage());
		}

	}

	public synchronized boolean doDeleteExamMaster(HttpServletRequest req, HttpServletResponse res)
	{
		try
		{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			sql = "DELETE FROM ExamMaster WHERE ExamID="+req.getParameter("ExamID");
			pstmt = con.prepareStatement(sql);
			if (pstmt.executeUpdate(sql) > 0)
			{
				System.err.println("Exam Successfully Deleted.");
			}
			else
				System.err.println("Error in Deleting Exam.");

			return true;
		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			return false;
		}
		finally
		{
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}

	public synchronized boolean doDeleteTestDetails(HttpServletRequest req, HttpServletResponse res)
	{
		try
		{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			sql = "DELETE FROM NewExamDetails WHERE ExamID="+req.getParameter("ExamID")+" and TestCode="+req.getParameter("TestCode")+" and SectionID="+req.getParameter("SectionID");
			pstmt = con.prepareStatement(sql);
			if (pstmt.executeUpdate() > 0)
			{
				System.err.println("Test Successfully Deleted.");
			}
			else
				System.err.println("Error in Deleting Test.");

			return true;
		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			return false;
		}
		finally
		{
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}

 	public synchronized void deleteTestDetails(HttpServletRequest req, HttpServletResponse res)
	{
		try{
		PrintWriter out = res.getWriter();
		out.println("<center>Delete Test.");
		out.println("<form action=" +req.getRequestURI()+ " method='post'>");
		out.println("<table border=0 cellspacing=1 cellpadding=1 width=300 bgcolor='#000000'>");
		out.println("<tr><th><b>WARNING</b></th></tr>");
		out.println("<tr><td><p>Selected Section of Test will be permenently deleted.<P>Are you sure ?</td>");
		out.println("<tr><input type=hidden name='action' value='doDeleteTest'>");
		out.println("<input type=hidden name='ExamID' value='" +req.getParameter("ExamID")+ "'>");
		out.println("<input type=hidden name='TestCode' value='" +req.getParameter("TestCode")+ "'>");
		out.println("<input type=hidden name='SectionID' value='" +req.getParameter("SectionID")+ "'>");

		out.println("<th><input type=submit value='Delete'>");
		out.println("<input type=button value='Cancel' onClick='javascript:history.back()'></th></tr>");
		out.println("</table></form>");
		}
		catch(Exception e)
		{
			System.err.println(e.getMessage());
		}

	}

	public synchronized void displayExamMasterDataEntryForm(HttpServletRequest req, HttpServletResponse res)
	{
		try{

		PrintWriter out = res.getWriter();
		out.println("<center>Define new Exam.");
		out.println("<form action=" +req.getRequestURI()+ " method='post'>");
		out.println("<table border=0 cellspacing=1 cellpadding=1>");
		out.println("<tr><th colspan=2><b>Exam Details</b></th></tr>");
		out.println("<tr><td align=right><b>Exam :&nbsp;</b></td>");
		out.println("<td><input type=text name=Exam></td></tr>");

		out.println("<tr><td align=right><b>How would you like Questions to be appeared in the Exam :&nbsp;</b></td>");
		out.println("<td><select name='ExamMode'><option value='1'>One Question</option><option value='2'>All Questions</option></select></td></tr>");

		out.println("<tr><td align=right><b>Exam Registration Fees :&nbsp;</b></td>");
		out.println("<td><input type=text name=RegistrationFee></td></tr>");

		out.println("<tr><td align=right><b>StartDate :&nbsp;</b></td>");
		out.println("<td class='small'>");
		out.println(displayIntSelect("StartDay", 1,31,1));
		out.println("&nbsp;-&nbsp;");
		out.println(displayIntSelect("StartMonth",1,12,1));
		out.println("&nbsp;-&nbsp;");
		out.println(displayIntSelect("StartYear", 2000,2020,2000));
		out.println("&nbsp;&nbsp;(DD-MM-YYYY)&nbsp;</td></tr>");

		out.println("<tr><td align=right><b>EndDate :&nbsp;</b></td>");
		out.println("<td class='small'>");
		out.println(displayIntSelect("EndDay", 1,31,1));
		out.println("&nbsp;-&nbsp;");
		out.println(displayIntSelect("EndMonth",1,12,1));
		out.println("&nbsp;-&nbsp;");
		out.println(displayIntSelect("EndYear", 2000,2020,2000));
		out.println("&nbsp;&nbsp;(DD-MM-YYYY)&nbsp;</td></tr>");

		out.println("<tr><td align=right><b>Who is conducting this Exam :&nbsp;</b></td>");
		out.println("<td><input type=text name=ConductedBy></td></tr>");

		out.println("<tr><td align=right><b>Centre :&nbsp;</b></td>");
		out.println("<td><input type=text name=Centre></td></tr>");

		out.println("<tr><td align=right><b>Country :&nbsp;</b></td>");
		out.println("<td>");
		out.println(displayCountrySelect("IN"));
		out.println("</td></tr>");

		out.println("<tr><td align=right><b>Frequency :&nbsp;</b></td>");
		out.println("<td><input type=text name=Frequency></td></tr>");

		out.println("<tr><td align=right><b>Show Result after Exam ?&nbsp;</b></td>");
		out.println("<td><select name=ShowResults><option value=1 selected>Yes</option><option value=0>No</option></td></tr>");

		out.println("<tr><td align=right><b>Allow user to select Test ?&nbsp;</b></td>");
		out.println("<td><select name=DisplayTests><option value=1 selected>Yes</option><option value=0>No</option></td></tr>");

	//	out.println("<tr><td align=right><b>Result Storage Strategy :&nbsp;</b></td>");
	//	out.println("<td>");
	//	out.println(displayStoreSelect(0));
	//	out.println("</td></tr>");

		out.println("<tr><input type=hidden name='action' value='doAdd'>");
		out.println("<th colspan=2><input type=submit value='Submit'></th></tr>");
		out.println("</table></form>");
		}
		catch(Exception e)
		{
			System.err.println(e.getMessage());
		}
	}

	public void displayFullTestEntryForm(HttpServletRequest req, HttpServletResponse res)
	{
		PrintWriter out= null;
		try
		{
			out = res.getWriter();
			out.println("<center>Define new test.");
			out.println("<form action=" +req.getRequestURI()+ " method='post'>");
			out.println("<table border=0 cellspacing=1 cellpadding=1>");
			out.println("<tr><th colspan=2><b>Test Details</b></th></tr>");

			out.println("<tr><td align=right><b>Test Name :&nbsp;</b></td>");
			if(req.getParameter("TestName")==null)
				out.println("<td><input type=text name=TestName></td></tr>");
			else
				out.println("<td>"+req.getParameter("TestName")+"<input type=hidden name=TestName value="+req.getParameter("TestName")+"><input type=hidden name=TestCode value="+req.getParameter("TestCode")+"></td></tr>");
			out.println("<tr><td align=right><b>SectionName :&nbsp;</b></td>");
			out.println("<td><input type=text name=SectionName></td></tr>");

			out.println("<tr><td align=right><b>Subjects :&nbsp;</b></td>");
			int ExamID = Integer.parseInt(req.getParameter("ExamID"));
			out.println("<td>"+displaySubjectSelect(ExamID)+"</td></tr>");

			out.println("<tr><td align=right><b>NoOfQuestions:&nbsp;</b></td>");
			out.println("<td><input type=text name=NoOfQuestions></td></tr>");

			out.println("<tr><td align=right><b>TimerType :&nbsp;</b></td>");
			out.println("<td><select name=TimerType>");
			out.println("<option value=1>Question Timer</option>");
			out.println("<option value=2>Section Timer</option>");
			out.println("<option value=3 selected>Exam Timer</option>");
			out.println("</select></td></tr>");

			out.println("<tr><td align=right><b>QuestionTime :&nbsp;</b></td>");
			out.println("<td><input type=text name=QuestionTime></td></tr>");

			out.println("<tr><td align=right><b>SectionTime :&nbsp;</b></td>");
			out.println("<td><input type=text name=SectionTime></td></tr>");

			out.println("<tr><td align=right><b>NegativeMarks :&nbsp;</b></td>");
			out.println("<td><input type=text name=NegativeMarks></td></tr>");

			out.println("<tr><td align=right><b>Level :&nbsp;</b></td>");
			out.println("<td>"+displayLevelSelect(ExamID)+"</td></tr>");

			out.println("<tr><td align=right><b>IncludeSublevels :&nbsp;</b></td>");
			out.println("<td><select name=IncludeSublevels>");
			out.println("<option value=1>Yes</option>");
			out.println("<option value=0>No</option>");
			out.println("</select></td></tr>");

			out.println("<tr><td align=right><b>Criteria :&nbsp;</b></td>");
			out.println("<td><input type=text name=Criteria></td></tr>");

			out.println("<tr><td align=right><b>NoOfBreaksAllowed :&nbsp;</b></td>");
			out.println("<td><input type=text name=NoOfBreaksAllowed></td></tr>");

			out.println("<tr><td align=right><b>BreakInterval :&nbsp;</b></td>");
			out.println("<td><input type=text name=BreakInterval></td></tr>");

			out.println("<tr><td align=right><b>Prerequisite :&nbsp;</b></td>");
			out.println("<td><input type=text name=Prerequisite></td></tr>");

			out.println("<tr><td align=right><b>NoOfAttemptsAllowed :&nbsp;</b></td>");
			out.println("<td><input type=text name=NoOfAttemptsAllowed></td></tr>");

			out.println("<tr><td align=right><b>ExamTime :&nbsp;</b></td>");
			out.println("<td><input type=text name=ExamTime></td></tr>");

			out.println("<tr><td align=right><b>DisplaySections :&nbsp;</b></td>");
			out.println("<td><select name=DisplaySections>");
			out.println("<option value=1>Yes</option>");
			out.println("<option value=0>No</option>");
			out.println("</select></td></tr>");

			out.println("<tr><td align=right><b>Adaptive :&nbsp;</b></td>");
			out.println("<td><select name=Adaptive>");
			out.println("<option value=1>Yes</option>");
			out.println("<option value=0>No</option>");
			out.println("</select></td></tr>");

			out.println("<tr><td align=right><b>Up Limit :&nbsp;</b></td>");
			out.println("<td>"+displayIntSelect("UpLimit",1,5,1)+"</td></tr>");

			out.println("<tr><td align=right><b>Down Limit :&nbsp;</b></td>");
			out.println("<td>"+displayIntSelect("DownLimit",1,5,1)+"</td></tr>");


			//out.println("<tr><td align=right><b>Instruction :&nbsp;</b></td>");
			//out.println("<td>"+displayInstructionSelect(0)+"</td></tr>");

			out.println("<tr><td align=center colspan=2>");
			out.println("<input type='hidden' name=action value=doAddTest>");
			out.println("<input type='hidden' name=ExamID value="+ExamID+">");
			out.println("<input type=submit value='Add Details'> &nbsp;&nbsp;&nbsp;<input type=button value=Cancel onClick='javascript:history.back()'></td></tr>");
			out.println("</table></form></center>");
		}
		catch(NumberFormatException nfe)
		{

			out.println(Utils.showError("ERROR", "Error in Section Entry",""));
			return;
		}

		catch(Exception e)
		{
			System.err.println(e.getMessage());
		}
	}


	public synchronized void displayExistingExamMaster(HttpServletRequest req, HttpServletResponse res)
	{
		try
		{
			PrintWriter out = res.getWriter();
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
			con = pool.getConnection();
			sql = "SELECT * FROM ExamMaster ORDER BY Exam";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			out.println("<table border=0 cellspacing=1 cellpadding=1>");
			out.println("<tr><th colspan=13>ExamMaster</th></tr>");
		//<th>ConductedBy</th><th>Centre</th><th>Country</th><th>Frequency</th>
	//<th>StoreID</th>
		out.println("<tr><th>Exam</th><th>ExamMode</th><th>StartDate</th><th>EndDate</th><th>ShowResults</th><th>DisplayTests</th><th>Delete</th><th>TestDetails</th></tr>");

			while (rs.next())
			{
				String StartDate = null;
				String EndDate = null;
				String StoreID = null;

				StartDate=getFormattedDate(rs.getDate("StartDate"));
				EndDate=getFormattedDate(rs.getDate("EndDate"));
				//StoreID=getStoreName(rs.getInt("StoreID"));

				out.println("<tr><td><a href='" +req.getRequestURI()+ "?action=Update&ExamID="+rs.getInt("ExamID")+"'>" +rs.getString("Exam")+ "</a></td>");
				out.println("<td>" +rs.getString("ExamMode")+ "</td>");
				out.println("<td>" +StartDate+"</td>");
				out.println("<td>" +EndDate+ "</td>");
				//out.println("<td>" +rs.getString("ConductedBy")+ "</td>");
				//out.println("<td>" +rs.getString("Centre")+ "</td>");
				//out.println("<td>" +rs.getString("Country")+ "</td>");
				//out.println("<td>" +rs.getString("Frequency")+ "</td>");
				if(rs.getInt("ShowResults")==1)
					out.println("<td>Yes</td>");
				else
					out.println("<td>No</td>");

				if(rs.getInt("DisplayTests")==1)
					out.println("<td>Yes</td>");
				else
					out.println("<td>No</td>");

				//out.println("<td>" +StoreID+ "</td>");
				out.println("<td><a href='" +req.getRequestURI()+ "?action=Delete&ExamID="+rs.getInt("ExamID")+"'>Delete</a></td>");
				out.println("<td><a href='" +req.getRequestURI()+ "?action=TestDetails&ExamID="+rs.getInt("ExamID")+"'>TestDetails</a></td></tr>");
			}
			out.println("</table>");
		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
		}
		finally
		{
			rs = null;
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}
	public void displayExistingTestDetails(HttpServletRequest req, HttpServletResponse res)
	{
		try
		{
			PrintWriter out = res.getWriter();
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
			con = pool.getConnection();
			int ExamID = Integer.parseInt(req.getParameter("ExamID"));
			int TestCode = 0;
			if(req.getParameter("TestCode")==null)
			{
				sql = "SELECT * FROM NewExamDetails where ExamID="+ExamID+" ORDER BY TestName, SectionName";
			}
			else
			{
				TestCode = Integer.parseInt(req.getParameter("TestCode"));
				sql = "SELECT * FROM NewExamDetails where ExamID="+ExamID+" and TestCode="+TestCode+" ORDER BY TestName, SectionName";
			}
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			out.println("<table border=0 cellspacing=1 cellpadding=1>");
			out.println("<tr><th colspan=5>Test Details</th></tr>");
			out.println("<tr><th>Test Name</th><th>Section Name</th><th>No Of Questions</th><th>Display Sections</th><th>Delete</th></tr>");

			while(rs.next()) {
				out.println("<tr><td><a href='" +req.getRequestURI()+ "?action=UpdateTest&SectionID="+rs.getInt("SectionID")+"'>" +rs.getString("TestName")+ "</a></td>");
				out.println("<td>"+rs.getString("SectionName")+"</td>");
				out.println("<td>"+rs.getString("NoOfQuestions")+"</td>");

				if(rs.getInt("DisplaySections")==1)
					out.println("<td>Yes</td>");
				else
					out.println("<td>No</td>");

				out.println("<td><a href='"+req.getRequestURI()+ "?action=DeleteTest&TestCode="+rs.getInt("TestCode")+"&ExamID="+rs.getInt("ExamID")+"&SectionID="+rs.getInt("SectionID")+"'>Delete</a></td></tr>");
			}
			out.println("</table>");

		}
		catch(Exception e)
		{
			System.err.println("Connection Error :"+e);
		}
		finally
		{
			rs=null;
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}

	}

	public String displayStoreSelect(int id) {
		try {

			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			sql = "SELECT distinct(StoreID), Name FROM ExamStoragePattern";
			rs=null;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery(sql);

			String val = "<select name=StoreID>";
			while(rs.next()) {
				if(rs.getInt("StoreID") == id)
					val=val+"<option value='"+rs.getInt("StoreID")+"' selected>"+rs.getString("Name")+"</option>";
				else
					val=val+"<option value='"+rs.getInt("StoreID")+"'>"+rs.getString("Name")+"</option>";
			}
			val=val+"</select>";
			return val;

		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			return null;
		}
		finally
		{
			rs=null;
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}


	public String displayInstructionSelect(int ID) {
		try {

			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			sql = "SELECT * FROM InstructionMaster";
			ResultSet rs1=null;
			pstmt = con.prepareStatement(sql);
			rs1 = pstmt.executeQuery(sql);

			String val = "<select name=Instruction>";
			while(rs1.next()) {
				int InstructionID=rs1.getInt("InstructionID");
				if(InstructionID==ID)
					val=val+"<option value='"+InstructionID+"' selected>"+rs1.getString("Name")+"</option>";
				else
					val=val+"<option value='"+InstructionID+"'>"+rs1.getString("Name")+"</option>";

			}
			val=val+"</select>";
			return val;

		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			return null;
		}
		finally
		{
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}


	public String displayCountrySelect(String id) {
		try {

			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			sql = "SELECT * FROM CountryMaster";
			ResultSet rs1=null;
			rs1 = pstmt.executeQuery(sql);

			String val = "<select name=Country>";
			while(rs1.next()) {
				String CountryCode=rs1.getString("CountryCode");
				System.out.println("CountryCode :"+CountryCode);
				if(CountryCode.equals(id))
					val=val+"<option value='"+CountryCode+"' selected>"+rs1.getString("Name")+"</option>";
				else
					val=val+"<option value='"+CountryCode+"'>"+rs1.getString("Name")+"</option>";
			}
			val=val+"</select>";
			return val;

		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			return null;
		}
		finally
		{
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}


	public String displayLevelSelect(int ExamID) {
		try {

			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			sql = "SELECT * FROM LevelMaster where ExamID="+ExamID;
			ResultSet rs1=null;
			pstmt = con.prepareStatement(sql);
			rs1 = pstmt.executeQuery();

			String val = "<select name=Level>";
			while(rs1.next()) {
				val=val+"<option value='"+rs1.getString("LevelID")+"' selected>"+rs1.getString("Level")+"</option>";
			}
			val=val+"</select>";
			return val;

		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			return null;
		}
		finally
		{
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}

	public String displayIntSelect(String name, int start, int end, int selected) {
		String val = "<select name="+name+">";
		for(int i=start; i<=end; i++) {
			if(i==selected)
				val=val+"<option value='"+i+"' selected>"+i+"</option>";
			else
				val=val+"<option value='"+i+"'>"+i+"</option>";
		}
		val = val+"</select>";
		return val;
	}
//DM290102A
	public String displaySubjectSelect(int ExamID) {
			String var = "<select name=CodeGroupID size=5 multiple>";
		try
		{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
			con = pool.getConnection();
			//ExamID=Integer.parseInt(req.getParameter("ExamID"));
			String sql = "select * from CodeMaster where ExamID="+ExamID;
			System.out.print(sql);
			ResultSet rs1 = null;
			String select="";
			pstmt = con.prepareStatement(sql);
			rs1=pstmt.executeQuery(sql);
			//Vector vectID = new Vector();
			while(rs1.next())
			//	vectID.addElement(rs1.getString("CodeID"));
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next())		{
				String name=rs.getString("Description");
				String ID=rs.getString("CodeID");
				//if(vectID.contains(ID))
				//	var = var+"<option value='"+ID+ "' selected>" + name + "</option>";
				//else
					var = var+"<option value='"+ID+ "'>" + name + "</option>";
			}
		}
		catch(Exception e) {
			System.err.println(e.getMessage());
		}
		var = var + "</select>";
		return var;
	}

   	public String getFormattedDate(Date date) {
		try
		{
			return (date.getDate() + "-" + (date.getMonth()+1) + "-" + (date.getYear()+1900));
		}
		catch(Exception e)
		{
			System.err.println ("Error while Formatting Date.");
			return null;
		}
	}
	public String getStoreName(int StoreID) {
		try {

			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

			con = pool.getConnection();
			sql = "SELECT Name FROM ExamStoragePattern where StoreID="+StoreID;
			ResultSet rs1=null;
			pstmt = con.prepareStatement(sql);
			rs1 = pstmt.executeQuery(sql);

			while(rs1.next())
				return rs1.getString("Name");

			return null;

		}
		catch(Exception e)
		{
			System.err.println("Connection Error");
			return null;
		}
		finally
		{
			pstmt = null;
			if (con != null)
				pool.releaseConnection(con);
			else
				System.err.println ("Error while Connecting to Database.");
		}
	}
	public String getTime(int sec)
	{
		int s=0, m=0, h=0;
		s=sec;
		while(s>59) {
			s=s-60;
			m++;
		}
		while(m>59) {
			m=m-60;
			h++;
		}
		String time= "";
		if(h>9)
			time = h+":";
		else
			time = "0"+h+":";

		if(m>9)
			time = time+""+m+":";
		else
			time = time+""+"0"+m+":";

		if(s>9)
			time = time+""+s;
		else
			time = time+""+"0"+s;

		return time;
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		out.println("<html><head><LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></head>");
		out.println("<body><center><p>");

		String action = req.getParameter("action");
		if ( action.equalsIgnoreCase("doAdd") )
		{
			if ( doAddExam(req, res) )
			{
				out.println("Exam Successfully Added.");
				res.sendRedirect( req.getRequestURI() );
			}
			else
				out.println("<B>ERROR: Error in adding Exam.</B>");
		}
		else if ( action.equalsIgnoreCase("Update") )
		{
			updateExamMaster(req, res);
		}
		else if ( action.equalsIgnoreCase("doUpdate") )
		{
			if (doUpdateExamMaster(req, res) )
			{
				out.println("Exam Successfully Updated.");
				res.sendRedirect( req.getRequestURI() );
			}
			else
				out.println("<B>ERROR: Error in Updating Exam.</B><br><Br>"+sql);
		}
		else if ( action.equalsIgnoreCase("Delete") )
		{
			deleteExamMaster(req, res);
		}
		else if ( action.equalsIgnoreCase("doDelete") )
		{
			if (doDeleteExamMaster(req, res) )
			{
				out.println("Exam Successfully Deleted.");
				res.sendRedirect( req.getRequestURI() );
			}
			else
				out.println("<B>ERROR: Error in Deleting Exam.</B>");
		}
		else if ( action.equalsIgnoreCase("TestDetails") )
		{
			displayFullTestEntryForm(req, res);
			out.println("<br><Br><p><hr size=1></p>");
			displayExistingTestDetails(req, res);
		}
		else if(action.equalsIgnoreCase("DeleteTest"))
		{
			deleteTestDetails(req, res);
		}
		else if(action.equalsIgnoreCase("doDeleteTest"))
		{
			if(doDeleteTestDetails(req, res))
			{
				out.println("Exam Successfully Deleted.");
				res.sendRedirect( req.getRequestURI() );
			}
		}
		else if(action.equalsIgnoreCase("FullTestEntry"))
		{
			displayFullTestEntryForm(req, res);
		}
		else if(action.equalsIgnoreCase("doAddTest"))
		{
			if ( doAddTest(req, res) )
			{
				res.sendRedirect(req.getRequestURI()+"?action=TestDetails&ExamID=" + req.getParameter("ExamID") );
			}
			else
				out.println(Utils.showError("ERROR", "An error has occured while adding new Test.","Check the fields for valid data"));

		}
		else if ( action.equalsIgnoreCase("UpdateTest") )
		{
			updateTestDetails(req, res);
		}
		else if ( action.equalsIgnoreCase("doUpdateTest") )
		{
			if (doUpdateTestDetails(req, res) )
			{
				out.println("Test Successfully Updated.");
				res.sendRedirect( req.getRequestURI()+"?action=TestDetails&ExamID=" + req.getParameter("ExamID"));
			}
			else
				out.println("<B>ERROR: Error in Updating Test.</B><br><Br>"+sql);
		}

		out.println("</body></html>");
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		out.println("<html><head><LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></head>");
		out.println("<body><center><p>");

		String action = req.getParameter("action");

		if (action == null || action == "")
		{
			displayExamMasterDataEntryForm(req, res);
			out.println("<p><hr size=1></p>");
			displayExistingExamMaster(req, res);
		}
		else
		{
			doPost(req, res);
		}

		out.println("</body></html>");
	}
}
/*
----------Test Points-----------
DM2601A -> Test Adding Module
DM2601B -> Test Updating Module

--------------------------------
*/
