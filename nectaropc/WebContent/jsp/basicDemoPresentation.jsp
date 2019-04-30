<%@ page language="java" import="javax.persistence.*,com.ngs.entity.*,com.ngs.dao.*,com.ngs.security.*,com.ngs.gbl.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@ page import ="javax.sql.*" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<% response.setHeader("pragma","no-cache");//HTTP 1.1 
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.addDateHeader("Expires", -1); 
response.setDateHeader("max-age", 0); 
//response.setIntHeader ("Expires", -1); 
//prevents caching at the proxy server 
response.addHeader("cache-Control", "private"); %>
<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies. %>
 <jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<TITLE>Demo Presentation</TITLE>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store">
</HEAD>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
<script>
<%--window.location.hash="no-back-button";--%>
<%--window.location.hash="Again-No-back-button";//again because google chrome don't insert first hash into history--%>
<%--window.onhashchange=function(){window.location.hash="no-back-button";}--%>
</SCRIPT> 
<BODY align="center" bgcolor="#ffffcc"> 

	<% 
	    String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		//System.out.println("check..... username :"+username);
		//System.out.println("check..... password :"+password);
		
		String action = request.getParameter("action");
		int cid = Integer.parseInt(request.getParameter("candidateid"));
		String demoaction = "";//request.getParameter("demoaction");
		
		System.err.println("*** Requested By : " + request.getRequestURI() + " *** Action : " + action);
		
		if (null == session || action == null || action == "") 
	 	{
	 	    response.sendRedirect("Login.jsp");
	        return;
	    }
	    else 
		{
		    //System.out.println("candidateid :::::::"+cid);
			//ChapterdetailsDAO objChapterdetailsDAO = new ChapterdetailsDAO();
			//Chapterdetails objChapterdetails = objChapterdetailsDAO.findById(cid);
			// JDBC driver name and database URL
		    Connection dbConnection = null;
			PreparedStatement preparedStatement = null;
			PreparedStatement preparedStatement1 = null;
			int chaptercount=0;
			int ch1cnt=0,ch2cnt=0,ch3cnt=0,ch4cnt=0,ch5cnt=0,ch6cnt=0,ch7cnt=0,ch8cnt=0;
		    ServletContext context2 = getServletContext();
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
			dbConnection = pool.getConnection();
		    		  
	        String TableSQL = "select * from chapterdetails where candidateid=?";
			preparedStatement1 = dbConnection.prepareStatement(TableSQL);
			preparedStatement1.setInt(1,cid);
			ResultSet rs = preparedStatement1.executeQuery();
	    	if(rs.next())
	    	do
	    	{
	    		ch1cnt = rs.getInt("Ch1Count");
	    		ch2cnt = rs.getInt("Ch2Count");
	    		ch3cnt = rs.getInt("Ch3Count");
	    		ch4cnt = rs.getInt("Ch4Count");
	    		ch5cnt = rs.getInt("Ch5Count");
	    		ch6cnt = rs.getInt("Ch6Count");
	    		ch7cnt = rs.getInt("Ch7Count");
	    		ch8cnt = rs.getInt("Ch8Count");
	    		
	    	}while(rs.next());
			//int totchaptercount = objChapterdetails.getCh1count()+objChapterdetails.getCh2count()+objChapterdetails.getCh3count()+objChapterdetails.getCh4count()+objChapterdetails.getCh5count()+objChapterdetails.getCh6count()+objChapterdetails.getCh7count();
			//System.out.println("totchaptercount :::::::"+totchaptercount);
			int totchaptercount = ch1cnt + ch2cnt + ch3cnt + ch4cnt + ch5cnt + ch6cnt + ch7cnt + ch8cnt;      
			if(totchaptercount==0)
			{
				//System.out.println("totchaptercount############"+totchaptercount);
				//String resultMessage="Your attempt has been expired";
				//request.setAttribute("Message", resultMessage);
				//getServletContext().getRequestDispatcher("/jsp/Result.jsp").forward(request, response);
				response.sendRedirect("Result.jsp");
			}
			int basch1cnt=0,basch2cnt=0,basch3cnt=0,basch4cnt=0,basch5cnt=0,basch6cnt=0,basch7cnt=0,basch8cnt=0;
			int intch1cnt=0,intch2cnt=0,intch3cnt=0,intch4cnt=0,intch5cnt=0,intch6cnt=0,intch7cnt=0,intch8cnt=0;
			int advch1cnt=0,advch2cnt=0,advch3cnt=0,advch4cnt=0,advch5cnt=0,advch6cnt=0,advch7cnt=0,advch8cnt=0;	
		%>
		
		<CENTER>
		  <form name="f1" action="basicDemoPresentation.jsp" method=POST>
		    <table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
		      <tr>
		        <td align="center"><img src="simages/logoN1.jpg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		        <td align="center"><img src="simages/newlogo.jpg"></td>
		      </tr>
		      <tr>
		        <td align="center">&nbsp;</td>
		        <td align="center"> <br>
		          <table border="0" cellspacing="1" cellpadding="1" align="center">
		            <tr>
		              <th colspan="2">Module List</th>
		            </tr>
		            <% 
	            	
	            	if (action.equals("basic")) 
		            {%>
		            	<tr>
		            	<TD align=right>Choose Test or Module (Pending Attempt):</TD><TD><SELECT NAME="testormod">
		            	<OPTION VALUE="1lW1SyYq13jaczD5SAhQiJHPklQ7Ozw1u">Introduction to Financial Literacy (<%=ch1cnt%>)</OPTION>
		            	<OPTION VALUE="1nTS_kH2B4AmB0N5U6te0ICzA2Ae9JvQD">Setting of Financial Goals (<%=ch2cnt%>)</OPTION>
		            	<OPTION VALUE="1xgm-e64UE5x7ll1T93mCoRXCdIKMtaoO">Budgeting - Income v/s Expenditure (<%=ch3cnt%>)</OPTION>
		            	<OPTION VALUE="1JGTSTINol_jx3v6wtWrPx3irN1EyDoma">Budgeting - Prioritizing the Needs (<%=ch4cnt%>)</OPTION>
		            	<OPTION VALUE="15rOnofeL6isAwXiTJvK9qj2ln1iUvBBi">Intresting Concepts (<%=ch5cnt%>)</OPTION>
		            	<OPTION VALUE="1e1Kna6BqWwAMNCUYU2VAGvBW0BGySzLz">Basics of Investment (<%=ch6cnt%>)</OPTION>
		            	<OPTION VALUE="1lW1SyYq13jaczD5SAhQiJHPklQ7Ozw1u">Basics of Banking - Part1 (<%=ch7cnt%>)</OPTION>
		            	<OPTION VALUE="1oS_r7JQNOReVA_vi0TCIQqCcISHPuOQG">RBI(<%=ch8cnt%>)</OPTION>
		            	</SELECT></TD></tr> 
		            <%}	else if (action.equals("intermediate")) {%>
		            	<tr>
		            	<TD align=right>Choose Test or Module:</TD><TD><SELECT NAME="testormod">
		            	<OPTION VALUE="1xumt36KpvK5Eo4YUnXHxeaG9Wq-sUncV">Introduction to Financial Literacy</OPTION>
		            	<OPTION VALUE="1RJf31Ap3JJGhgVyyc_5dykRrH8NajjI7">Savings and Investment related Products</OPTION>
		            	<OPTION VALUE="1TaIgKtpSZ_ITA9uqbxWVftop8RxGq831">Basics of Taxation</OPTION>
		            	<OPTION VALUE="1bmhyqezCsnwT3fJDJWL442MKbDL2Zlxt">Basics of Insurance</OPTION>
		            	<OPTION VALUE="1KbdhXtXQzwIXpv_s3r6rQdgHS7WQcMov">Basics of Banking - Part II</OPTION>
		            	<OPTION VALUE="1EY3ppCGGMaEWP0GU2Xy_7cm1q_KnP1fv">Basics of Credit and Debit Cards</OPTION>
		            	<OPTION VALUE="1y9B2VFpFBVNZ9-_DVBckQ0MD19aYC4bx">Loan Products from Banks</OPTION>
		            	<OPTION VALUE="1HlgKrV7jfpBG7j3y67Uj9KeeuXgnqHPd">IRDA</OPTION>
		            	</SELECT></TD></tr> 
		            <%}
		            	else if (action.equals("advance")) {%>
		            <tr>
		            	<TD align=right>Choose Test or Module:</TD><TD><SELECT NAME="testormod">
		            	<OPTION VALUE="1-ey5pZE7AvNQ6gs49wqZ0QpxPAE5PMxG">Introduction to Financial Literacy</OPTION>
		            	<OPTION VALUE="12wmboj4fELkJyjqPV8_6ygpvSoiT2QIs">Importance of Financial Planning</OPTION>
		            	<OPTION VALUE="1tNVfWbExsOfvRRNIetpbQ4aSswqXBKV2">Savings v/s Investments</OPTION>
		            	<OPTION VALUE="1cszoHntSHW2cwnQERYrhHKt7jZjOA3Vg">Basics of Equity and Mutual Funds</OPTION>
		            	<OPTION VALUE="1iCd-Wlqt2fztr9JneHdnbwaIKCDSVZ5K">Risk v/s Return Perspective</OPTION>
		            	<OPTION VALUE="1uqIBzbxE9re7GHWVmUkISEFJV75c3FgQ">Basics of Currency and Exchange rate</OPTION>
		            	<OPTION VALUE="1Rb3i1chuPCNkev7oq9-J75qjtD9t_Xiu">Basics of Financial Markets</OPTION>
		            	<OPTION VALUE="1K17s25dnQ91JCRs7HtGclxT21ebmwff_">SEBI</OPTION>
		            	</SELECT></TD></tr> 
		            	<%}
		            	else if (action.equals("realestate")) {%>
		            	<tr>
		            	<TD align=right>Choose Test or Module:</TD><TD><SELECT NAME="testormod">
		            	<OPTION VALUE="Introduction-to-Real-Estate-Awareness-Program">Introduction to Real Estate Awareness Program</OPTION>
		            	</SELECT></TD></tr> 
		            	<%}%>
		           		 <tr>
			               <input type=hidden name=action value="basicAction">
			               <input type=hidden name=candidateid value="<%=cid%>">
			               <input type=hidden name=demoaction value="<%=action%>">
			               <input type=hidden name=username value="<%=username%>">
			               <input type=hidden name=password value="<%=password%>">
			               <th colspan="2" valign="top">
			                <input type=submit name="submit"><INPUT TYPE=Button VALUE='Back to Login Page' Onclick='history.back()'>
			              </th>
			            </tr>
			            </table>
			    		</form>
				    <% if (action.equals("basicAction"))
			       	{
			         System.err.println("*** Requested By : " + request.getRequestURI() + " *** demo Action : " + action);
			         String modulename = request.getParameter("testormod");
			         demoaction = request.getParameter("demoaction");
			         cid = Integer.parseInt(request.getParameter("candidateid"));
			         username = request.getParameter("username");
					 password = request.getParameter("password");
		
					 System.out.println("checkin..... username :"+username);
					 ////System.out.println("checkin..... password :"+password);
			         //////System.out.println("demoaction :"+demoaction);
			         if(!modulename.equals(""))
			         {%>
			            <jsp:forward page="DemoPresentation.jsp"> 
						<jsp:param name="username" value="<%=username%>"/> 
						<jsp:param name="password" value="<%=password%>"/> 
						<jsp:param name="candidateid" value="<%=cid%>"/> 
						</jsp:forward> 
			         	
			         <%}
			         }
			       }%>
		        </CENTER>
				</BODY>
				</HTML>
					
		