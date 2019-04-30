<%@ page errorPage="errorpage.jsp" language="java" import="java.sql.*" session="true" %>
<%@page import="com.ngs.*"%>
<%@page import="com.ngs.entity.*,com.ngs.dao.*"%>
<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; 
 charset=Big5">
<TITLE>Demo Presentation</TITLE>

</HEAD>
<BODY align="center" bgcolor="#ffffcc">
	<% 
	    String username = "admin";//request.getParameter("username");
		String password = "nectar123";//request.getParameter("password");
		String demoaction = "demo";//request.getParameter("demoaction");
		int cid = 5;//Integer.parseInt(request.getParameter("candidateid"));
		//String action = request.getParameter("action");
		/*//System.out.println("check..... username :"+username);
		//System.out.println("check..... password :"+password);
		//System.out.println("checkdemoaction :"+demoaction);
		//System.out.println("check-------action :"+action);*/
		
		if (null == session) 
	 	{
	 	    response.sendRedirect("Login.jsp");
	        return;
	    		 
	 	}
	     else{%>
	    	 
	    	 <video width="740" height="420" controls>
			  <source src="Financial Literacy\Nectar-Progressv1.mp4" type="video/mp4">
			   Your browser does not support the video tag.
			</video>
	    	 
	    	
	     	  <% } 	%>
				
</BODY>
</HTML>