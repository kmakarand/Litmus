<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		Query query=null;int cid = 0;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Connection con = pool.getConnection();Utils myUtils = new Utils();
		EntityManager em = EntityManagerHelper.getEntityManager();
		cid = Integer.parseInt(request.getParameter("CandidateID"));
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("addscheduleform.jsp");
				
		if (action == null || action == "")
		{
			response.setContentType("text/html");
			out.println("<HTML><HEAD><TITLE>Registration Form</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
			out.println("<script language=javascript>");
			out.println("function checkVal(){");
			out.println("var x='document.form1.passyr';");
			out.println("var y='document.form1.percent';");
			out.println("var z='document.form1.university';");
			out.println("if (!isnulls(x) || !checkNumeric(eval(x),'Year of Passing is a Numeric Field')){");
			out.println("	alert('Year of Degree Field cannot be Empty !!');");
			out.println("	eval(x).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if (eval(x).value<=1950 || eval(x).value>=2002){");
			out.println("	alert('Year of Degree cannot be less than 1950 or more than 2001');");
			out.println("	eval(x).value='';");
			out.println("	eval(x).focus();");
			out.println("	return false;}");
			out.println("else if (!isnulls(y)){");
			out.println("	alert('Percentage/Grade field cannot be Empty');");
			out.println("	eval(y).focus();");
			out.println("	return false;}");
			out.println("else if (!isnulls(z)){");
			out.println("	alert('University field cannot be Empty');");
			out.println("	eval(z).focus();");
			out.println("	return false;}");
			out.println("else");
			out.println("document.form1.submit();");
			out.println("}");
			out.println("</script>");

			out.println("Additional Qualifiaction <HR SIZE=1>");
			out.println("<FORM METHOD=POST NAME=form1>");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=2>Enter your Qualification Details</TH></TR>");
			out.println("<TR><TD>Degree/Diploma</TD><TD><SELECT NAME=qid>");

			query = em.createNamedQuery("AddQualification-QualificationmasterId.sql1");
			List<QualificationmasterId> qmList = query.getResultList();
			for (QualificationmasterId qmid:qmList)
			{
				out.println("<OPTION VALUE='"+qmid.getQualificationId()+"'>'"+qmid.getQualification()+"'</OPTION>");
			}
			out.println("</OPTION></TD></TR>");
			out.println("<TR><TD>Year of Passing</TD><TD><INPUT TYPE=TEXT NAME=passyr></TD></TR>");
			out.println("<TR><TD>Percent/Grade</TD><TD><INPUT TYPE=TEXT NAME=percent></TD></TR>");
			out.println("<TR><TD>University</TD><TD><INPUT TYPE=TEXT NAME=university></TD></TR>");
			out.println("<TH COLSPAN=2><INPUT TYPE=BUTTON VALUE=Submit onclick='return checkVal();'></TH>");
			out.println("</TABLE>");
			out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doAdd'><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+">");
			out.println("</FORM>");
		}
		else if (action.equals("doAdd"))
		{
			int qid = Integer.parseInt(request.getParameter("qid"));
			String passyr = request.getParameter("passyr");
			String percent = request.getParameter("percent");
			String university = request.getParameter("university");
			cid = Integer.parseInt(request.getParameter("cid"));

			query = em.createNamedQuery("AddQualification-Qualificationsdetails.sql2");
			query.setParameter(cid, cid);
			query.setParameter(qid, qid);
			List<Qualificationsdetails> qdList = query.getResultList();
			if(qdList !=null)
			{
				out.println("This Qualification already exist");
				out.println("<BR><INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'>");
			}
			else
			{
			  EntityManagerHelper.beginTransaction(); 
			  Qualificationsdetails qdid = new Qualificationsdetails();
			  QualificationsdetailsDAO qdDAO = new QualificationsdetailsDAO();
			  qdid.setCandidateId(cid);
			  qdid.setQualificationId(qid);
			  qdid.setYearOfPassing(passyr);
			  qdid.setPercent(percent);
			  qdid.setUniversity(university);
			  qdDAO.save(qdid);
			  EntityManagerHelper.commit();
			  if (qdid !=null)
				{
					out.println("New Degree Succesfully Added !!");
					String schedulelink = "ScheduleTime?CandidateID="+cid;
					response.sendRedirect(schedulelink);
//					out.println("<BR><INPUT TYPE=BUTTON VALUE='Close Window' onclick='javascript: window.close();'>");
				}
			}
		}
			
%>