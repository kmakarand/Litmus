<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = req.getParameter("action");
		EntityManager em = EntityManagerHelper.getEntityManager();
		Query query = null;
		String sql="";
		int cid = Integer.parseInt(req.getParameter("CandidateID"));
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("exammanger.jsp");
		Connection con = pool.getConnection();
		
		out.println("<html><head><LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></head>");
		out.println("<body><center><p>");
		
		if (action == null || action == "")
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
				out.println("<p><hr size=1></p>");
				try
				{
					PrintWriter out = res.getWriter();
					out.println("<table border=0 cellspacing=1 cellpadding=1>");
					out.println("<tr><th colspan=13>ExamMaster</th></tr>");
				//<th>ConductedBy</th><th>Centre</th><th>Country</th><th>Frequency</th>
			//<th>StoreID</th>
					ExammasterDAO exmDAO = new ExammasterDAO();
					out.println("<tr><th>Exam</th><th>ExamMode</th><th>StartDate</th><th>EndDate</th><th>ShowResults</th><th>DisplayTests</th><th>Delete</th><th>TestDetails</th></tr>");
					List<Exammaster> exmList = exmDAO.findAll();
					for(Exammaster exm:exmList)
					{
						String StartDate = null;
						String EndDate = null;
						String StoreID = null;
		
						StartDate=getFormattedDate(exm.getStartDate());
						EndDate=getFormattedDate(exm.getEndDate());
						//StoreID=getStoreName(rs.getInt("StoreID"));
		
						out.println("<tr><td><a href='" +req.getRequestURI()+ "?action=Update&ExamID="+exm.getExamId()+"'>" +exm.getExam()+ "</a></td>");
						out.println("<td>" +exm.getExamMode()+ "</td>");
						out.println("<td>" +StartDate+"</td>");
						out.println("<td>" +EndDate+ "</td>");
						//out.println("<td>" +rs.getString("ConductedBy")+ "</td>");
						//out.println("<td>" +rs.getString("Centre")+ "</td>");
						//out.println("<td>" +rs.getString("Country")+ "</td>");
						//out.println("<td>" +rs.getString("Frequency")+ "</td>");
						if(exm.getShowResults()==1)
							out.println("<td>Yes</td>");
						else
							out.println("<td>No</td>");
		
						if(exm.getDisplayTests()==1)
							out.println("<td>Yes</td>");
						else
							out.println("<td>No</td>");
		
						//out.println("<td>" +StoreID+ "</td>");
						out.println("<td><a href='" +req.getRequestURI()+ "?action=Delete&ExamID="+exm.getExamId()+"'>Delete</a></td>");
						out.println("<td><a href='" +req.getRequestURI()+ "?action=TestDetails&ExamID="+exm.getExamId()+"'>TestDetails</a></td></tr>");
					}
					out.println("</table>");
				}
				catch(Exception e)
				{
					System.err.println("Connection Error");
				}
				finally
				{
					
				}
		}
		else if ( action.equalsIgnoreCase("doAdd") )
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
%>