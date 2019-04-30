<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		Query query=null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Connection con = pool.getConnection();
		
		if (action == null || action == "")
		{
					out.println("<HTML><HEAD><TITLE>Category Master</TITLE>");
					out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
					out.println("<BODY><CENTER>");
					
				try
				{
					response.setContentType("TEXT/HTML");
					out.println("<BR><BR><TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
					out.println("<TR><TH COLSPAN=3><B>Category Master</B></TH></TR>");
					out.println("<TR><TH>Sr. NO.</TH><TH>CategoryID</TH><TH>Category</TH></TR>");
					CategorymasterDAO cDAO = new CategorymasterDAO();
					List<Categorymaster> cList = cDAO.findAll();
					int count=1;
					for(Categorymaster c:cList)
					{
						out.println("<TR><TD align=center>" + (count++) + "</TD><TD align=center>" + c.getCategoryId() + "</TD><TD>" + " " + c.getCategory() + "</TD></TR>");
					}
					out.println("</TABLE>");
				}
					catch(Exception e)
					{
						out.println("Error  here : " + e.getMessage());
					}
					finally
					{
						EntityManagerHelper.closeEntityManager();
					}
			
								out.println("</BODY>");
								out.println("</HTML>");
							
		}
%>