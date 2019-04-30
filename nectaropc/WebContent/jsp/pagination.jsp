		<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
		<%@page import="com.ngs.EntityManagerHelper"%>
		<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
		<html>
		<head>
		<title>Nectar Examination</title>
		<link rel="stylesheet" href="../alm.css" type="text/css">
		<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
		</head>
		<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
		<%
		Logger log = Logger.getLogger("Pagination.jsp");
		int total_entries=0;
		Connection con=pool.getConnection();
		Statement st=con.createStatement();
		Statement st1=con.createStatement();
		ResultSet rs=st.executeQuery("SELECT count(*) from CandidateMaster");
		rs.next();
		int count=rs.getInt(1);
		total_entries =count;
		int page_number=0;
		int total_pages=0;
		int i;
		int entries_per_page = 20;
		if(request.getParameter("page_number")!=null)
		{
		page_number = Integer.parseInt(request.getParameter("page_number"));
		} else {
		page_number = 1;
		}
		total_pages = (total_entries / entries_per_page);
		int offset = (page_number - 1) * entries_per_page;
		String sql = "SELECT * FROM CandidateMaster ORDER BY CandidateID ASC LIMIT "+offset+","+entries_per_page;
		log.info("Sql :"+sql);
		ResultSet rs1=st1.executeQuery(sql);
		out.println("\n<BR></BR>");
		out.println("<h3 ALIGN='CENTER'>Candidates' Master List</h3>");
		out.println("<TABLE BORDER='1' CELLSPACING='1' CELLPADDING='1' ALIGN='CENTER' width='70%'>");
		out.println("<TR><TH COLSPAN=7>Summary of Candidates' Master List</TH></TR>");
		out.println("<TR><TH>Sr. No.</TH>"+"<TH>CandidateID</TH>"+"<TH>FirstName</TH>"+"<TH>LastName</TH>"+"<TH>Username</TH>"+"<TH>Password</TH></TR>");
		int rowcount=1;
		if(page_number>1)
		rowcount = offset+1;
		String strPassword="";
		while(rs1.next())
		{
		//try{
			strPassword = rs1.getString("password");
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
		out.println("<TD ALIGN='CENTER'>"+rowcount+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+rs1.getString("CandidateID")+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+rs1.getString("FirstName")+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+rs1.getString("LastName")+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+rs1.getString("Username")+"</TD>");
		out.println("<TD ALIGN='CENTER'>"+strPassword+"</TD>");
		out.println("</TR>");
		rowcount++;
		}
		out.println("<TR>");
		out.print("<TD ALIGN='CENTER' COLSPAN=7>");
		for(i = 1; i <= total_pages; i++)
		{ 
			
			
			if(i == page_number)
			{
			// This is the only page. so no link
			out.print("<B>"+"page:"+i);
			}
			else {%>
			<a href='pagination.jsp?page_number=<%=i%>'><%=i%></a>
			<%}
			
		}
		out.println("</B></TD>");
		out.println("</TR></TABLE>");
		%>
		</body>
		</html>
