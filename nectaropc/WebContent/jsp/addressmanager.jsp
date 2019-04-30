<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = req.getParameter("action");
		String sql="",firstname="",lastname="";
		int cid = 32;Query query=null;
		Candidatemaster cm = null;Locationmaster lm = null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		con = pool.getConnection();
		
		if (action == null || action == "")
		{
			res.setContentType("text/html");
			out.println("<HTML><HEAD><TITLE>Address Details</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<script language=javascript>");
			out.println("function checkVal(){");
			out.println("var a='document.form1.address';");
			out.println("var b='document.form1.pin';");
			out.println("var c='document.form1.phone';");
			out.println("var d='document.form1.fax';");
			out.println("if (!isnulls(a)){");
			out.println("	alert('Address Field cannot be Empty !!');");
			out.println("	eval(a).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if (!checkNumeric(eval(b),'Pincode is a Numeric Field')){");
			out.println("	eval(b).value='';");
			out.println("	eval(b).focus();");
			out.println("	return false;}");
			out.println("else if (!checkNumeric(eval(c),'Phone is a Numeric Field')){");
			out.println("	eval(c).value='';");
			out.println("	eval(c).focus();");
			out.println("	return false;}");
			out.println("else if (!checkNumeric(eval(d),'Fax is a Numeric Field')){");
			out.println("	eval(d).value='';");
			out.println("	eval(d).focus();");
			out.println("	return false;}");
			out.println("else");
			out.println("	document.form1.submit();");
			out.println("}");

			out.println("function checkNumeric(field,msg)");
			out.println("{");
			out.println("	var strString = field.value;");
			out.println("	var strValidChars = '0123456789.-;';");
			out.println("	var strChar;");
			out.println("	for (a = 0; a < strString.length ; a++)");
			out.println("	{");
			out.println("		strChar = strString.charAt(a);");
			out.println("		if (strValidChars.indexOf(strChar) == -1)");
			out.println("		{");
			out.println("			alert(msg);");
			out.println("			field.value='';");
			out.println("			field.focus();");
			out.println("			return false;");
			out.println("		}");
			out.println("	}");
			out.println("return true;");
			out.println("}");

			out.println("function isnulls(name)");
			out.println("{");
			out.println("	if (eval(name).value=='')");
			out.println("	{");
			out.println("		return false;");
			out.println("	}");
			out.println("	else");
			out.println("		return true;");
			out.println("}");
			out.println("</script>");

			query = em.createNamedQuery("AddressManager-Candidatemaster.sql1");
			query.setParameter(cid, cid);
			cm = (Candidatemaster)query.getSingleResult();
			firstname = cm.getFirstName();
			lastname = cm.getLastName();
			out.println("Additional Qualifiaction <HR SIZE=1>");
			out.println("<FORM METHOD=POST NAME=form1>");
			out.println("<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=2>Address details of "+ firstname +" " + lastname +"</TH></TR>");
			out.println("<TR><TD align=right>Type of Address :</TD><TD><SELECT NAME=typeofadd><OPTION VALUE=1>Home Address</OPTION><OPTION VALUE=0>Office Address</OPTION></SELECT></TD></TR>");

			out.println("<TR><TD align=right>Address :</TD><TD><TEXTAREA NAME=address COLS=30 ROWS=4></TEXTAREA></TD></TR>");
			out.println("<TR><TD align=right>Street :</TD><TD><INPUT TYPE=TEXT NAME=street></TD></TR>");

			out.println("<TR><TD align=right>City :</TD><TD><SELECT NAME=location>");
			query = em.createNamedQuery("AddressManager-Locationmaster.sql2");
			List<Locationmaster>lmList = query.getResultList();
			for(Locationmaster llm:lmList)
			{
				out.println("<OPTION VALUE="+llm.getLocationId()+">"+llm.getLocationName()+"</OPTION>");
			}
			out.println("</SELECT></TD></TR>");
			out.println("<TR><TD align=right>Pincode :</TD><TD><INPUT TYPE=TEXT NAME=pin></TD></TR>");
			out.println("<TR><TD align=right>Phone :</TD><TD><INPUT TYPE=TEXT NAME=phone></TD></TR>");
			out.println("<TR><TD align=right>Fax :</TD><TD><INPUT TYPE=TEXT NAME=fax></TD></TR>");

			out.println("<TH COLSPAN=2><INPUT TYPE=BUTTON VALUE=Submit onclick='return checkVal();'>&nbsp;<INPUT TYPE=RESET VALUE=Reset>&nbsp;<INPUT TYPE=BUTTON VALUE=Close onclick='javascript:history.back();'></TH>");
			out.println("</TABLE>");
			out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doAdd'><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+">");
			out.println("</FORM>");
		}
		else if (action.equals("doAdd"))
		{
			res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null;Query query=null;
		Addressdetails ad = null;
		AddressdetailsDAO adDAO = new AddressdetailsDAO();
		try
		{
			int typeofadd = Integer.parseInt(req.getParameter("typeofadd"));
			String address = req.getParameter("address");
			String street = null;
			street = req.getParameter("street");
			int locationid = Integer.parseInt(req.getParameter("location"));
			int pin=0,phone=0,fax=0;
			String tpin = req.getParameter("pin");
			String tphone = req.getParameter("phone");
			String tfax = req.getParameter("fax");
			int cid = Integer.parseInt(req.getParameter("cid"));
			
			LocationmasterDAO lmDAO = new LocationmasterDAO();
			Locationmaster lm = lmDAO.findById(locationid);
			query = em.createNamedQuery("AddressManager-AddressdetailsId.sql2");
			query.setParameter(cid, cid);
			query.setParameter(typeofadd, typeofadd);
			ad = (Addressdetails)query.getSingleResult();
			if (ad!=null)
			{
				out.println("This Address already exist");
				out.println("<BR><INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'>");
			}
			else
			{
				ad = new Addressdetails();
				Addressdetails adid = new Addressdetails();
				EntityManagerHelper.beginTransaction();
				ad.setCandidateId(cid);
				ad.setTypeOfAddress(typeofadd);
				ad.setAddress(address);
				ad.setCountryId(lm.getCountryId());
				ad.setStateId(lm.getStateId());
				ad.setPincode(tpin);
				ad.setPhone(tphone);
				ad.setFax(tfax);
				adDAO.save(ad);
				EntityManagerHelper.commit();
							
				if (ad!=null)
				{
					out.println("New Degree Succesfully Added !!");
					out.println("<BR><INPUT TYPE=BUTTON VALUE='Close Window' onclick='javascript: window.close();'>");
				}
			}
		}
			
%>