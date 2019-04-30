		<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
		<%@page import="com.ngs.EntityManagerHelper"%>
		<%@page import="com.ngs.PaginationBean"%>
		<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
		<html>
		<head>
		<title>Nectar Examination</title>
		<link rel="stylesheet" href="alm.css" type="text/css">
		<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
		</head>
		<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
		<FORM METHOD="POST">
		<%
		Logger log = Logger.getLogger("Pagination.jsp");
		log.info("start");
		int rowcount=0;int total_pages;int pageNo;int pagesize=20;
		if(null==request.getParameter("page_number"))
		pageNo = 0;
		else
		pageNo = Integer.parseInt(request.getParameter("page_number"));
		log.info("pageNo :"+pageNo);
		CandidatemasterDAO objCandidatemasterDAO = new CandidatemasterDAO();
		EntityManager em = EntityManagerHelper.getEntityManager();
		Query query = em.createQuery("Select cm.candidateId,clm.clientName,cm.firstName,cm.lastName,cm.username,cm.password from Candidatemaster cm,Clientmaster clm where cm.clientId=clm.clientId");
		PaginationBean objPaginationBean = new PaginationBean();
		List<Object[]> obList = objPaginationBean.findAllByObjectWithPaging(pageNo,pagesize,query);
		//List<Candidatemaster> cmaList = objCandidatemasterDAO.findAllCandidatesWithPaging(pageNo,pagesize);
		List<Candidatemaster> allList = objCandidatemasterDAO.findAll();
		for(Candidatemaster cmList:allList)
		{ rowcount++;}
		log.info("rowcount :"+rowcount);
		
		out.println("\n</BR>");
		out.println("<h3 ALIGN='CENTER'>Candidates' Master List</h3>");
		
		out.println("<TABLE BORDER='1' CELLSPACING='1' CELLPADDING='1' ALIGN='CENTER' width='70%'>");
		out.println("<TR><TH COLSPAN=8>Summary of Candidates' Master List</TH></TR>");
		out.println("<TR><TH>Sr. No.</TH>"+"<TH>CandidateID</TH>"+"<TH>Centre Name</TH>"+"<TH>FirstName</TH>"+"<TH>LastName</TH>"+"<TH>Username</TH>"+"<TH>Password</TH></TR>");
		
		String strPassword="";int count=1;
		if(pageNo>1)
		count = (pagesize*(pageNo-1))+1;
		for(Object[] objList:obList)
		{
		//try{
			strPassword = (String) objList[5];
			if(strPassword.length()>15)
			{
			strPassword = Encrypter.decrypt(strPassword);
			//System.out.println("strPassword	1:"+strPassword);
			}
			else
			{
			//System.out.println("strPassword	2:"+strPassword);
			}
		//}catch(Exception e){}
		out.println("<TR>");
		//out.println("<TD ALIGN='RIGHT'>" +Count+ "&nbsp;</TD>");
		out.println("<TD ALIGN='CENTER'>"+count+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+(Integer) objList[0]+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+(String) objList[1]+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+(String) objList[2]+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+(String) objList[3]+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+(String) objList[4]+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+strPassword+"</TD>");
		out.println("</TR>");
		count++;
		}
		int rowend = 0;
		if(rowcount % pagesize >=1)
		rowend=1;
		log.info("rowend :"+rowend);
		out.println("<TR>");
		out.print("<TD ALIGN='CENTER' COLSPAN=8>");
		out.println("<select name='page_number' style='color:#2D7EE7'>");
		for(int i = 1; i <=(rowcount/pagesize)+rowend; i++)
		{ 
		    
			if(i == pageNo)
			{
			out.println("<B><option value='"+i+"' selected>"+i+"</option></B>");
			}
			else{
			out.println("<B><option value='"+i+"'>"+i+"</option></B>");
			}
			
		}
		out.println("</select>");
		//out.println("<FONT COLOR=red><B>page:"+pageNo+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B></FONT>");
		//out.println("</B>");
		out.println("<input type=submit value=\"Show Page\" name=\"submit\"></TD>");
		out.println("</TR></TABLE>");
		%>
		</FORM>
		</body>
		</html>
