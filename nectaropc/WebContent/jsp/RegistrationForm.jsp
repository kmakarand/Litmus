<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*,java.net.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="java.util.Date"%>
<%@page import="com.ngs.gbl.RegistrationKey"%>
<%@page import="com.ngs.sms.*"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		Query query=null;int cid = 0;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Connection con = pool.getConnection();Utils myUtils = new Utils();
		EntityManager em = EntityManagerHelper.getEntityManager();
		Logger log = Logger.getLogger("RegistrationForm.jsp");
		CandidatemasterDAO cmDAO = new CandidatemasterDAO();
		ClientmasterDAO clmDAO = new ClientmasterDAO();
		Vector vlocationid = new Vector();
		List<Object[]> objList=null;
		List<Locationmaster> lmList=null;
		String sql = null,errorstr="";
		int totLic=0,totReg=0,lid=0;
		
		out.println("<HTML><HEAD><TITLE>Registration Confirmation</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		
		
		try{
	if (action == null || action == ""){
		String ClientID = (String) session.getAttribute("ClientID");
		//FileAppender fileappender = new FileAppender(new PatternLayout(),"ztest.log");
		//log.addAppender(fileappender);
		log.info("Welcome to Registration Form 1:"+ClientID);
		ExpiryValidation ev = new ExpiryValidation();
		if(ev.LicenceValidation(ClientID))
		{
			out.println(ev.getMessage());
		}
		log.info("Welcome to Registration Form 2:"+ClientID);
		response.setContentType("text/html");
		out.println("<HTML><HEAD><TITLE>Registration Form</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
		out.println("<script language=javascript>");
		out.println("function checkVal(){");
		out.println("var a='document.form1.firstname';");
		out.println("var b='document.form1.homeadd';");
		out.println("var c='document.form1.homephone';");
		out.println("var d='document.form1.offpin';");
		out.println("var e='document.form1.homepin';");
		out.println("var f='document.form1.offfax';");
		out.println("var g='document.form1.homefax';");
		out.println("var h='document.form1.cell';");
		out.println("var i='document.form1.pager';");
		out.println("var j='document.form1.email';");
		out.println("var k='document.form1.lang';");
		out.println("var l='document.form1.homephone';");
		out.println("var m='document.form1.lastname';");
		out.println("var n='document.form1.offcityID';");
		out.println("var o='document.form1.homecityID';");
		out.println("var p='document.form1.offadd';");		
		//out.println("alert('Please select a offadd')");
		out.println("var birthdate =self.document.form1.bdate.options[self.document.form1.bdate.selectedIndex].value+self.document.form1.bmonth.options[self.document.form1.bmonth.selectedIndex].value+self.document.form1.byear.options[self.document.form1.byear.selectedIndex].value;");
        
		out.println("if (!isnulls(a)){");
		out.println("	alert('First Name Field cannot be Empty !!');");
		out.println("	eval(a).focus();");
		out.println("	return false;");
		out.println("}");
		out.println("else if (eval(a).value.length>20){");
		out.println("	alert('First Name cannot be more than 20 characters !!');");
		out.println("	eval(a).focus();");
		out.println("	return false;");
		out.println("}");
		out.println("else if (!isnulls(m)){");
		out.println("	alert('Last Name Field cannot be Empty !!');");
		out.println("	eval(m).focus();");
		out.println("	return false;");
		out.println("}");
///########## Mailing Validation #########////
		out.println("var mailadd =document.form1.mailadd[0].checked;");
		out.println("if (mailadd == true || mailadd == 'True'){");
		out.println("	if (!isnulls(b)){");
		out.println("		alert('Home Address Field cannot be Empty !!');");
		out.println("		eval(b).focus();");
		out.println("		return false;");
		out.println("	}");
		out.println("	else if (!isnulls(o)){");
		out.println("		alert('Home City Field cannot be Empty !!');");
		out.println("		eval(o).focus();");
		out.println("		return false;");
		out.println("	}");
		out.println("	else if (!isnulls(e)){");
		out.println("		alert('Home Pincode Field cannot be Empty !!');");
		out.println("		eval(e).focus();");
		out.println("		return false;");
		out.println("	}");
		out.println("}");
		out.println("else{");
		out.println("	if (!isnulls(p)){");
		out.println("		alert('Office Address Field cannot be Empty !!');");
		out.println("		eval(p).focus();");
		out.println("		return false;");
		out.println("	}");
		out.println("	else if (!isnulls(n)){");
		out.println("		alert('Office City Field cannot be Empty !!');");
		out.println("		eval(n).focus();");
		out.println("		return false;");
		out.println("	}");
		out.println("	else if (!isnulls(d)){");
		out.println("		alert('Office Pincode Field cannot be Empty !!');");
		out.println("		eval(d).focus();");
		out.println("		return false;");
		out.println("	}");
		out.println("}");
///########## Mailing Validation #########////

		out.println("if (!checkNumeric(eval(c),'Telephone is a Numeric Field')){");
		out.println("	eval(c).value='';");
		out.println("	eval(c).focus();");
		out.println("	return false;}");
		out.println("else if (!checkNumeric(eval(l),'Telephone is a Numeric Field')){");
		out.println("	eval(l).value='';");
		out.println("	eval(l).focus();");
		out.println("	return false;}");
		out.println("else if (eval(c).value.length>15){");
		out.println("	alert('Telephone Number cannot be more than 15 digits !!');");
		out.println("	eval(c).focus();");
		out.println("	return false;");
		out.println("}");
		out.println("else if (!checkNumeric(eval(d),'Pincode is a Numeric Field')){");
		out.println("	eval(d).value='';");
		out.println("	eval(d).focus();");
		out.println("	return false;}");
		out.println("else if (eval(d).value.length>6){");
		out.println("	alert('Pincode cannot be more than 6 digits !!');");
		out.println("	eval(d).focus();");
		out.println("	return false;");
		out.println("}");
		out.println("else if (!checkNumeric(eval(e),'Pincode is a Numeric Field')){");
		out.println("	eval(e).value='';");
		out.println("	eval(e).focus();");
		out.println("	return false;}");
		out.println("else if (eval(e).value.length>6){");
		out.println("	alert('Pincode cannot be more than 6 digits !!');");
		out.println("	eval(e).focus();");
		out.println("	return false;");
		out.println("}");
		out.println("else if (!checkNumeric(eval(f),'Fax is a Numeric Field')){");
		out.println("	eval(f).value='';");
		out.println("	eval(f).focus();");
		out.println("	return false;}");
		out.println("else if (!checkNumeric(eval(g),'Please enter 12 digits of Aadhaar number in correct format !!')){");
		out.println("	eval(g).value='';");
		out.println("	eval(g).focus();");
		out.println("	return false;}");
		//out.println("else if (eval(g).value.length!=12){");
		//out.println("	alert('Adhar Number should be 12 digits !!');");
		//out.println("	eval(g).focus();");
		//out.println("	return false;");
		//out.println("}");
		out.println("else if (!checkNumeric(eval(h),'Mobile is a Numeric Field')){");
		out.println("	eval(h).value='';");
		out.println("	eval(h).focus();");
		out.println("	return false;}");
		out.println("else if (eval(h).value.length!=10){");
		out.println("	alert('Mobile Number should be 10 digits !!');");
		out.println("	eval(h).focus();");
		out.println("	return false;");
		out.println("}");
		out.println("else if (!checkNumeric(eval(i),'Pager is a Numeric Field')){");
		out.println("	eval(i).value='';");
		out.println("	eval(i).focus();");
		out.println("	return false;}");
		out.println("else if (!checkNumeric(eval(k),'Experience is a Numeric Field')){");
		out.println("	eval(k).value='';");
		out.println("	eval(k).focus();");
		out.println("	return false;}");
		out.println("if (!isnulls(j)){");
		out.println("	alert('Email Field cannot be Empty !!');");
		out.println("	eval(j).focus();");
		out.println("	return false;");
		out.println("}");
		out.println("else if ( !checkDate(birthdate) ) ");
		out.println("	{");
		out.println("	self.document.form1.bmonth.focus();");
		out.println("	return false; }");
		out.println("else if (!checkEmail(eval(j))){");
		out.println("	eval(j).focus();");
		out.println("	return false;}");
		out.println("else");
		out.println("	document.form1.submit();");
		out.println("}");
		out.println("</script>");

		String firstname = (String) session.getAttribute("firstname");
		if (firstname==null){firstname="";}
		String lastname = (String) session.getAttribute("lastname");
		if (lastname==null){lastname="";}
		String offadd = (String) session.getAttribute("offadd");
		if (offadd==null){offadd="";}
		String homeadd = (String) session.getAttribute("homeadd");
		if (homeadd==null){homeadd="";}
		String homecityID = (String) session.getAttribute("homecityID");
		if (homecityID==null){homecityID="";}
		String offpin = (String) session.getAttribute("offpin");
		if (offpin==null){offpin="";}
		String homepin = (String) session.getAttribute("homepin");
		if (homepin==null){homepin="";}

		String offphone = (String) session.getAttribute("offphone");
		if (offphone==null){offphone="";}
		String homephone = (String) session.getAttribute("homephone");
		if (homephone==null){homephone="";}
		String offfax = (String) session.getAttribute("offfax");
		if (offfax==null){offfax="";}
		String homefax = (String) session.getAttribute("homefax");
		if (homefax==null){homefax="";}
		log.info("ADHAR 	:"+homefax);
		String cell = (String) session.getAttribute("cell");
		if (cell==null){cell="";}
		String pager = (String) session.getAttribute("pager");
		if (pager==null){pager="";}
		String email = (String) session.getAttribute("email");
		if (email==null){email="";}
		String lang = (String) session.getAttribute("lang");
		if (lang==null){lang="";}

		errorstr = (String) session.getAttribute("errorstr");
		if (errorstr==null){errorstr="";}
		else{out.println("warning : "+errorstr +" !!");}

		int clientid=0;

		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
//					clientid =1;
			response.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);

		out.println("<FORM METHOD=POST NAME=form1>");
		out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
		out.println("<TR><TH COLSPAN=5>REGISTRATION FORM FOR TRAINING PROGRAME</TH></TR><BR></BR>");
		out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>First Name :</TD><TD><INPUT TYPE=TEXT NAME=firstname VALUE="+firstname+"></TD><TD align=right><FONT COLOR=red>*</FONT>Last Name :</TD><TD><INPUT TYPE=TEXT NAME=lastname VALUE="+lastname+"></TD></TR>");
		out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Birth Date :</TD><TD><SELECT NAME=bdate>");
		for (int i=1;i<=31 ;i++ )
		{
			if (i<10)
			{
				out.println("<OPTION VALUE=0"+i+">"+i+"</OPTION>");
			}
			else
			out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
		}
		out.println("</SELECT>-<SELECT NAME=bmonth>");
		out.println("<OPTION VALUE=01>Jan</OPTION>");
		out.println("<OPTION VALUE=02>Feb</OPTION>");
		out.println("<OPTION VALUE=03>Mar</OPTION>");
		out.println("<OPTION VALUE=04>Apr</OPTION>");
		out.println("<OPTION VALUE=05>May</OPTION>");
		out.println("<OPTION VALUE=06>Jun</OPTION>");
		out.println("<OPTION VALUE=07>Jul</OPTION>");
		out.println("<OPTION VALUE=08>Aug</OPTION>");
		out.println("<OPTION VALUE=09>Sep</OPTION>");
		out.println("<OPTION VALUE=10>Oct</OPTION>");
		out.println("<OPTION VALUE=11>Nov</OPTION>");
		out.println("<OPTION VALUE=12>Dec</OPTION>");
		out.println("</SELECT>-<SELECT NAME=byear>");
		for (int i=1940;i<=1994 ;i++ )
		{
			out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
		}
		out.println("</SELECT></TD><TD align=right>Sex:</TD><TD><SELECT NAME=sex>");
		out.println("<OPTION VALUE=1>Male</OPTION><OPTION VALUE=0>Female</OPTION>");
		out.println("</SELECT></TD></TR>");

		out.println("<TR><TD align=right>Mailing Address :</TD><TD><input type='radio' name=mailadd value=0 CHECKED> Home Address Details </TD><TD align=center COLSPAN=2><input type='radio' name=mailadd value=1>Office Address Details </TD></TR>");

		out.println("<TR><TD align=right valign=top><FONT COLOR=red>*</FONT>Address :</TD><TD><TEXTAREA NAME=homeadd rows=3 cols=25>"+homeadd+"</TEXTAREA></TD><TD align=right valign=top>Address :</TD><TD><TEXTAREA NAME=offadd rows=3 cols=25>"+offadd+"</TEXTAREA></TD></TR>");

//				out.println("<TR><TD align=right>City :</TD><TD><INPUT TYPE=TEXT NAME=offcityID maxlength=20><FONT COLOR=red>*</FONT></TD><TD align=right>City :</TD><TD><INPUT TYPE=TEXT NAME=homecityID maxlength=20></TD></TR>");
		out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>City :</TD><TD><INPUT TYPE=TEXT NAME=homecityID maxlength=20></TD><TD align=right>City :</TD><TD><INPUT TYPE=TEXT NAME=offcityID maxlength=20></TD></TR>");

		out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>State :</TD><TD><SELECT NAME=homestateID>");
		sql = "SELECT clm.locationId FROM Clientmaster clm WHERE clm.clientId=?1";
		query = em.createQuery(sql);
		query.setParameter(1, clientid);
		int slid =0;
		slid = (Integer)query.getSingleResult();
		sql = "SELECT lm.countryId,lm.stateId FROM Locationmaster lm WHERE lm.locationId=?1";
		query = em.createQuery(sql);
		query.setParameter(1, slid);
		objList = query.getResultList();
		int ctid=0,stateid=0;
		for(Object[] obj:objList)
		{
			ctid = (Integer)obj[0];
			stateid = (Integer)obj[1];
		}
		String locationname ="";
		sql = "SELECT lm.locationName FROM Locationmaster lm WHERE lm.countryId=?1 AND lm.stateId=?2 AND lm.cityId=0 AND lm.areaId=0";
		query = em.createQuery(sql);
		query.setParameter(1, ctid);
		query.setParameter(2, stateid);
		locationname = (String)query.getSingleResult();
		//log.info("locationname:"+locationname);
		sql = "select distinct lm.countryId,lm.locationId,lm.stateId,lm.locationName FROM Locationmaster lm where lm.stateId > 0 GROUP BY lm.countryId,lm.locationId,lm.stateId,lm.locationName ORDER BY lm.locationName";
		query = em.createQuery(sql);
		objList = query.getResultList();
		for(Object[] obj:objList)
		{
			int countryid = (Integer)obj[0];
			lid = (Integer)obj[1];
			String lname = (String)obj[3];
			if (locationname.equals(lname))
			{
				out.println("<option value="+lid+" SELECTED>"+lname+"</option>");
			}
			else
				out.println("<option value="+lid+">"+lname+"</option>");
			
		}
		out.println("</SELECT></TD><TD align=right>State :</TD><TD><SELECT NAME=offstateID>");
		sql = "select distinct lm.countryId,lm.locationId,lm.stateId,lm.locationName FROM Locationmaster lm where lm.stateId > 0 GROUP BY lm.countryId,lm.locationId,lm.stateId,lm.locationName ORDER BY lm.locationName";
		query = em.createQuery(sql);
		objList = query.getResultList();
		for(Object[] obj:objList)
		{
			int countryid = (Integer)obj[0];
			lid = (Integer)obj[1];
			String lname = (String)obj[3];
			if (locationname.equals(lname))
			{
				out.println("<option value="+lid+" SELECTED>"+lname+"</option>");
			}
			else
				out.println("<option value="+lid+">"+lname+"</option>");
			
		}
		out.println("</SELECT></TD></TR>");

		out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Country :</TD><TD><SELECT NAME=homecountryID>");
		sql = "select distinct lm.countryId,lm.locationId,lm.locationName FROM Locationmaster lm where lm.stateId<=0 GROUP BY lm.countryId,lm.locationId,lm.locationName order by lm.locationName";
		query = em.createQuery(sql);
		objList = query.getResultList();
		for(Object[] obj:objList)
		{
			int countryid = (Integer)obj[0];
			lid = (Integer)obj[1];
			String locationName = (String)obj[2];
				if (countryid == 99)
				{
					out.println("<option value="+lid+" SELECTED>"+locationName+"</option>");
				}
				else
					out.println("<option value="+lid+">"+locationName+"</option>");
							
		}
		out.println("</SELECT></TD><TD align=right>Country :</TD><TD><SELECT NAME=offcountryID>");
		sql = "select distinct lm.countryId,lm.locationId,lm.locationName FROM Locationmaster lm where lm.stateId<=0 GROUP BY lm.countryId,lm.locationId,lm.locationName order by lm.locationName";
		query = em.createQuery(sql);
		objList = query.getResultList();
		for(Object[] obj:objList)
		{
			int countryid = (Integer)obj[0];
			lid = (Integer)obj[1];
			String locationName = (String)obj[2];
				if (countryid == 99)
				{
					out.println("<option value="+lid+" SELECTED>"+locationName+"</option>");
				}
				else
					out.println("<option value="+lid+">"+locationName+"</option>");
							
		}
		out.println("</SELECT></TD></TR>");

		out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Pincode :</TD><TD><INPUT TYPE=TEXT NAME=homepin VALUE="+homepin+"></TD><TD align=right>Pincode :</TD><TD><INPUT TYPE=TEXT NAME=offpin VALUE="+offpin+"></TD></TR>");

		out.println("<TR><TD align=right>Telephone :</TD><TD><INPUT TYPE=TEXT NAME=homephone VALUE="+homephone+"></TD><TD align=right>Telephone :</TD><TD><INPUT TYPE=TEXT NAME=offphone VALUE="+offphone+"></TD></TR>");

		out.println("<TR><TD align=right>AdharCard :</TD><TD><INPUT TYPE=TEXT NAME=homefax VALUE="+homefax+"></TD><TD align=right>Fax :</TD><TD><INPUT TYPE=TEXT NAME=offfax VALUE="+offfax+"></TD></TR>");

		out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Mobile :</TD><TD><INPUT TYPE=TEXT NAME=cell  VALUE="+cell+"></TD><TD align=right>Pager :</TD><TD><INPUT TYPE=TEXT NAME=pager VALUE="+pager+"></TD></TR>");

		out.println("<TD align=right><FONT COLOR=red>*</FONT>Email :</TD><TD><INPUT TYPE=TEXT NAME=email VALUE="+email+"></TD>");
		out.println("<TD align=right><FONT COLOR=red>*</FONT>Choose Language:</TD><TD><SELECT NAME=lang>");
		out.println("<OPTION VALUE=1>English</OPTION><OPTION VALUE=2>Marathi</OPTION>");
		out.println("</SELECT></TD></TR>");
		
		
		out.println("<TR><TD><FONT COLOR=red>*</FONT>Examination :</TD>");
	
		/* New Code Added for selection of Examination start here*/
		
		out.println("<TD><SELECT NAME=ExamID>");
						
		//String pql = "SELECT DISTINCT(ExamID),TestName FROM NewExamDetails ORDER BY ExamID";
		String pql = "SELECT DISTINCT nxd.examId,nxd.testName FROM Newexamdetails nxd where nxd.examId IN"+
					 " (SELECT s.examId FROM Schedule s WHERE s.clientId=?1 and s.scheduleDate >= CURRENT_DATE)";
		//log.info(pql);
		query = em.createQuery(pql);
		query.setParameter(1, clientid);
		objList = query.getResultList();
		String testName="";
		int iExamID = 0;
		for(Object[] obj:objList)
		{
			testName = (String)obj[1];
			iExamID = (Integer)obj[0];
			if(iExamID == 10531)
			{
				out.println("<OPTION VALUE="+iExamID+" SELECTED>"+testName+"</OPTION>");
			}
			else
				out.println("<OPTION VALUE="+iExamID+">"+testName+"</OPTION>");
		}
		
		
		out.println("</SELECT></TD><TD align=right>Choose Level:</TD><TD><SELECT NAME=LevelID>");
		out.println("<OPTION VALUE=1>Simple</OPTION><OPTION VALUE=2>Medium</OPTION>");
		out.println("<OPTION VALUE=3>Difficult</OPTION><OPTION VALUE=4>Mixed</OPTION>");
		out.println("</SELECT></TD>");
		out.println("</TR>");
		
		/* New Code Added for selection of Examination end here*/
			

		out.println("<TR><TH COLSPAN=4><FONT COLOR=red>*</FONT> Indicates compulsory Fields !!</TH></TR>");

		out.println("<TR><TH COLSPAN=4><INPUT TYPE=BUTTON VALUE=Submit onclick='return checkVal();'>&nbsp;<INPUT TYPE=RESET VALUE=Reset>&nbsp;<INPUT TYPE=BUTTON VALUE=Back onclick='javascript:history.back();'></TH><TR>");
		
		out.println("</TABLE>");
		out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doAdd'><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"><INPUT TYPE=HIDDEN NAME=ClientID VALUE="+clientid+">");
		out.println("</FORM>");
	}
	else if (action.equalsIgnoreCase("doAdd"))
	{
		//log.info("Start Add");
		try
		{
			int examid = Integer.parseInt(request.getParameter("ExamID"));
			//log.info("RegistrationForm:doADD ExamID:"+examid);
			int levelid = Integer.parseInt(request.getParameter("LevelID"));
			//log.info("RegistrationForm:doADD levelid:"+levelid);
			int clientid = Integer.parseInt(request.getParameter("ClientID"));
			//log.info("RegistrationForm:doADD clientid:"+clientid);
			int lang = Integer.parseInt(request.getParameter("lang"));
			//System.out.println("Language --------------"+lang);
			String firstname = request.getParameter("firstname");
			session.setAttribute("firstname",firstname);
			String lastname = request.getParameter("lastname");
			session.setAttribute("lastname",lastname);
			int bdate = Integer.parseInt(request.getParameter("bdate"));
			String dt = "",mt= "";
			if (bdate<10){dt = "0" + bdate;}
			int bmonth = Integer.parseInt(request.getParameter("bmonth"));
			if (bmonth<10){mt = "0" + bmonth;}
			int byear = Integer.parseInt(request.getParameter("byear"));
			int sex = Integer.parseInt(request.getParameter("sex"));
		
			String dob = "" + byear + "-" + mt + "-" + dt ;
		//out.println("DOB : " + dob);
		
		//out.println("ceid " + CentreID);
			int mailadd = Integer.parseInt(request.getParameter("mailadd"));
		out.println("mailadd : " + mailadd);
			String offadd = request.getParameter("offadd");
			session.setAttribute("offadd",offadd);
		//out.println("offadd "+offadd);
			String offcityID = request.getParameter("offcityID");
			int offstateID = Integer.parseInt(request.getParameter("offstateID"));
		//out.println("stateid "+offstateID);
			int offcountryID = Integer.parseInt(request.getParameter("offcountryID"));
		//out.println("count "+offcountryID);
			String offpin = request.getParameter("offpin");
			session.setAttribute("offpin",offpin);
			String offphone = request.getParameter("offphone");
			session.setAttribute("offphone",offphone);
			String offfax = request.getParameter("offfax");
			session.setAttribute("offfax",offfax);
		//out.println("off " + offfax);
			String homeadd = request.getParameter("homeadd");
			session.setAttribute("homeadd",homeadd);
			String homecityID = request.getParameter("homecityID");
			session.setAttribute("homecityID",homecityID);
			int homestateID = Integer.parseInt(request.getParameter("homestateID"));
			int homecountryID = Integer.parseInt(request.getParameter("homecountryID"));
		//out.println("homecountryid  " + homecountryID);
			String homepin = request.getParameter("homepin");
			session.setAttribute("homepin",homepin);
			String homephone = request.getParameter("homephone");
			session.setAttribute("homephone",homephone);
			String homefax = request.getParameter("homefax");
			session.setAttribute("homefax",homefax);
		out.println("Adhar " + homefax);
			String cell = request.getParameter("cell");
			////System.out.println("cellcellcellcell " + cell);
			session.setAttribute("cell",cell);
			String pager = request.getParameter("pager");
			session.setAttribute("pager",pager);
		//out.println("pager	 " + pager);
			String email = request.getParameter("email");
			session.setAttribute("email",email);
		//out.println("examil : " + email);
			/*int experience = 0;
			String exp = request.getParameter("experience");
			if (exp == null || exp == "" || exp.equals(null) || exp.equals("")){
				experience = 0;}
			else
				experience = Integer.parseInt(exp);
		//out.println("exp :" + experience+"<br>");
			exp = ""+ experience;
			session.setAttribute("experience",exp);*/
		
			String checkoffadd ="",checkhomeadd="";
			int LocationID = 0;
			boolean check = true;
		
		//			RegistrationKey regkey = new RegistrationKey (con,cid);
			String username = Utils.GenerateString(firstname,5,5);
			//log.info("Add username:"+username);
			sql = "SELECT cm.firstName from Candidatemaster cm WHERE cm.firstName=?1";
			query = em.createQuery(sql);
			query.setParameter(1, username);
			if (EntityManagerHelper.getSingleResult(query)!=null)
			{
				while (check==true)
				{   
					username = Utils.GenerateString(firstname,5,5);
				}
			}
			else
			{
				check=false;
			}
			check=true;
			String password = Utils.GenerateString(lastname,5,5);
			sql = "SELECT cm.lastName from Candidatemaster cm WHERE cm.lastName=?1";
			query = em.createQuery(sql);
			query.setParameter(1, password);
			
			if (EntityManagerHelper.getSingleResult(query)!=null)
			{
				while (check==true)
				{
					password = Utils.GenerateString(lastname,5,5);
				}
			}
			else
			{
				check=false;
			}
			
			//log.info("Original password: " + password);
			String encryptedPassword =  Encrypter.encrypt(password);
			password = encryptedPassword;
			//log.info("Encrypted password: " + encryptedPassword);
			String decryptedPassword =  Encrypter.decrypt(encryptedPassword);
			//log.info("Decrypted password: " + decryptedPassword);
			
			log.info("RegistrationForm:Add  before nvcanID:");
			NextValues nvcanID    =   new NextValues("CandidateMaster", "CandidateID");
		
			int genNextcandID    =    nvcanID.getWithSetNextValue();
			log.info("RegistrationForm:Add  genNextcandID:"+genNextcandID);
			
			EntityManagerHelper.beginTransaction();
			
			int homemail = 0,offmail=0;
				if (mailadd == 0){	homemail = 0; offmail=1;	}
				else
				{homemail =1;offmail=0;}
						Addressdetails homead = new Addressdetails();
						Addressdetails offad = new Addressdetails();
						AddressdetailsDAO adDAO = new AddressdetailsDAO();
						homead.setCandidateId(genNextcandID);
		  						homead.setTypeOfAddress(1);
		  						homead.setMailAddress(homemail);
		  						homead.setAddress(homeadd);
		  						homead.setCity(homecityID);
		  						homead.setStateId(homestateID);
		  						homead.setCountryId(homecountryID);
		  						homead.setPincode(homepin);
		  						homead.setPhone(homephone);
		  						homead.setFax(homefax);
		  						homead.setMobileNo(cell);
		  						adDAO.save(homead);
					
						Userdetails ud = new Userdetails();
						UserdetailsDAO udDAO = new UserdetailsDAO();
						ud.setCandidateId(genNextcandID);
						ud.setExamId(examid);
						ud.setLevelId(levelid);
						examid = ud.getExamId();
						if(examid==10533 || examid==10534 || examid==10535)
						{
							ud.setModuleCount(16);
							log.info("RegistrationForm:examid:"+examid);
							log.info("RegistrationForm:setModuleCount:"+ud.getModuleCount());
						}
						else
						{
						ud.setModuleCount(0);
						}
						ud.setLanguage(lang);
						udDAO.save(ud);
						
						ChapterdetailsDAO objChapterdetailsDAO = new ChapterdetailsDAO();
						Chapterdetails objChapterdetails = new Chapterdetails();
						objChapterdetails.setCandidateId(ud.getCandidateId());
						objChapterdetails.setCh1count(2);objChapterdetails.setCh2count(2);
						objChapterdetails.setCh3count(2);objChapterdetails.setCh4count(2);
						objChapterdetails.setCh5count(2);objChapterdetails.setCh6count(2);
						objChapterdetails.setCh7count(2);objChapterdetails.setCh8count(2);
						if(examid==10533)objChapterdetails.setModuleName("Basic");
						if(examid==10534)objChapterdetails.setModuleName("Intermediate");
						if(examid==10535)objChapterdetails.setModuleName("Advance");
						objChapterdetailsDAO.save(objChapterdetails);
						
		  						offad.setCandidateId(genNextcandID);
		  						offad.setTypeOfAddress(2);
		  						offad.setMailAddress(offmail);
		  						offad.setAddress(offadd);
		  						offad.setStateId(offstateID);
		  						offad.setCountryId(offcountryID);
		  						offad.setPincode(offpin);
		  						offad.setPhone(offphone);
		  						offad.setFax(offfax);
		  						offad.setMobileNo(pager);
		  						adDAO.save(offad);
						if (homead!=null & offad!=null)
						{
							Candidatemaster cm = new Candidatemaster();
							cmDAO = new CandidatemasterDAO();
							log.info("RegistrationForm:saving  Candidatemaster:"+genNextcandID);
							cm.setCandidateId(genNextcandID);
							cm.setScheduleId(0);
							cm.setTypeOfUser("0");
							cm.setIsTableCreated(0);
							cm.setStatus(1);
							cm.setCentreOfRegistration(0);
							cm.setUsername(username);
							cm.setPassword(password);
							cm.setFirstName(firstname);
							cm.setLastName(lastname);
							cm.setDateOfBirth(Utils.ConvertStrToDate(dob));
							cm.setSex(sex);
							cm.setClientId(clientid);
							cm.setEmail(email);
							//cm.setExperience(experience);
							Calendar today = Calendar.getInstance();
							Date mydate = new Date();
							mydate = today.getTime();
							cm.setDateOfRegistration(mydate);
							cmDAO.save(cm);
							
							if (cm!=null)
							{
								Candidatedetails  cd = new Candidatedetails();
								CandidatedetailsDAO cdDAO = new CandidatedetailsDAO();
								cd.setCandidateId(genNextcandID);
								cd.setExamId(examid);
								cdDAO.save(cd);
								
								Usergroupxref ugf = new Usergroupxref();
								UsergroupxrefDAO ugfDAO = new UsergroupxrefDAO();
								ugf.setGroupId("20");
								ugf.setUsername(username);
								ugfDAO.save(ugf);
								
								sql="SELECT DISTINCT nxd.sectionId,nxd.codeGroupId FROM Newexamdetails nxd WHERE nxd.examId=?1";
								query = em.createQuery(sql);
								query.setParameter(1, examid);
								out.println("<BR>.....1");
								out.println("<BR>.....2.1");
								objList = query.getResultList();
								for(Object[] obj:objList)
								{
									int tempsecid = (Integer)obj[0];
									int tempcgid = (Integer)obj[1];
									
									Newteststatusdetails nsd = new Newteststatusdetails();
									NewteststatusdetailsDAO nsdDAO = new NewteststatusdetailsDAO();
									nsd.setCandidateId(genNextcandID);
									nsd.setExamId(examid);
									nsd.setSectionId(tempsecid);
									nsd.setCodeGroupId(tempcgid);
									nsd.setTestMode(0);
									nsd.setStatus(0);
									nsd.setSequenceId(0);
									nsd.setAttemptNo(0);
									nsdDAO.save(nsd);
									
		
								}
								
								EntityManagerHelper.commit();
								out.println("</BODY></HTML>");
								session.removeAttribute("firstname");
								session.removeAttribute("lastname");
								session.removeAttribute("offadd");
								session.removeAttribute("offpin");
								session.removeAttribute("offphone");
								session.removeAttribute("offfax");
								session.removeAttribute("homeadd");
								session.removeAttribute("homepin");
								session.removeAttribute("homephone");
								session.removeAttribute("homefax");
								//session.removeAttribute("cell");
								session.removeAttribute("pager");
								
								//session.removeAttribute("email");
								session.removeAttribute("experience");
								session.removeAttribute("errorstr");
		
								String schedulelink = ""+request.getRequestURI()+"?action=doAddQualification&CandidateID="+genNextcandID+"&ExamID="+examid;
								response.sendRedirect(schedulelink);
							}
						}
		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			
		}

	}
	else if (action.equalsIgnoreCase("doAddQualification"))
	{
		try
		{
			//System.err.println("Inside Add qualification");
			int examid = Integer.parseInt(request.getParameter("ExamID"));
			//System.err.println("RegistrationForm:AddQualification ExamID:"+examid);
			cid = Integer.parseInt(request.getParameter("CandidateID"));
			boolean repeatcheck = false;
		//System.err.println(repeatcheck);
			String check = request.getParameter("MoreCheck");
		//out.println(check);
			if (check == null || check == "" || check.equals("") || check.equals(null) || check.equals("null"))
			{
				repeatcheck=true;
			}
		
			out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
			out.println("<script language=javascript>");
		
			out.println("function checkAction(str){");
			out.println("	if (checkVal() == true) {");
			out.println("		if (str == 'save'){");
			out.println("			document.form1.action='?action=doSaveQualification';");
			out.println("			document.form1.submit();");
			out.println("			return true;}");
			out.println("		else {");
			out.println("			document.form1.action='?action=doAddMoreQualification';");
			out.println("			document.form1.submit();");
			out.println("			return true;}");
			out.println("	}else{ return false;}}");
		
			out.println("function Next(){");
			out.println("			document.form1.action='?action=doPaymentDetails&CandidateID="+cid+"'");
			out.println("			document.form1.submit();");
			out.println("			return true;}");
		
			out.println("function checkVal(){");
			out.println("var x='document.form1.passyr';");
			out.println("var y='document.form1.percent';");
			out.println("var z='document.form1.university';");
			out.println("var a='document.form1.qualification';");
			out.println("if (!isnulls(a)){");
			out.println("	alert('Qualification Field cannot be Empty !!');");
			out.println("	eval(a).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if (!isnulls(x) || !checkNumeric(eval(x),'Year of Passing is a Numeric Field')){");
			out.println("	alert('Year of Degree Field cannot be Empty !!');");
			out.println("	eval(x).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if (eval(x).value<=1950 || eval(x).value>=2013){");
			out.println("	alert('Year of Degree cannot be less than 1950 or more than 2012');");
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
			out.println("	return true;");
			out.println("}");
		
		
			out.println("</script>");
		
			out.println("Additional Qualifiaction <HR SIZE=1>");
			out.println("<FORM METHOD=POST NAME=form1 action="+request.getRequestURI()+">");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=2>Enter your Qualification Details</TH></TR>");
			out.println("<TR><TD>Degree/Diploma</TD><TD><INPUT TYPE=TEXT NAME=qualification></TD></TR>");
			out.println("<TR><TD>Year of Passing</TD><TD><INPUT TYPE=TEXT NAME=passyr></TD></TR>");
			out.println("<TR><TD>Percent/Grade</TD><TD><INPUT TYPE=TEXT NAME=percent></TD></TR>");
			out.println("<TR><TD>University</TD><TD><INPUT TYPE=TEXT NAME=university></TD></TR>");
			out.println("<TR><TH COLSPAN=2><INPUT TYPE=Button onclick=\"return checkAction('MoreQualification');\" VALUE='Add More Qualification'>");
			if (repeatcheck == false)
			{
				out.println("<INPUT TYPE=BUTTON VALUE='Next' onclick=\"return Next();\">");
			}
			else
			{
				out.println("<INPUT TYPE=BUTTON VALUE='Save and Proceed' onclick=\"return checkAction('save');\">");
			}
			out.println("<INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"></TH></TR>");
			out.println("<INPUT TYPE=HIDDEN NAME=ExamID VALUE="+examid+"></TH></TR>");
			out.println("</TABLE>");
			out.println("</FORM>");
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
			
		}
	}
	else if (action.equalsIgnoreCase("doSaveQualification"))
	{
		try
		{
			int examid = Integer.parseInt(request.getParameter("ExamID"));
			//System.err.println("RegistrationForm:SaveQualification ExamID:"+examid);
			String qualification = request.getParameter("qualification");
		//out.println(qid);
			String passyr = request.getParameter("passyr");
		//out.println(passyr);
			String percent = request.getParameter("percent");
		//out.println(percent);
			String university = request.getParameter("university");
		//out.println(university);
			cid = Integer.parseInt(request.getParameter("cid"));
		//out.println(cid);
		
			QualificationsdetailsDAO qdDAO = new QualificationsdetailsDAO();
			Qualificationsdetails qd = new Qualificationsdetails();
			sql = "SELECT qd FROM Qualificationsdetails qd WHERE qd.candidateId=?1 and qd.qualification=?2";
			query = em.createQuery(sql);
			query.setParameter(1, cid);
			query.setParameter(2, qualification);
		//out.println(sql);
			if (EntityManagerHelper.getSingleResult(query)!=null)
			{
				out.println("This Qualification already exist");
				out.println("<BR><INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'>");
			}
			else
			{
				qd.setCandidateId(cid);
				qd.setQualification(qualification);
				qd.setYearOfPassing(passyr);
				qd.setPercent(percent);
				qd.setUniversity(university);				
		//out.println("sql");				
				if (qd!=null)
				{
					EntityManagerHelper.beginTransaction();
					qdDAO.save(qd);
					EntityManagerHelper.commit();
					out.println("New Degree Succesfully Added !!");
					String schedulelink = ""+request.getRequestURI()+"?action=doPaymentDetails&CandidateID="+cid+"&ExamID="+examid;
					response.sendRedirect(schedulelink);
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
			
		}

	}
	else if (action.equalsIgnoreCase("doAddMoreQualification"))
	{
		try
		{
		out.println("mo0re qual");
			int examid = Integer.parseInt(request.getParameter("ExamID"));
			//System.err.println("RegistrationForm:MoreQualification ExamID:"+examid);
			session.setAttribute("ExamID",String.valueOf(examid));
			String qualification = request.getParameter("qualification");
			String passyr = request.getParameter("passyr");
			String percent = request.getParameter("percent");
			String university = request.getParameter("university");
			cid = Integer.parseInt(request.getParameter("cid"));
		
			QualificationsdetailsDAO qdDAO = new QualificationsdetailsDAO();
			Qualificationsdetails qd = new Qualificationsdetails();
			sql = "SELECT qd FROM Qualificationsdetails qd WHERE qd.candidateId=?1 and qd.qualification=?2";
			query = em.createQuery(sql);
			query.setParameter(1, cid);
			query.setParameter(2, qualification);
		//out.println(sql);
			if (EntityManagerHelper.getSingleResult(query)!=null)
			{
				out.println("This Qualification already exist");
				out.println("<BR><INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'>");
			}
			else
			{
				qd.setCandidateId(cid);
				qd.setQualification(qualification);
				qd.setYearOfPassing(passyr);
				qd.setPercent(percent);
				qd.setUniversity(university);				
		//out.println("sql");				
				if (qd!=null)
				{
					EntityManagerHelper.beginTransaction();
					qdDAO.save(qd);
					EntityManagerHelper.commit();
					out.println("New Degree Succesfully Added !!");
					String schedulelink = ""+request.getRequestURI()+"?action=doAddQualification&CandidateID="+cid+"&MoreCheck=check"+"&ExamID="+examid;
					response.sendRedirect(schedulelink);
				}
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
	else if (action.equalsIgnoreCase("doPaymentDetails"))
	{
		int iexamid = Integer.parseInt(request.getParameter("ExamID"));
		int examid=0;
		//System.err.println("RegistrationForm:PaymentDetails ExamID:"+iexamid);
		cid = Integer.parseInt(request.getParameter("CandidateID"));
		int clientid = 0;
		String ClientID = (String) session.getAttribute("ClientID");
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
			response.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);
		try
		{
	
			response.setContentType("text/html");
			out.println("<HTML><HEAD><TITLE>Payment Details Form</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
			out.println("<script language=javascript>");
			out.println("function checkVal(){");
		//			out.println("var a='document.form1.amount';");
			out.println("var b='document.form1.ddno';");
			out.println("var c='document.form1.drawnbank';");
			out.println("var d='document.form1.branchname';");
			out.println("var paymode =self.document.form1.paymode.options[self.document.form1.paymode.selectedIndex].value;");
		
			out.println("if (paymode == \"Cheque\" || paymode == \"DDt\"){");
			out.println("	if (!isnulls(b)){");
			out.println("		alert('Cheque/DD No. Field cannot be Empty !!');");
			out.println("		eval(b).focus();");
			out.println("		return false;");
			out.println("	}");
			out.println("	else if (!isnulls(c)){");
			out.println("		alert('Drawn on Bank Field cannot be Empty !!');");
			out.println("		eval(c).focus();");
			out.println("		return false;");
			out.println("	}");
			out.println("	else if (!isnulls(d)){");
			out.println("		alert('Branch name Field cannot be Empty !!');");
			out.println("		eval(d).focus();");
			out.println("		return false;");
			out.println("	}");
			out.println("}");
		
		
			out.println("var chequedate =self.document.form1.dddate.options[self.document.form1.dddate.selectedIndex].value+self.document.form1.ddmonth.options[self.document.form1.ddmonth.selectedIndex].value+self.document.form1.ddyear.options[self.document.form1.ddyear.selectedIndex].value;");
		
		//			out.println("else if (!isnulls(b)){");
		//			out.println("	alert('Cheque/DD No. Field cannot be Empty !!');");
		//			out.println("	eval(b).focus();");
		//			out.println("	return false;");
		//			out.println("}");
			out.println("if (!checkNumeric(eval(b),'Cheque/DD No. is a Numeric Field')){");
			out.println("	eval(b).value='';");
			out.println("	eval(b).focus();");
			out.println("	return false;}");
			out.println("else if ( !checkDate(chequedate) ) ");
			out.println("	{");
			out.println("	self.document.form1.bmonth.focus();");
			out.println("	return false; }");
			out.println("else");
			out.println("	document.form1.submit();");
			out.println("}");
			out.println("</script>");
		
			String firstname = "" , lastname ="";
		
			sql = "SELECT cm.firstName,cm.lastName FROM Candidatemaster cm WHERE cm.candidateId=?1";
			query = em.createQuery(sql);
			query.setParameter(1, cid);
		//out.println(sql);
			objList = query.getResultList();
		  			for(Object[] obj:objList)
			{
				firstname = (String)obj[0];
				lastname = (String)obj[1];
			}
		
				sql = "SELECT cd.examId FROM Candidatedetails cd WHERE cd.candidateId=?1";
				query = em.createQuery(sql);
				query.setParameter(1, cid);
		//out.println(sql);
	  			examid = (Integer)query.getSingleResult();
				out.println("<FORM METHOD=POST NAME=form1 action="+request.getRequestURI()+">");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=2>Payment Details : " + firstname + " " +lastname+"</TH></TR>");
				out.println("<TR><TD align=right>Mode of Payment :</TD><TD><SELECT NAME=paymode>");
				out.println("<OPTION VALUE=Cash>Cash</OPTION><OPTION VALUE='DDt'>Demand Draft</OPTION></SELECT></TD></TR>");
		
				out.println("<TR><TD align=right>Amount :</TD><TD>Rs. &nbsp;&nbsp;&nbsp;600</TD></TR>");
		
				out.println("<TR><TD align=right>DD No. :</TD><TD><INPUT TYPE=TEXT NAME=ddno align=right></TD></TR>");
		
				out.println("<TR><TD align=right>DD Date :</TD><TD><SELECT NAME=dddate>");
				for (int i=1;i<=31 ;i++ )
				{
					if (i<10)
					{
						out.println("<OPTION VALUE=0"+i+">"+i+"</OPTION>");
					}
					else
					out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
				}
				out.println("</SELECT>-<SELECT NAME=ddmonth>");
				out.println("<OPTION VALUE=01>Jan</OPTION>");
				out.println("<OPTION VALUE=02>Feb</OPTION>");
				out.println("<OPTION VALUE=03>Mar</OPTION>");
				out.println("<OPTION VALUE=04>Apr</OPTION>");
				out.println("<OPTION VALUE=05>May</OPTION>");
				out.println("<OPTION VALUE=06>Jun</OPTION>");
				out.println("<OPTION VALUE=07>Jul</OPTION>");
				out.println("<OPTION VALUE=08>Aug</OPTION>");
				out.println("<OPTION VALUE=09>Sep</OPTION>");
				out.println("<OPTION VALUE=10>Oct</OPTION>");
				out.println("<OPTION VALUE=11>Nov</OPTION>");
				out.println("<OPTION VALUE=12>Dec</OPTION>");
				out.println("</SELECT>-<SELECT NAME=ddyear>");
				out.println("<OPTION VALUE=2012>2012</OPTION></SELECT></TD></TR>");
		
				out.println("<TR><TD align=right>Drawn on Bank :</TD><TD><INPUT TYPE=TEXT NAME=drawnbank></TD></TR>");
		
				out.println("<TR><TD align=right>Branch Name :</TD><TD><INPUT TYPE=TEXT NAME=branchname></TD></TR>");
		
				out.println("<TH COLSPAN=2><INPUT TYPE=BUTTON VALUE=Submit onclick='return checkVal();'>&nbsp;<INPUT TYPE=RESET VALUE=Reset></TH>");
				out.println("</TABLE>");
				out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doSavePaymentDetails'><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"><INPUT TYPE=HIDDEN NAME=ExamID VALUE="+iexamid+">");
				out.println("</FORM>");
		
				out.println("</BODY></HTML>");
		
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
			
		}

	}
	else if (action.equalsIgnoreCase("doSavePaymentDetails"))
	{
		try
		{
			cid = Integer.parseInt(request.getParameter("cid"));
		out.println("<br>cid : " + cid);
			int examid = Integer.parseInt(request.getParameter("ExamID"));
			//System.err.println("RegistrationForm:SavePaymentDetails ExamID:"+examid);
			session.setAttribute("ExamID",String.valueOf(examid));
			out.println("<br>examid : " + examid);
			String paymode = request.getParameter("paymode");
		out.println("<br>paymode : " + paymode);
		//			int amount = Integer.parseInt(request.getParameter("amount"));
		//out.println("<br>amount : " + amount);
			String currency = "Rs.";//request.getParameter("currency");
		out.println("<br>currency : " + currency);
			int ddno = 0;
			String ddnum = request.getParameter("ddno");
		
			if (ddnum == null || ddnum == "" || ddnum.equals("") || ddnum.equals(null)){
				ddno = 0;}
			else
				ddno = Integer.parseInt(ddnum);
		out.println("<br>ddno : " + ddno);
		
			int dddate = Integer.parseInt(request.getParameter("dddate"));
		out.println("<br>dt : " + dddate);
			String dt = "",mt= "";
			if (dddate<10){dt = "0" + dddate;}
			int ddmonth = Integer.parseInt(request.getParameter("ddmonth"));
		out.println("<br>mon : " + ddmonth);
			if (ddmonth<10){mt = "0" + ddmonth;}
			int ddyear = Integer.parseInt(request.getParameter("ddyear"));
		out.println("<br>year : " + ddyear);
			String chdate = "" + ddyear + "-" + mt + "-" + dt ;
		out.println("ch date : " + chdate);
		
			String drawnbank = request.getParameter("drawnbank");
		out.println("<br>bank : " + drawnbank);
			if (drawnbank == null || drawnbank == "")
			{
				drawnbank = "";
			}
			String branchname = request.getParameter("branchname");
		out.println("<br>bname : " + branchname);
			if (branchname == null || branchname == "")
			{
				branchname = "";
			}
		
			Paymentdetails pd = new Paymentdetails();
			PaymentdetailsDAO pdDAO = new PaymentdetailsDAO();
			pd.setExamId(examid);
			pd.setCandidateId(cid);
			pd.setAmount(600.00f);
			pd.setCurrency(currency);
			pd.setDate(Utils.ConvertStrToDate(chdate));
			pd.setModeOfPayment(paymode);
			pd.setBank(drawnbank);
			pd.setBranch(branchname);
			pd.setChequeNo("ddno");
					
		//out.println(sql);
			EntityManagerHelper.beginTransaction();
			pdDAO.save(pd);
			EntityManagerHelper.commit();
			if (pd!=null)
			{
				out.println("Payments Details Added Sucessfully !!");
				//System.err.println("Payments Details Added Sucessfully !!");
				String schedulelink = ""+request.getRequestURI()+"?action=doScheduleTime&CandidateID="+cid+"&ExamID="+examid;
				response.sendRedirect(schedulelink);
			}
			else
			//System.err.println("Payment Updation Problem !! before");
			out.println("Payment Updation Problem !!");
			//System.err.println("Payment Updation Problem !! after");
		
		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			
		}
	}
	else if (action.equalsIgnoreCase("doScheduleTime"))
	{
		int clientid = 0,examid=0;
		String ClientID = (String) session.getAttribute("ClientID");
		System.err.println("ScheduleTime 1:ClientID"+ClientID);
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
			response.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);
		
		String CandidateID = request.getParameter("CandidateID");
		int ExamID = Integer.parseInt(request.getParameter("ExamID"));
		System.err.println("RegistrationForm:ScheduleTime ExamID:"+ExamID);
		if (CandidateID == null || CandidateID.equals("") || CandidateID.equals(null) || CandidateID=="")
		{
			//cid = 1;
			response.sendRedirect("../jsp/Login.jsp");
		}
		else
			cid = Integer.parseInt(CandidateID);
			System.err.println("ScheduleTime 2:cid"+cid);
		try
		{
			
				out.println("<HTML><HEAD><TITLE>Exam Time</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				sql = "SELECT s FROM Schedule s WHERE s.clientId=?1 and s.examId=?2 and s.scheduleDate >= CURRENT_DATE " +
					  " ORDER BY s.scheduleDate,s.timeFrom,s.timeTo";
		//System.out.println("schedule query :"+sql);
				query = em.createQuery(sql);
				query.setParameter(1, clientid);
				query.setParameter(2, ExamID);
				List<Schedule> scList = query.getResultList();
				
		  				//System.err.println("ScheduleTime request.getRequestURI()"+request.getRequestURI());
				out.println("<FORM METHOD=POST NAME=form1 action="+request.getRequestURI()+">");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=2>Select Exam Date and Time </TH></TR>");
				out.println("<TR><TD>Select</TD><TD><SELECT NAME=scheduleid>");
		
		//				String timefrom
				for(Schedule sc: scList)
				{
					String timefrom = sc.getTimeFrom();
					//System.err.println("ScheduleTime 3:timefrom"+timefrom);
					timefrom = timefrom.substring(0,5);
					//System.err.println("ScheduleTime 4:timefrom"+timefrom);
					String timeto = sc.getTimeTo();
					//System.err.println("ScheduleTime 5:timeto"+timeto);
					timeto = timeto.substring(0,5);
					//System.err.println("ScheduleTime 6:timeto"+timeto);
					String date = Utils.ConvertDateToString(sc.getScheduleDate());
					//System.err.println("ScheduleTime 7:date"+date);
					Utils myUtil = new Utils();
					date = myUtil.getDate(date);
					//System.err.println("ScheduleTime 8:date"+date);
		//					Date date = rs.getDate("ScheduleDate");
		//out.println("Date : " + date);
		//					String scdate = dt.format(date);
		//out.println(scdate);
					out.println("<OPTION VALUE="+sc.getScheduleId()+">"+date+"  "+ timefrom +"-"+timeto+"</OPTION>");
				}
				out.println("</SELECT></TD></TR>");
				out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Details><INPUT TYPE=HIDDEN NAME=action Value=doAddScheduleTime><INPUT TYPE=HIDDEN NAME=examid Value="+examid+"><INPUT TYPE=HIDDEN NAME=ClientID Value="+clientid+"><INPUT TYPE=HIDDEN NAME=cid Value="+cid+"></TH></TR>");
				out.println("</TABLE>");
		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			
		}
	}
	else if (action.equalsIgnoreCase("doAddScheduleTime"))
	{
		
		////System.out.println("AddScheduleTime1");
		try
		{
			cid = Integer.parseInt(request.getParameter("cid"));
			int clientid = Integer.parseInt(request.getParameter("ClientID"));
			int examid = Integer.parseInt(request.getParameter("examid"));
			int scheduleid = Integer.parseInt(request.getParameter("scheduleid"));
			int totalseats = 0,seatsreserved =0;
			String shdate = "";
			////System.out.println("AddScheduleTime2");
			sql = "SELECT s FROM Schedule s WHERE s.scheduleId=?1";
			query = em.createQuery(sql);
			query.setParameter(1, scheduleid);
			List<Schedule> scList = query.getResultList();
		//out.println(sql);
			for(Schedule s:scList)
			{
				shdate = Utils.ConvertDateToString(s.getScheduleDate());
			}
		
			sql = "SELECT cm.availableSeats FROM Clientmaster cm WHERE cm.clientId=?1";
			query = em.createQuery(sql);
			query.setParameter(1, clientid);
		//out.println(sql+clientid);
			totalseats = (Integer)query.getSingleResult();
			
			sql = "SELECT count(s) FROM Slotregisteration s WHERE s.scheduleId=?1";
			query = em.createQuery(sql);
			query.setParameter(1, scheduleid);
		//out.println(sql+scheduleid);
			Number nsseatsreserved = (Number)query.getSingleResult();
			seatsreserved = nsseatsreserved.intValue();
			//out.println("seatsreserved"+seatsreserved);
			//out.println("totalseats"+totalseats);
			if (seatsreserved < totalseats)
			{
				cmDAO = new CandidatemasterDAO();
				Candidatemaster cm = cmDAO.findById(cid);
				cm.setScheduleId(scheduleid);
				EntityManagerHelper.beginTransaction();
				cmDAO.update(cm);
				if (cm!=null)
				{
					sql = "SELECT sr FROM Slotregisteration sr WHERE sr.scheduleId=?1 and sr.candidateId=?2";
					query = em.createQuery(sql);
					query.setParameter(1, scheduleid);
					query.setParameter(2, cid);
					
					if (EntityManagerHelper.getSingleResult(query)==null)
					{
						Slotregisteration sr = new Slotregisteration();
						SlotregisterationDAO srDAO = new SlotregisterationDAO();
						sr.setCandidateId(cid);
						sr.setScheduleId(scheduleid);
						sr.setAttended(0);
						srDAO.save(sr);
		//out.println(sql);
						if (sr!=null)
						{
							cmDAO = new CandidatemasterDAO();
							cm = cmDAO.findById(cid);
							cm.setScheduleId(scheduleid);
							cmDAO.update(cm);
							EntityManagerHelper.commit();
							if (cm!=null)
							{
								sql = "SELECT cm from Candidatemaster cm WHERE cm.candidateId=?1";
								query = em.createQuery(sql);
								query.setParameter(1, cid);
								List<Candidatemaster> cmList = query.getResultList();
								String firstname="",lastname="",recipient="",username="",password="";String cell="";
								String emailhost = "";String smshost="";
							    String emailport = "";String smsport="";
							    String emailuser = "";String smsuser="";
							    String emailpass = "";String smspass="";
							    String welcomesubject="";String smssubject="";
							    Encrypter objEncrypter = new Encrypter();
		//out.println(sql);
								out.println("<BR><TABLE BORDER=0>");
								out.println("<TR><TH>Reg. No.</TH><TH>First Name</TH><TH>Last Name</TH><TH>Username Name</TH></TR>");
								for(Candidatemaster cm1:cmList)
								{
									RegistrationKey regkey = new RegistrationKey (cid);
									String tpkey = regkey.KeyCode();
									firstname = cm1.getFirstName();
									lastname = cm1.getLastName();
									recipient = cm1.getEmail();
									username = cm1.getUsername();
									password = objEncrypter.decrypt(cm1.getPassword());
									////System.out.println(firstname +" "+lastname+" "+" Sucessfully Registered here !!!!@@");
									out.println("<TR><TD>" + regkey.getKeyCode() +  "</TD><TD>" + firstname + "</TD><TD>" + lastname + "</TD><TD>" + cm.getUsername() + "</TD></TR>");
								}
								out.println("</TABLE>");
								 
								emailhost = (String) session.getAttribute("email.host");
								emailport = (String) session.getAttribute("email.port");
								emailuser = (String) session.getAttribute("email.user");
								emailpass = (String) session.getAttribute("email.pass");
								welcomesubject = (String) session.getAttribute("email.welcome.subject");
								
								smshost = (String) session.getAttribute("sms.host");
								smsport = (String) session.getAttribute("sms.port");
								smsuser = (String) session.getAttribute("sms.user");
								smspass = (String) session.getAttribute("sms.pass");
								smssubject = (String) session.getAttribute("sms.subject");
								cell = (String) session.getAttribute("cell");
								////System.out.println("cellcellcellcell 2:" + cell);
								
								/*
								//System.out.println("firstname 2:" + firstname);
								//System.out.println("lastname 2:" + lastname);
								//System.out.println("username 2:" + username);
								//System.out.println("password 2:" + password);
								//System.out.println("cellcellcellcell 2:" + cell);
								//System.out.println("emailhost 2:" + emailhost);
								//System.out.println("emailport 2:" + emailport);
								//System.out.println("emailuser 2:" + emailuser);
								//System.out.println("emailpass 2:" + emailpass);
								//System.out.println("welcomesubject 2:" + welcomesubject);
								//System.out.println("recipient 2:" + recipient);*/
													
								
								////System.out.println("before sendmail start"+emailhost+emailport+emailuser+emailpass+welcomesubject);
								boolean mailFlag = Utils.sendEmail(firstname,lastname,username,password,recipient,emailhost,emailport,emailuser,emailpass,welcomesubject);
								int count =0;
								if(mailFlag && count==0)
								{
									////System.out.println("inside sendmail start");
									out.println("<BR><BR/><B>"+firstname +" "+lastname+" "+"</B> Sucessfully Registered here !!");
									//if(Utils.sendSMS(firstname,lastname,username,password,smshost,smsuser,smspass,smssubject,cell))
									String smsmsg="Congrats! You have successfully registered with NGEPL.\n"+"UserName:"+username+"\n"+"Password:"+password;
									String mobile=URLEncoder.encode(cell, "UTF-8");
						    		String msg=URLEncoder.encode(smsmsg,"UTF-8");
						    		//String SMSApi1 = "https://site2sms.p.mashape.com/index.php?uid=9881864520&pwd=fire76bird&phone="+mobile+"&msg="+msg;
							    	//String url1 = "https://freesms8.p.mashape.com/index.php?msg="+msg+"&phone="+mobile+"&pwd=7110&uid=9881864520";
							        String response1 = SmsUtility.sendSms(msg, mobile);
							        out.println("<BR><BR/><B>"+firstname +" "+lastname+" "+"</B> Sucessfully SMS Sent !!");
							        //System.out.println("sendsms response:"+response1);
							        count++;
								    
								}
								else{
									count++;
									 ////System.out.println("bfore logon sendmail start");
									 response.sendRedirect("../jsp/Login.jsp");
								}
							}
						}
					}
					else
						out.println("Schedule Registration Problem !!");
				}
				
			}
			else
			{
				out.println("All Seats for this Schedule has been booked !! <BR><BR>Please Select another slot for your Test.");
				out.println("<INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'>");
			}
		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
		
		}
		//out.println("start Candidate Sucessfully Registered here !!");
	}
		}
		catch(Exception e)
		{
	out.println("Error : " + e.getMessage());

		}
		finally
		{
	
		}
%>
		