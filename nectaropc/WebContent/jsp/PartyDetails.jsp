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
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		ClientmasterDAO cmDAO = new ClientmasterDAO();
		ScheduleDAO scDAO = new ScheduleDAO();
		CandidatemasterDAO cndDAO = new CandidatemasterDAO();
		Logger log = Logger.getLogger("UserDetails.jsp");
		Connection con = pool.getConnection();
		EntityManager em = EntityManagerHelper.getEntityManager();
		
		String sql="";

		if (action == null || action == "")
		{
			out.println("<HTML><HEAD><TITLE>Party Details</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			
			try
			{
				out.println("<BR><BR><TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
				out.println("<TR><TH COLSPAN=16><B>Party Details</B></TH></TR>");
				out.println("<TR><TH>Sr. NO.</TH><TH>PartyID</TH><TH>Party</TH><TH>Contact</TH><TH>Address</TH>");
				out.println("<TH>Street</TH><TH>Area</TH><TH>City</TH><TH>Pincode</TH><TH>State</TH>");
				out.println("<TH>Country</TH><TH>Phone1</TH><TH>Phone2</TH><TH>Fax</TH><TH>Email</TH><TH>Url</TH></TR>");
				PartydetailsDAO pDAO = new PartydetailsDAO();
				List<Partydetails> pList = pDAO.findAll();
				int count=1;
				for(Partydetails p:pList)
				{
					out.println("<TR><TD align=center>" + count + "</TD><TD align=center>" + p.getPartyId() + "</TD><TD>" + " " + p.getParty() + "</TD>");
					out.println("<TD>" + p.getContact() + "</TD><TD>" + " " + p.getAddress() + "</TD>");
					out.println("<TD>" + p.getStreet() + "</TD><TD>" + " " + p.getArea() + "</TD>");
					out.println("<TD>" + p.getCity() + "</TD><TD>" + " " + p.getPincode() + "</TD>");
					out.println("<TD>" + p.getState() + "</TD><TD>" + " " + p.getCountry() + "</TD>");
					out.println("<TD>" + p.getPhone1() + "</TD><TD>" + " " + p.getPhone2() + "</TD>");
					out.println("<TD>" + p.getFax() + "</TD><TD>" + " " +p.getEmail() + "</TD>");
					out.println("<TD>" + p.getUrl() + "</TD></TR>");
				}
				out.println("</TABLE>");
			}
				catch(Exception e)
				{
					out.println("Error  here : " + e.getMessage());
				}
				finally
				{
					
				}
	
						out.println("</BODY>");
						out.println("</HTML>");
		}
			
		
		
%>