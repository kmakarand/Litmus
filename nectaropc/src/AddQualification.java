import java.io.*;
import java.sql.*;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.*;
import javax.servlet.http.*;

import com.ngs.EntityManagerHelper;
import com.ngs.dao.QualificationmasterDAO;
import com.ngs.dao.QualificationsdetailsDAO;
import com.ngs.entity.Qualificationmaster;
import com.ngs.entity.QualificationmasterId;
import com.ngs.entity.Qualificationsdetails;
import com.ngs.entity.QualificationsdetailsId;
import com.ngs.gbl.*;

@SuppressWarnings("serial")
public class AddQualification extends HttpServlet
{
	QualificationmasterDAO qmDAO = new QualificationmasterDAO();
	QualificationmasterId qm = new QualificationmasterId();
	EntityManager em = EntityManagerHelper.getEntityManager();
	QualificationsdetailsDAO qdDAO = new QualificationsdetailsDAO();
	
	@SuppressWarnings("unchecked")
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		Query query=null;
		int cid = Integer.parseInt(req.getParameter("CandidateID"));
		try
		{
			if (action == null || action == "")
			{
				res.setContentType("text/html");
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
			else
			{
				doPost(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
		}
	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		out.println("<HTML><HEAD><TITLE>Remark Manager</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		try
		{
			String action = req.getParameter("action");
			if (action.equalsIgnoreCase("doAdd"))
			{
				Add(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}

	@SuppressWarnings("unchecked")
	public void Add(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		Query query = null;
		try
		{
			int qid = Integer.parseInt(req.getParameter("qid"));
			String passyr = req.getParameter("passyr");
			String percent = req.getParameter("percent");
			String university = req.getParameter("university");
			int cid = Integer.parseInt(req.getParameter("cid"));

			query = em.createNamedQuery("AddQualification-Qualificationsdetails.sql2");
			query.setParameter(cid, cid);
			query.setParameter(qid, qid);
			List<QualificationsdetailsId> qdList = query.getResultList();
			if(qdList !=null)
			{
				out.println("This Qualification already exist");
				out.println("<BR><INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'>");
			}
			else
			{
			  EntityManagerHelper.beginTransaction(); 
			  QualificationsdetailsId qdid = new QualificationsdetailsId();
			  Qualificationsdetails qd = new Qualificationsdetails();
			  qdid.setCandidateId(cid);
			  qdid.setQualificationId(qid);
			  qdid.setYearOfPassing(passyr);
			  qdid.setPercent(percent);
			  qdid.setUniversity(university);
			  //qd.(qdid);
			  qdDAO.save(qd);
			  EntityManagerHelper.commit();
			  if (qdid !=null)
				{
					out.println("New Degree Succesfully Added !!");
					String schedulelink = "ScheduleTime?CandidateID="+cid;
					res.sendRedirect(schedulelink);
//					out.println("<BR><INPUT TYPE=BUTTON VALUE='Close Window' onclick='javascript: window.close();'>");
				}
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
		  EntityManagerHelper.closeEntityManager();
		}
	}
	public void destroy()
	{
	}
}
