import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.html.simpleparser.HTMLWorker;
import com.itextpdf.text.html.simpleparser.StyleSheet;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.lowagie.text.Element;
import com.lowagie.text.html.HtmlTags;
import com.ngs.gen.Utils;


public class MarkSheet extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null,stmt1 = null;
	ResultSet rs = null,rs1 = null;
	String fname="",lname="",clientId="";
	String candidateId = "",key="";
	int cid=0;

	public void init()
	{
		try
		{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		}
		catch(Exception e)
		{
			//System.out.println("Connection Error : " + e.getMessage());
		}
	}

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		HttpSession session=req.getSession(true);
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		//System.out.println("inside markseet action :"+action);
		String sql="";
		try {
			con = pool.getConnection();
						
			if (action == null || action == "")
			{
			
				sql = "SELECT FirstName,LastName,CandidateID,ClientID FROM CandidateMaster";
				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				//System.out.println(" sql:"+sql);
											
				out.println("<HTML><HEAD><TITLE>Mark Sheet</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				out.println("<FORM NAME=form action=\"../servlet/MarkSheet\">");
				out.println("<BR></BR><BR></BR><BR></BR>");
				out.println("<table border=\"1\" cellspacing=\"1\" cellpadding=\"1\" align=\"center\">");
				out.println("<TR><th colspan=\"2\">Candidate Marksheet Details</th></TR>");
				out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Registration No -> Candidate Name :</TD><TD><SELECT NAME=CandidateID>");
				while(rs1.next())
				{
					fname = rs1.getString("FirstName");
					lname = rs1.getString("LastName");
					candidateId = rs1.getString("CandidateID");
					clientId = rs1.getString("ClientID");
					cid = Integer.parseInt(candidateId);
					RegistrationKey regkey = new RegistrationKey(cid);
					String Regkey = regkey.getKeyCode();
					//System.out.println("RegistrationKey :"+Regkey);
										
					session.setAttribute("FirstName",fname);
					session.setAttribute("LastName",lname);
					session.setAttribute("CandidateID",candidateId);
					session.setAttribute("ClientID",clientId);
					session.setAttribute("CID",Integer.valueOf(cid));
					session.setAttribute("Regkey",Regkey);
					//System.out.println("candidateId :"+candidateId);
					//System.out.println("clientId :"+clientId);
					if (candidateId.equals("371"))
					{
						out.println("<option value='"+candidateId+"' SELECTED>"+Regkey+" -> "+fname+" "+lname+"</option>");
					}
					else
						out.println("<option value='"+candidateId+"'>"+Regkey+" -> "+fname+" "+lname+"</option>");
							
				}		
				out.println("</SELECT></TD></TR>");
				out.println("<tr><td colspan=\"2\" align=center><input type=submit value=Genmarksheet name=submit></td></tr>");
				out.println("<input type=hidden value=showmarksheet name=action>");
				out.println("</table></FORM></BODY></HTML>");
				//	con.close();
			}
				} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				}
		
				Integer CandidateID = (Integer) session.getAttribute("CID");
				int cid = 0;
				try {
					cid = Integer.parseInt(req.getParameter("CandidateID"));
					//System.out.println("inside markseet CandidateID :"+cid);
				}catch(NullPointerException npe) {
				}

				//		int cid = CandidateID.intValue();
						String ExamID = req.getParameter("ExamID");
						int lid=0,examid=0,clientid=0;
						String ClientID = (String) session.getAttribute("ClientID");
						//System.out.println("inside markseet ClientID :"+ClientID);
						if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
						{
				//			clientid = 0;
							res.sendRedirect("../jsp/Login.jsp");
						}
						else
							clientid = Integer.parseInt(ClientID);
				//		if (ExamID == null || ExamID.equals("") || ExamID.equals(null) || ExamID=="")
				//		{
				//			examid =1;
				//		}
				//		else
				//			cid = Integer.parseInt(ExamID);


		try
		{
			if (action.equals("showmarksheet"))
			{
				res.setContentType("text/html");
				StringBuffer sb = new StringBuffer();
				sb.append("<HTML><HEAD><TITLE></TITLE>");
				sb.append("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				sb.append("<BODY><CENTER>");
				String firstname = "" , lastname ="",testname="",clientname="",date="",time="",result="",fromtime="",totime="",key="",cityid="",areaid="";
				int totquest=0,nowrong=0,nocorrect=0,rest=0,sectionid=0,schid=0;
				float percent = 0.00f;
				float passpercent=0.00f;

				sql = "SELECT ExamID FROM CandidateDetails WHERE CandidateID=" + cid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					examid = rs.getInt("ExamID");
				}

				sql = "SELECT FirstName,LastName,ClientID,ScheduleID FROM CandidateMaster WHERE CandidateID=" + cid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					firstname = rs.getString("FirstName");
					lastname = rs.getString("LastName");
					clientid = rs.getInt("ClientID");
					schid = rs.getInt("ScheduleID");
				}

				sql = "SELECT TestName FROM NewExamDetails WHERE ExamID=" + examid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					testname = rs.getString("TestName");
				}

				sql = "SELECT ClientName FROM ClientMaster WHERE ClientID=" + clientid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					clientname = rs.getString("ClientName");
				}
				sql = "SELECT TimeFrom,TimeTo,ScheduleDate,SectionID  FROM Schedule WHERE ScheduleID="+schid ;
//out.println(sql);
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					sectionid =  rs.getInt("SectionID");
					date = rs.getString("ScheduleDate");
//out.println("date : " + date);
					fromtime = rs.getString("TimeFrom");
					fromtime = fromtime.substring(0,5);
					totime = rs.getString("TimeTo");
					totime = totime.substring(0,5);
				}
/*				sql = "SELECT Date,Time,TotalQuestions,NoOfWrong,NoOfCorrect,Result  FROM PerformanceMaster WHERE CandidateID=" + cid + " and ExamID=" + examid;
				rs = stmt.executeQuery(sql);

				while (rs.next())
				{
					date = rs.getString("Date");
					time = rs.getString("Time");
					totquest = rs.getInt("TotalQuestions");
					nowrong = rs.getInt("NoOfWrong");
					nocorrect = rs.getInt("NoOfCorrect");
					rest = rs.getInt("Result");
				}
*/
				float score=0.0f;
				String tql = "SELECT sum(TotalQuestions),sum(NoOfWrong),sum(NoOfCorrect),sum(Score) FROM 	NewPerformanceMaster WHERE CandidateID=" + cid + " and ExamID=" + examid +" group by SectionID";
//out.println(tql);
				pstmt = con.prepareStatement(tql);
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					totquest =  rs.getInt(1);
					nowrong = rs.getInt(2);
					nocorrect = rs.getInt(3);
					score = rs.getFloat(4);
				}
				tql = "Select NoOfQuestions,LevelID from NewExamDetails where ExamID="+examid+" and SectionID="+sectionid ;
//out.println("<BR>"+tql);
				pstmt = con.prepareStatement(tql);
				rs = pstmt.executeQuery();
				int TotalMarks=0;
				while(rs.next())
				{
					TotalMarks = TotalMarks +(rs.getInt("NoOfQuestions")*rs.getInt("LevelID"));
				}

//				unattempted=totquest-(nocorrect+nowrong);
				percent	= ((score*100)/TotalMarks) ;
				if (percent < 0)
					percent = 0;
				//select c.CityID,c.AreaID from CandidateMaster a,ClientMaster b,LocationMaster c where a.CandidateID=1 and a.ClientID=b.ClientID and b.LocationID=c.LocationID




/*				sql = "SELECT Percentage FROM RemarkDetails WHERE ExamID=" + examid;
out.println(sql);
				rs = stmt.executeQuery(sql);
				while (rs.next())
				{
					passpercent = rs.getFloat("Percentage");
				}
*/
				sql = "SELECT Result FROM NewPerformanceMaster WHERE ExamID=" +examid+ " AND SectionID=" +sectionid+ " AND CandidateID=" +cid;
//out.println(sql);
			 	pstmt = con.prepareStatement(sql);
			  	rs = pstmt.executeQuery();
				int Result = 0;
				while (rs.next())
				{
					Result = rs.getInt("Result");
				}
				if (Result == 1){result="Pass";}else{result="Fail";}
//				percent = (nocorrect*100)/totquest;
/*
				day = date.substring(8,10);
				mth = date.substring(5,7);
				yr = date.substring(0,4);
				date = day + "-" + mth + "-" + yr;
*/
//				Utils myUtil = new Utils();
//				date = myUtil.getDate(date);
               
				cid = Integer.parseInt(req.getParameter("CandidateID"));
								
				RegistrationKey regkey = new RegistrationKey(cid);
				String Regkey = regkey.getKeyCode();
				//System.out.println("RegistrationKey from bean:"+Regkey);
				
				 Document document = new Document(PageSize.A4);
				 PdfWriter pdfWriter = PdfWriter.getInstance(document, new FileOutputStream("c://"+Regkey+" Marksheet.pdf"));
				 document.open();
				 document.addAuthor("Makarand Kulkarni");
				 document.addCreator("Nectar Global Services");
				 document.addSubject("Thanks for your support");
				 document.addCreationDate();
				 document.addTitle("Nectar Prometric Examination");
				 HTMLWorker htmlWorker = new HTMLWorker(document);
				
				
				PdfPTable table = new PdfPTable(2);
				table.setWidthPercentage(100);
				table.getDefaultCell().setBorder(Rectangle.NO_BORDER);
				table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
				table.getDefaultCell().setFixedHeight(70);
				Image image = Image.getInstance("c:\\Nectar_Logo_191_71.jpg");
				table.addCell(image);
				table.addCell("NECTAR PROMETRIC EXAMINATION");
				document.add(table);
								
				sb.append("<FORM METHOD=POST NAME=form1>");
				sb.append("----------------------------------------------------------------------------------------------------------------------------------");
				sb.append("<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 width='100%'>"+"\n");
		
				sb.append("<TR><TD COLSPAN=3></TD></TR>");
				sb.append("<TR><TD COLSPAN=3 ALIGN=CENTER><B><U><H4>MARK SHEET</H4></U></B></TD></TR>");
				
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");
				//sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");
		
				sb.append("<TR><TD ALIGN=LEFT><B>Registration No.</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+Regkey+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=LEFT><B>Candidate Name</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+firstname+" "+lastname +"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Test Name</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+testname+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Centre</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+clientname+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Date</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+Utils.getFullDate(date)+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Time</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+fromtime +" to " +totime+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Your Score</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+percent+"%</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Passing Score</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>60 %</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Result</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+result+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD COLSPAN=3></TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("</TABLE>");
				sb.append("</FORM>");
				//sb.append("</TABLE>");
				sb.append("</BODY></HTML>");
				//sb.append("Nectar Prometric Examination");

				String pdfdoc = sb.toString();
				//System.out.println(" pdf document :"+pdfdoc);
		
				htmlWorker.setStyleSheet(GenerateStyleSheet());
				htmlWorker.parse(new StringReader(pdfdoc));
			  	document.close();
				out.println("<HTML><HEAD><TITLE>Mark Sheet</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER></BR></BR></BR></BR>");
				out.println("<div align='center'>");
				out.println("<h4>MarkSheet is generated suceesfully</h4>");
				out.println("<table border='0' cellspacing='1' cellpadding='1' "+
									"width='30%' ALIGN='CENTER'>");
				out.println("<tr><th colspan='2'>Candidate Details</th></tr>");
				out.println("<tr><td align='right'>Registration No </td>"+"<td>"+Regkey+"</td></tr>");
				out.println("<tr><td align='right'>Candidate Name  </td>"+"<td>"+firstname+" "+lastname +"</td></tr>");
				out.println("</table></BODY></HTML>");	
				
			}
			else
			{
//				doPost(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
				
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}
	}
	
	private static StyleSheet GenerateStyleSheet()
			{
				StyleSheet css = new StyleSheet();
				//System.out.println("clss :"+css.getClass());
			
				css.loadTagStyle("h1", "size", "30pt");
				css.loadTagStyle("h1", "style", "line-height:30pt;font-weight:bold;");
				css.loadTagStyle("h2", "size", "22pt");
				css.loadTagStyle("h2", "style", "line-height:30pt;font-weight:bold;margin-top:5pt;margin-bottom:12pt;");
				css.loadTagStyle("h3", "size", "15pt");
				css.loadTagStyle("h3", "style", "line-height:25pt;font-weight:bold;margin-top:1pt;margin-bottom:15pt;");
				css.loadTagStyle("h4", "size", "13pt");
				css.loadTagStyle("h4", "style", "line-height:23pt;margin-top:1pt;margin-bottom:15pt;");
				css.loadTagStyle("hr", "width", "100%");
				css.loadTagStyle("a", "style", "text-decoration:underline;");
				css.loadTagStyle(HtmlTags.HEADERCELL, HtmlTags.BORDERWIDTH, "0");
				//css.loadTagStyle(HtmlTags.HEADERCELL, HtmlTags.BORDERCOLOR, "#333");
				css.loadTagStyle(HtmlTags.HEADERCELL, HtmlTags.BACKGROUNDCOLOR, "#cccccc");
				css.loadTagStyle(HtmlTags.CELL, HtmlTags.BACKGROUNDCOLOR,"#EFEFEF");
				//css.loadStyle(HtmlTags.CELL, HtmlTags.FONT, "line-height:30pt;font-weight:bold;" );
				//css.loadTagStyle(HtmlTags.CELL, HtmlTags.BORDERWIDTH, "0.5");
				//css.loadTagStyle(HtmlTags.CELL, HtmlTags.BORDERCOLOR, "#333");*/
				return css;
			}


	
	public void destroy()
	{
	}
}
