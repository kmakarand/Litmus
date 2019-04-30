<%@ page errorPage="errorpage.jsp" language="java" import="java.sql.*" session="true" %>
<%@page import="com.ngs.*"%>
<%@page import="com.ngs.entity.*,com.ngs.dao.*"%>
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
<script>
window.location.hash="no-back-button";
window.location.hash="Again-No-back-button";//again because google chrome don't insert first hash into history
window.onhashchange=function(){window.location.hash="no-back-button";}
</script>
</HEAD>
<BODY align="center" bgcolor="#ffffcc">
	<%
		Connection dbConnection = null;
		PreparedStatement preparedStatement = null;
		PreparedStatement preparedStatement1 = null;
		int chaptercount=0;
		int ch1cnt=0,ch2cnt=0,ch3cnt=0,ch4cnt=0,ch5cnt=0,ch6cnt=0,ch7cnt=0;
			    ServletContext context2 = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		dbConnection = pool.getConnection();
		dbConnection.setAutoCommit(false);
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String modulename = request.getParameter("testormod");
		String demoaction = request.getParameter("demoaction");
		int cid = Integer.parseInt(request.getParameter("candidateid"));
		String action = request.getParameter("action");
		String moduleurl="https://drive.google.com/file/d/"+modulename+"/preview";
		//System.out.println("check..... username :"+username);
		//System.out.println("check..... password :"+password);
		//System.out.println("checkdemoaction :"+demoaction);
		//System.out.println("check-------action :"+action);
		
		if (null == session) 
			 	{
			 	    response.sendRedirect("Login.jsp");
			        return;
			    }
		else
			    //else if(username.equals("demo") && password.equals("nectar123"))
		{	
		    ChapterDetailsBean objChapterDetailsBean = new ChapterDetailsBean();
		    UserdetailsDAO obUserdetailsDAO = new UserdetailsDAO();
			Userdetails objUserdetails=obUserdetailsDAO.findById(cid);
			int modulecount = objUserdetails.getModuleCount();
			//System.out.println("modulecount..............	:"+modulecount);
			if(modulecount>0)
			{
		boolean flag=false;
		/*EntityManagerHelper.beginTransaction();
		modulecount = modulecount-1;
		objUserdetails.setModuleCount(modulecount);
		obUserdetailsDAO.update(objUserdetails);*/
		flag = objChapterDetailsBean.setChapterCount(cid,modulename,modulecount,dbConnection);
		
		//if(demoaction.equals("realestate"))flag=true;
		
		if(flag)
		{
		//System.out.println("flag..............	:"+flag);
	%>
				<div align="center">
				<iframe width="100%" height="630" src="<%=moduleurl%>" controls controlsList="nodownload"></iframe>
				<div/>   
	      	 	<%}
	      	 	else{
	             		response.sendRedirect("Login.jsp");
	     	  		}
	      	 }
	      
				
	     else{
	             response.sendRedirect("Login.jsp");
	     	  }
		}%>
				
</BODY>
</HTML>