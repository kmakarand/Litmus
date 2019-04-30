<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%!

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
	
	public synchronized void displayExistingExamMaster(HttpServletRequest req, HttpServletResponse res)
	{
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
	
	public String displayCountrySelect(String id) {
		try {

			Query query=null;
			String sql = "SELECT cm FROM Countrymaster cm";
			List<Countrymaster> cmList = query.getResultList();

			String val = "<select name=Country>";
			for(Countrymaster cm:cmList){
				String CountryCode=cm.getCountryCode();
				System.out.println("CountryCode :"+CountryCode);
				if(CountryCode.equals(id))
					val=val+"<option value='"+CountryCode+"' selected>"+cm.getName()+"</option>";
				else
					val=val+"<option value='"+CountryCode+"'>"+cm.getName()+"</option>";
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
			
		}
	}
	
	
%>

<%
		String action = request.getParameter("action");
		Query query=null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("addscheduleform.jsp");
		Connection con = pool.getConnection();
		
		out.println("<HTML><HEAD><TITLE>Registration Confirmation</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
	
	
		if (action == null || action == "")
		{
			displayExamMasterDataEntryForm(request, response);
			out.println("<p><hr size=1></p>");
			displayExistingExamMaster(request, response);
		}
		
		out.println("</CENTER></BODY>");
		out.println("</HTML>");
%>